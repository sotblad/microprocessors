def spAND(inputs):
    s = inputs[0]
    for i in range(1, len(inputs)):
        s *= inputs[i]
    return s


def spOR(inputs):
    s = 1-inputs[0]
    for i in range(1, len(inputs)):
        s *= (1-inputs[i])
    return 1-s


def spXOR(inputs):
    s = sp2XOR(inputs[0], inputs[1])
    for i in range(2, len(inputs)):
        s = sp2XOR(s, inputs[i])
    return s


def spXNOR(inputs):
    return 1 - spXOR(inputs)


def spNAND(inputs):
    s = inputs[0]
    for i in range(1, len(inputs)):
        s *= inputs[i]
    return 1-s


def spNOR(inputs):
    s = 1-inputs[0]
    for i in range(1, len(inputs)):
        s *= 1-inputs[i]
    return s


def spNOT(input1sp):
    return 1-input1sp[0]


def sp2XOR(input1sp, input2sp):
    return (1-input1sp)*input2sp + input2sp*(1-input1sp)


class Entity:
    def __init__(self, type, inputs, output):
        self.type = type
        self.inputs = inputs
        self.output = output

    def __str__(self):
        return "{type=" + str(self.type) + ", inputs=" + str(self.inputs) + ", output=" + str(self.output) + "}"


def process(element, SignalsTable):
    inputs = []
    for i in element.inputs:
        inputs.append(SignalsTable[i])
    if element.type == 0: # AND
        SignalsTable[element.output] = spAND(inputs)
    elif element.type == 1: # OR
        SignalsTable[element.output] = spOR(inputs)
    elif element.type == 2: # XOR
        SignalsTable[element.output] = spXOR(inputs)
    elif element.type == 3:  # XNOR
        SignalsTable[element.output] = spXNOR(inputs)
    elif element.type == 4:  # NAND
        SignalsTable[element.output] = spNAND(inputs)
    elif element.type == 5:  # NOR
        SignalsTable[element.output] = spNOR(inputs)
    elif element.type == 6:  # NOT
        SignalsTable[element.output] = spNOT(inputs)
    return SignalsTable


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


def readCircuit():
    with open('circuit.txt') as f:
        lines = [line.rstrip('\n') for line in f]

    inputs = lines[0].split()[1:]

    flag = [lines[1:], inputs]
    while len(flag) != 1:
        flag = sort(flag[0], flag[1])

    return [[lines[0]]+flag[0], inputs]


def main():
    sortedCircuit = readCircuit()

    ElementsTable = []
    ElementTypes = ["AND", "OR", "XOR", "XNOR", "NAND", "NOR", "NOT"]

    for i in sortedCircuit[0][1:]:
        splitLine = i.split()
        type = splitLine[0]
        output = splitLine[1]
        inputs = []
        for j in splitLine[2:]:
            inputs.append(j)
        ElementsTable.append(Entity(ElementTypes.index(type), inputs, output))

    SignalsTable = dict()
    for i in ElementsTable:
        for j in i.inputs:
            SignalsTable[j] = 0
        SignalsTable[i.output] = 0

    for i in ElementsTable:
        SignalsTable = process(i, SignalsTable)

    print(SignalsTable)


if __name__ == "__main__":
    main()
