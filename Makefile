obj-m := rt-driver.o
rt-driver-objs := entry.o

ARCH := arm64
KDIR ?= /lib/modules/$(shell uname -r)/build

# Разрешаем предупреждения вместо ошибок
export KBUILD_MODPOST_WARN=1

all:
	$(MAKE) ARCH=$(ARCH) LLVM=1 LLVM_IAS=1 -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -f *.o *.ko *.mod.c *.mod *.order *.symvers .*.cmd
	rm -rf .tmp_versions

.PHONY: all clean
