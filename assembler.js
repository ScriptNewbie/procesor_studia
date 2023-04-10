const fs = require('fs');

const generatePayload = (value) => {
    const binaryValue = value.toString(2);
    return payload = String("0").repeat(16 - binaryValue.length) + binaryValue
}

try {
  let data = fs.readFileSync('source.as', 'utf8');
  data = data.replace(/[\r\t]+/g, ''); //zmienic
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
        expression[0] = expression[0].slice(0, -1)
        labels.push({name: expression[0], line: index})
        expression.shift();
    }
  })

  console.log(expressions)

  const machineCode = [];
  expressions.forEach((expression) => {
    const [operation, firstOperand, secondOperand] = expression
    if(operation === "add" || operation === "sub") {
        if(typeof firstOperand !== 'undefined') {
            const address = parseInt(firstOperand.substr(1));
            if(firstOperand.startsWith("r") && !isNaN(address)) {
                machineCode.push((operation === "add" ? "00000" : "00001") + generatePayload(address))
            } else console.log("Syntax error: Add requires register as argument");
        } else console.log("Syntax error: Add requires operand");
    }
    else if(operation === "mov") {
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
                } else console.log("Syntax error: Wrong second operand!");
            } else {
                if(firstOperand.startsWith("r"))
                {
                    machineCode.push("11001" + generatePayload(parseInt(firstOperand.substr(1))))
                } else if(firstOperand.startsWith("@"))
                {
                    machineCode.push("11010" + generatePayload(parseInt(firstOperand.substr(1))))
                } else console.log("Syntax error: Wrong second operand!");

            }
        } else console.log("Syntax error: Add requires two operands");
    } else if(operation === "inc" || operation == "dec"){
        if(typeof firstOperand === 'undefined' && typeof secondOperand === 'undefined') {
            machineCode.push((operation === "inc" ? "00001" : "00101") + generatePayload(1))
        } else if(typeof firstOperand !== 'undefined' && typeof secondOperand === 'undefined'){
            const value = parseInt(firstOperand);
            if(!isNaN(value)){
                machineCode.push((operation === "inc" ? "00001" : "00101") + generatePayload(value))
            } else {
                console.log("Syntax error: Operand is wrong!")
            } 
        } else {
            console.log("Syntax error: Wrong operands!")
        }
    }
    else if(operation === "ret") {
        machineCode.push("100010000000000000000")
    } else {
        machineCode.push("110110000000000000000")
    }
  })
  console.log(machineCode)
} catch (err) {
  console.error(err);
}