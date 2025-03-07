import random

box = [[0 for i in range(4)] for i in range(4)]
spaces = []

def main ():
    spaces = ['00','01','02','03','10','11','12','13','20','21','22','23','30','31','32','33']
    pos1 = pickPosition(spaces)
    spaces.remove(pos1)
    pos2 = pickPosition(spaces)
    box[int(pos1[0])][int(pos1[1])] = generateDigit()
    box[int(pos2[0])][int(pos2[1])] = generateDigit()
    outputBox()
    while True:
        cmd = input()
        if cmd == 'A':
            swipeLeft()
        elif cmd == 'W':
            swipeUp()
        elif cmd == 'S':
            swipeDown()
        elif cmd == 'D':
            swipeRight()
        print()
        outputBox()

def generateDigit():
    return random.choices([2, 4], weights=[90, 10], k=1)[0]

def pickPosition(pos):
    return random.choice(pos)

def outputBox ():
    for i in range(4):
        for j in range(4):
            print(box[i][j], end= ' ')
        print()

def swipeRight ():
    spaces = []

    for i in range(4):
        emptyList = []
        index = 0
        for j in range(4):
            if box[i][4-j-1] != 0:
                emptyList.append(box[i][4-j-1])
                index+=1
        for j in range(index,4):
            emptyList.append(0)
        index = 4
        for j in range(4):
            box[i][4 -j -1] = emptyList[j]
    
    for i in range(4):
        prev = box[i][3]
        emptyList = []
        index = 0
        j = 1
        while j < 4:
            if prev != 0 and prev != -1:
                index+=1
            elif prev == 0:
                break
            elif prev == -1:
                prev = box[i][4-j-1]
                j+=1
                continue

            if box[i][4-j-1] == prev:
                emptyList.append(prev*2)
                prev = -1
            else:
                emptyList.append(prev)
                prev = box[i][4-j-1]
            j+=1
        if prev != 0 and prev != -1:
            emptyList.append(prev)
            index+=1
        for j in range(index,4):
            emptyList.append(0)
            spaces.append(str(i) + str(4-j-1))
        for j in range(4):
            box[i][4 -j -1] = emptyList[j]

    pos = pickPosition(spaces)
    box[int(pos[0])][int(pos[1])] = generateDigit()

            

def swipeLeft ():
    spaces = []

    for i in range(4):
        emptyList = []
        index = 0
        for j in range(4):
            if box[i][j] != 0:
                emptyList.append(box[i][j])
                index+=1
        for j in range(index,4):
            emptyList.append(0)
        for j in range(4):
            box[i][j] = emptyList[j]
    
    for i in range(4):
        prev = box[i][0]
        emptyList = []
        index = 0
        j = 1
        while j < 4:
            if prev != 0 and prev != -1:
                index+=1
            elif prev == 0:
                break
            elif prev == -1:
                prev = box[i][j]
                j+=1
                continue

            if box[i][j] == prev:
                emptyList.append(prev*2)
                prev = -1
            else:
                emptyList.append(prev)
                prev = box[i][j]
            j+=1
        if prev != 0 and prev != -1:
            emptyList.append(prev)
            index+=1
        for j in range(index,4):
            emptyList.append(0)
            spaces.append(str(i) + str(j))
        for j in range(4):
            box[i][j] = emptyList[j]
    
    pos = pickPosition(spaces)
    box[int(pos[0])][int(pos[1])] = generateDigit()

def swipeDown ():
    spaces = []

    for i in range(4):
        emptyList = []
        index = 0
        for j in range(4):
            if box[4-j-1][i] != 0:
                emptyList.append(box[4-j-1][i])
                index+=1
        for j in range(index,4):
            emptyList.append(0)
        for j in range(4):
            box[4-j-1][i] = emptyList[j]
    outputBox()
    for i in range(4):
        prev = box[3][i]
        emptyList = []
        index = 0
        j = 1
        while j < 4:
            if prev != 0 and prev != -1:
                index+=1
            elif prev == 0:
                break
            elif prev == -1:
                prev = box[4-j-1][i]
                j+=1
                continue
            
            if box[4-j-1][i] == prev:
                emptyList.append(prev*2)
                prev = -1
            else:
                emptyList.append(prev)
                prev = box[4-j-1][i]
            j+=1
        if prev != 0 and prev != -1:
            emptyList.append(prev)
            index+=1
        for j in range(index,4):
            emptyList.append(0)
            spaces.append(str(4-j-1) + str(i))
        for j in range(4):
            box[4-j-1][i] = emptyList[j]

    pos = pickPosition(spaces)
    box[int(pos[0])][int(pos[1])] = generateDigit()

def swipeUp ():
    spaces = []

    for i in range(4):
        emptyList = []
        index = 0
        for j in range(4):
            if box[j][i] != 0:
                emptyList.append(box[j][i])
                index+=1
        for j in range(index,4):
            emptyList.append(0)
        for j in range(4):
            box[j][i] = emptyList[j]
    
    for i in range(4):
        prev = box[0][i]
        emptyList = []
        index = 0
        j = 1
        while j < 4:
            if prev != 0 and prev != -1:
                index+=1
            elif prev == 0:
                break
            elif prev == -1:
                prev = box[j][i]
                j+=1
                continue

            if box[j][i] == prev:
                emptyList.append(prev*2)
                prev = -1
            else:
                emptyList.append(prev)
                prev = box[j][i]
            j+=1
        if prev != 0 and prev != -1:
            emptyList.append(prev)
            index+=1
        for j in range(index,4):
            emptyList.append(0)
            spaces.append(str(j) + str(i))
        for j in range(4):
            box[j][i] = emptyList[j]

    pos = pickPosition(spaces)
    box[int(pos[0])][int(pos[1])] = generateDigit()

main()
