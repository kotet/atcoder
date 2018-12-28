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
import std.random;
import std.typecons;

alias sread = () => readln.chomp();
alias Point2 = Tuple!(long, "y", long, "x");

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

void minAssign(T, U = T)(ref T dst, U src)
{
    dst = cast(T) min(dst, src);
}

void main()
{
    long H, W;
    Point2 S, G;
    scan(H, W);
    char[][] t;
    foreach (y; 0 .. H)
    {
        auto cs = sread().to!(char[]);
        foreach (x, c; cs)
            if (c == 's')
            {
                S = tuple(y, x);
            }
            else if (c == 'g')
            {
                G = tuple(y, x);
            }
        t ~= cs;
    }

    auto r = new long[][](H, W);
    foreach (row; r)
        row[] = long.max;
    r[S.y][S.x] = 0;

    Point2[] queue;
    queue ~= S;

    while (!queue.empty)
    {
        auto p = queue.front;
        queue.popFront();

        if (2 < r[p.y][p.x] || t[p.y][p.x] == 'g')
        {
            continue;
        }

        if (t[p.y][p.x] == '#')
            r[p.y][p.x]++;
        if (-1 < p.y - 1 && r[p.y][p.x] < r[p.y - 1][p.x])
        {
            r[p.y - 1][p.x] = r[p.y][p.x];
            queue ~= Point2(p.y - 1, p.x);
        }
        if (-1 < p.x - 1 && r[p.y][p.x] < r[p.y][p.x - 1])
        {
            r[p.y][p.x - 1] = r[p.y][p.x];
            queue ~= Point2(p.y, p.x - 1);
        }
        if (p.y + 1 < H && r[p.y][p.x] < r[p.y + 1][p.x])
        {
            r[p.y + 1][p.x] = r[p.y][p.x];
            queue ~= Point2(p.y + 1, p.x);
        }
        if (p.x + 1 < W && r[p.y][p.x] < r[p.y][p.x + 1])
        {
            r[p.y][p.x + 1] = r[p.y][p.x];
            queue ~= Point2(p.y, p.x + 1);
        }
    }

    writeln((r[G.y][G.x] < 3) ? "YES" : "NO");
}
