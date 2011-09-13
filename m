Subject: Re: [PATCH] Fix includes for userspace tools and libraries (was Re:
 [PATCH] Fix include semanage/handle.h for semanage_set_root() as used by
 semodule)
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Tue, 13 Sep 2011 02:53:22 +0200
In-Reply-To: <1315868758.2177.8.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315868758.2177.8.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315875203.2177.22.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-13 at 01:05 +0200, Guido Trentalancia wrote:
> Hi Eric.
> 
> On Mon, 2011-09-12 at 18:01 -0400, Eric Paris wrote:
> > On 09/12/2011 04:29 PM, Guido Trentalancia wrote:
> > > Hi Stephen.
> > > 
> > > On Mon, 2011-09-12 at 08:57 -0400, Stephen Smalley wrote:
> > >> On Fri, 2011-09-09 at 13:31 -0400, Eric Paris wrote:
> > >>> I'm also really annoyed by this at times, but I don't know what the
> > >>> right answer is.
> > >>>
> > >>> We really treat it like we have 5+ separate projects which just all
> > >>> happen to live in the same git tree.  Thus to build libselinux you
> > >>> must have already built and installed libsepol.  And then to build
> > >>> libsemanage you need to have done that with both libsepol and
> > >>> libselinux.  Then of course to get the builds and install right (on
> > >>> Fedora/RHEL) you have to know to use LIBDIR=/usr/lib64 SHLIBDIR=/lib64
> > >>> for libsepol and libsepol, but SHLIBDIR=/usr/lib64 for libsemanage.
> > >>> Its a mess, but I don't know what to do that's better....
> > >>
> > >> make DESTDIR=~/out at top-level should work fine - it will build and
> > >> install each library into a private tree (as specified by DESTDIR) and
> > >> then build and install the programs against those libraries.  Without
> > >> needing to clobber the system ones.
> > > 
> > > At the moment, it does not, until the Makefile(s) are modified or at
> > > least until the libraries are manually installed first.
> > > 
> > > Try by yourself, but do not forget to remove
> > > $(PREFIX)/usr/include/{selinux,semanage,sepol} and
> > > $(PREFIX){/usr,}/lib/libse{linux,manage,pol}* first !
> > 
> > I recently added the patch which changed the global to be 'build'
> > instead of 'install', so sds might not realize that 'install' is no
> > longer the default, however I think Guido is right about the install
> > having a number of paces that it hard coded things...
> 
> The new target seems to be "all" (introduced on Aug the 11th by Eric).
> 
> However, at the moment, without an existing installation in place the
> build fails on my system because it cannot source header files from
> $(PREFIX)/include/{selinux,sepol,semanage} during compilation and then
> because it cannot source shared libraries from LIBDIR ?= $(PREFIX)/lib
> during linking.
> 
> It also fails if an existing installation provides obsolete header
> files.
> 
> Another (even better) way of achieving the same would probably be to set
> a TOPLEVEL variable to "pwd" (shell builtin for current directory) in
> the top-level Makefile and then add -I
> $(TOPLEVEL)/{selinux,sepol,semanage}/include and -L
> $(TOPLEVEL)/lib{selinux,sepol,semanage}/src to CFLAGS and LDFLAGS
> respectively...

And here is what I meant:

diff -pruN selinux/checkpolicy/Makefile selinux-12092011-test-toplevel-arguments/checkpolicy/Makefile
--- selinux/checkpolicy/Makefile	2011-09-09 20:12:55.978662153 +0200
+++ selinux-12092011-test-toplevel-arguments/checkpolicy/Makefile	2011-09-13 02:24:20.252767154 +0200
@@ -19,7 +19,7 @@ CHECKOBJS = y.tab.o lex.yy.o queue.o mod
 CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
 CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
 
-LDLIBS=$(LIBDIR)/libsepol.a -lfl
+LDLIBS=../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
 
 GENERATED=lex.yy.c y.tab.c y.tab.h
 
diff -pruN selinux/checkpolicy/test/Makefile selinux-12092011-test-toplevel-arguments/checkpolicy/test/Makefile
--- selinux/checkpolicy/test/Makefile	2011-09-09 20:12:55.980662174 +0200
+++ selinux-12092011-test-toplevel-arguments/checkpolicy/test/Makefile	2011-09-13 02:25:01.297083713 +0200
@@ -9,7 +9,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 CFLAGS ?= -g -Wall -O2 -pipe
 override CFLAGS += -I$(INCLUDEDIR)
 
-LDLIBS=-lfl -lsepol -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
+LDLIBS=-lsepol -lselinux ../../libsepol/src/libsepol.a -L$(LIBDIR) -lfl
 
 all: dispol dismod
 
diff -pruN selinux/Makefile selinux-12092011-test-toplevel-arguments/Makefile
--- selinux/Makefile	2011-09-09 20:12:55.977662144 +0200
+++ selinux-12092011-test-toplevel-arguments/Makefile	2011-09-13 02:29:20.085069282 +0200
@@ -3,10 +3,15 @@ PYSUBDIRS=libselinux libsemanage
 DISTCLEANSUBIDRS=libselinux libsemanage
 
 ifeq ($(DEBUG),1)
-	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
-	export LDFLAGS = -g
+	CFLAGS += -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
+	LDFLAGS += -g
 endif
 
+CFLAGS += -I$(CURDIR)/libselinux/include -I$(CURDIR)/libsepol/include -I$(CURDIR)/libsemanage/include
+LDFLAGS += -L$(CURDIR)/libselinux/src -L$(CURDIR)/libsepol/src -L$(CURDIR)/libsemanage/src
+export CFLAGS
+export LDFLAGS
+
 all install relabel clean test indent:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
diff -pruN selinux/policycoreutils/semodule_deps/Makefile selinux-12092011-test-toplevel-arguments/policycoreutils/semodule_deps/Makefile
--- selinux/policycoreutils/semodule_deps/Makefile	2011-09-09 20:12:56.076662865 +0200
+++ selinux-12092011-test-toplevel-arguments/policycoreutils/semodule_deps/Makefile	2011-09-13 02:14:41.954328802 +0200
@@ -7,7 +7,7 @@ MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = $(LIBDIR)/libsepol.a
+LDLIBS = ../../libsepol/src/libsepol.a
 
 all: semodule_deps
 
diff -pruN selinux/policycoreutils/sestatus/Makefile selinux-12092011-test-toplevel-arguments/policycoreutils/sestatus/Makefile
--- selinux/policycoreutils/sestatus/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-12092011-test-toplevel-arguments/policycoreutils/sestatus/Makefile	2011-09-13 02:12:59.996589853 +0200
@@ -5,7 +5,7 @@ MANDIR = $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LIBDIR ?= ${PREFIX}/lib
 
-CFLAGS = -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
 LDLIBS = -lselinux -L$(LIBDIR)
 
diff -pruN selinux/policycoreutils/setfiles/Makefile selinux-12092011-test-toplevel-arguments/policycoreutils/setfiles/Makefile
--- selinux/policycoreutils/setfiles/Makefile	2011-09-09 20:12:56.078662881 +0200
+++ selinux-12092011-test-toplevel-arguments/policycoreutils/setfiles/Makefile	2011-09-13 02:12:44.826477882 +0200
@@ -5,7 +5,7 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
-CFLAGS = -g -Werror -Wall -W
+CFLAGS ?= -g -Werror -Wall -W
 override CFLAGS += -I$(PREFIX)/include
 LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
diff -pruN selinux/README selinux-12092011-test-toplevel-arguments/README
--- selinux/README	1970-01-01 01:00:00.000000000 +0100
+++ selinux-12092011-test-toplevel-arguments/README	2011-09-13 02:22:53.625094846 +0200
@@ -0,0 +1,17 @@
+INSTALLATION:
+
+Type "make" to build and then "make install" to install.
+
+---
+
+The environment variables CFLAGS and LDFLAGS can be passed to "make" to use custom compiler
+and/or linker flags (for example: CFLAGS="-O3" LDFLAGS="" make).
+
+The environment variables LIBDIR and SHLIBDIR can be passed to "make" in order to configure
+different directories for the libraries (e.g. LIBDIR=/usr/lib64 and SHLIBDIR=/usr/lib64
+on 64-bit systems).
+
+The environment variable PREFIX can be passed to "make" in order to configure an install
+prefix other than "/usr".
+
+Please see the Makefile(s) for other environment variables that can be used.

There are many different ways of achieving it.

Using the CURDIR variable provided by make is quite nice. Not only it is
much simpler and much cleaner, but it also avoids the need to revert the
patch before creating the separate components to be released.

However there are many other bits left out from previously posted
patches (honor LIBDIR for load_policy, LIBSO link creation in SHLIBDIR
for the three shared libraries, genhomedircon manual page, do not
hard-code path in genhomedircon script, replacement of curly brackets
with parentheses for some variables in some makefiles, make use of
PREFIX for determining LOCALEDIR in some makefiles, do not override
passed environment variables in some makefiles, et cetera).

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
