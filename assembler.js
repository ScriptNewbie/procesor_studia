//Uwaga, jeżeli w linii będzie sam komentarz, błędnie będzie numerować linie przy errorze ;)

const fs = require('fs');

const generatePayload = (value) => {
    const binaryValue = value.toString(2);
    return payload = String("0").repeat(16 - binaryValue.length) + binaryValue
}

const getLabelAddress = (name, labels) => {
    for (let i = 0; i < labels.length; i++) {
      if (labels[i].name === name) {
        const { line } = labels[i];
        return line;
      }
    }
    return -1;
  };

const generateJumpPayload = (firstOperand, secondOperand, index, labels) => {
    let ok = true;
    let address = 0;
    if(typeof firstOperand !== 'undefined' && typeof secondOperand === 'undefined') {
        if(isNaN(firstOperand))
        {
            address = getLabelAddress(firstOperand, labels)
            if(address < 0) {
                console.log((index + 1) + ": Syntax error: such label does not exist")
                ok = false;
            }
        } else {
            address = parseInt(firstOperand)
        }
    } else {
        console.log((index + 1) + ": Syntax error: Wrong operands")
        ok = false
    }
    return {isOk: ok, payload: generatePayload(address)}
}

try {
  let ok = true;
  let data = fs.readFileSync('source.as', 'utf8');
  data = data.replace(/[\r\t]+/g, ' ');
  const lines = data.split('\n');
  let expressions = [];
  lines.forEach(line => {
    line = line.split("//")[0].toLowerCase();
    let words = line.split(/[ ,]+/).map(word => word.trim());
    words = words.filter(Boolean);
    expressions.push(words);
  });
  expressions = expressions.filter(array => array.length !== 0);
  

  const labels = [];
  expressions.forEach((expression, index) => {
    if(expression[0][expression[0].length-1] == ":") {
        if(isNaN(parseInt(expression[0]))){
            expression[0] = expression[0].slice(0, -1)
            labels.push({name: expression[0], line: index})
        } else {
            console.log((index + 1) + ": Syntax error: Label cannot start with number")
            ok = false;
        }
        expression.shift();
    }
  })

  const machineCode = [];
  expressions.forEach((expression, index) => {
    const [operation, firstOperand, secondOperand] = expression
    if(operation === "mov") {
        if(typeof firstOperand !== 'undefined' && typeof secondOperand !== 'undefined') {
            if(firstOperand == "a") {
                if(!isNaN(secondOperand))
                {
                    machineCode.push("11101" + generatePayload(parseInt(secondOperand)))
                } else if(secondOperand.startsWith("r"))
                {
                    machineCode.push("11100" + generatePayload(parseInt(secondOperand.substr(1))))
                } else if(secondOperand.startsWith("@"))
                {
                    machineCode.push("11110" + generatePayload(parseInt(secondOperand.substr(1))))
                } else {
                    console.log((index + 1)+ ": Syntax error: Wrong second operand!");
                    ok = false;
                }
            } else if(secondOperand === "a") {
                if(firstOperand.startsWith("r"))
                {
                    machineCode.push("11001" + generatePayload(parseInt(firstOperand.substr(1))))
                } else if(firstOperand.startsWith("@"))
                {
                    machineCode.push("11010" + generatePayload(parseInt(firstOperand.substr(1))))
                } else {
                    console.log((index + 1)+ ": Syntax error: Wrong second operand!");
                    ok = false;
                }

            } else {
                console.log((index + 1)+ ": Syntax error: One operand must be acumulator")
            }
        } else {
            console.log((index + 1)+ ": Syntax error: Add requires two operands");
            ok = false;
        }
    } else if(operation === "add" || operation === "sub") {
        if(typeof firstOperand !== 'undefined') {
            const address = parseInt(firstOperand.substr(1));
            if(firstOperand.startsWith("r") && !isNaN(address)) {
                machineCode.push((operation === "add" ? "00000" : "00100") + generatePayload(address))
            } else {
                console.log((index + 1)+ ": Syntax error: Add requires register as argument");
                ok = false;
            }
        } else {
            console.log((index + 1)+ ": Syntax error: Add requires operand");
            ok = false;
        }
    } else if(operation === "inc" || operation == "dec"){
        if(typeof firstOperand === 'undefined' && typeof secondOperand === 'undefined') {
            machineCode.push((operation === "inc" ? "00001" : "00101") + generatePayload(1))
        } else if(typeof firstOperand !== 'undefined' && typeof secondOperand === 'undefined'){
            const value = parseInt(firstOperand);
            if(!isNaN(value)){
                machineCode.push((operation === "inc" ? "00001" : "00101") + generatePayload(value))
            } else {
                console.log((index + 1)+ ": Syntax error: Operand is wrong!")
                ok = false;
            } 
        } else {
            console.log((index + 1)+ ": Syntax error: Wrong operands!")
            ok = false;
        }
    } else if(operation === "and"){
        if(typeof firstOperand !== 'undefined') {
            const address = parseInt(firstOperand.substr(1));
            if(firstOperand.startsWith("r") && !isNaN(address)) {
                machineCode.push( "01000" + generatePayload(address))
            } else {
                console.log((index + 1)+ ": Syntax error: AND requires register as argument");
                ok = false;
            }
        } else {
            console.log((index + 1)+ ": Syntax error: AND requires operand");
            ok = false;
        }
    } else if(operation === "or"){
        if(typeof firstOperand !== 'undefined') {
            const address = parseInt(firstOperand.substr(1));
            if(firstOperand.startsWith("r") && !isNaN(address)) {
                machineCode.push( "01100" + generatePayload(address))
            } else {
                console.log((index + 1)+ ": Syntax error: OR requires register as argument");
                ok = false;
            }
        } else {
            console.log((index + 1)+ ": Syntax error: OR requires operand");
            ok = false;
        }
    } else if(operation === "xor"){
        if(typeof firstOperand !== 'undefined') {
            const address = parseInt(firstOperand.substr(1));
            if(firstOperand.startsWith("r") && !isNaN(address)) {
                machineCode.push( "10000" + generatePayload(address))
            } else {
                console.log((index + 1)+ ": Syntax error: XOR requires register as argument");
                ok = false;
            }
        } else {
            console.log((index + 1)+ ": Syntax error: XOR requires operand");
            ok = false;
        }
    } else if(operation === "not") {
        machineCode.push("101000000000000000000")
    } else if(operation === "jmp") {
        const {isOk, payload} = generateJumpPayload(firstOperand, secondOperand, index, labels)
        ok = isOk
        machineCode.push("01001" + payload)
    } else if(operation === "jmpz") {
        const {isOk, payload} = generateJumpPayload(firstOperand, secondOperand, index, labels)
        ok = isOk
        machineCode.push("01010" + payload)
    } else if(operation === "jmpo") {
        const {isOk, payload} = generateJumpPayload(firstOperand, secondOperand, index, labels)
        ok = isOk
        machineCode.push("01011" + payload)
    } else if(operation === "jmps") {
        const {isOk, payload} = generateJumpPayload(firstOperand, secondOperand, index, labels)
        ok = isOk
        machineCode.push("10010" + payload)
    } else if(operation === "call") {
        const {isOk, payload} = generateJumpPayload(firstOperand, secondOperand, index, labels)
        ok = isOk
        machineCode.push("01101" + payload)
    } else if(operation === "callz") {
        const {isOk, payload} = generateJumpPayload(firstOperand, secondOperand, index, labels)
        ok = isOk
        machineCode.push("01110" + payload)
    } else if(operation === "callo") {
        const {isOk, payload} = generateJumpPayload(firstOperand, secondOperand, index, labels)
        ok = isOk
        machineCode.push("01111" + payload)
    } else if(operation === "calls") {
        const {isOk, payload} = generateJumpPayload(firstOperand, secondOperand, index, labels)
        ok = isOk
        machineCode.push("10110" + payload)
    } else if(operation === "ret") {
        machineCode.push("100010000000000000000")
    } else if(operation ==="nop"){
        machineCode.push("110110000000000000000")
    } else {
        console.log((index + 1)+ ": Syntax error: No such mnemonic")
        ok = false;
    }
  })

  const addressLength = Math.ceil(Math.log2(machineCode.length))
  const generateAddress = (address) => {
    const binaryAddress = address.toString(2);
    return String("0").repeat(addressLength - binaryAddress.length) + binaryAddress
  }


  if(ok)
  {
    machineCode.forEach((line, index) => {
        const payload = `${addressLength}'b${generateAddress(index)}: data <= 21'b${line};\n`
        try {
            fs.writeFileSync("output.txt", payload, { flag: 'a' });
          } catch (err) {
            console.error(err);
          }
    })
  }
  
  try {
    fs.writeFileSync("output.txt", "\n---------------------END--------------------\n", { flag: 'a' });
  } catch (err) {
    console.error(err);
  }

} catch (err) {
  console.error(err);
}