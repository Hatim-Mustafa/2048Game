import random

box = [[0 for i in range(4)] for i in range(4)]
spaces = []

def main ():
    InitializeGame()
    outputBox()

    while True:
        cmd = input()
        basicMovement(cmd)
        print()
        outputBox()
    
def InitializeGame ():
    spaces = ['00','01','02','03','10','11','12','13','20','21','22','23','30','31','32','33']
    pos1 = pickPosition(spaces)
    spaces.remove(pos1)
    pos2 = pickPosition(spaces)
    box[int(pos1[0])][int(pos1[1])] = generateDigit()
    box[int(pos2[0])][int(pos2[1])] = generateDigit()

def generateDigit():
    return random.choices([2, 4], weights=[90, 10], k=1)[0]

def pickPosition(pos):
    return random.choice(pos)

def outputBox ():
    for i in range(4):
        for j in range(4):
            print(box[i][j], end= ' ')
        print()

def basicMovement (cmd):
    spaces = []

    for i in range(4):
        emptyList = []
        index = 0
        for j in range(4):
            coord = checkMotion(i, j, cmd)
            if box[coord[0]][coord[1]] != 0:
                emptyList.append(box[coord[0]][coord[1]])
                index+=1
        for j in range(index,4):
            emptyList.append(0)
        index = 4
        for j in range(4):
            coord = checkMotion(i, j, cmd)
            box[coord[0]][coord[1]] = emptyList[j]
    
    for i in range(4):
        coord = checkMotion(i, 0, cmd)
        prev = box[coord[0]][coord[1]]
        emptyList = []
        index = 0
        j = 1
        while j < 4:
            if prev != 0 and prev != -1:
                index+=1
            elif prev == 0:
                break
            elif prev == -1:
                coord = checkMotion(i, j, cmd)
                prev = box[coord[0]][coord[1]]
                j+=1
                continue

            coord = checkMotion(i, j, cmd)
            if box[coord[0]][coord[1]] == prev:
                emptyList.append(prev*2)
                prev = -1
            else:
                emptyList.append(prev)
                prev = box[coord[0]][coord[1]]
            j+=1
        if prev != 0 and prev != -1:
            emptyList.append(prev)
            index+=1
        for j in range(index,4):
            coord = checkMotion(i, j, cmd)
            emptyList.append(0)
            spaces.append(str(coord[0]) + str(coord[1]))
        for j in range(4):
            coord = checkMotion(i, j, cmd)
            box[coord[0]][coord[1]] = emptyList[j]

    pos = pickPosition(spaces)
    box[int(pos[0])][int(pos[1])] = generateDigit()

def checkMotion (i, j, cmd):
    if cmd == 'A':
        return [i, j]
    elif cmd == 'W':
        return [j, i]
    elif cmd == 'S':
        return [4-j-1, i]
    elif cmd == 'D':
        return [i, 4-j-1]

main()