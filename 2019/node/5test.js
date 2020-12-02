const path = require('path')
// const { read, position } = require('promise-path')
// const fromHere = position(__dirname)
// const report = (...messages) => console.log(`[${require(fromHere('../../package.json')).logName} / ${__dirname.split(path.sep).pop()}]`, ...messages)

async function run () {
  // const input = (await read(fromHere('input.txt'), 'utf8')).trim()

const input = '3,225,1,225,6,6,1100,1,238,225,104,0,1101,37,34,224,101,-71,224,224,4,224,1002,223,8,223,101,6,224,224,1,224,223,223,1002,113,50,224,1001,224,-2550,224,4,224,1002,223,8,223,101,2,224,224,1,223,224,223,1101,13,50,225,102,7,187,224,1001,224,-224,224,4,224,1002,223,8,223,1001,224,5,224,1,224,223,223,1101,79,72,225,1101,42,42,225,1102,46,76,224,101,-3496,224,224,4,224,102,8,223,223,101,5,224,224,1,223,224,223,1102,51,90,225,1101,11,91,225,1001,118,49,224,1001,224,-140,224,4,224,102,8,223,223,101,5,224,224,1,224,223,223,2,191,87,224,1001,224,-1218,224,4,224,1002,223,8,223,101,4,224,224,1,224,223,223,1,217,83,224,1001,224,-124,224,4,224,1002,223,8,223,101,5,224,224,1,223,224,223,1101,32,77,225,1101,29,80,225,101,93,58,224,1001,224,-143,224,4,224,102,8,223,223,1001,224,4,224,1,223,224,223,1101,45,69,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,7,226,226,224,102,2,223,223,1005,224,329,101,1,223,223,108,677,226,224,102,2,223,223,1005,224,344,1001,223,1,223,1108,226,677,224,102,2,223,223,1005,224,359,1001,223,1,223,8,677,226,224,102,2,223,223,1006,224,374,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,389,101,1,223,223,1108,677,226,224,1002,223,2,223,1005,224,404,1001,223,1,223,108,677,677,224,102,2,223,223,1005,224,419,101,1,223,223,7,226,677,224,1002,223,2,223,1006,224,434,1001,223,1,223,107,226,677,224,102,2,223,223,1005,224,449,101,1,223,223,1108,677,677,224,1002,223,2,223,1006,224,464,101,1,223,223,7,677,226,224,102,2,223,223,1006,224,479,101,1,223,223,1007,677,677,224,1002,223,2,223,1005,224,494,101,1,223,223,1008,226,226,224,102,2,223,223,1006,224,509,1001,223,1,223,107,677,677,224,102,2,223,223,1006,224,524,1001,223,1,223,8,226,226,224,1002,223,2,223,1005,224,539,1001,223,1,223,1007,677,226,224,102,2,223,223,1006,224,554,1001,223,1,223,1007,226,226,224,1002,223,2,223,1005,224,569,1001,223,1,223,8,226,677,224,1002,223,2,223,1006,224,584,101,1,223,223,108,226,226,224,1002,223,2,223,1006,224,599,101,1,223,223,1107,677,226,224,1002,223,2,223,1005,224,614,1001,223,1,223,1107,226,677,224,102,2,223,223,1006,224,629,1001,223,1,223,1008,226,677,224,102,2,223,223,1005,224,644,101,1,223,223,1107,226,226,224,102,2,223,223,1006,224,659,1001,223,1,223,1008,677,677,224,102,2,223,223,1006,224,674,1001,223,1,223,4,223,99,226'


  await solveForFirstStar(input)
  // await solveForSecondStar(input)
}

const IMMEDIATE = 1

const opcodes = {
  1: addValues,
  2: multiplyValues,
  3: saveInputToPosition,
  4: outputValue,
  5: jumpIfTrue,
  6: jumpIfFalse,
  7: lessThan,
  8: equals,
  99: endProgram
}

function getParameter ({ memory, mode, parameter }) {
  return mode === IMMEDIATE ? parameter : memory[parameter]
}

function addValues ({ memory, position, mode1, mode2 }) {
  const parameter1 = getParameter({ memory, mode: mode1, parameter: memory[position + 1] })
  const parameter2 = getParameter({ memory, mode: mode2, parameter: memory[position + 2] })
  const parameter3 = memory[position + 3]
  memory[parameter3] = parameter1 + parameter2
  return position + 4
}

function multiplyValues ({ memory, position, mode1, mode2 }) {
  const parameter1 = getParameter({ memory, mode: mode1, parameter: memory[position + 1] })
  const parameter2 = getParameter({ memory, mode: mode2, parameter: memory[position + 2] })
  const parameter3 = memory[position + 3]
  memory[parameter3] = parameter1 * parameter2
  return position + 4
}

function saveInputToPosition ({ memory, position, inputs }) {
  const parameter1 = memory[position + 1]
  memory[parameter1] = inputs[0]
  return position + 2
}

function outputValue ({ memory, position, outputs, mode1 }) {
  const parameter1 = getParameter({ memory, mode: mode1, parameter: memory[position + 1] })
  outputs[0] = parameter1
  return position + 2
}

function jumpIfTrue ({ memory, position, mode1, mode2 }) {
  const parameter1 = getParameter({ memory, mode: mode1, parameter: memory[position + 1] })
  const parameter2 = getParameter({ memory, mode: mode2, parameter: memory[position + 2] })
  if (parameter1 !== 0) {
    return parameter2
  }
  return position + 3
}

function jumpIfFalse ({ memory, position, mode1, mode2 }) {
  const parameter1 = getParameter({ memory, mode: mode1, parameter: memory[position + 1] })
  const parameter2 = getParameter({ memory, mode: mode2, parameter: memory[position + 2] })
  if (parameter1 === 0) {
    return parameter2
  }
  return position + 3
}

function lessThan ({ memory, position, mode1, mode2, mode3 }) {
  const parameter1 = getParameter({ memory, mode: mode1, parameter: memory[position + 1] })
  const parameter2 = getParameter({ memory, mode: mode2, parameter: memory[position + 2] })
  const parameter3 = memory[position + 3]
  if (parameter1 < parameter2) {
    memory[parameter3] = 1
  } else {
    memory[parameter3] = 0
  }
  return position + 4
}

function equals ({ memory, position, mode1, mode2 }) {
  const parameter1 = getParameter({ memory, mode: mode1, parameter: memory[position + 1] })
  const parameter2 = getParameter({ memory, mode: mode2, parameter: memory[position + 2] })
  const parameter3 = memory[position + 3]
  if (parameter1 === parameter2) {
    memory[parameter3] = 1
  } else {
    memory[parameter3] = 0
  }
  return position + 4
}

function endProgram ({ memory, position }) {
  // report('Reached the end of the program at position', position)
  return -1
}

function executeProgram ({ memory, position, inputs, outputs }) {
  const instruction = (memory[position] + '').split('')
  const opcode = Number.parseInt([instruction.pop(), instruction.pop()].reverse().join(''))
  const mode1 = Number.parseInt(instruction.pop() || 0)
  const mode2 = Number.parseInt(instruction.pop() || 0)
  const mode3 = Number.parseInt(instruction.pop() || 0)

  try {
    return opcodes[opcode]({ memory, position, inputs, outputs, mode1, mode2, mode3 })
  } catch (ex) {
    console.log('Unable to execute instruction at', position, `(Opcode: ${opcode}, Modes: 1:${mode1}, 2:${mode2}, 3:${mode3})`, `[${memory[position]}]`, 'memory dump:', memory.join(' '))
    return -1
  }
}

async function solveForFirstStar (input) {
  const memory = input.split(',').map(n => Number.parseInt(n))
  const inputs = { 0: 1 }
  const outputs = {}

  let position = 0
  do {
    position = executeProgram({ memory, position, inputs, outputs })
    console.log(memory.join(','))
  }
  while (position !== -1)

  const solution = outputs
  console.log('Solution 1:', solution)
}

async function solveForSecondStar (input) {
  const memory = input.split(',').map(n => Number.parseInt(n))
  const inputs = { 0: 5 }
  const outputs = {}

  let position = 0
  do {
    position = executeProgram({ memory, position, inputs, outputs })
    console.log(memory.join(','))
  }
  while (position !== -1)

  const solution = outputs
  console.log('Solution 2:', solution)
}

run()