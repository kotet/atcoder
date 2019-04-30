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
