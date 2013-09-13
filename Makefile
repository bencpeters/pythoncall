all: pythoncall.mexglx

PYTHON_ROOT=/home/benpeters/python
LIBPYTHON=$(firstword $(wildcard $PYTHON_ROOT/lib/libpython3.3m.a))

NUMPYINC=$(PYTHON_ROOT)/lib/python3.3/site-packages/numpy/core/include

CFLAGS=-g -DDEBUG -I/home/benpeters/python/include/python3.3m -I$(NUMPYINC) -DNUMPY -DLIBPYTHON='\"$(LIBPYTHON)\"'
LDFLAGS=LDFLAGS='-nostartfiles -pthread -Wl,--version-script,/usr/local/matlab/R2013a/extern/lib/glnxa64/mexFunction.map -Wl,--no-undefined' -L $(PYTHON_ROOT)/lib/
LIBS=-lpython3.3m -lutil

pythoncall.mexglx: pythoncall.c
	mex $(CFLAGS) $(LDFLAGS) $^ $(LIBS)

clean:
	rm -f pythoncall.o pythoncall.mexglx
