MACH != uname -m
OS != uname -s | tr -c -d '[:alpha:]' | tr '[:upper:]' '[:lower:]'
VSN != cat ../vsn

DIR = tcxmerge-${VSN}-${OS}-${MACH}

.PHONY: all clean tar zip

all: tar

clean:
	-rm -r ${DIR} ${DIR}.tar.gz ${DIR}.zip

tar: ${DIR}.tar.gz

zip: ${DIR}.zip

${DIR}.tar.gz: ${DIR}/tcxmerge ${DIR}/README.md
	tar -czvf $@ ${DIR}

${DIR}.zip: ${DIR}/tcxmerge ${DIR}/README.md
	zip -9 -r $@ ${DIR}

${DIR}/tcxmerge: ${DIR}
	cp ../tcxmerge.native $@
	strip $@

${DIR}/README.md: ${DIR}
	cp ../README.md $@

${DIR}:
	mkdir $@
