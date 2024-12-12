---
title: 南师大 2024 年新生赛 (第一场) Python 题解
category: [教学, 本科]
tags: [计算机科学, 程序设计, Python]
date: 2024/08/29
---

本文的视频题解可以在 [哔哩哔哩](https://www.bilibili.com/video/BV1BsWWe7EWh/) 找到.

<!-- more -->

**#1**

```python
def main():
    a, b, c = map(int, input().split())
    if a > b:
        if b > c:
            print(a, b, c)
        else:
            if a > c:
                print(a, c, b)
            else:
                print(c, a, b)
    else:
        if b > c:
            if a > c:
                print(b, a, c)
            else:
                print(b, c, a)
        else:
            print(c, b, a)
    return

main()
```

**#1** `list.sort`, `sorted`

``` python
def main():
    l = map(int, input().split())
    # 1. list.sort 方法
    l = list(l)
    l.sort(reverse=True)
    print(*l)
    return

main()
```

```python
def main():
    l = map(int, input().split())
    # 2. sorted 函数
    l = sorted(l, reverse=True)
    print(*l)
    return

main()
```

**#2**

``` python
def main():
    a, b, c = map(int, input().split())
    if a > b:
        if b > c:
            print(b, a)
        else:
            if a > c:
                print(c, a)
            else:
                print(a, c)
    else:
        if b > c:
            if a > c:
                print(a, b)
            else:
                print(c, b)
        else:
            print(b, c)
    return

main()
```

**#3**

```python
def is_leap(yr):
    return yr % 4 == 0 and yr % 100 != 0 or yr % 400 == 0

def main():
    yr, mo = map(int, input().split())
    d = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][mo]
    if is_leap(yr) and mo == 2:
        d += 1
    print(d)
    return

main()
```

**#3** `match`

``` python
def is_leap(yr):
    return yr % 4 == 0 and yr % 100 != 0 or yr % 400 == 0

def main():
    yr, mo = map(int, input().split())
    match mo:
        case 1 | 3 | 5 | 7 | 8 | 10 | 12:
            d = 31
        case 4 | 6 | 9 | 11:
            d = 30
        case 2:
            d = 29 if is_leap(yr) else 28
        case _:
            d = 0
    print(d)
    return

main()
```

**#3** `calendar.monthrange`

``` python
import calendar

def main():
    yr, mo = map(int, input().split())
    d = calendar.monthrange(yr, mo)[1]
    print(d)
    return

main()

```

**#4**

``` python
def is_leap(yr):
    return yr % 4 == 0 and yr % 100 != 0 or yr % 400 == 0

def days_in_month(yr, mo):
    d = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][mo]
    if is_leap(yr) and mo == 2:
        d += 1
    return d

def main():
    yr, mo, d = map(int, input().split())
    for i in range(1, mo):
        d += days_in_month(yr, i)
    print(d)
    return

main()
```

**#5**

```python
def main():
    x = int(input())
    s = 1 + x
    for i in range(2, x):
        if x % i == 0:
            s += i
    print(s)
    return

main()
```

**#6**

``` python
def main():
    x = int(input())
    for i in range(2, x):
        if x % i == 0:
            print("No")
            return
    print("Yes")
    return

main()
```

**#7**

``` python
def is_prime(x):
    for i in range(2, int(x / 2) + 1):
        if x % i == 0:
            return False
    return True

def main():
    n = int(input())
    s = 0
    for i in range(2, n + 1):
        if is_prime(i):
            s += 1
    print(s)
    return

main()
```

**#8**

``` python
def is_prime(x):
    if x == 1:
        return False
    for i in range(2, int(x / 2) + 1):
        if x % i == 0:
            return False
    return True

def main():
    x = int(input())
    for i in range(2, int(x / 2) + 1):
        if is_prime(i) and is_prime(x - i):
            print("{}+{}={}".format(i, x - i, x))
    return

main()
```

**#9**

```python
def main():
    n = int(input())
    s = 0
    while n != 0:
        s += n % 10
        n //= 10
    print(s)
    return

main()
```

**#9** `sum`

```python
def main():
    print(sum(map(int, input())))
    return

main()
```

**#10**

```python
def main():
    n1 = int(input())
    n2 = 0
    while n1 != 0:
        n2 *= 10
        n2 += n1 % 10
        n1 //= 10
    print(n2)
    return

main()
```

**#10** 切片

```python
def main():
    print(input()[::-1])
    return

main()
```

**#10** `reversed`

```python
def main():
    n = input()
    print(*list(reversed(n)), sep="")
    return

main()
```

**#11**

```python
def main():
    n = int(input())
    n1 = n
    n2 = 0
    while n1 != 0:
        n2 *= 10
        n2 += n1 % 10
        n1 //= 10
    print("Yes" if n2 == n else "No")
    return

main()
```

**#11** 切片

```python
def main():
    n = input()
    print("Yes" if n == n[::-1] else "No")
    return

main()
```

**#12**

```python
def is_palindrome(n):
    n1 = n
    n2 = 0
    while n1 != 0:
        n2 *= 10
        n2 += n1 % 10
        n1 //= 10
    return n2 == n

def main():
    n = int(input())
    s = 0
    for i in range(1, n):
        if is_palindrome(i):
            s += 1
    print(s)
    return

main()
```

**#13**

```python
def is_prime(x):
    if x == 1:
        return False
    for i in range(2, int(x / 2) + 1):
        if x % i == 0:
            return False
    return True

def main():
    n = int(input())
    while n != 0:
        if not is_prime(n):
            print("No")
            return
        n //= 10
    print("Yes")
    return

main()
```

**#14**

```python
def is_prime(x):
    if x == 1:
        return False
    for i in range(2, int(x / 2) + 1):
        if x % i == 0:
            return False
    return True

def is_super_prime(n):
    while n != 0:
        if not is_prime(n):
            return False
        n //= 10
    return True

def main():
    n = int(input())
    s = 0
    for i in range(2, n + 1):
        if is_super_prime(i):
            s += 1
    print(s)
    return

main()
```

**#15**

```python
def gcd(a, b):
    # Euclid 算法: gcd(a, b) == gcd(b, a % b)
    while b != 0:
        a, b = b, a % b
    return a

def main():
    a, b = map(int, input().split())
    print(gcd(a, b), int(a * b / gcd(a, b)), sep="\n")
    return

main()
```

**#16**

```python
def gcd(a, b):
    while b != 0:
        a, b = b, a % b
    return a

def main():
    b1, a1 = map(int, input().split())
    b2, a2 = map(int, input().split())
    denominator = a1 * a2
    numer = b1 * a2 + b2 * a1
    t = gcd(denominator, numer)
    print(int(numer / t), int(denominator / t))
    return

main()
```

**#16** `fractions`

```python
import fractions

def main():
    f1 = fractions.Fraction(*map(int, input().split()))
    f2 = fractions.Fraction(*map(int, input().split()))
    f3 = f1 + f2
    print(f3.numerator, f3.denominator)
    return

main()
```

**#17**

```python
def main():
    n = int(input())
    l = len(str(n))
    t = n // 10 ** (l - 1)
    n %= 10 ** (l - 1)
    print(n, t, sep="")
    return

main()
```

**#18**

```python
def fib(n):
    if n == 1 or n == 2:
        return 1
    return fib(n - 1) + fib(n - 2)

def main():
    k1, k2 = map(int, input().split())
    s = 0
    for i in range(k1, k2 + 1):
        s += fib(i)
    print(s)
    return

main()
```

**#18** 动态规划

```python
def main():
    fib = [0, 1]
    k1, k2 = map(int, input().split())
    for i in range(2, k2 + 1):
        fib.append(fib[i - 1] + fib[i - 2])
    s = sum(fib[k1:k2 + 1])
    print(s)
    return

main()
```

**#19**

```python
def main():
    input()
    a = list(map(int, input().split()))
    a.append(a[0])
    del a[0]
    print(*a)
    return

main()
```

**#20**

```python
def main():
    n = int(input())
    a = list(map(int, input().split()))
    m = max(a)
    s = 0
    for i in a:
        if i == m:
            s += 1
    print(s)
    return

main()
```

**#20** 勘误

```python
def main():
    n = int(input())
    a = list(map(int, input().split()))
    m, s = a[0], 1
    for i in range(1, n):
        if a[i] == m:
            s += 1
        elif a[i] > m:
            m = a[i]
            s = 1
    print(s)
    return

main()
```

**#21**

```python
def main():
    n = int(input())
    a, b, s = 0, 0, 0
    while n:
        s += n
        a += n
        b += n
        n = a // 3 + b // 4
        a %= 3
        b %= 4
    print(s)
    return

main()
```
