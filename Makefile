CC=i686-elf-g++
AS=i686-elf-as
WARNINGS  = -Waggregate-return # deny returning structure or union
WARNINGS += -Wall # many warnings
WARNINGS += -Wcast-align # warn when alginment of cast grows target
WARNINGS += -Wcast-qual # warn when removing types via cast
WARNINGS += -Wctor-dtor-privacy # warn all private constructors
WARNINGS += -Wdisabled-optimization # warn if GCC unable to optimize
WARNINGS += -Weffc++ # Effective C++ warnings
WARNINGS += -Werror # warnings as errors
WARNINGS += -Wextra # extra warnings
WARNINGS += -Wformat=2 # warn about formatting type errors
WARNINGS += -Winit-self # warn vars inited by self
WARNINGS += -Winline # warn inline can't be inlined
WARNINGS += -Wlogical-op # warn suspicous logical ops
WARNINGS += -Wmissing-declarations # warn global funs no declaration
WARNINGS += -Wmissing-include-dirs # warn user-suplied include dir not exist
WARNINGS += -Wunused # warn unused things
WARNINGS += -Wnoexcept # warn when exception evals to false
WARNINGS += -Wold-style-cast # warn if old-style cast used
WARNINGS += -Woverloaded-virtual # warn if overloading of virts
WARNINGS += -Wpadded # warn if padding is included in struct
WARNINGS += -Wredundant-decls # warn if redundant declaration
WARNINGS += -Wshadow # warn about shadowing
WARNINGS += -Wconversion # warn implicit conversions of ints
WARNINGS += -Wsign-promo # warn if unsigned become signs
WARNINGS += -Wstrict-aliasing=3 # warn violation of strict aliasing
WARNINGS += -Wstrict-null-sentinel # warn of uncasted NULL as sentinal
WARNINGS += -Wstrict-overflow=5 # overflow warnings
WARNINGS += -Wswitch-default # warn if switch withhout default
WARNINGS += -Wswitch-enum # warn if non-comprehensive switch enum
WARNINGS += -Wundef # warn if undefined identifier in ifdef
WARNINGS += -Wunsafe-loop-optimizations # warn if loop cannot be optimized
WARNINGS += -Wuseless-cast # warn casting expr to own type
WARNINGS += -Wzero-as-null-pointer-constant # warn literal '0' used as null pointer
WARNINGS += -pedantic # strict ISO C++
CFLAGS  = -g -O2 -std=c++11 -fstrict-overflow -fstrict-enums -flto -fuse-linker-plugin
CFLAGS += -ffreestanding -fno-exceptions -fno-rtti -fstrict-aliasing $(WARNINGS)

all: bltos.bin

kernel.o: kernel.cpp
	$(CC) -c kernel.cpp -o kernel.o $(CFLAGS)

boot.o:
	$(AS) boot.s -o boot.o

bltos.bin: kernel.o boot.o
	$(CC) -T linker.ld -o bltos.bin -nostdlib -lgcc $(CFLAGS) boot.o kernel.o

# bltos.iso: bltos.bin
# 	mkdir -p isodir
# 	mkdir -p isodir/boot
# 	cp bltos.bin isodir/efi.img
# 	mkdir -p isodir/boot/grub
# 	cp grub.cfg isodir/boot/grub/grub.cfg
# 	grub-mkrescue -o bltos.iso isodir

clean:
	rm -f *.o
	rm -f *.bin
	rm -rf isodir
	rm -f *.iso
