ARDUINO_DIR = ${HOME}/.local/arduino-1.0.5
ALTERNATE_CORE = SF32u4_boards
ARDMK_DIR = /usr/share/arduino

ARDUINO_LIBS =

BOARD_TAG = promicro16
MONITOR_PORT =/dev/ttyACM3

include ${ARDMK_DIR}/Arduino.mk


sketch.cpp: copilot.h

copilot.c copilot.h: codegen

LOCAL_OBJS := $(sort $(OBJDIR)/copilot.o $(LOCAL_OBJS))
$(TARGET_ELF): $(LOCAL_OBJS)

codegen: copilot-spec.hs clean-codegen
	runghc $<
	ln -s copilot-c99-codegen/copilot.c copilot.c
	ln -s copilot-c99-codegen/copilot.h copilot.h

.PHONY: codegen

clean-codegen:
	rm -rf copilot-c99-codegen copilot.c copilot.h

clean: clean-codegen
