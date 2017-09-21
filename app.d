import std.algorithm;
import std.array;
import std.conv;
import std.range;
import std.stdio;
import std.string;
import std.traits;
import std.typecons;

enum INF(T) = T.max / 2; ///longの場合10^^18くらい

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

T[] dijkstra(T = long)(T[][] graph, size_t from)
{
	auto result = new T[](graph.length);
	result[] = INF!T;
	result[from] = 0;
	auto queue = new bool[](graph.length);
	queue[] = false;
	foreach (_; 0 .. graph.length)
	{
		size_t min = result.maxIndex();
		foreach (i; 0 .. graph.length)
			if (queue[i] == false && result[i] < result[min])
				min = i;
		queue[min] = true;
		writeln(queue, min);

		foreach (to; 0 .. graph.length)
		{
			if (result[min] + graph[min][to] < result[to])
				result[to] = result[min] + graph[min][to];
		}
	}
	return result;
}

/// dmd-2.070のstd.algorithmにはminIndexがない
size_t minIndex(T)(T[] array)
{
	size_t result;
	T _n = array[0];
	foreach (i, n; array)
		if (n < _n)
			result = i;
	return result;
}
/// dmd-2.070のstd.algorithmにはmaxIndexがない
size_t maxIndex(T)(T[] array)
{
	size_t result;
	T _n = array[0];
	foreach (i, n; array)
		if (_n < n)
			result = i;
	return result;
}
