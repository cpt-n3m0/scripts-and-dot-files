projectDirs=( "/media/shared/codebase" "/home/cpt-n3m0/projects" )
out=( )
outputfile='/tmp/gitstatues'

for d in "${projectDirs[@]}"
do
  cd $d
  for p in $(ls -d */)
  do
    cd $p
    if test -d ".git"
    then

      tmpout=/tmp/gitProjectsStatusesOut
      git status > /tmp/gpso
      egrep ^.*:$ /tmp/gpso > $tmpout

      while read s; do
        out+=("$s $d/$p")
      done < $tmpout
    fi
    cd ..
  done
done

echo "Git statuses"> /tmp/gitstatuses
if [ ${#out[@]} -eq 0 ]
then
  printf "\tAll projects are in order"
else
  for s in "${out[@]}"
  do
    printf "\t- $s\n" >> $outputfile
  done
fi
