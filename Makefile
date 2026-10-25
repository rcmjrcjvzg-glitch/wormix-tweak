TARGET = iphone:clang:latest:15.0
ARCHS = arm64
INSTALL_TARGET_PROCESSES = ru.pragmatix.wormix.mobile

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WormixTest
WormixTest_FILES = Tweak.x
WormixTest_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/tweak.mk