TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

TOOL_NAME = BatteryInfo

BatteryInfo_FILES = main.m
BatteryInfo_CFLAGS = -fobjc-arc
BatteryInfo_CODESIGN_FLAGS = -Sentitlements.plist
BatteryInfo_PRIVATE_FRAMEWORKS = IOKit
BatteryInfo_INSTALL_PATH = /usr/local/bin

include $(THEOS_MAKE_PATH)/tool.mk
