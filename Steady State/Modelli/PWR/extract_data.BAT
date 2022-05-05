del out\stripf
del out\output_strip

..\..\utils\execution\relap5.exe -i input_strip.i -o out\output_strip -r out\rstplt -s out\stripf

py ..\..\utils\other\parser.py

matlab -nosplash -nodesktop -r "cd analysis; publish('analyze.m', 'outputDir','../analysis', 'format','html', 'showCode', false); exit;"