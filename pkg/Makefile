MACH != uname -m
OS != uname -s | tr -c -d '[:alpha:]' | tr '[:upper:]' '[:lower:]'
VSN != cat ../vsn

DIR = tcxmerge-${VSN}-${OS}-${MACH}

.PHONY: all clean

all: ${DIR}.tar.gz

clean:
	-rm -r ${DIR} ${DIR}.tar.gz

${DIR}.tar.gz: ${DIR}.tar
	gzip -9 ${DIR}.tar

${DIR}.tar: ${DIR}/tcxmerge ${DIR}/README.md
	tar -cvf $@ ${DIR}

${DIR}/tcxmerge: ${DIR}
	cp ../tcxmerge.native $@
	strip $@

${DIR}/README.md: ${DIR}
	cp ../README.md $@

${DIR}:
	mkdir $@
