import numpy as np


def spAND(input1sp, input2sp):
    # print("AND Gate for input probabilities ({} {})".format(input1sp, input2sp))
    return input1sp*input2sp


def spNOT(input1sp):
    # print("NOT Gate for input probability ({})".format(input1sp))
    return 1-input1sp


def spXOR(input1sp, input2sp):
    # print("XOR Gate for input probabilities ({} {})".format(input1sp, input2sp))
    return input1sp*input2sp*((1/input1sp) + (1/input2sp) - 2)


def switchingActivity(sp):
    return 2*sp*(1-sp)


def testbench(circuitRes):
    tTable = []
    cnt = 1
    for x in range(0, 2 ** 3):
        pinakas = []
        for i in range(0, 3):
            pinakas.append(x // cnt % 2)
            cnt *= 2
        pinakas = pinakas[::-1]
        cnt = 1
        tTable.append(pinakas)

    e = [0, 0, 0, 0, 0, 0, 1, 1]
    f = [1, 0, 1, 0, 1, 0, 1, 0]
    d = [0, 0, 0, 0, 0, 0, 1, 0]

    counter = 0
    for i in range(0, 2**3):
        res = circuit(tTable[i][0], tTable[i][1], tTable[i][2], 0, 0, 0)
        if res[4] == e[i] and res[5] == f[i] and res[3] == d[i]:
            counter += 1

    if counter == 8:
        print("✅ Testbench passed")
        print("Switching activity\n~~~~~~~~~~~~~~~~~~")
        print("swE =", switchingActivity(circuitRes[4]))
        print("swF =", switchingActivity(circuitRes[5]))
        print("swD =", switchingActivity(circuitRes[3]), "\n~~~~~~~~~~~~~~~~~~")
    else:
        print("❌ Testbench failed")
        return False

    return True

# def testbench2(inputs, lines):
#     print(inputs)
#     inputsLen = len(inputs)
#     tTable = []
#     cnt = 1
#     for x in range(0, 2**inputsLen):
#         pinakas = []
#         for i in range(0, inputsLen):
#             pinakas.append(x // cnt % 2)
#             cnt *= 2
#         pinakas = pinakas[::-1]
#         cnt = 1
#         tTable.append(pinakas)
#
#     inpKeys = list(inputs.keys())
#     print(inpKeys)
#
#     for i in range(0, len(lines)):
#         linesSplit = lines[i].split()
#         print(linesSplit)
#         if linesSplit[0] == "NOT":
#             x = inpKeys.index(linesSplit[2])
#             print("AAAAAAA", x)
#             inpKeys.append(linesSplit[1])
#             arr = []
#             for j in range(0, 2**inputsLen):
#                 arr.append(spNOT(tTable[j][x]))
#             print(arr)
#         elif linesSplit[0] == "AND":
#             print("O")
#     #
#     #
#     # e = [0, 0, 0, 0, 0, 0, 1, 1]
#     # f = [1, 0, 1, 0, 1, 0, 1, 0]
#     # d = [0, 0, 0, 0, 0, 0, 1, 0]
#
#     return True


class Entity:
    def __init__(self, type, inputs, output):
        self.type = type
        self.inputs = inputs
        self.output = output

    def __str__(self):
        return "{type=" + str(self.type) + ", inputs=" + str(self.inputs) + ", output=" + str(self.output) + "}"


def process(element, SignalsTable):
    if element.type == 0:
        SignalsTable[element.output] = spAND(SignalsTable[element.inputs[0]], SignalsTable[element.inputs[1]])
    elif element.type == 1:
        SignalsTable[element.output] = spNOT(SignalsTable[element.inputs[0]])
    elif element.type == 2:
        SignalsTable[element.output] = spXOR(SignalsTable[element.inputs[0]], SignalsTable[element.inputs[1]])
    return SignalsTable


def circuit(a, b, c, d, e, f):
    SignalsTable = [a, b, c, d, e, f]
    ElementTypes = ["AND", "NOT", "XOR"]

    E1 = Entity(0, [0, 1], 4)
    E2 = Entity(1, [2], 5)
    E3 = Entity(0, [4, 5], 3)

    ElementsTable = [E1, E2, E3]

    for i in ElementsTable:
        SignalsTable = process(i, SignalsTable)

    return SignalsTable


def findInputs(lines):
    firstLine = 0
    if lines[0][0:10] == "top_inputs":
        firstLine = 1
        inputs = lines[0].split()[1:]
    else:
        leftSide = []
        rightSide = []
        for i in range(firstLine, len(lines)):
            vars = lines[i].split()[1:]
            leftSide.append(vars[0])
            rightSide = rightSide + vars[1:]
        inputs = list(set(rightSide) - set(leftSide))

    return [firstLine, inputs]


def triadio():
    ElementTypes = ["AND", "NOT", "XOR"]
    inputsDict = dict()
    with open('circuit.txt') as f:
        lines = [line.rstrip('\n') for line in f]

    findInps = findInputs(lines)
    firstLine = findInps[0]
    inputs = findInps[1]

    for i in range(firstLine, len(lines)):
        lineParts = lines[i].split()
        type = ElementTypes.index(lineParts[0])
        vars = lineParts[1:]
        currentInputs = []
        for j in vars:
            if j in inputs and j not in inputsDict.keys():
                inputsDict[j] = float(input(str(j) + " = "))
                currentInputs.append(inputsDict[j])
        if type == 0:
            inputsDict[vars[0]] = spAND(inputsDict[vars[1]], inputsDict[vars[2]])
        elif type == 1:
            inputsDict[vars[0]] = spNOT(inputsDict[vars[1]])
        else:
            inputsDict[vars[0]] = spXOR(inputsDict[vars[1]], inputsDict[vars[2]])

    # inpsDict = dict()
    # for i in inputs:
    #     inpsDict[i] = inputsDict[i]
    #
    # testbench2(inpsDict, lines[firstLine:])

    return inputsDict


def sort(lines, inputs):
    goodList = []
    badList = []
    inps = []
    bad = 0
    for i in range(0, len(lines)):
        vars = lines[i].split()[1:]
        gateInputs = vars[1:]
        inputs1 = list(set(gateInputs) & set(inputs))
        if len(inputs1) == len(gateInputs):
            goodList.append(i)
            inps.append(vars[0])
        else:
            bad = 1
            badList.append(i)
    if bad == 0:
        return [lines]
    next = goodList + badList
    nextInps = inputs + inps
    newLines = []
    for i in next:
        newLines.append(lines[i])

    return [newLines, sorted(list(dict.fromkeys(nextInps)))]


def triatria():
    with open('circuit.txt') as f:
        lines = [line.rstrip('\n') for line in f]

    findInps = findInputs(lines)
    firstLine = findInps[0]
    inputs = findInps[1]

    flag = [lines[firstLine:], inputs]
    while len(flag) != 1:
        flag = sort(flag[0], flag[1])

    if firstLine == 1:
        inputs.insert(0, "top_inputs")
        flag[0] = [" ".join(inputs)] + flag[0]
    return flag[0]


def main():
    # 3.1
    circuitRes = circuit(0.4456, 0.4456, 0.4456, 0, 0, 0)
    testbench(circuitRes)


    # 3.2
    print(triadio())

    # 3.3
    print(triatria())


if __name__ == "__main__":
    main()
