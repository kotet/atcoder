NUM=4

echo "Removing old input..."

rm -f {input,answer}/*.random

if [ "$1" = "clean" ]; then
    exit
fi

expr 1 + $1 >/dev/null 2>&1
if [ $? -le 1 ]; then
    NUM=$1
fi

ID=$(seq 1 $NUM)

echo "Generating random input..."
for id in $ID; do
    id=$(printf %02d $id)
    rdmd input_generate.d >"input/$id.random"
done

echo "Generating answer..."
for id in $ID; do
    id=$(printf %02d $id)
    rdmd answer_generate.d <"input/$id.random" >"answer/$id.random"
done
