#!/bin/sh

# Run this script as follows
# ./compile_report.sh 'Report Title' doc1.pdf doc2.pdf

# Insert the title
cat preamble.tex >custom.tex
printf '\n\n\\title{%s}\n\n' "$1" >>custom.tex
shift
cat report.tex >>custom.tex

# Run pdflatex 5 times
mkdir -p latex.out
printf 'Invoking "pdflatex -output-directory latex.out -halt-on-error custom.tex"\n'
for i in $(seq 1 5); do
	pdflatex -output-directory latex.out -halt-on-error custom.tex 1>/dev/null || exit 1
done

# Cat other documents
pdftk latex.out/custom.pdf $@ cat output report.pdf

# Clean-up
rm custom.tex
rm latex.out/*
rmdir latex.out

