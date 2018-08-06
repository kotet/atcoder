BUILD="sudo docker run --rm -v $PWD:/src -w /src dlanguage/dmd:2.070.1 dmd app.d"

echo "Building..."
echo $BUILD
$BUILD

if [ ! $? = 0 ]; then
    echo "Build failed."
    exit
fi

echo "Removing old output..."
mkdir -p output
rm output/*

for file in `ls input`; do
    echo -n "Testing $file..."
    timeout 5 ./app < input/$file > output/$file
    if diff -q output/$file answer/$file > /dev/null; then
        echo "passed."
    else
        echo "failed."
    fi
done

rm -f app app.o
