INCDIR=include
SRCDIR=src
OBJDIR=obj
EXE=sean

CC=g++
# Debug build
#CFLAGS=-g -Wall -Wconversion -Wsign-conversion -I$(INCDIR) -fopenmp -lfftw3
# Release build
CFLAGS=-O3 -Wall -Wconversion -Wsign-conversion -I$(INCDIR) -fopenmp -lfftw3
ROOTFLAGS=`root-config --cflags --glibs` -lMathMore -lm

_DEPS = Experiment.h Config.h CrossSection.h Target.h Absorption.h Settings.h InputReader.h PhononDensity.h Plotter.h Writer.h Integrator.h
DEPS = $(patsubst %,$(INCDIR)/%,$(_DEPS))

_OBJ = Experiment.o main.o CrossSection.o Target.o Absorption.o Settings.o InputReader.o PhononDensity.o Plotter.o Writer.o Integrator.o
OBJ = $(patsubst %,$(OBJDIR)/%,$(_OBJ))

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS) $(ROOTFLAGS) 

$(EXE): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(ROOTFLAGS)

clean:
	rm -f $(OBJDIR)/*.o
	rm -f $(EXE)
