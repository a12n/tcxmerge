MACH != uname -m
OS != uname -s | tr -c -d '[:alpha:]' | tr '[:upper:]' '[:lower:]'
VSN != cat ../vsn
EXE != case ${OS} in cygwin*) echo .exe ;; *) echo ;; esac

DIR = tcxmerge-${VSN}-${OS}-${MACH}

.PHONY: all clean deps tar zip

all: tar

clean:
	-rm -r ${DIR} ${DIR}.tar.gz ${DIR}.zip

deps: ${DIR}/tcxmerge${EXE}
	ldd ${DIR}/tcxmerge${EXE} | grep /usr/ | cut -d ' ' -f 3 | \
		xargs -i cp {} ${DIR}

tar: ${DIR}.tar.gz

zip: ${DIR}.zip

${DIR}.tar.gz: ${DIR}/tcxmerge${EXE} ${DIR}/README.md
	tar -czvf $@ ${DIR}

${DIR}.zip: ${DIR}/tcxmerge${EXE} ${DIR}/README.md
	zip -9 -r $@ ${DIR}

${DIR}/tcxmerge${EXE}: ${DIR}
	cp ../tcxmerge.native $@
	strip $@

${DIR}/README.md: ${DIR}
	cp ../README.md $@

${DIR}:
	mkdir $@
