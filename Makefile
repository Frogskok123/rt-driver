MODULE_NAME := rt_driver
RESMAN_CORE_OBJS := entry.o

# ДОБАВЬ ЭТИ СТРОКИ (из rwProcMem33)
ccflags-y += -DCONFIG_MODVERSIONS=0
ccflags-y += -fno-pic
ccflags-y += -Wno-declaration-after-statement

ifneq ($(KERNELRELEASE),)
	obj-m := $(MODULE_NAME).o
	$(MODULE_NAME)-objs := $(RESMAN_CORE_OBJS)
	
	# ДОБАВЬ ЭТО для обхода MODVERSIONS
	KBUILD_MODPOST_WARN := 1
else
	KDIR := kernel
	
all:
	make -C $(KDIR) M=$(PWD) ARCH=arm64 \
		CROSS_COMPILE=aarch64-linux-gnu- \
		KBUILD_MODPOST_WARN=1 \
		modules -j$(nproc)
	aarch64-linux-gnu-strip --strip-debug $(MODULE_NAME).ko

clean:
	rm -rf *.ko *.o *.mod .*.*.cmd *.mod.o *.mod.c *.symvers *.order .tmp_versions
endif
