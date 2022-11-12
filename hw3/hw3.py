import numpy as np


def spAND(input1sp, input2sp):
    #print("AND Gate for input probabilities ({} {})".format(input1sp, input2sp))
    return input1sp*input2sp


def spNOT(input1sp):
    #print("NOT Gate for input probability ({})".format(input1sp))
    return 1-input1sp


def spXOR(input1sp, input2sp):
    #print("XOR Gate for input probabilities ({} {})".format(input1sp, input2sp))
    return input1sp*input2sp*((1/input1sp) + (1/input2sp) - 2)

def testbench():
    gates = 3

    tTable = []
    for x in range(0, 2**gates):
        tTable.append([x // 4 % 2, x // 2 % 2, x % 2])

    e = [0, 0, 0, 0, 0, 0, 1, 1]
    f = [1, 0, 1, 0, 1, 0, 1, 0]
    d = [0, 0, 0, 0, 0, 0, 1, 0]

    counter = 0
    for i in range(0, 2**gates):
        res = circuit(tTable[i][0], tTable[i][1], tTable[i][2], 0, 0, 0)
        if res[4] == e[i] and res[5] == f[i] and res[3] == d[i]:
            counter += 1

    if counter == 8:
        print("✅ Testbench passed")
    else:
        print("❌ Testbench failed")


class Entity:
    def __init__(self, type, inputs, output):
        self.type = type
        self.inputs = inputs
        self.output = output

    def __str__(self):
        return "{type=" + str(self.type) + ", inputs=" + str(self.inputs) + ", output=" + str(self.output) + "}"


def process(element, SignalsTable):
    if(element.type == 0):
        SignalsTable[element.output] = spAND(SignalsTable[element.inputs[0]], SignalsTable[element.inputs[1]])
    elif(element.type == 1):
        SignalsTable[element.output] = spNOT(SignalsTable[element.inputs[0]])
    elif(element.type == 2):
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


def triadio():
    ElementTypes = ["AND", "NOT", "XOR"]
    inputsDict = dict()
    with open('circuit.txt') as f:
        lines = [line.rstrip('\n') for line in f]

    inputs = []
    firstLine = 0
    method = 2
    if(lines[0][0:10] == "top_inputs"):
        method = 1
        firstLine = 1
        inputs = lines[0].split()[1:]
    else:
        leftSide = []
        rightSide = []
        for i in range(firstLine, len(lines)):
            vars = lines[i].split()[1:]
            leftSide.append(vars[0])
            rightSide = rightSide+vars[1:]
        inputs = list(set(rightSide) - set(leftSide))

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
        print("\n".join(lines))
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

    firstLine = 0
    topInputs = ""
    if (lines[0][0:10] == "top_inputs"):
        firstLine = 1
        topInputs = lines[0]
        inputs = lines[0].split()[1:]
    else:
        leftSide = []
        rightSide = []
        for i in range(firstLine, len(lines)):
            vars = lines[i].split()[1:]
            leftSide.append(vars[0])
            rightSide = rightSide + vars[1:]
        inputs = list(set(rightSide) - set(leftSide))

    flag = [0, 0]
    flag[0] = lines[firstLine:]
    flag[1] = inputs
    while(len(flag) != 1):
        flag = sort(flag[0], flag[1])

    if firstLine == 1:
        flag[0] = [topInputs] + flag[0]
    return flag[0]


def main():
    # 3.1
    print(circuit(1, 2, 3, 4, 5, 6))
    testbench()

    # 3.2
    print(triadio())

    # 3.3
    triatria()


if __name__ == "__main__":
    main()
