import std.algorithm;
import std.array;
import std.conv;
import std.functional;
import std.math;
import std.meta;
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

/// warshallFloyd[from][to] == minCost
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
/// dijkstra[to] == minCost
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

/// 親 = fun(子A, 子B)
template segTree(fun...)
{
	alias binfuns = binaryFun!fun;
	Tuple!(T[], "tree", T[], "data") segTree(T)(T[] data, T default_value)
	{
		immutable new_data_length = cast(size_t)(2 ^^ data.length.log2.ceil());
		immutable tree_length = new_data_length - 1;

		T[] tree = new T[](tree_length + new_data_length);

		tree[tree_length .. tree_length + data.length] = data[];
		tree[tree_length + data.length .. $] = default_value;

		foreach_reverse (depth; 0 .. cast(size_t) data.length.log2.ceil())
			foreach (i; 0 .. 2 ^^ depth)
			{
				immutable parent = 2 ^^ depth - 1 + i;
				tree[parent] = binfuns(tree[(parent + 1) * 2 - 1], tree[(parent + 1) * 2]);
			}
		return Tuple!(T[], "tree", T[], "data")(tree, tree[tree_length .. $]);
	}
}
///デバッグ用
string fmt(T)(Tuple!(T[], "tree", T[], "data") segtree)
{
	string result;
	immutable depth = cast(size_t) segtree.tree.length.log2.ceil();
	foreach (i; 0 .. depth)
		result ~= segtree.tree[2 ^^ i - 1 .. 2 ^^ (i + 1) - 1].map!(to!string)
			.join('\t'.repeat.take(2 ^^ (depth - i - 1)).array.idup) ~ "\n";
	return result;
}
/// target番目のデータをvalueに更新し、それに合わせてsegtreeを更新
template update(fun...)
{
	alias binfuns = binaryFun!fun;
	void update(T)(Tuple!(T[], "tree", T[], "data") segtree, size_t target, T value)
	{
		segtree.data[target] = value;
		size_t parent = (segtree.tree.length - segtree.data.length) + target + 1;
		while (true)
		{
			parent /= 2;
			if (parent == 0)
				return;
			immutable childA = parent * 2;
			immutable childB = childA + 1;
			T newVal = binfuns(segtree.tree[childA - 1], segtree.tree[childB - 1]);
			if (segtree.tree[parent - 1] == newVal)
				return;
			segtree.tree[parent - 1] = newVal;
		}
	}
}
