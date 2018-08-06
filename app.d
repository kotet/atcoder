import std.stdio;
import std.ascii;
import std.conv;
import std.string;
import std.algorithm;
import std.range;
import std.functional;
import std.math;
import core.bitop;

// ABC-104-C

void main()
{
    auto dg = readln.chomp.split.map!(to!long);
    long d = dg[0], g = dg[1];
    long[] p = new long[](d), c = new long[](d);
    foreach (i; 0 .. d)
    {
        auto pc = readln.chomp.split.map!(to!long);
        p[i] = pc[0];
        c[i] = pc[1];
    }

    g /= 100;
    c[] /= 100;
    long[] tmp = new long[](0);
    solve(p, c, tmp.dup, tmp.dup, iota(0, cast(long) p.length).array, g).writeln;
}

long solve(long[] p, long[] c, long[] use, long[] notuse, long[] a, long g)
{
    if (a.empty)
    {
        long score, cnt;

        foreach (long i; use)
        {
            score += (i + 1) * p[i] + c[i];
            cnt += p[i];
        }
        if (g <= score)
        {
            return cnt;
        }
        else if (!notuse.empty)
        {
            if ((g - score) / (notuse.reduce!max() + 1) <= p[notuse.reduce!max()])
            {
                return max(cnt + ((g - score) / (notuse.reduce!max() + 1)), 1);
            }
            else
            {
                return long.max;
            }
        }
        else
        {
            return long.max;
        }
    }
    else
    {
        long y = solve(p, c, use ~ a[0], notuse, a[1 .. $], g);
        long n = solve(p, c, use, notuse ~ a[0], a[1 .. $], g);
        return min(y, n);
    }
}
