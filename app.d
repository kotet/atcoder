import core.bitop, std.algorithm, std.ascii, std.bigint, std.conv, std.math,
    std.functional, std.numeric, std.range, std.stdio, std.string, std.random,
    std.typecons, std.container, std.format;

// dfmt off
T lread(T = long)(){return readln.chomp.to!T();}
T[] aryread(T = long)(){return readln.split.to!(T[])();}
void scan(TList...)(ref TList Args){auto line = readln.split();
foreach (i, T; TList){T val = line[i].to!(T);Args[i] = val;}}
alias sread = () => readln.chomp();enum MOD = 10 ^^ 9 + 7;
alias PQueue = BinaryHeap!(Array!long, "a<b");
// dfmt on

void main()
{
    //
    long N, M;
    scan(N, M);
    auto A = new long[](N);
    auto B = new long[](N);
    foreach (i; 0 .. N)
        scan(A[i], B[i]);
    B[] *= -1;
    zip(A, B).sort();
    long ans;
    long j = 0;
    auto pq = PQueue();
    foreach (i; 1 .. M + 1)
    {
        while (A[j] <= i)
            pq.insert(-B[j++]);
        if (!pq.empty)
        {
            ans += pq.front;
            pq.popFront();
        }
    }
    writeln(ans);
}
