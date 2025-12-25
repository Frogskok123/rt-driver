obj-m               := rt-driver.o
rt-driver-objs      := entry.o

ARCH          := arm64
CROSS_COMPILE ?= aarch64-linux-gnu-
KDIR          ?= /path/to/your/kernel

# главная строка – гасит модversions и задаёт универсальный vermagic
KBUILD_MODPOST_NOFINAL := y
KBUILD_MODPOST_WARN    := 1
ccflags-y += -D"VERMAGIC_STRING=\"5.10.0 SMP preempt mod_unload aarch64\""

all:
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -f *.o *.ko *.mod.c *.mod *.order *.symvers .*.cmd .tmp_versions

