import math
import random
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.animation import FuncAnimation

x_points = []
y_points = []
colors = []

def placePoints(iterations):
    for i in range(0, iterations):
        x_points.append(random.uniform(-1, 1))
        y_points.append(random.uniform(-1, 1))

def checkPoints(points):
    for i in range(0, len(points)):
        x = math.sqrt(points[i][0] ** 2 + points[i][1] ** 2)
        if x < 1:
            points[i] = points[i][:-1] + (1, )
            colors.append('r')
        else:
            colors.append('b')

if __name__ == '__main__':
    iters = 200000
    placePoints(iters)
    XY = [i for i in zip(x_points, y_points, [0]*iters)]
    checkPoints(XY)
    in_points = list((i[2] for i in XY)).count(1)
    res = (in_points/iters)*4
    print(res)
    fig = plt.figure()
    plt.xlim([-1, 1])
    plt.ylim([-1, 1])
    plt.title("Pi approximation: " + str(res))

    ## ANIMATE
    # graph, = plt.plot([], [], "o")
    #
    # def animate(i):
    #     graph.set_data([x[0] for x in XY][:i+1], [x[1] for x in XY][:i+1])
    #  #   graph.set_offsets(np.c_[x_vals,y_vals])
    #     graph.set_color(colors[:i+1][-1])
    #     return graph
    #
    # animated = FuncAnimation(fig, animate, frames=iters, interval=0.01)
    #
    # plt.figure()
    plt.scatter([x[0] for x in XY], [x[1] for x in XY], color=colors)
    plt.show()