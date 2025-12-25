# Universal 5.10.x ARM64 driver
obj-m               := rt-driver.o
rt-driver-objs      := entry.o

ARCH                := arm64
CROSS_COMPILE       ?= aarch64-linux-gnu-
KDIR                ?= /lib/modules/$(shell uname -r)/build

# убираем modversions и фиксим vermagic
ccflags-y           += -D"VERMAGIC_STRING=\"5.10.0 SMP preempt mod_unload aarch64\""
KBUILD_MODPOST_WARN  = 1
KBUILD_MODPOST_NOFINAL = y

all:
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -f *.o *.ko *.mod.c *.mod *.order *.symvers .*.cmd
	rm -rf .tmp_versions

.PHONY: all clean

