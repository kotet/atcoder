import std.algorithm;
import std.array;
import std.conv;
import std.range;
import std.stdio;
import std.string;
import std.traits;
import std.typecons;

enum INF(T) = T.max / 2; //longの場合10^^18くらい

void main()
{

}

/// graphMatrix[from][to] == cost < INF!T
T[][] graphMatrix(T = long)(size_t e)
{
	auto m = new T[][](e, e);
	foreach (ref r; m)
		r[] = INF!T;
	return m;
}
/// デバッグ用。GraphMatrixを見やすい文字列にする
string fmt(T)(T[][] graph)
{
	auto result = "";
	foreach (r; graph)
	{
		result ~= r.map!(n => (n == INF!T) ? "max" : n.to!string).join("\t") ~ "\n";
	}
	return result;
}

/// warshallFloyd[from][to] == shortestCost
T[][] warshallFloyd(T)(T[][] graph)
{
	auto result = new T[][](graph.length, graph.length);
	foreach (i, ref r; result)
		r[] = graph[i];

	foreach (relay; 0 .. graph.length)
		foreach (from; 0 .. graph.length)
			foreach (to; 0 .. graph.length)
				result[from][to] = min(result[from][to], result[from][relay] + result[relay][to]);
	return result;
}
