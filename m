Message-Id: <201206042207.q54M7fLJ009293@vivaldi13.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: eparis@parisplace.org
Cc: SELinux@tycho.nsa.gov
Subject: [PATCH]: allow standard compilation of GIT development tree (was Re: [PATCH]: do not link static libraries from the system library directory)
Date: Tue, 05 Jun 2012 00:07:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Eric !

>At the moment, the sugggested way to do with is to use:
>
>make DESTDIR=[some dir] install

That is not standard. Standard practice is to build first by typing "make" and only after the build has completed successfully eventually proceed with the installation by typing "make install" (with DESTDIR).

>I've never really seen something which can get it right 'all the
>time'.  Fedora, and I assume other distros actually just use the git
>tree subdirectories.  I feel like any such patch to handle this is
>going to have to be something set in the top level Makefile and will
>have to cause no difficulties for other workflows....

You can build with virtually everything on automated build systems, as long as you can enter it once. But with humans, I suppose, you need something standard and easy to remember...

Here is the missing patch which complements the previous one (they were intentionally splitted):

Allow standard compilation with separate installation of the SELinux
GIT development tree.

To build, just type "make".

To install (after successful build), just type "make install".

During installation, it is possible to pass the variables DESTDIR,
LIBDIR and SHLIBDIR to GNU make in order to fine tune the results.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

---
 Makefile |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- selinux/Makefile	2011-09-09 20:12:55.977662144 +0200
+++ selinux-04062012/Makefile	2012-06-04 23:35:49.859339267 +0200
@@ -2,11 +2,21 @@ SUBDIRS=libsepol libselinux libsemanage
 PYSUBDIRS=libselinux libsemanage
 DISTCLEANSUBIDRS=libselinux libsemanage
 
+TOPDIR := $(shell pwd)
+
+CPPFLAGS ?= -I$(TOPDIR)/libselinux/include -I$(TOPDIR)/libsepol/include -I$(TOPDIR)/libsemanage/include
+LDFLAGS ?= -L$(TOPDIR)/libselinux/src -L$(TOPDIR)/libsepol/src -L$(TOPDIR)/libsemanage/src
+CFLAGS ?= $(CPPFLAGS)
+
 ifeq ($(DEBUG),1)
-	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
-	export LDFLAGS = -g
+	CFLAGS += -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
+	LDFLAGS += -g
 endif
 
+export CPPFLAGS
+export CFLAGS
+export LDFLAGS
+
 all install relabel clean test indent:
 	@for subdir in $(SUBDIRS); do 
 		(cd $$subdir && $(MAKE) $@) || exit 1; 

>On Mon, Jun 4, 2012 at 11:33 AM, Guido Trentalancia
><guido@trentalancia.com> wrote:
>> Do not ever link GIT development sources against static SELinux libraries that
>> are eventually already installed in the system library directory (LIBDIR), but
>> instead source the "fresh" local versions from the GIT development tree itself.
>>
>> This patch prevents build errors when SELinux is not already installed on a
>> system or even worse it prevents linking against previous (obsolete, buggy or even
>> insecure) versions of the libraries that might be found on the standard system
>> library directory as defined by the Makefile variable LIBDIR.
>>
>> It is intended only for the GIT development tree, therefore it should not be
>> applied to the individually released libraries or userspace tools, as it would
>> break their build (however, if released components are generated more or less
>> directly from the GIT development tree, it shouldn't be too difficult or time
>> consuming to process their Makefiles upon creation by using some sort of sed
>> script to revert linking from LIBDIR instead of relative local GIT tree library
>> subdirectories).
>>
>> Please note that similar problems do arise for the header files and the shared
>> libraries when building the GIT tree, although these problems can be avoided by
>> passing the appropriate compiler/linker options in CPPFLAGS, CFLAGS and LDFLAGS
>> to make so that the local headers and shared libraries files are used when
>> compiling/linking.
>>
>> Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
>>
>> ---
>>  checkpolicy/Makefile                    |    2 +-
>>  checkpolicy/test/Makefile               |    2 +-
>>  libselinux/src/Makefile                 |    2 +-
>>  policycoreutils/mcstrans/src/Makefile   |    2 +-
>>  policycoreutils/mcstrans/utils/Makefile |    2 +-
>>  policycoreutils/semodule_deps/Makefile  |    2 +-
>>  policycoreutils/sepolgen-ifgen/Makefile |    2 +-
>>  7 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff -pru selinux-04062012-original/checkpolicy/Makefile selinux-04062012/checkpolicy/Makefile
>> --- selinux-04062012-original/checkpolicy/Makefile      2011-09-09 20:12:55.978662153 +0200
>> +++ selinux-04062012/checkpolicy/Makefile       2012-06-04 14:04:44.954580741 +0200
>> @@ -19,7 +19,7 @@ CHECKOBJS = y.tab.o lex.yy.o queue.o mod
>>  CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
>>  CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
>>
>> -LDLIBS=$(LIBDIR)/libsepol.a -lfl
>> +LDLIBS=../libsepol/src/libsepol.a -lfl
>>
>>  GENERATED=lex.yy.c y.tab.c y.tab.h
>>
>> diff -pru selinux-04062012-original/checkpolicy/test/Makefile selinux-04062012/checkpolicy/test/Makefile
>> --- selinux-04062012-original/checkpolicy/test/Makefile 2012-03-23 17:00:49.273045007 +0100
>> +++ selinux-04062012/checkpolicy/test/Makefile  2012-06-04 14:01:39.788487811 +0200
>> @@ -9,7 +9,7 @@ INCLUDEDIR ?= $(PREFIX)/include
>>  CFLAGS ?= -g -Wall -W -Werror -O2 -pipe
>>  override CFLAGS += -I$(INCLUDEDIR)
>>
>> -LDLIBS=-lfl -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
>> +LDLIBS=-lfl -lselinux ../../libsepol/src/libsepol.a -L$(LIBDIR)
>>
>>  all: dispol dismod
>>
>> diff -pru selinux-04062012-original/libselinux/src/Makefile selinux-04062012/libselinux/src/Makefile
>> --- selinux-04062012-original/libselinux/src/Makefile   2012-05-29 21:12:20.635265972 +0200
>> +++ selinux-04062012/libselinux/src/Makefile    2012-06-04 14:02:48.398135397 +0200
>> @@ -122,7 +122,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
>>        $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
>>
>>  $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
>> -       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
>> +       $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ../../libsepol/src/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
>>
>>  %.o:  %.c policy.h
>>        $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
>> diff -pru selinux-04062012-original/policycoreutils/mcstrans/src/Makefile selinux-04062012/policycoreutils/mcstrans/src/Makefile
>> --- selinux-04062012-original/policycoreutils/mcstrans/src/Makefile     2011-09-09 20:12:56.040662607 +0200
>> +++ selinux-04062012/policycoreutils/mcstrans/src/Makefile      2012-06-04 14:06:54.356297716 +0200
>> @@ -28,7 +28,7 @@ override CFLAGS += -I../include -D_GNU_S
>>  all: $(PROG)
>>
>>  $(PROG): $(PROG_OBJS)
>> -       $(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a
>> +       $(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre ../../../libsepol/src/libsepol.a
>>
>>  %.o:  %.c
>>        $(CC) $(CFLAGS) -fPIE -c -o $@ $<
>> diff -pru selinux-04062012-original/policycoreutils/mcstrans/utils/Makefile selinux-04062012/policycoreutils/mcstrans/utils/Makefile
>> --- selinux-04062012-original/policycoreutils/mcstrans/utils/Makefile   2011-09-09 20:12:56.041662614 +0200
>> +++ selinux-04062012/policycoreutils/mcstrans/utils/Makefile    2012-06-04 14:06:45.590585065 +0200
>> @@ -21,7 +21,7 @@ endif
>>
>>  CFLAGS ?= -Wall
>>  override CFLAGS += -I../src -D_GNU_SOURCE
>> -LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre $(LIBDIR)/libsepol.a
>> +LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre ../../../libsepol/src/libsepol.a
>>
>>  TARGETS=$(patsubst %.c,%,$(wildcard *.c))
>>
>> diff -pru selinux-04062012-original/policycoreutils/semodule_deps/Makefile selinux-04062012/policycoreutils/semodule_deps/Makefile
>> --- selinux-04062012-original/policycoreutils/semodule_deps/Makefile    2011-11-15 00:32:56.867740958 +0100
>> +++ selinux-04062012/policycoreutils/semodule_deps/Makefile     2012-06-04 14:06:38.284818580 +0200
>> @@ -7,7 +7,7 @@ MANDIR ?= $(PREFIX)/share/man
>>
>>  CFLAGS ?= -Werror -Wall -W
>>  override CFLAGS += -I$(INCLUDEDIR)
>> -LDLIBS = $(LIBDIR)/libsepol.a
>> +LDLIBS = ../../libsepol/src/libsepol.a
>>
>>  all: semodule_deps
>>
>> diff -pru selinux-04062012-original/policycoreutils/sepolgen-ifgen/Makefile selinux-04062012/policycoreutils/sepolgen-ifgen/Makefile
>> --- selinux-04062012-original/policycoreutils/sepolgen-ifgen/Makefile   2011-11-15 00:32:56.878741037 +0100
>> +++ selinux-04062012/policycoreutils/sepolgen-ifgen/Makefile    2012-06-04 14:08:14.580334340 +0200
>> @@ -6,7 +6,7 @@ INCLUDEDIR ?= $(PREFIX)/include
>>
>>  CFLAGS ?= -Werror -Wall -W
>>  override CFLAGS += -I$(INCLUDEDIR)
>> -LDLIBS = $(LIBDIR)/libsepol.a
>> +LDLIBS = ../../libsepol/src/libsepol.a
>>
>>  all: sepolgen-ifgen-attr-helper
>>

Of course, after the two patches have been applied, it would still work with the previous trick of doing just "make install" (not recommended).

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
