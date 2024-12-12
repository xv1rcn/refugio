---
title: 南师大 2024 年新生赛 (第二场) Python 题解
category: [教学, 本科]
tags: [计算机科学, 程序设计, Python]
date: 2024/09/01
---

本文的视频题解可以在 [哔哩哔哩](https://www.bilibili.com/video/BV1vgsMevEL1/) 找到.

<!-- more -->

**A. 为了盐城鸡蛋饼什么都干得出来 (Easy Version)**

``` python
def solution():
    n, m = map(int, input().split())
    c = n * m
    u, d = c // 2, c % 2
    print(u, d)
    return

def main():
    for _ in range(int(input())):
        solution()
    return

main()
```

**B. 依我看，小逝一桩 (Easy Version)**

```python
def construct(s):
    is_healing = s[0] == "A"
    if s[1] == "A":
        return is_healing, 1
    elif s[1] == "J":
        return is_healing, 11
    elif s[1] == "Q":
        return is_healing, 12
    elif s[1] == "K":
        return is_healing, 13
    else:
        return is_healing, int(s[1:])

def main():
    deck_cards = []
    for _ in range(int(input())):
        deck_cards.append(construct(input()))
    hp, dmg, heal = 3, 0, 0
    while True:
        hp -= 1
        if heal:
            hp += 1
            heal -= 1
        if not hp:
            break
        dmg += 1
        drawn_cards = []
        for _ in range(4):
            drawn_cards.append(deck_cards.pop(0))
        drawn_cards = sorted([card[1] for card in drawn_cards if card[0]])
        pts = 0
        for pt in drawn_cards:
            pts += pt
            if pts <= 13:
                heal += 1
            else:
                break
    print(dmg)
    return

main()
```

**C. 拼点**

```python
def construct(n):
    if n == "A":
        return 1
    elif n == "B":
        return 2
    elif n == "C":
        return 3
    elif n == "D":
        return 4
    elif n == "J":
        return 11
    elif n == "Q":
        return 12
    elif n == "K":
        return 13
    else:
        return int(n)

def main():
    n, m = map(int, input().split())
    a_points = list(map(construct, input().split()))
    a_colors = list(map(construct, input().split()))
    b_points = list(map(construct, input().split()))
    b_colors = list(map(construct, input().split()))
    a_points_max, a_colors_max = 0, 0
    for i in range(n):
        if a_points_max < a_points[i]:
            a_points_max, a_colors_max = a_points[i], a_colors[i]
        elif a_points_max == a_points[i] and a_colors_max < a_colors[i]:
            a_colors_max = a_colors[i]
    b_points_max, b_colors_max = 0, 0
    for i in range(m):
        if b_points_max < b_points[i]:
            b_points_max, b_colors_max = b_points[i], b_colors[i]
        elif b_points_max == b_points[i] and b_colors_max < b_colors[i]:
            b_colors_max = b_colors[i]
    if a_points_max > b_points_max:
        print("Op Win")
    elif a_points_max < b_points_max:
        print("Op Out")
    elif a_colors_max > b_colors_max:
        print("Op Win")
    elif a_colors_max < b_colors_max:
        print("Op Out")
    else:
        print("all Lost")
    return

main()
```

**D. 哈希冲突**

```python
def main():
    n = int(input())
    a = list(map(int, input().split()))
    b = {}
    s = 0
    for i in range(n):
        if a[i] in b.keys():
            s += 1
            b[a[i]] = (b[a[i]] + i) / 2
        else:
            b[a[i]] = i
    print(s)
    for i in range(n):
        print("%.6f" % (b[i] if i in b.keys() else -1), end=" ")
    return

main()
```

**E. 我们有两次逃课机会**

```python
def main():
    input()
    a = sum(map(int, input().split()))
    print(a * 14)
    return

main()
```

**F. Collatz Conjecture**

```python
print(-1)
```

**G. 芝士，与你分享**

```python
def main():
    print(sum(map(int, input().split())))
    return

main()
```

**H. 来我家做客吧**

```python
def main():
    input()
    a = list(map(int, input().split()))
    x = max(a) - min(a)
    print(x)
    return

main()
```

**I. 你说的对，但是做不了一点**

```python
def main():
    n, m = map(int, input().split())
    p = max(map(int, input().split()))
    s = 0
    for i in range(m):
        a, b = map(int, input().split())
        if 27 * (a + b) / 4 >= p:
            s += 1
    print(s)
    return

main()
```

**J. 舰长，该凹深渊了**

```python
def main():
    n = int(input())
    a = {}
    for i in range(n):
        name, time = input().split()
        time = int(time)
        if name in a.keys():
            if a[name] > time:
                a[name] = time
        else:
            a[name] = time
    if "TannicAcid" not in a.keys():
        print(n + 1)
        return
    r = 1
    for name, time in a.items():
        if name != "TannicAcid" and a[name] < a["TannicAcid"]:
            r += 1
    print(r)
    return

main()
```

