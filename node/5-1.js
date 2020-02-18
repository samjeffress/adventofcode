const input = [
  3,225,1,225,6,6,1100,1,238,225,104,0,1101,37,34,224,101,-71,224,224,4,224,1002,223,8,223,101,6,224,224,1,224,223,223,1002,113,50,224,1001,224,-2550,224,4,224,1002,223,8,223,101,2,224,224,1,223,224,223,1101,13,50,225,102,7,187,224,1001,224,-224,224,4,224,1002,223,8,223,1001,224,5,224,1,224,223,223,1101,79,72,225,1101,42,42,225,1102,46,76,224,101,-3496,224,224,4,224,102,8,223,223,101,5,224,224,1,223,224,223,1102,51,90,225,1101,11,91,225,1001,118,49,224,1001,224,-140,224,4,224,102,8,223,223,101,5,224,224,1,224,223,223,2,191,87,224,1001,224,-1218,224,4,224,1002,223,8,223,101,4,224,224,1,224,223,223,1,217,83,224,1001,224,-124,224,4,224,1002,223,8,223,101,5,224,224,1,223,224,223,1101,32,77,225,1101,29,80,225,101,93,58,224,1001,224,-143,224,4,224,102,8,223,223,1001,224,4,224,1,223,224,223,1101,45,69,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,7,226,226,224,102,2,223,223,1005,224,329,101,1,223,223,108,677,226,224,102,2,223,223,1005,224,344,1001,223,1,223,1108,226,677,224,102,2,223,223,1005,224,359,1001,223,1,223,8,677,226,224,102,2,223,223,1006,224,374,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,389,101,1,223,223,1108,677,226,224,1002,223,2,223,1005,224,404,1001,223,1,223,108,677,677,224,102,2,223,223,1005,224,419,101,1,223,223,7,226,677,224,1002,223,2,223,1006,224,434,1001,223,1,223,107,226,677,224,102,2,223,223,1005,224,449,101,1,223,223,1108,677,677,224,1002,223,2,223,1006,224,464,101,1,223,223,7,677,226,224,102,2,223,223,1006,224,479,101,1,223,223,1007,677,677,224,1002,223,2,223,1005,224,494,101,1,223,223,1008,226,226,224,102,2,223,223,1006,224,509,1001,223,1,223,107,677,677,224,102,2,223,223,1006,224,524,1001,223,1,223,8,226,226,224,1002,223,2,223,1005,224,539,1001,223,1,223,1007,677,226,224,102,2,223,223,1006,224,554,1001,223,1,223,1007,226,226,224,1002,223,2,223,1005,224,569,1001,223,1,223,8,226,677,224,1002,223,2,223,1006,224,584,101,1,223,223,108,226,226,224,1002,223,2,223,1006,224,599,101,1,223,223,1107,677,226,224,1002,223,2,223,1005,224,614,1001,223,1,223,1107,226,677,224,102,2,223,223,1006,224,629,1001,223,1,223,1008,226,677,224,102,2,223,223,1005,224,644,101,1,223,223,1107,226,226,224,102,2,223,223,1006,224,659,1001,223,1,223,1008,677,677,224,102,2,223,223,1006,224,674,1001,223,1,223,4,223,99,226
]

const INPUT_VALUE = 1

const ADD = 1
const MULTIPLY = 2
const HALT = 99
const SAVE = 3
const OUTPUT = 4

const MODE_REFERENCE = 'reference' // position
const MODE_VALUE = 'value' // immediate

const valueAt = (input, mode, position) => {
  console.log('val at position', position, ': ', input[position], '. val at val at position', input[input[position]], 'using', mode)
  // console.log(input.slice(0, 7))
  const valAtPosition = input[position]
  
  // if (valAtPosition < 0) {
  //   const positiveIndex = valAtPosition >= 0 ? valAtPosition : input.length + (valAtPosition%input.length)
  //   if (isNaN(positiveIndex)) {
  //     throw new Error('bad nan')
  //   }
  //   return input[positiveIndex]
  // }
  
  if (mode === MODE_REFERENCE) {
    const positiveIndex = valAtPosition >= 0 ? valAtPosition : input.length + (valAtPosition%input.length)
    if (isNaN(positiveIndex)) {
      throw new Error('bad nan')
    }
    return input[positiveIndex]
  }
  return valAtPosition
  
  
  
  // const val = mode === MODE_REFERENCE 
  //   ? input[valAtPosition]
  //   : input[position] 
  // if (isNaN(val)) {
  //   throw new Error('bad nan')
  // }
  // return val
}
    
    
const rewindInput = (noun, verb) => [...input.slice(0,1), noun, verb,...input.slice(3)]

const add = (a, b) => a + b
const multiply = (a, b) => a * b

const storeInputValue = (input, startingPosition) => {
  const positionToReplace = input[startingPosition+1]
  const newArray = [...input.slice(0,positionToReplace), INPUT_VALUE, ...input.slice(positionToReplace +1)]
  return newArray  
}

const outputParameter = (input, startingPosition) => {
  const value = valueAt(input, MODE_REFERENCE, startingPosition+1)
  console.log(`==== OUTPUT VALUE: ${value} ====`)
  return input
}
   
const executeMathFunction = (input, startingPosition, mathOperator, modes) => {
  // console.log(modes)
  const firstValue = valueAt(input, modes[0], startingPosition+1)
  const secondValue = valueAt(input, modes[1], startingPosition+2)
  // console.log('firstValue', firstValue, 'secondValue', secondValue)
  const value = mathOperator(firstValue, secondValue)
  const positionToReplace = input[startingPosition+3]
  
  // console.log('math value: ', value, ' positionToReplace, ', positionToReplace)
  const newArray = [...input.slice(0,positionToReplace), value, ...input.slice(positionToReplace +1)]
  return newArray
}

const processInput = (input, startingPosition) => {
  // console.log(startingPosition, input[startingPosition])
  const optcode = `${input[startingPosition]}`
  // console.log('optcode', optcode, 'startingPosition', startingPosition, input[startingPosition-1])

  // need to interpret each position of the opcode to determine if parameters are position or values
  const instruction = optcode.length > 1 ? optcode.slice(optcode.length-2) : optcode
  console.log(instruction)
  const modesSpecified = [optcode.replace(instruction, '')].reverse()
  const modes = Array(3).fill().map((item, index) => 
    (modesSpecified[index] || '0') === '0' ? MODE_REFERENCE : MODE_VALUE)
  
  switch (parseInt(instruction)) {
    case ADD:
      // console.log('ADD')
      return processInput(executeMathFunction(input, startingPosition, add, modes), startingPosition+4)
      break;
    case MULTIPLY:
      // console.log('MULTIPLY')
      return processInput(executeMathFunction(input, startingPosition, multiply, modes), startingPosition+4)
      break;
    case HALT: 
      // console.log('HALT')
      console.log(JSON.stringify(input))
      return input
      break;
    case SAVE:
      // console.log('SAVE')
      return processInput(storeInputValue(input, startingPosition), startingPosition+2)
      return input
      break
    case OUTPUT:
      // console.log('OUTPUT')
      return processInput(outputParameter(input, startingPosition), startingPosition+2)
      return input
      break
    default: 
      console.log('Unknown opcode')
      throw new Error('Unknown opcode')
  }
}

Array(100).fill().map((nounItem, nounIndex) => 
  Array(100).fill().map((verbItem, verbIndex) => ({ noun: nounIndex, verb: verbIndex }))
)
.flat()
.map(i => {
  // const rewoundInput = rewindInput(i.noun, i.verb)
  const result = processInput(input, 0)
  return {result, ...i}
})
// .filter(x => x.result[0] === MAGIC_NUMBER_TO_FIND)
// .map(x => {
//   console.log('something', x)
//   console.log(x.noun * 100 + x.verb)
// })