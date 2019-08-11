import core.bitop, std.algorithm, std.ascii, std.bigint, std.conv, std.math,
    std.functional, std.numeric, std.range, std.stdio, std.string, std.random,
    std.typecons, std.container, std.format;

// dfmt off
T lread(T = long)(){return readln.chomp.to!T();}
T[] aryread(T = long)(){return readln.split.to!(T[])();}
void scan(TList...)(ref TList Args){auto line = readln.split();
foreach (i, T; TList){T val = line[i].to!(T);Args[i] = val;}}
alias sread = () => readln.chomp();enum MOD = 10 ^^ 9 + 7;
// dfmt on

void main()
{
    // https://atcoder.jp/contests/abc137/tasks/abc137_c
    long N = lread();
    long[string] D;
    foreach (i; 0 .. N)
    {
        char[] S = sread().dup;
        sort(cast(ubyte[]) S);
        D[cast(string) S] = D.get(cast(string) S, 0) + 1;
    }
    D.values.map!((x) => combination(x, 2)).sum().writeln();
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
