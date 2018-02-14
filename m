From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:06 +0100
Message-Id: <20180214095717.1050-5-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 04/15] checkpolicy: build: follow standard
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

Notes:
    v5:
    	- Only use $(DESTDIR) in install
    	- Remove CFLAGS from linking rule
    	- Do not override CFLAGS
    v4:
    	- Introduce LDLIBS_LIBSEPOLA if LIBSEPOLA is not defined.
    
    v2:
    	- Rework all packages (not just selinux/sepol/semanage)

 checkpolicy/Makefile      | 28 ++++++++++++++++------------
 checkpolicy/test/Makefile | 15 +++++++++------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 68e11f2a..4c817cd6 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -1,12 +1,9 @@
 #
 # Makefile for building the checkpolicy program
 #
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
-INCLUDEDIR ?= $(PREFIX)/include
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 TARGETS = checkpolicy checkmodule
 
 LEX = flex
@@ -14,7 +11,12 @@ YACC = bison -y
 
 CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
 
-override CFLAGS += -I.
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
+# is no need to define a value for LDLIBS_LIBSEPOLA
+ifeq ($(LIBSEPOLA),)
+        LDLIBS_LIBSEPOLA := -l:libsepol.a
+endif
 
 CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
 	    policy_define.o
@@ -27,8 +29,10 @@ all:  $(TARGETS)
 	$(MAKE) -C test
 
 checkpolicy: $(CHECKPOLOBJS) $(LIBSEPOLA)
+	$(CC) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
 
 checkmodule: $(CHECKMODOBJS) $(LIBSEPOLA)
+	$(CC) -o $@ $^ $(LDFLAGS) $(LDLIBS_LIBSEPOLA)
 
 %.o: %.c 
 	$(CC) $(CFLAGS) -o $@ -c $<
@@ -46,15 +50,15 @@ lex.yy.c: policy_scan.l y.tab.c
 	$(LEX) policy_scan.l
 
 install: all
-	-mkdir -p $(BINDIR)
-	-mkdir -p $(MANDIR)/man8
-	install -m 755 $(TARGETS) $(BINDIR)	
-	install -m 644 checkpolicy.8 $(MANDIR)/man8
-	install -m 644 checkmodule.8 $(MANDIR)/man8
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	-mkdir -p $(DESTDIR)$(MANDIR)/man8
+	install -m 755 $(TARGETS) $(DESTDIR)$(BINDIR)	
+	install -m 644 checkpolicy.8 $(DESTDIR)$(MANDIR)/man8
+	install -m 644 checkmodule.8 $(DESTDIR)$(MANDIR)/man8
 
 relabel: install
-	/sbin/restorecon $(BINDIR)/checkpolicy
-	/sbin/restorecon $(BINDIR)/checkmodule
+	/sbin/restorecon $(DESTDIR)$(BINDIR)/checkpolicy
+	/sbin/restorecon $(DESTDIR)$(BINDIR)/checkmodule
 
 clean:
 	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index 59fa4460..89e7557c 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -1,19 +1,22 @@
 #
 # Makefile for building the dispol program
 #
-PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= $(PREFIX)/lib
-INCLUDEDIR ?= $(PREFIX)/include
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
-
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
+	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 dismod: dismod.o $(LIBSEPOLA)
+	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
 
 clean:
 	-rm -f dispol dismod *.o 
-- 
2.15.1
