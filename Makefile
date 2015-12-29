THEOS_DEVICE_IP = 192.168.2.3
ARCHS = armv7 arm64
TARGET = iphone:latest:8.0

include theos/makefiles/common.mk


TWEAK_NAME = skxbhook
skxbhook_FILES = Tweak.xm KeychainItemWrapper.m
skxbhook_FRAMEWORKS = UIKit Security

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 yanwen"
