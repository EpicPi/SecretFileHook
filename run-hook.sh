#!/bin/bash

# Flatten args by expanding cli input
ARGS=()
for arg in $@; do 
    ARGS+=("$arg")
done

# Populate SECRET
POSITIONAL=()
END=${#ARGS[@]} # end = length of flat args
for ((i=0;i<END;i++)); do
    case ${ARGS[$i]} in
    --secret)
        SECRET=${ARGS[($i+1)]}
        i=$i+1
        ;;
    *)
        POSITIONAL+=(${ARGS[$i]})
        ;;
    esac
done

RED='\033[0;31m'
NC='\033[0m' # No Color

for file in ${POSITIONAL[@]}; do
    FILE_NAME=$(awk -F'/' '{print $(NF)}' <<< $file)
    if [ $FILE_NAME == $SECRET ]; then
        printf "${RED}$SECRET file found in commit. This is a secret file that should nto be commited. Please remove. \n${NC}"
        exit 1
    fi
done




