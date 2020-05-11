# 新ジャッジ
# BUILD="sudo docker run --rm -v $PWD:/src -w /src dlang2/dmd-ubuntu:2.091.0 dmd -wi -m64 -O -release -inline -boundscheck=off app.d"
# DEBUG="sudo docker run --rm -v $PWD:/src -w /src dlang2/dmd-ubuntu:2.091.0 dmd -g app.d"

# 旧ジャッジ
BUILD="sudo docker run --rm -v $PWD:/src -w /src dlanguage/dmd:2.070.1 dmd -m64 -w -O -release -inline app.d"
DEBUG="sudo docker run --rm -v $PWD:/src -w /src dlanguage/dmd:2.070.1 dmd -g app.d"

echo "Building..."
if [ "$1" = "debug" ]; then
    echo $DEBUG
    $DEBUG
else
    echo $BUILD
    $BUILD
fi

if [ ! $? = 0 ]; then
    echo "Build failed."
    exit
fi

echo "Removing old output..."
mkdir -p output
rm -f output/*

if [ "$1" = "gen" ]; then
    ./generate.sh $NUM
    INPUTS=$(ls input/ | grep -E "^.*\.random")
else
    ./generate.sh clean
    INPUTS=$(ls input/)
fi

for file in $INPUTS; do
    echo -n "Testing $file..."
    timeout 5 ./app <input/$file >output/$file 2>&1
    if diff -q output/$file answer/$file >/dev/null; then
        echo "passed."
    else
        echo "failed."
    fi
done

for file in $INPUTS; do
    bat output/$file
done

rm -f app app.o
