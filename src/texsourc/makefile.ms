# Copyright 2007 TeX Users Group.
# You may freely use, modify and/or distribute this file.

# Makefile for Y&YTeX

# NOTE: use old NMAKE for this to avoid bugs in call to LINK ?

# NOTE: full optimization causes some problems especially in TEX5.C & TEX6.C
# NOTE: assuming no aliasing causes some problems especially in TEXMF.C

# CC = wcl386
# CC = cl386
CC = cl

# LINK = 386link

# Use MicroSoft LINK instead

LINK = link

# Need not define MSDOS, since compiler already takes care of that...

# -Gf saves about 7k bytes in EXE file

# For production (-Bd show compiler passes)
# CFLAGS=-c -DDOS -DMSDOS -DTeX -DMYDEBUG -Ilib -Ox -W3
# CFLAGS=-c -DDOS -DMSDOS -DTeX -DMYDEBUG -Ilib -Oax -W3
# CFLAGS=-c -DDOS -DMSDOS -DPHARLAP -DTeX -DMYDEBUG -Ilib -Oax -Zp4 -W3
# CFLAGS=-c -DDOS -DMSDOS -DPHARLAP -DTeX -DMYDEBUG -Ilib -Oax -Gf -W3
# CFLAGS=-c -DDOS -DMSDOS -DPHARLAP -DTeX -DMYDEBUG -Ilib -Ox -Gf -W3
CFLAGS=-c -DDOS -DMSDOS -DPHARLAP -DTeX -DMYDEBUG -Ilib -Ox -Gy -Gf -W3
# debugging info added
CFLAGS=-c -DDOS -DMSDOS -DPHARLAP -DTeX -DMYDEBUG -Ilib -Ox -Gy -Gf -W3 -Zi

# turn off optimizations to try and catch bugs 94 March 20
# CFLAGS=-c -DDOS -DMSDOS -DPHARLAP -DTeX -DMYDEBUG -Ilib -Od -Gy -W3

# Without Optimization (for TEX5.C and TEX6.C and TEX2.C)
# CFLAGSAFE=-c -DDOS -DMSDOS -DTeX -DMYDEBUG -Ilib -Oityb1 -Gs -W3

# With floating point (and not packed):
# # LFLAGS=@msc386 -l lib\libdos 
# LFLAGS=@msvc32.dos -l lib\libdos 

# Without floating point (and packed):
# LFLAGS=@msc386 @nofloat -l lib\libdos -pack <=====
# cannot pack unless exeformat is EXP and msvc32.dos sets it to PE
# LFLAGS=@msvc32.dos -exeformat exp -l lib\libdos -pack 
# LFLAGS=@msvc32.dos @y&ytex @nofloat 
# LFLAGS=@msvc32.nt @y&ytex <=== for Windows NT ?
# LFLAGS=@msvc32.dos @y&ytex.lnk
# debugging info added
# LFLAGS=@msvc32.dos @y&ytex.lnk -cvsym

# For MicroSoft Linker
# LFLAGS=y&ytex @c:\tnt\bin\msvc32.lnk @y&ytex.lnk
# LFLAGS=y&ytex @c:\tnt\bin\msvc32.lnk -l lib\libdos
# LFLAGS=@c:\tnt\bin\msvc32.lnk lib\libdos.lib 
# LFLAGS=@c:\tnt\bin\msvc32.lnk lib\libdos.lib dosx32.lib dos32.lib errno.lib
LFLAGS=@c:\tnt\bin\msvc32.lnk lib\libdos.lib dos32.lib errno.lib
# debugging info added
LFLAGS=@c:\tnt\bin\msvc32.lnk lib\libdos.lib dos32.lib errno.lib -cvsym

# ONLY AN ATTEMPT TO SOLVE PROBLEM WITH TNT 6.1:
# LFLAGS=@msvc32.nt @y&ytex 

# NEED TO REMOVE @nofloat FOR PRODUCTION IN CASE PEOPLE DON'T HAVE COPROCESSOR!

# For debugging
# # CFLAGS=-c -DDOS -DMSDOS -DTeX -DMYDEBUG -Ilib -Zi -W3
# CFLAGS=-c -DDOS -DMSDOS -DTeX -DMYDEBUG -Ilib -Z7 -W3
# CFLAGS=-c -DDOS -DMSDOS -DPHARLAP -DTeX -DMYDEBUG -Ilib -Z7 -W4
# CFLAGS=-c -DDOS -DMSDOS -DPHARLAP -DTeX -DMYDEBUG -Ilib -Z7 -W4

# For debugging
# LFLAGS=-pack -fullsym @msc386 @nofloat -lib lib\libdos -exe y&ytex
# LFLAGS= @msc386 @nofloat -l lib\libdos -pack -fullsym -regvars
# LFLAGS= @msvc32.dos -exeformat exp -l lib\libdos -pack -fullsym -regvars
# LFLAGS= @msvc32.dos @y&ytex -fullsym -regvars
# LFLAGS=@msvc32.dos @y&ytex -fullsym -regvars
# LFLAGS=@msvc32.dos @y&ytex -fullsym -regvars

# objs = cextra.obj citex.obj openinou.obj local.obj \
objs = 	texmf.obj tex0.obj tex1.obj tex2.obj tex3.obj tex4.obj \
	  tex5.obj tex6.obj tex7.obj tex8.obj \
	      itex.obj openinou.obj local.obj texmagic.obj

# NOTE: have to use PHARLAP linker for this

# ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# link in c:\tnt\lib\realloc.obj to avoid bug in MS realloc() (TNT 6.1)
# use c:\tnt\lib\realloc for 386|LINK,  c:\tnt\cofflib\realloc  for MS LINK
# somehow we get a conflict if we link in local.obj ....

y&ytex.exe: $(objs) lib/libdos.lib
#	wcl386 @combine
#    	386link citex cextra local openinou \
#    	386link itex texmf local openinou \
#    	$(LINK) texmf tex0 tex1 tex2 tex3 tex4 tex5 tex6 tex7 tex8 \
#	 itex openinou local texmagic $(LFLAGS)
#	 itex openinou local texmagic c:\tnt\lib\realloc $(LFLAGS)
#
   	$(LINK) $(LFLAGS) texmf tex0 tex1 tex2 tex3 tex4 tex5 tex6 tex7 tex8 \
	 itex openinou local texmagic
#
#	 itex openinou local texmagic $(LFLAGS)
#	copy citex.exe y&ytex.exe
#	copy itex.exe y&ytex.exe
#	del citex.exe
#	del itex.exe
	markphar -dosstyle texmf
	del y&ytex.exe
#	rename itex.exe y&ytex.exe
	rename texmf.exe y&ytex.exe
	cfig386 y&ytex.exe %%y&ytex
#	rebindb y&ytex 
#	rebindb y&ytex kernel32.dll etc etc
	c:\winice\dbg2map y&ytex.exe
# above gives unhandled file format ...
	c:\winice\msym y&ytex
# above gives not enough memory ...

# ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###

# cextra.obj: texd.h ..\lib\texmf.c
# cextra.obj: lib\texmf.c lib\texd.h
texmf.obj: lib\texmf.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h lib\c-ctype.h lib\c-pathch.h 
#	$(CC) -focextra -DINITEX -DINI $(CFLAGS) -c ..\lib\texmf.c
#	$(CC) -Focextra -DINITEX -DINI $(CFLAGS) lib\texmf.c
	$(CC) -DINITEX -DINI $(CFLAGS) lib\texmf.c
#	copy texmf.obj cextra.obj

# citex.obj: itex.c lib\texd.h 
itex.obj: itex.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h 
#	$(CC) -focitex -DINITEX $(CFLAGS) -c itex.c
#	$(CC) -Focitex -DINITEX $(CFLAGS) itex.c
	$(CC) -DINITEX $(CFLAGS) itex.c
#	copy itex.obj citex.obj

# openinout.obj: texd.h ..\lib\openinout.c 
openinou.obj: lib\openinou.c \
	lib\config.h lib\c-auto.h lib\c-std.h lib\c-unistd.h \
	lib\c-memstr.h lib\c-errno.h lib\c-minmax.h lib\c-limits.h \
	lib\c-pathmx.h lib\c-fopen.h lib\c-proto.h lib\common.h \
	lib\getopt.h lib\lib.h lib\types.h lib\ourpaths.h \
	lib\pascal.h lib\c-namemx.h lib\c-pathch.h lib\texd.h \
	lib\texmf.h lib\texmfmem.h lib\coerce.h 
#	$(CC) $(CFLAGS) -c ..\lib\openinout.c
	$(CC) $(CFLAGS) lib\openinou.c

local.obj: local.c \
	lib\getopt.h lib\texd.h lib\texmf.h lib\config.h \
	lib\c-auto.h lib\c-std.h lib\c-unistd.h lib\c-memstr.h \
	lib\c-errno.h lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h \
	lib\c-fopen.h lib\c-proto.h lib\common.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h lib\coerce.h 
	$(CC) -DINITEX $(CFLAGS) local.c

# NOTE: cannot compile tex5.c and tex6.c with full optimizations ...

tex0.obj: tex0.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h 

tex1.obj: tex1.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h 

tex2.obj: tex2.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h 

tex3.obj: tex3.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h 

tex4.obj: tex4.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h 

# tex5.obj: tex5.c lib\texd.h lib\texmf.h lib\coerce.h

tex5.obj: tex5.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h 
#	$(CC) $(CFLAGSAFE) tex5.c

# tex6.obj: tex6.c lib\texd.h lib\texmf.h lib\coerce.h

tex6.obj: tex6.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h 
#	$(CC) $(CFLAGSAFE) tex6.c

tex7.obj: tex7.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h 

tex8.obj: tex8.c \
	lib\texd.h lib\texmf.h lib\config.h lib\c-auto.h \
	lib\c-std.h lib\c-unistd.h lib\c-memstr.h lib\c-errno.h \
	lib\c-minmax.h lib\c-limits.h lib\c-pathmx.h lib\c-fopen.h \
	lib\c-proto.h lib\common.h lib\getopt.h lib\lib.h \
	lib\types.h lib\ourpaths.h lib\pascal.h lib\texmfmem.h \
	lib\coerce.h 

texmagic.obj: texmagic.c 

.SUFFIXES:
.SUFFIXES: .obj .c

c..obj:
	$(CC) $(CFLAGS) $*.c
