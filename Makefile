CFLAGS := -Wall -export-dynamic -lm -g `pkg-config --cflags --libs gtk+-2.0 libglade-2.0`
TARGET_EXEC := glow-text-editor

BUILD_DIR := ./build
SRC_DIRS := ./src

SRCS := $(shell find $(SRC_DIRS) -name '*.cpp' -or -name '*.c' -or -name '*.s')

OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CPPFLAGS := $(INC_FLAGS) -MMD -MP

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS) $(CFLAGS)

$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(dir $@)	
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@ $(CFLAGS)

$(BUILD_DIR)/%.cpp.o: %.cpp	
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@


.PHONY: clean
clean:
	rm -r $(BUILD_DIR)

-include $(DEPS)

