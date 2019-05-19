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
    auto uf = UnionFind(N);
    foreach (_; 0 .. M)
    {
        long X, Y, Z;
        scan(X, Y, Z);
        uf.unite(X - 1, Y - 1);
    }
    uf.size.writeln();
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
