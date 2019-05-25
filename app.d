import core.bitop, std.algorithm, std.ascii, std.bigint, std.conv, std.math,
    std.functional, std.numeric, std.range, std.stdio, std.string, std.random,
    std.typecons, std.container;

// dfmt off
T lread(T = long)(){return readln.chomp.to!T();}
T[] aryread(T = long)(){return readln.split.to!(T[])();}
void scan(TList...)(ref TList Args){auto line = readln.split();
foreach (i, T; TList){T val = line[i].to!(T);Args[i] = val;}}
alias sread = () => readln.chomp();enum MOD = 10 ^^ 9 + 7;
// dfmt on

void main()
{
    // https://atcoder.jp/contests/chokudai_S002/tasks/chokudai_S002_a
    long N = lread();
    foreach (_; 0 .. N)
    {
        long A, B;
        scan(A, B);
        writeln(A * B);
    }
}
