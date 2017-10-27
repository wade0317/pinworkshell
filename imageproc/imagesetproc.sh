#!/bin/bash

#当前脚本目录

ALL_IMAGE_DIR=$(cd `dirname $0`; pwd)

if [ "$1" == "" ]; then
	echo ""
else 
	ALL_IMAGE_DIR=$1
fi
echo $ALL_IMAGE_DIR


for IMAGESET_DIR in $( find $ALL_IMAGE_DIR -name "*.imageset" )  
	
do  

	IMAGESET_NAME=${IMAGESET_DIR##*/}
	NEW_IMAGE_BASE_NAME=${IMAGESET_NAME%.imageset*}

	find $IMAGESET_DIR -type f -name "*.[pPjJ][nNpP][gG]" | while read ORIGIN_IMAGE_FILE
	do

		ORIGIN_IMAGE_NAME=${ORIGIN_IMAGE_FILE##*/}
		ORIGIN_IMAGE_BASE_NAME=${ORIGIN_IMAGE_NAME%.[pPjJ][nNpP][gG]*}	
		ORIGIN_IMAGE_BASE_NAME=${ORIGIN_IMAGE_BASE_NAME%@[123]x*}

		NEW_IMAGE_NAME=${ORIGIN_IMAGE_NAME/${ORIGIN_IMAGE_BASE_NAME}/${NEW_IMAGE_BASE_NAME}}
		NEW_IMAGE_FILE=${ORIGIN_IMAGE_FILE/${ORIGIN_IMAGE_NAME}/${NEW_IMAGE_NAME}}


		if [ "$NEW_IMAGE_BASE_NAME" != "$ORIGIN_IMAGE_BASE_NAME" ]; then
			
			echo
			echo
			echo 图片路径:
			echo 旧:$ORIGIN_IMAGE_FILE
			echo 新:$NEW_IMAGE_FILE

			echo 图片名称:
			echo 旧:$ORIGIN_IMAGE_NAME
			echo 新:$NEW_IMAGE_NAME

			mv "$ORIGIN_IMAGE_FILE" "$NEW_IMAGE_FILE"
			cat $IMAGESET_DIR/Contents.json
			sed -i "" "s/$ORIGIN_IMAGE_NAME/$NEW_IMAGE_NAME/g" $IMAGESET_DIR/Contents.json
			cat $IMAGESET_DIR/Contents.json
		fi

	done


done  





