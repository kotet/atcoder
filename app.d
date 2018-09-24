import core.bitop;
import std.algorithm;
import std.ascii;
import std.bigint;
import std.conv;
import std.functional;
import std.math;
import std.numeric;
import std.range;
import std.stdio;
import std.string;

T lread(T = long)()
{
    return readln.chomp.to!T();
}

T[] aryread(T = long)()
{
    return readln.split.to!(T[])();
}

alias sread = () => readln.chomp();

void main()
{
    // ABC110_D
    auto nm = aryread;
    long N = nm[0];
    long M = nm[1];

    auto ps = factorize(M).values;
    BigInt result = 1;

    foreach (p; ps)
    {
        BigInt a = iota(1, p + 1).map!BigInt
            .reduce!((a, b) => a * b);
        BigInt b = iota(p).map!BigInt
            .map!(x => N + x)
            .reduce!((a, b) => a * b);
        result *= b / a;
    }
    (result % (10 ^^ 9 + 7)).writeln;
}

long[long] factorize(long x)
{
    long[long] ps;
    while ((x & 1) == 0)
    {
        x /= 2;
        ps[2] = (2 in ps) ? ps[2] + 1 : 1;
    }
    for (long i = 3; i <= x; i += 2)
        while (x % i == 0)
        {
            x /= i;
            ps[i] = (i in ps) ? ps[i] + 1 : 1;
        }
    return ps;
}
