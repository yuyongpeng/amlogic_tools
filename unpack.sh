#!/usr/bin/sudo sh

echo "....................."
echo "Amlogic Kitchen"
echo "....................."
echo "....................."

if [ -d level1 ]; then
    echo "Deleting existing level1"
    rm -rf level1 && mkdir level1
else
    mkdir level1
fi

echo "....................."
echo "Amlogic Kitchen"
echo "....................."
if [ ! -d in ]; then
    echo "Can't find /in folder"
    echo "Creating /in folder"
    mkdir in
fi
count_file=$(ls -1 in/*.img 2>/dev/null | wc -l)
if [ "$count_file" = 0 ]; then
    echo "No files found in /in"
    exit 0
fi
echo "Files in input dir (*.img)"
count=0
for entry in $(ls in/*.img); do
    count=$(($count + 1))
    name=$(basename in/$entry .img)
    echo $count - $name
done
echo "....................."
echo "Enter a file name :"
read projectname
echo $projectname >level1/projectname.txt

if [ ! -f in/$projectname.img ]; then
    echo "Can't find the file"
    exit 0
fi

filename=$(cat level1/projectname.txt)
bin/linux/AmlImagePack -d in/$filename.img level1
echo "Done."

imgextractor="bin/common/imgextractor.py"

version=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)')
if [ -z "$version" ]; then
    echo "No Python installed!"
fi

if [ ! -d level1 ]; then
    echo "Unpack level 1 first"
    exit 0
fi

if [ -d level2 ]; then
    echo "Deleting existing level2"
    rm -rf level2 && mkdir -p level2/config
else
    mkdir -p level2/config
fi

for part in system system_ext vendor product odm oem odm_ext_a odm_ext_b; do
    if [ -f level1/$part.PARTITION ]; then
        echo "Extracting $part"
        if echo $(file level1/$part.PARTITION) | grep -q "sparse"; then
            bin/linux/simg2img level1/$part.PARTITION level2/$part.raw.img
            python3 $imgextractor "level2/$part.raw.img" "level2"
        else
            python3 $imgextractor "level1/$part.PARTITION" "level2"
        fi
        awk -i inplace '!seen[$0]++' level2/config/*
    fi
done

rm -rf level2/*.raw.img

if [ -f level1/super.PARTITION ]; then
    bin/linux/simg2img level1/super.PARTITION level2/super.img
    echo $(du -b level2/super.img | cut -f1) >level2/config/super_size.txt
    bin/linux/super/lpunpack -slot=0 level2/super.img level2/
    rm -rf level2/super.img

    if [ $(ls -1q level2/*_a.img 2>/dev/null | wc -l) -gt 0 ]; then
        echo "3" >level2/config/super_type.txt
    else
        echo "2" >level2/config/super_type.txt
    fi

    for part in system system_ext vendor product odm oem system_a system_ext_a vendor_a product_a odm_a system_b system_ext_b vendor_b product_b odm_b; do
        if [ -f level2/$part.img ]; then
            size=$(du -b level2/$part.img | cut -f1)
            if [ $size -ge 1024 ]; then
                python3 $imgextractor "level2/$part.img" "level2"
                awk -i inplace '!seen[$0]++' level2/config/*
            fi
        fi
    done
fi

echo "Done."



