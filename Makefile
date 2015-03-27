OCAMLBUILD_FLAGS ?=
OCAMLBUILD_FLAGS += -cflags -w,+A-44
OCAMLBUILD_FLAGS += -use-ocamlfind

.PHONY: all clean
.SUFFIXES: .byte .ml .native

all: tcxmerge.native

clean:
	ocamlbuild ${OCAMLBUILD_FLAGS} -clean

.ml.byte:
	ocamlbuild ${OCAMLBUILD_FLAGS} $@

.ml.native:
	ocamlbuild ${OCAMLBUILD_FLAGS} $@
