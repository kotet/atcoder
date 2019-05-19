import core.bitop, std.algorithm, std.ascii, std.bigint, std.conv, std.math,
    std.functional, std.numeric, std.range, std.stdio, std.string, std.random,
    std.typecons, std.container;

T lread(T = long)()
{
    return readln.chomp.to!T();
}

T[] aryread(T = long)()
{
    return readln.split.to!(T[])();
}

void scan(TList...)(ref TList Args)
{
    auto line = readln.split();
    foreach (i, T; TList)
    {
        T val = line[i].to!(T);
        Args[i] = val;
    }
}

alias sread = () => readln.chomp();
enum MOD = 10 ^^ 9 + 7;

void main()
{
    long N, M;
    scan(N, M);
    auto uf_same = UnionFind(N);
    auto uf_diff = UnionFind(N);
    foreach (_; 0 .. M)
    {
        long X, Y, Z;
        scan(X, Y, Z);
        // if (Z & 1)
        //     uf_diff.unite(X - 1, Y - 1);
        // else
        //     uf_same.unite(X - 1, Y - 1);
        uf_same.unite(X - 1, Y - 1);
    }
    foreach (i; 0 .. N)
        uf_same.root(i);
    // uf_same.writeln();
    uf_same.sort();
    uf_same.uniq().walkLength().writeln();
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
