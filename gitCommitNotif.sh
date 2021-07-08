projectDirs=("/media/shared/codebase/" "~/projects")

for d in $projectDirs
do
  echo $d
  cd $d
  for p in $(ls -d */)
  do
    cd $p
    echo checking $p
    if test -d ".git"
    then
      git status
    fi
    cd ..
  done
done
