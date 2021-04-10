#!/bin/bash
#
echo "##################################"
echo "@@@@ Manage Files Application @@@@"
echo "##################################"
while getopts ":r:m:";
do
        echo "(R)ename or (M)ove File? "
        read opcao
        case "$opcao" in
                r|R)
                        clear
                        echo "Renaming file."
                        echo "What is the folder to be renamed?"
                        echo "----------------------------------"
                        for i in $(ls "$TORRENT/"); do
                                echo "- $i"
                        done
                        echo "----------------------------------"
                        read rename
                        echo "----------------------------------"
                        echo "What will be the new name? "
                        echo "----------------------------------"
                        read new
                        mv "$TORRENT/$rename" "$TORRENT/$new"
                        ;;
                m|M)
                        clear
                        echo "Moving file."
                        echo "What is the destination folder?"
                        echo "----------------------------------"
                        for i in $(ls "$GDRIVE/"); do
                                echo "- $i"
                        done
                        echo "----------------------------------"
                        read destination
                        #
                        echo "What is the folder to be uploaded?"
                        echo "----------------------------------"
                        for i in $(ls "$TORRENT/"); do
                                echo "- $i"
                        done
                        echo "----------------------------------"
                        read folder
                        echo "##################################"
                        #
                        # Create and sync the folder
                        #
                        mkdir "$GDRIVE/$destination/$folder"
                        rclone copy --no-traverse --progress "$TORRENT/$folder" "GDrive:/$destination/$folder"
                        #
                        # Now, checks if the movement was done
                        #
                        if [ -d "$GDRIVE/$destination/$folder/" ]
                        then
                        # Check if the folder exists at destination
                                echo "The folder $folder exists"
                                echo "----------------------------------"
                        # Check if the folder is empty or not
                                find "$GDRIVE/$destination/$folder" -type f -exec echo Found file {} \;
                                echo "----------------------------------"
                                echo -n "What next? (D)elete folder/(K)eep folder/(E)xit? "
                                read option
                        # Set options to delete or keep the source folder and files
                                case "$option" in
                                        d|D)
                                                echo "Deleting source folder $folder."
                                                rm -R "$TORRENT/$folder"
                                                echo "Deleted"
                                                ;;
                                        k|K)
                                                echo "Keeping folder $folder as it is."
                                                echo "Done"
                                                ;;
                                        e|E)
                                                echo "Exiting without changes..."
                                                echo "Done"
                                                ;;
                                        *)
                                                echo "Invalid option"
                                                ;;
                                esac
                        else
                                echo "Nope, it wasn't moved"
                        fi
                        ;;
                *)
                echo "Invalid option"
                ;;
        esac
        clear
        echo "----------- Exit application? -----------"
        echo "Hit CTRL + C to stop or Enter to continue"
        read closeapp
        clear
done
