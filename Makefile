all: pythoncall.mexglx

PYTHON_ROOT ?= /home/benpeters/.pyenv/versions/3.3.2
LIBPYTHON=$(firstword $(wildcard $(PYTHON_ROOT)/lib/libpython3.3m.so.*))

NUMPYINC=$(PYTHON_ROOT)/lib/python3.3/site-packages/numpy/core/include

CFLAGS=-g -DDEBUG -I$(PYTHON_ROOT)/include/python3.3m -I$(NUMPYINC) -DNUMPY -DLIBPYTHON='\"$(LIBPYTHON)\"' 
LDFLAGS=LDFLAGS='-nostartfiles -shared -Xlinker -export-dynamic -Wl,--version-script,/usr/local/matlab/R2013a/extern/lib/glnxa64/mexFunction.map -Wl,--no-undefined,-rpath=$(PYTHON_ROOT)/lib' -L $(PYTHON_ROOT)/lib/
LIBS=-lpython3.3m -lutil -ldl -lm -lpthread

pythoncall.mexglx: pythoncall.c
	mex $(CFLAGS) $(LDFLAGS) $^ $(LIBS)

clean:
	rm -f pythoncall.o pythoncall.mexglx
