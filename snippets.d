/// 素因数分解
long[long] factorize(long x)
{
    assert(0 < x, "x is negative");
    long[long] ps;
    while ((x & 1) == 0)
    {
        x /= 2;
        ps[2] = (2 in ps) ? ps[2] + 1 : 1;
    }
    for (long i = 3; i * i <= x; i += 2)
        while (x % i == 0)
        {
            x /= i;
            ps[i] = (i in ps) ? ps[i] + 1 : 1;
        }
    if (x != 1)
        ps[x] = (x in ps) ? ps[x] + 1 : 1;
    return ps;
}

/// x^^n % m
T powmod(T=long)(T x, T n, T m)
{
    if (n < 1)
        return 1;
    if (n & 1)
    {
        return x * powmod(x, n - 1, m) % m;
    }
    T tmp = powmod(x, n / 2, m);
    return tmp * tmp % m;
}

long[] UnionFind(long N)
{
    return iota!long(N).array;
}

long root(long[] uf, long x)
{
    if (uf[x] == x)
        return x;
    long r = root(uf, uf[x]);
    uf[x] = r;
    return r;
}

void unite(long[] uf, long x, long y)
{
    long rx = root(uf, x);
    long ry = root(uf, y);
    if (rx != ry)
        uf[rx] = ry;
}

bool same(long[] uf, long x, long y)
{
    return root(uf, x) == root(uf, y);
}