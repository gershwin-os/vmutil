#include $(GNUSTEP_MAKEFILES)/common.make
#
#TOOL_NAME = vmutil
#
#vmutil_OBJC_FILES = main.m
#
## Add framework include dir manually
#ADDITIONAL_OBJCFLAGS += -fobjc-arc
#ADDITIONAL_OBJCFLAGS += -F/System/Library/Frameworks
#ADDITIONAL_OBJCFLAGS += -I/System/Library/Frameworks/FBVirtualization.framework/Headers
#
## Link against the framework
#ADDITIONAL_LDFLAGS += -F/System/Library/Frameworks -framework FBVirtualization
#
#include $(GNUSTEP_MAKEFILES)/tool.make


include $(GNUSTEP_MAKEFILES)/common.make

TOOL_NAME = vmutil
vmutil_OBJC_FILES = main.m

# Add the path to the framework .so
ADDITIONAL_INCLUDE_DIRS += -I/System/Library/Frameworks/FBVirtualization.framework/Headers
ADDITIONAL_LDFLAGS += -L/System/Library/Frameworks/FBVirtualization.framework -lFBVirtualization

include $(GNUSTEP_MAKEFILES)/tool.make

