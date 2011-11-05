#!/bin/sh -e

cd `dirname $0`

[ ! -d html ] && mkdir html
cd html

download() {
    url="http://html5forwebdesigners.com/$1"
    filename="`echo $1 | sed -e 's/%20/ /'`"

    if [ "`basename "$filename"`" != "$filename" ]
    then
        folder="`dirname "$filename"`"
        [ ! -d "$folder" ] && mkdir "$folder"
    fi

    if [ ! -f "$filename" ]
    then
        echo "Downloading $url"
        curl -s "$url" -o "$filename"
    fi
}

download manifest.appcache

for filename in `cat manifest.appcache | grep ^/ | cut -c 2-`
do
    download "$filename"
done
