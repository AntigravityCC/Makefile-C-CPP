TARGET = exe

CC = gcc
CXX = g++

AllDIRS := $(shell ls -R | grep '^\./.*:$$' | awk '{gsub(":","");print}') .
CSRCS = $(foreach n,$(AllDIRS) , $(wildcard $(n)/*.c)) 
CXXSRCS = $(foreach n,$(AllDIRS) , $(wildcard $(n)/*.cpp)) 

OBJS := $(CSRCS:.c=.o) $(CXXSRCS:.cpp=.o)

DEBUG_FLAG  =
#DEBUG_FLAG := -g

SRC_PATH = .
INC_PATH = -I $(SRC_PATH) \
				-I $(SRC_PATH)/src\
				-I $(SRC_PATH)/include\


LIB_PATH = -lpthread

$(TARGET) : $(OBJS)
	$(CXX) $(DEBUG_FLAG) $^ -o $@ $(INC_PATH) $(LIB_PATH);
	@echo "> build success <"


%.o : %.cpp
	$(CXX) $(DEBUG_FLAG) $< -c -o $@ $(INC_PATH) $(LIB_PATH);

%.o : %.c
	$(CC) $(DEBUG_FLAG) $< -c -o  $@ $(INC_PATH) $(LIB_PATH);

.PHONY:clean

clean:
	rm -f $(OBJS) $(TARGET)
