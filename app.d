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
    // ABC125-D
    long N = lread();
    auto A = aryread();
    auto dp = new long[][](N + 1, 2);
    dp[0][] = dp[1][] = long.min / 2;
    dp[0][0] = 0;
    // writeln(dp[0]);
    foreach (i; 0 .. N)
    {
        dp[i + 1][0] = dp[i + 1][0].max(dp[i][0] + A[i]);
        dp[i + 1][0] = dp[i + 1][0].max(dp[i][1] - A[i]);

        dp[i + 1][1] = dp[i + 1][1].max(dp[i][0] - A[i]);
        dp[i + 1][1] = dp[i + 1][1].max(dp[i][1] + A[i]);
    }
    writeln(dp[N][0]);
}
