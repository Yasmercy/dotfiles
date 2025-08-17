# Always use pdflatex with synctex
$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';

# Use biber instead of bibtex automatically
$bibtex = 'biber %O %S';

# Clean extra junk
# @generated_exts = qw(acn acr alg aux bbl bcf blg glg glo gls ist lof log lol lot out run.xml synctex.gz toc fdb_latexmk fls);

# Continuous preview with zathura
$pdf_previewer = "zathura %S";
