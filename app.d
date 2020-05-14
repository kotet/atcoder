// dfmt off
T lread(T=long)(){return readln.chomp.to!T;}T[] lreads(T=long)(long n){return iota(n).map!((_)=>lread!T).array;}
T[] aryread(T=long)(){return readln.split.to!(T[]);}void arywrite(T)(T a){a.map!text.join(' ').writeln;}
void scan(L...)(ref L A){auto l=readln.split;foreach(i,T;L){A[i]=l[i].to!T;}}alias sread=()=>readln.chomp();
void dprint(L...)(lazy L A){debug{auto l=new string[](L.length);static foreach(i,a;A)l[i]=a.text;arywrite(l);}}
static immutable MOD=10^^9+7;alias PQueue(T,alias l="b<a")=BinaryHeap!(Array!T,l);import std;
// dfmt on

void main()
{
    long N, M, X;
    scan(N, M, X);
    auto CA = new long[][](N);
    foreach (i; 0 .. N)
        CA[i] = aryread();
    long ans = long.max;
    foreach (s; 1 .. (1 << N))
    {
        long cost;
        auto m = new long[](M);
        foreach (i; 0 .. N)
            if (s & (1 << i))
            {
                cost += CA[i][0];
                m[] += CA[i][1 .. $][];
            }
        if (m.all!(x => X <= x))
            ans = ans.min(cost);
    }
    writeln(ans == long.max ? -1 : ans);
}
