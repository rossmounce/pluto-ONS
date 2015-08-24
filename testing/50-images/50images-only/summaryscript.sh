#list of output file folders
ls | grep 'ijs' > ls.txt
#output number of tips
find . -name '*.xml' | sort | xargs grep -c -h '<otu id' > numtips.txt
#output number of empty tips per file
find -name '*xml' | sort | xargs grep -c -h 'otu id="otu[0-9]*"/>' > empty.txt
#output number of pattern matching EGIDs per file
find -name '*xml' | sort | xargs grep -c -h '[A-Z][0-9][0-9][0-9][0-9][0-9]\|[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9]\|[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9]\|N[CP]_[0-9][0-9][0-9]' > strictmatches.txt
#output number of tips with whitespace in EGIDs
find . -name '*.xml' | sort | xargs grep -c -h '[(].* .*[)]' > spaceparentheses.txt
#output number of tips with no EGIDs
find . -name '*.xml' | sort | xargs grep -v -c -h  '[(]\|encoding\|edge\|tree\|nexml\|node\|otus' > noEGID.txt

#paste per-file data together into TSV format report
paste ls.txt numtips.txt empty.txt strictmatches.txt spaceparentheses.txt noEGID.txt | sed '1 i\FileName\tTipsInFile\tEmptyTips\tExactMatchEGIDs\tSpacesInParentheses\tnoEGID' > summarytable.txt
