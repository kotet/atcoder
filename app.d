import std;

// dfmt off
T lread(T = long)(){return readln.chomp.to!T();}
T[] lreads(T = long)(long n){return generate(()=>readln.chomp.to!T()).take(n).array();}
T[] aryread(T = long)(){return readln.split.to!(T[])();}
void scan(TList...)(ref TList Args){auto line = readln.split();
foreach (i, T; TList){T val = line[i].to!(T);Args[i] = val;}}
alias sread = () => readln.chomp();enum MOD = 10 ^^ 9 + 7;
alias PQueue(T, alias less = "a<b") = BinaryHeap!(Array!T, less);
// dfmt on

void main()
{
    // ABC143_D
    long N = lread();
    auto L = aryread();
    L.sort();
    long cnt;
    foreach (A; 0 .. N)
        foreach (B; A + 1 .. N)
        {
            long a = L[A];
            long b = L[B];
            long min_c = max(a - b, b - a);
            auto min_C = max(B + 1, L.bsearch(min_c) + 1);
            long max_c = a + b;
            auto max_C = min(N, L.bsearch(max_c));
            // writefln("%d %d %d", min_C, max_C, max(0, max_C - min_C));
            cnt += max(0, max_C - min_C + 1);
        }
    writeln(cnt);
}

long bsearch(T)(T[] ary, T key)
{
    long ok = 0;
    long ng = ary.length;
    while (1 < ng - ok)
    {
        long m = (ok + ng) / 2;
        if (ary[m] < key)
        {
            ok = m;
        }
        else
        {
            ng = m;
        }
    }
    return ok;
}
