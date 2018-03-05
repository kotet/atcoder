import std.stdio;
import std.conv;
import std.string;
import std.algorithm;
import std.range;
import std.functional;
import std.math;
import core.bitop;

void main()
{
    /// ABC089_D
    long H, W, D;
    {
        auto input = readln.chomp.split(' ').map!(to!long);
        H = input[0];
        W = input[1];
        D = input[2];
    }
    long[2][] table = new long[2][](H * W + 1);
    foreach (h; 0 .. H)
    {
        auto input = readln.chomp.split(' ').map!(to!long).array;
        foreach (w, n; input)
        {
            table[n] = [h, w];
        }
    }

    long[] cost = new long[](H * W + 1);
    foreach (i; D + 1 .. H * W + 1)
    {
        cost[i] = cost[i - D] + abs(table[i][0] - table[i - D][0]) + abs(
                table[i][1] - table[i - D][1]);
    }

    auto Q = readln.chomp.to!long;
    foreach (_; 0 .. Q)
    {
        long L, R;
        {
            auto input = readln.chomp.split(' ').map!(to!long);
            L = input[0];
            R = input[1];
        }
        writeln(cost[R] - cost[L]);
    }
}
