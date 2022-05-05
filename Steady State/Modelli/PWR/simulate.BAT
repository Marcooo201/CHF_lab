del out\output
del out\rstplt

..\..\..\utils\execution\relap5.exe -i input.i -o out\output -r out\rstplt -Z ..\..\..\utils\execution\tpfh2onew

del read_steam_comment.o
