From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 24 Jan 2018 10:27:25 +0100
Message-Id: <20180124092736.8432-5-marcus.folkesson@gmail.com>
In-Reply-To: <20180124092736.8432-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
Subject: [PATCH v4 04/15] checkpolicy: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch solves the following issues:
- DESTDIR is needed during compile time to compute library
  and header paths which it should not.
- Installing with both DESTDIR and PREFIX set gives us odd paths
- Make usage of DESTDIR and PREFIX more standard

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 checkpolicy/Makefile      | 19 +++++++++++++------
 checkpolicy/test/Makefile | 17 ++++++++++++-----
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 68e11f2a..9a55b968 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -1,12 +1,10 @@
 #
 # Makefile for building the checkpolicy program
 #
-PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
-MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
-INCLUDEDIR ?= $(PREFIX)/include
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 TARGETS = checkpolicy checkmodule
 
 LEX = flex
@@ -14,6 +12,13 @@ YACC = bison -y
 
 CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
 
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
+# is no need to define a value for LDLIBS_LIBSEPOLA
+ifeq ($(LIBSEPOLA),)
+        LDLIBS_LIBSEPOLA := -l:libsepol.a
+endif
+
 override CFLAGS += -I.
 
 CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
@@ -27,8 +32,10 @@ all:  $(TARGETS)
 	$(MAKE) -C test
 
 checkpolicy: $(CHECKPOLOBJS) $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
 
 checkmodule: $(CHECKMODOBJS) $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
 
 %.o: %.c 
 	$(CC) $(CFLAGS) -o $@ -c $<
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index 59fa4460..094e7ee2 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -1,19 +1,26 @@
 #
 # Makefile for building the dispol program
 #
-PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= $(PREFIX)/lib
-INCLUDEDIR ?= $(PREFIX)/include
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 
 CFLAGS ?= -g -Wall -W -Werror -O2 -pipe
 
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
+# is no need to define a value for LDLIBS_LIBSEPOLA
+ifeq ($(LIBSEPOLA),)
+        LDLIBS_LIBSEPOLA := -l:libsepol.a
+endif
+
 all: dispol dismod
 
 dispol: dispol.o $(LIBSEPOLA)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 dismod: dismod.o $(LIBSEPOLA)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 clean:
 	-rm -f dispol dismod *.o 
-- 
2.15.1
