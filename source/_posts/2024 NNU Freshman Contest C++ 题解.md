---
title: 2024 NNU Freshman Contest C++ 题解
category: [计算机, C++]
tags: [本科]
date: 2024/11/20
toc: false
---

本文的视频题解可以在 [哔哩哔哩](https://www.bilibili.com/video/BV1VbUHY5E8T/) 找到.

<!-- more -->

**A. Save your tears for the day so far away**

``` cpp
#include <bits/stdc++.h>
using namespace std;

int check(const char &a, const char &b, const vector<char> &v) {
    int d = 0;
    for (const char it: v)
        if (d & 1) {
            if (it == a)
                ++d;
        } else {
            if (it == b)
                ++d;
        }
    if (d & 1)
        --d;
    return d;
}

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    int n;
    cin >> n;
    vector<char> v(n);
    for (int i = 0; i < n; ++i)
        cin >> v[i];
    int ans = INT_MAX; // ans = n;
    for (char a = 'a'; a <= 'z'; ++a)
        for (char b = 'a'; b <= 'z'; ++b)
            ans = min(ans, n - check(a, b, v));
    cout << ans;
    return 0;
}
```

**B. To irrigate the wilderness that's still asleep**

``` cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    int n, k;
    cin >> n >> k;
    vector<pair<int, int> > v(k);
    vector<int> pos(k);
    for (int i = 0; i < k; ++i) {
        cin >> v[i].first >> v[i].second;
        pos[i] = v[i].second;
    }
    queue<pair<vector<int>, int> > q;
    q.push(make_pair(pos, 0));
    set<vector<int> > vis;
    vis.insert(pos);
    while (!q.empty()) {
        auto cur_pos = q.front().first;
        int cur_rot = q.front().second;
        q.pop();
        if (all_of(cur_pos.begin(), cur_pos.end(), [](int c) { return c == 1; })) {
            cout << cur_rot;
            return 0;
        }
        for (int i = 0; i < k - 1; ++i)
            for (int j = i + 1; j < k; ++j) {
                auto new_pos = cur_pos;
                new_pos[i] = (new_pos[i] - 1 + v[i].first) % n + 1;
                new_pos[j] = (new_pos[j] - 1 + v[j].first) % n + 1;
                if (vis.find(new_pos) == vis.end()) {
                    vis.insert(new_pos);
                    q.push(make_pair(new_pos, cur_rot + 2));
                }
            }
    }
    cout << -1;
    return 0;
}
```

**C. In the world waiting to be lit**

**D. To spread over the riverbeds so dry and dead**

``` cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;

ll gcd(const ll a, const ll b) {
    return b > 0 ? gcd(b, a % b) : a;
}

void exgcd(const ll a, const ll b, ll &x, ll &y) {
    if (b == 0) {
        x = 1, y = 0;
        return;
    }
    exgcd(b, a % b, y, x);
    y -= a / b * x;
}

ll solve(ll n, ll r, const ll a, const ll g) {
    ll b = n - a;
    if (b % g != 0)
        return -1;
    n /= g, r /= g, b /= g;
    ll x, y;
    exgcd(r, n, x, y);
    while (x < 0)
        x += n;
    return b * x % n;
}

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    int n, k;
    cin >> n >> k;
    vector<ll> r(k), a(k), p(k), q(k);
    ll res = 0;
    for (int i = 0; i < k; ++i) {
        cin >> r[i] >> a[i];
        --a[i];
        const ll g = gcd(n, r[i]);
        p[i] = solve(n, r[i], a[i], g);
        q[i] = n / g;
        if (p[i] == -1) {
            cout << -1;
            return 0;
        }
        res += p[i];
    }
    if (res % 2 == 0) {
        cout << res;
        return 0;
    }
    int idx = 0;
    ll m = LONG_LONG_MAX;
    while (p[idx] % 2 == 0)
        ++idx;
    for (int i = 0; i < k; ++i) {
        if (i == idx)
            continue;
        if (q[i] % 2 == 1)
            m = min(m, q[i]);
    }
    if (m != LONG_LONG_MAX) {
        cout << res + m;
        return 0;
    }
    for (int i = idx + 1; i < k; ++i)
        if (p[i] % 2 == 1) {
            cout << res + q[idx];
            return 0;
        }
    cout << -1;
    return 0;
}
```

**E. Let ships that ran aground re-launch their sails**

``` cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    int a, b, c;
    cin >> a >> b >> c;
    if (b < a)
        cout << -1;
    else
        cout << max(c - a, 0);
    return 0;
}
```

**F. Ah how I long to embrace**

``` cpp
#include <bits/stdc++.h>
using namespace std;

enum input_type { CORRECT = -1, NOT_FACTOR, FACTOR };

enum output_type { QUERY, ADD, SUBMIT };

input_type input() {
    int i;
    cin >> i;
    return static_cast<input_type>(i);
}

void output(const output_type &i, const long long &n) {
    char c = ' ';
    switch (i) {
        case QUERY:
            c = '?';
            break;
        case ADD:
            c = '+';
            break;
        case SUBMIT:
            c = '!';
            break;
    }
    cout << c << " " << n << endl;
    fflush(stdout);
}

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    long long p = 2;
    while (true) {
        output(QUERY, p);
        switch (input()) {
            case CORRECT:
                output(SUBMIT, p);
                return 0;
            case NOT_FACTOR:
                output(ADD, p / 2);
            case FACTOR:
                p <<= 1;
                break;
        }
    }
}
```

**G. The future breaking out of shades from the past**

``` cpp
#include <bits/stdc++.h>
using namespace std;

enum input_type { CORRECT = -1, NOT_FACTOR, FACTOR };

enum output_type { QUERY, ADD, SUBMIT };

input_type input() {
    int i;
    cin >> i;
    return static_cast<input_type>(i);
}

void output(const output_type &i, const long long &n) {
    char c = ' ';
    switch (i) {
        case QUERY:
            c = '?';
            break;
        case ADD:
            c = '+';
            break;
        case SUBMIT:
            c = '!';
            break;
    }
    cout << c << " " << n << endl;
    fflush(stdout);
}

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    output(ADD, 0b11111);
    long long p = 2;
    while (true) {
        output(QUERY, p);
        switch (input()) {
            case CORRECT:
                output(SUBMIT, p);
                return 0;
            case NOT_FACTOR:
                output(ADD, p / 2);
            case FACTOR:
                p <<= 1;
                break;
        }
    }
}
```

**H. Still ablaze**

``` cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    int n, m;
    cin >> n >> m;
    vector<int> v(n), w(n), dp(m + 1);
    for (int i = 0; i < n; ++i)
        cin >> v[i] >> w[i];
    for (int i = 0; i < n; ++i)
        for (int j = m; j >= v[i]; --j)
            dp[j] = max(dp[j], dp[j - v[i]] + w[i]);
    cout << dp[m];
    return 0;
}
```

**I. Seeds bear new life when flowers dare to fade**

``` cpp
#include <bits/stdc++.h>
using namespace std;

constexpr int MAX_W = 100 * 1000;

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    int n, m;
    cin >> n >> m;
    vector<long long> v(n), w(n), dp(MAX_W + 1);
    for (int i = 1; i <= MAX_W; ++i)
        dp[i] = INT_MAX;
    for (int i = 0; i < n; ++i)
        cin >> v[i] >> w[i];
    int ans = 0;
    for (int i = 0; i < n; ++i)
        for (int j = MAX_W; j >= w[i]; --j) {
            dp[j] = min(dp[j], dp[j - w[i]] + v[i]);
            if (dp[j] <= m)
                ans = max(ans, j);
        }
    cout << ans;
    return 0;
}
```

**J. Petals linger about**

``` cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;
typedef pair<ll, ll> pll;

void dfs(const int idx, const int &n, const ll now_v, const ll now_w, vector<pll> &p,
         const vector<ll> &v, const vector<ll> &w, const int &m) {
    if (now_v > m)
        return;
    if (idx == n) {
        p.emplace_back(now_v, now_w);
        return;
    }
    dfs(idx + 1, n, now_v + v[idx], now_w + w[idx], p, v, w, m);
    dfs(idx + 1, n, now_v, now_w, p, v, w, m);
}

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    int n, m;
    cin >> n >> m;
    vector<ll> v(n), w(n);
    for (int i = 0; i < n; ++i)
        cin >> v[i] >> w[i];
    vector<pll> pre, suf;
    dfs(0, n / 2, 0, 0, pre, v, w, m);
    dfs(n / 2, n, 0, 0, suf, v, w, m);
    sort(suf.begin(), suf.end());
    vector<ll> max_w(suf.size());
    max_w[0] = suf[0].second;
    for (int i = 1; i < suf.size(); ++i)
        max_w[i] = max(max_w[i - 1], suf[i].second);
    ll ans = 0;
    for (auto &it: pre) {
        int idx = upper_bound(suf.begin(), suf.end(),
                              make_pair(m - it.first, LONG_LONG_MAX)) - suf.begin();
        if (idx == 0) {
            ans = max(ans, it.second);
            continue;
        }
        ans = max(ans, it.second + max_w[idx - 1]);
    }
    cout << ans;
    return 0;
}
```

**K. Awaiting one last dance**

``` cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    int n;
    cin >> n;
    string s1, s2;
    cin >> s1 >> s2;
    vector cnt(128, 0);
    for (const auto c: s1)
        ++cnt[c];
    for (const auto c: s2)
        --cnt[c];
    for (const auto i: cnt)
        if (i != 0) {
            cout << -1;
            return 0;
        }
    vector<pair<int, int> > ans;
    for (int i = 0; i < n; ++i) {
        if (s1[i] == s2[i])
            continue;
        auto it = s2.find(s1[i], i);
        reverse(s2.begin() + i, s2.begin() + it + 1);
        ans.emplace_back(i + 1, it + 1);
    }
    cout << ans.size() << endl;
    for (const auto &[l, r]: ans)
        cout << "2 " << l << " " << r << endl;
    return 0;
}
```

**L. Shaking off all the dust from the past**

数学推导过程[见此](https://m.xv1r.cn/s/raRdiRB3K4PWseK).

``` cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;

constexpr ll MOD = 998244353;

ll quick_pow(ll a, ll b, const ll &m) {
    ll ans = 1;
    while (b > 0) {
        if (b & 1)
            ans = ans * a % m;
        b >>= 1;
        a = a * a % m;
    }
    return ans % m;
}

ll inv(const ll &a, const ll &m) {
    return quick_pow(a, m - 2, m);
}

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    int n;
    cin >> n;
    ll k = 2;
    for (int i = 1; i <= n - 1; ++i)
        k = (k + 2 * inv(i, MOD)) % MOD;
    cout << k;
    return 0;
}
```

**M. New stories have yet to start**

``` cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    cin.tie(nullptr), cout.tie(nullptr), ios::sync_with_stdio(false);
    unsigned long long a, b, c, d;
    cin >> a >> b >> c >> d;
    cout << a * b * c * d;
    return 0;
}
```
