#!/usr/bin/env bash

convert ( ) {
        nodir=${1##*/}
        notxt=${nodir%.txt}

        creation_date=$(sed -n '3p' $1 | cut -d ' ' -f 2 | sed 's/[^[:digit:]]//g') #extract the creation date of Zim doc
        title="$notxt" #$(sed -n '5p' $1| sed 's/ //g' | cut -d ' ' -f 2)                                   #extract the title of the Zim doc

        #making the new header by using change command on the originals
        #1st -e: put the creation date in first line
        #2nd -e: also put the creation date in second line but this time to be in the modified filed because Zim doesn't have a modification date
        #3rd -e: add the necessary tags to the third line
        #4th -e: add the wiki title to the fourth line
        #5th -e: add the type
        #6th -e: remove line 6 as It's not necessary.

        sed -e "1c\\
                created:  $creation_date" \
            -e "2c\\
                modified: $creation_date" \
            -e "3c\\
                tags: ${2:-Contents}" \
            -e "4c\\
                title: $title" \
            -e "5c\\
                type: text/vnd.tiddlywiki" \
            -e '6d' $1 |

                        #This is the part you put your own preferences depends on your wiki..
                        sed 's/#//g'   | # I like to remove hashes because they have special meaning in tiddly (make numbered list)
                        sed 's/>>>//g' | #I used this triple angle Brackets '>>>' alot in my wikis,
                                         # they also have special meaning in tiddly (make quotes).so I remove 'em too.

                                        # Repairing the Markup syntax.
                                        gsed -E -e '6,$G'\
                                        -e "s/={6} (.*) ={6}/! \1/;"\
                                        -e "s/={5} (.*) ={5}/!! \1/"\
                                        -e "s/={4} (.*) ={4}/!!! \1/"\
                                        -e "s/={3} (.*) ={3}/!!! \1/"\
                                        -e "s/={2} (.*) ={2}/!!! \1/"\
                                        -e "s/-{20}/---/"\
                                        -e "s/^[[:digit:]][[:digit:]]*\. /# /"\
                                        -e "s/\*\*(.*)\*\*/\x27\x27\1\x27\x27/"\
                                        -e "s/\_\{(.*)\}/,,\1,,/"\
                                        -e "s/\^\{(.*)\}/^^\1^^/"\
                                        -e "s/\[\[((https?:\/\/(www\.)?)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*))\|(.*)\]\]/\[\[\5\|\1\]\]/" > ${notxt}.tid

}

main (){

for file in "${1}"/*.txt; do

    convert "$file" "$2"

    if [[ -d "${file%.txt}" ]];then
        initial_tag_name="${file##*/}"
        tag_name="${initial_tag_name%.txt}"

        main "${file%.txt}" "$tag_name"

    fi
done
}

main "$1"
mkdir tids; mv *.tid tids
