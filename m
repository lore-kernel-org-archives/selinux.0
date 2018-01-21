From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 21 Jan 2018 22:46:07 +0100
Message-Id: <20180121214617.8975-5-marcus.folkesson@gmail.com>
In-Reply-To: <20180121214617.8975-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180121214617.8975-1-marcus.folkesson@gmail.com>
Subject: [PATCH v3 04/14] checkpolicy: build: follow standard
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
 checkpolicy/Makefile      | 19 ++++++++++++-------
 checkpolicy/test/Makefile | 15 ++++++++++-----
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 68e11f2a..78a8a43b 100644
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
@@ -14,6 +12,11 @@ YACC = bison -y
 
 CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
 
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+ifeq ($(LIBSEPOLA),)
+       LDFLAGS += -l:libsepol.a
+endif
+
 override CFLAGS += -I.
 
 CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
@@ -27,11 +30,13 @@ all:  $(TARGETS)
 	$(MAKE) -C test
 
 checkpolicy: $(CHECKPOLOBJS) $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
 
 checkmodule: $(CHECKMODOBJS) $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
 
 %.o: %.c 
-	$(CC) $(CFLAGS) -o $@ -c $<
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ -c $<
 
 y.tab.o: y.tab.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) -o $@ -c $<
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index 59fa4460..3eb1c512 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -1,19 +1,24 @@
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
+ifeq ($(LIBSEPOLA),)
+       LDFLAGS += -l:libsepol.a
+endif
+
 all: dispol dismod
 
 dispol: dispol.o $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
 
 dismod: dismod.o $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
 
 clean:
 	-rm -f dispol dismod *.o 
-- 
2.15.1
