#-------------Config---------------------#
#if you run this on a a Mac OSX: 1 else: 0
OSX=1
#your working directory
dir="/Users/syd/Desktop/c_proj/cannyEdgeDectector/cannyEdgeDectector/"
#your file name, if you need to perform edge detection to new image, target should be put inside picIn directory

if [ ! -n "$1" ];then
  image="Lena256.bmp"
else
  image="$1"
  echo "$1"
fi
#-------------Config---------------------#

#pic info
Info=$(file ${dir}picIn/${image}| cut -d',' -f 3)
#height
Height=$(echo $Info|cut -d 'x' -f 2)
#width
Width=$(echo $Info|cut -d 'x' -f 1)
echo file ${dir}picIn/${image}
echo $Width $Height

mainFile="./source/main.cpp"
utilFile="./source/util.h"
if [ -e "$mainFile" ]; then
  #file exited
  echo "opened succefully"
  #if you are on Linux or Powershell, {' '} is a must
  if [ $OSX -eq 1 ];then
    sed -i '' "s/string pwd = .*;/string nameIn = \"${dir}\";/g" $mainFile
    sed -i '' "s/string nameIn = .*;/string nameIn = \"${image}\";/g" $mainFile
    sed -i '' "s/#define H .*$/#define H $Height/g" $utilFile
    sed -i '' "s/#define W .*$/#define W $Width/g" $utilFile
  else
    sed -i "s/string pwd = .*;/string nameIn = \"${dir}\";/g" $mainFile
    sed -i "s/string nameIn = .*;/string nameIn = \"${image}\";/g" $mainFile
    sed -i "s/#define H .*$/#define H $Height/g" $utilFile
    sed -i "s/#define W .*$/#define W $Width/g" $utilFile
  fi
else
  echo "no correct cpp file"
fi

echo "starting comiling"
g++ ./source/*.cpp -o output
echo "executing..."
./output
echo "completed"
