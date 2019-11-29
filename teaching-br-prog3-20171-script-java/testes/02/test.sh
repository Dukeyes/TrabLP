#!/bin/bash

# Constant definitions.
DAT_FILE=recredenciamento.dat

# Parameters:
testId=$1
dir=$2
srcDir=$3
tempDir=$4
baseDir=$5
testDir=$6
subIn=$7
subOut=$8
diffCmd=$9

# Runs the program.
cd $srcDir
ant run-read-only > /dev/null 2> /dev/null
exitcode=$?
cd - > /dev/null

# Checks if the program ran normally.
if [ $exitcode = 0 ]; then
	# Checks if the serialization file was created.
	if [ -f $srcDir/$DAT_FILE ]; then
		echo "[I] Testando $dir: teste ${testId}, serialização OK!"
	else
		echo "[E] Testando $dir: teste ${testId}, não implementou serialização!"
	fi

	# Checks if the CSV files were not created.
	for output in `ls $testDir/$subOut`; do
		if [ -f $srcDir/$output ]; then
			echo "[E] Testando $dir: teste ${testId}, relatório criado em modo --read-only: ${output}"
		fi
	done

else
	# Program returned with exit code different than 0. Something wrong happened.
	echo "[E] Testando $dir: teste ${testId}, erro na execução!  (Ant exit code $exitcode)"
fi
