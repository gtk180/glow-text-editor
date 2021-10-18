EXES_GLADE = glow-text-editor
CC = cc
CFLAGS = -Wall -export-dynamic -lm -g `pkg-config --cflags --libs gtk+-2.0 libglade-2.0`

all: 
	$(MAKE) $(EXES_GLADE) 

%: %.c
	$(CC) $@.c -o $@ $(CFLAGS)

clean:
	rm -f $(EXES_GLADE) $(EXES_NOGLADE) 
