---
title: 南师大2024年新生赛（第三场）Python 题解
category: [计算机, Python]
tags: [本科]
date: 2024/09/23
toc: false
---

本文将不会更新视频题解.

<!-- more -->

**A. 输入输出实验——`scanf`和`printf`的“妙用”**

``` python
def main():
    a, b = map(int, input().split())
    if a == 1:
        year, month, day = map(int, input().split("-"))
    elif a == 2:
        month, day, year = map(int, input().split("/"))
    else:
        day, month, year = map(int, input().split("/"))
    if b == 1:
        print("%04d" % year, "%02d" % month, "%02d" % day, sep="-")
    elif b == 2:
        print("%02d" % month, "%02d" % day, "%04d" % year, sep="/")
    else:
        print("%02d" % day, "%02d" % month, "%04d" % year, sep="/")
    return

main()
```

**B. 简单思维训练——这是一道$A+B$**

```python
def main():
    a, b = map(int, input().split())
    c = sum(map(int, input().split()))
    d, e = min(a, c), min(b, 10 - c)
    f, g = max(a, 10 - c), max(b, c)
    print(d + e, f + g - 10)
    return

main()
```

**C. 初遇高精度——这还是一道$A+B$**

```python
def main():
    input()
    a, b = int(input().split()[-1][-1]), int(input().split()[-1][-1])
    print(str(a + b)[-1])
    return

main()
```

**D. 时间复杂度入门——从$l$加到$r$**

```python
def main():
    n = int(input())
    for _ in range(n):
        l, r = map(int, input().split())
        print((l + r) * (r - l + 1) // 2)
    return

main()
```

**E. 空间复杂度入门——计算空间开销**

```python
def main():
    n, m = map(int, input().split())
    s = [0, 0]
    for _ in range(n):
        a, b = map(int, input().split())
        s[1] += a * b
    s = [s[1] // 1024, s[1] % 1024]
    if s[0] > m or (s[0] == m and s[1] != 0):
        print("MLE")
    else:
        print("OK\n{}KB {}B".format(*s))
    return

main()
```

**F. 考拉兹猜想——怎么又是你**

```python
def main():
    k = int(input())
    match k % 3:
        case 1:
            print(2)
        case 2:
            print(4)
        case 0:
            print(1)
    return

main()
```

**G. 子串计数I**

```python
def main():
    n = int(input())
    s = input()
    l = [0] * 4
    for i in range(n - 1):
        l[{"00": 0, "01": 1, "10": 2, "11": 3}[s[i:i + 2]]] += 1
    print(*l)
    return

main()
```

**H. 子串计数II**

```python
def main():
    n, q = map(int, input().split())
    s = input()
    p, a = 0, [0]
    for i in range(n - 1):
        p += {"00": 0, "01": 1, "10": -1, "11": 0}[s[i:i + 2]]
        a.append(p)
    while q:
        l, r = map(int, input().split())
        print("No" if a[r - 1] - a[l - 1] else "Yes")
        q -= 1
    return

main()
```

**I. 寻找消失的集合I**

```python
def main():
    input()
    a = set(map(int, input().split()))
    c = set(map(int, input().split()))
    for b in map(int, input().split()):
        if b in a and b in c:
            print("Yes")
        elif b not in a and b not in c:
            print("Yes")
        else:
            print("No")
    return

main()
```

**J. 寻找消失的集合II**

```python
def main():
    n, m, k = map(int, input().split())
    a = set(map(int, input().split()))
    c = set(map(int, input().split()))
    b = c.difference(a)
    p = list(a.difference(b))
    for i in range(k - m + n):
        b.add(p[i])
    print(*b)
    return

main()
```

**K. 后缀表示法**

```python
class Rpn:
    stack = []

    @staticmethod
    def construct(s):
        n, *r = s.split(".")
        n = int(n) * 10 ** 4
        if r:
            n += int(r[0]) * 10 ** (4 - len(r[0]))
        return n

    def push(self, x):
        self.stack.append(x)
        return

    def pop(self):
        return self.stack.pop()

    def addition(self):
        r, l = self.pop(), self.pop()
        self.push(l + r)
        return

    def subtraction(self):
        r, l = self.pop(), self.pop()
        self.push(l - r)
        return

    def multiplication(self):
        r, l = self.pop(), self.pop()
        self.push(l * r // 10 ** 4)
        return

    def division(self):
        r, l = self.pop(), self.pop()
        self.push(l * 10 ** 4 // r)
        return

def main():
    n = int(input())
    rpn = Rpn()
    q = input().split()
    for i in range(n):
        a = q[i]
        if a == "+":
            rpn.addition()
        elif a == "-":
            rpn.subtraction()
        elif a == "*":
            rpn.multiplication()
        elif a == "/":
            rpn.division()
        else:
            rpn.push(rpn.construct(a))
    r = str(rpn.pop())
    print("{}.{}".format(r[:-4], r[-4:]))
    return

main()
```

**L. 能做到这题，你这辈子有了**

```python
def main():
    n = int(input())
    p, q, r = [], [], []
    for _ in range(n):
        a, b, c = input().split()
        c = int(c)
        if c == 2:
            p.append(a)
            p.append(b)
        elif c == -2:
            q.append(a)
            q.append(b)
        else:
            r.append((a, b))
        for i in r:
            if i[0] in p:
                q.append(i[1])
                r.remove(i)
                break
            elif i[0] in q:
                p.append(i[1])
                r.remove(i)
                break
            elif i[1] in p:
                q.append(i[0])
                r.remove(i)
                break
            elif i[1] in q:
                p.append(i[0])
                r.remove(i)
                break
    print(1, p[0], sep="\n")
    return

main()
```

**M. 注意力惊人A**

```python
def main():
    n = int(input())
    print(*[5 * i for i in range(1, n + 1)])
    return

main()
```

**N. FBI #2**

```python
def main():
    fib = [0, 1]
    n = int(input())
    l = [int(input()) for _ in range(n)]
    for i in range(2, max(l) + 1):
        fib.append(fib[i - 1] + fib[i - 2])
    print(*[fib[i] for i in l], sep="\n")
    return

main()
```
