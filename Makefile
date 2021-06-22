CFLAGS  = -std=c99 -pedantic -Wall -O2 -fPIC
LDLIBS  = -ldl -lncurses

RUNNING_INSTANCE_PID := $(shell pidof main)

all : main libgame.so

main : main.c game.h
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LDLIBS)

libgame.so : game.c game.h
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -o $@ $< $(LDLIBS)
ifneq "$(RUNNING_INSTANCE_PID)" ""
	@killall -USR1 main
endif

test : main libgame.so
	./$<

clean :
	$(RM) *.o *.so main
