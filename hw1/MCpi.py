import math
import random
import matplotlib.pyplot as plt

def placePoints(iterations):
    x_points = []
    y_points = []
    for i in range(0, iterations):
        x_points.append(random.uniform(-1, 1))
        y_points.append(random.uniform(-1, 1))
    return [x_points, y_points]

def checkPoints(points):
    colors = []
    for i in range(0, len(points)):
        x = math.sqrt(points[i][0] ** 2 + points[i][1] ** 2)
        if x < 1:
            points[i] = points[i][:-1] + (1, )
            colors.append('r')
        else:
            colors.append('b')
    return colors

def piApprox(iterations):
    points = placePoints(iterations)
    XY = [i for i in zip(points[0], points[1], [0] * iterations)]
    colors = checkPoints(XY)
    in_points = list((i[2] for i in XY)).count(1)
    res = (in_points / iterations) * 4
    print("Pi approximation for", iterations, "iterations:", res)
    return [res, XY, colors]

def plot(inp):
    plt.xlim([-1, 1])
    plt.ylim([-1, 1])
    plt.title("Pi approximation: " + str(inp[0]))
    plt.scatter([x[0] for x in inp[1]], [x[1] for x in inp[1]], color=inp[2])
    plt.show()

if __name__ == '__main__':
    iters = [10, 100, 1000, 4456, 10000]
    results = []
    for i in iters:
        approx = piApprox(i)
        results.append(approx[0])
        plot(approx)
    plt.plot(iters, results)
    plt.show()

