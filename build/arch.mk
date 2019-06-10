#for x86
HAVE_AVX2 := Yes

ifneq ($(filter %86 x86_64, $(ARCH)),)
include $(SRC_PATH)build/x86-common.mk
ifeq ($(USE_ASM), Yes)
ifeq ($(HAVE_AVX2), Yes)
CFLAGS += -DHAVE_AVX2
CXXFLAGS += -DHAVE_AVX2
ASMFLAGS += -DHAVE_AVX2
endif
endif
endif

#for arm
ifneq ($(filter-out arm64, $(filter arm%, $(ARCH))),)
ifeq ($(USE_ASM), Yes)
ASM_ARCH = arm
ASMFLAGS += -I$(SRC_PATH)codec/common/arm/
CFLAGS += -DHAVE_NEON
endif
endif

#for arm64
ifneq ($(filter arm64 aarch64, $(ARCH)),)
ifeq ($(USE_ASM), Yes)
ASM_ARCH = arm64
ASMFLAGS += -I$(SRC_PATH)codec/common/arm64/
CFLAGS += -DHAVE_NEON_AARCH64
endif
endif

#for loongson & i6400 (samurai)
ifneq ($(filter mips mips64, $(ARCH)),)

ifeq ($(USE_ASM), Yes)
ifeq ($(LOONGSON3A), "loongson3a")
ASM_ARCH = mips
ASMFLAGS += -I$(SRC_PATH)codec/common/mips/
LOONGSON3A = $(shell g++ -dM -E - < /dev/null | grep '_MIPS_TUNE ' | cut -f 3 -d " ")
CFLAGS += -DHAVE_MMI
endif
endif

ifeq ($(SAMURAI), Yes)
CC = mips-img-linux-gnu-gcc
CXX = mips-img-linux-gnu-g++
#AR = mips-img-linux-gnu-ar
LDFLAGS = -EL -mabi=64 -static
CFLAGS += -Wall -EL -mmsa -mabi=64 -march=i6400 
CXXFLAGS += -Wall -EL -mmsa -mabi=64 -march=i6400

ifeq ($(MSA_DEBLOCK), Yes)
CFLAGS += -DMSA_DEBLOCK
CXXFLAGS += -DMSA_DEBLOCK
ifeq ($(MSA_DEBLOCK_REFERENCE), Yes)
CFLAGS += -DMSA_DEBLOCK_REFERENCE
CXXFLAGS += -DMSA_DEBLOCK_REFERENCE
endif

LDFLAGS += -L$(SRC_PATH)codec/custom_deblocking_filter/deblocking_filter/ -ldeblock
INCLUDES += -I$(SRC_PATH)codec/custom_deblocking_filter/deblocking_filter/
endif

endif
endif
