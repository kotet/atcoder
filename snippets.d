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

/// 素因数分解
long[] factorize(long x)
{
    assert(0 < x, "x is negative");
    long[] result;
    while ((x & 1) == 0)
    {
        x /= 2;
        result ~= 2;
    }
    for (long i = 3; i * i <= x; i += 2)
        while (x % i == 0)
        {
            x /= i;
            result ~= i;
        }
    if (x != 1)
        result ~= x;
    return result;
}

T lcm(T)(T a, T b)
{
    return (a * b) / gcd(a, b);
}

/// x^^n % m
T powmod(T = long)(T x, T n, T m)
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

T invmod(T = long)(T x, T m)
{
    T powmod(T = long)(T x, T n, T m)
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

    return powmod(x, m - 2, m);
}

struct UnionFind
{
    private long[] rank;
    long[] data;
    long size;

    this(long N)
    {
        this.rank = new long[](N);
        this.data = iota!long(N).array;
        this.size = N;
    }

    long find(long x)
    {
        if (data[x] == x)
            return x;
        long r = this.find(data[x]);
        data[x] = r;
        return r;
    }

    void unite(long x, long y)
    {
        long rx = this.find(x);
        long ry = this.find(y);
        if (rx != ry)
        {
            this.size--;
            if (rank[rx] == rank[ry])
            {
                data[rx] = ry;
                rank[ry]++;
            }
            else if (rank[rx] < rank[ry])
                data[rx] = ry;
            else
                data[ry] = rx;
        }
    }

    bool isSame(long x, long y)
    {
        return this.find(x) == this.find(y);
    }
}

/// Number of k-combinations
T combination(T = long)(T n, T k)
{
    assert(0 <= k);
    assert(0 <= n);
    if (n < k)
        return 0;
    k = min(n - k, k);
    if (k == 0)
        return 1;
    if (k == 1)
        return n;
    return memoize!combination(n - 1, k - 1) + memoize!combination(n - 1, k);
}

T combination_mod(T = long)(T n, T k, T m)
{
    if (n < k)
        return 0;
    long a = 1;
    long b = 1;
    long c = 1;
    foreach (i; 1 .. n + 1)
    {
        a = (a * i) % m;
        if (i == k)
            b = a;
        if (i == (n - k))
            c = a;
    }
    T powmod(T = long)(T x, T n, T m)
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

    long bc = b * c % m;
    long bc_inv = powmod(bc, m - 2, m);
    return a * bc_inv % m;
}

/// binary search
long bsearch(T)(T[] ary, T key)
{
    long ok = 0;
    long ng = ary.length;
    while (1 < ng - ok)
    {
        long m = (ok + ng) / 2;
        if (ary[m] < key)
        {
            ok = m;
        }
        else
        {
            ng = m;
        }
    }
    return ok;
}
