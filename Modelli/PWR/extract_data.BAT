del stripf
del output_strip

relap5.exe -i input_strip.i -o output_strip -s stripf

graf.exe <stripf> "data.csv"