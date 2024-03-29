# Getting Started with typesetting and document processing with troff and mom

### Canonical reference materials

The canonical reference materials for groff are [cstr54](https://www.troff.org/54.pdf) (a downloadable PostScript copy of which is available here) and the troff and groff_diff manpages. The most complete and up-to-date source of information is the groff info pages, available by typing info groff at the command line (assuming you have the TeXinfo standalone browser installed on your system, which is standard for most GNU/Linux distributions). And for inputting special characters, see man groff_char.

[IETF reference](https://tools.ietf.org/doc/groff/html/mom/intro.html#top)

MOM
- [mom online reference](https://www.schaffter.ca/mom/momdoc/toc.html)
- [mom user manual (pdf)](https://www.schaffter.ca/mom/pdf/mom-pdf.pdf)
- [groff and mom overview](https://www.schaffter.ca/shared/groff-and-mom.pdf)
  - [groff and mom overview source](https://www.schaffter.ca/shared/groff-and-mom.mom)
  - [stypesheet used in book](https://www.schaffter.ca/shared/groff-and-mom-style.mom)
- [fonts in mom](https://www.schaffter.ca/mom/momdoc/appendices.html)
  - [font install automation](https://www.schaffter.ca/mom/momdoc/appendices.html#install-font)
- [Examples](https://www.schaffter.ca/mom/mom-04.html#examples)

```
$ info groff        # most complete and up-to-date information
$ man troff         # troff
$ man groff_diff    # GNU troff vs classival troff
$ man groff_mom     # mom macros, roff language which is part of groff
$ man groff_char    # groff glyph names
```

### Install more fonts

```
$ for size in 8 9 10 12 17; do  for type in r i b; do sudo install-font.sh -s -F cm -f +${type^^} cm${type}${size}.pfb ; done ; done
fontforge not installed. Aborting.
...
$ sudo pacman -S fontforge
```
