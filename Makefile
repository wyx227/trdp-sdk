 .EXPORT_ALL_VARIABLES:
# Check if configuration is present
ifeq (config/config.mk,$(wildcard config/config.mk)) 
# load target specific configuration
include config/config.mk
endif

include rules.mk

MD = mkdir -p

CFLAGS += -D$(TARGET_OS)

EXTDIR = ext_src
INCPATH += -I src -I api/trdp_api -I api/vos_api -I api/sdtv2_api -I src/common


vpath %.c src

INCLUDES = $(INCPATH)

LDFLAGS += -L src/common -L api/vos_api -L api/trdp_api -L $(OUTDIR) -lm -lzmq -ljson-c
LIBS = $(OUTDIR)/libsdt.a $(OUTDIR)/libtrdpap.a

ifeq ($(MD_SUPPORT),0)
CFLAGS += -DMD_SUPPORT=0
else
TRDP_OBJS += trdp_mdcom.o
CFLAGS += -DMD_SUPPORT=1
endif

ifeq ($(DEBUG), TRUE)
	OUTDIR = output/$(ARCH)-dbg
else
	OUTDIR = output/$(ARCH)-rel
endif

# Enable / disable Debug
ifeq ($(DEBUG),TRUE)
CFLAGS += -g3 -O -DDEBUG
LDFLAGS += -g3
# Display the strip command and do not execute it
STRIP = @echo "do NOT strip: "
else
CFLAGS += -Os  -DNO_DEBUG
endif



all:	outdir trdp_build sdt_build 

clean:
	rm -rf $(OUTDIR)
	rm -rf ext_src/SDTv2/output/*
	rm -rf ext_src/trdp/bld/*
	rm -rf api


outdir:
	mkdir -p $(OUTDIR)
	mkdir -p api
	cd api; $(LN) ../$(EXTDIR)/trdp/src/api trdp_api
	cd api; $(LN) ../$(EXTDIR)/trdp/src/vos/api vos_api
	cd api; $(LN) ../$(EXTDIR)/SDTv2/api sdtv2_api

trdp_build:	api/.TRDP_BUILT

sdt_build: api/.SDTV2_BUILT


api/.TRDP_BUILT:
	$(MAKE) -C $(EXTDIR)/trdp -j8 libtrdpap
	cd $(OUTDIR); $(LN) ../../$(EXTDIR)/trdp/bld/$(OUTDIR)/libtrdpap.a libtrdpap.a
	touch $(@)

api/.SDTV2_BUILT:
	$(MAKE) -C $(EXTDIR)/SDTv2 -j8
	cd $(OUTDIR); $(LN) ../../$(EXTDIR)/SDTv2/$(OUTDIR)/libsdt.a libsdt.a
	touch $(@)


%_config:	
	cp -f config/$@ config/config.mk
	cp -f ext_src/SDTv2/config/$(subst config,cfg,$@) ext_src/SDTv2/config/config.mk
	cp -r ext_src/trdp/config/$@ ext_src/trdp/config/config.mk


help:
	@echo "Software packets utilizing TRDP protocol"
	@echo "make all for build all required user software"
	@echo "make install for installing the softwares to the target machines"
	@echo "make clean for cleaning the build artifacts"
	@echo "make LINUX_X86_64_config for building for PC Linux target"
	@echo "Make LNNUX_aarch64_config for building for Raspberry Pi and Raxda Rock Pi"

