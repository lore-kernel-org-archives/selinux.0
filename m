Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uASLf8AO026177
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 16:41:08 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id BCBB856079A
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 22:40:58 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/4] checkpolicy: remove -lfl from LDLIBS
Date: Mon, 28 Nov 2016 22:40:17 +0100
Message-Id: <20161128214018.7861-3-nicolas.iooss@m4x.org>
In-Reply-To: <20161128214018.7861-1-nicolas.iooss@m4x.org>
References: <20161128214018.7861-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When building checkpolicy/test, the linker reports the following error:

    cc   dispol.o  -lfl /usr/src/selinux/DESTDIR/usr/lib/libsepol.a
    -L/usr/src/selinux/DESTDIR/usr/lib -o dispol

    /usr/lib/gcc/x86_64-pc-linux-gnu/6.2.1/../../../../lib/libfl.so:
    undefined reference to `yylex'

    collect2: error: ld returned 1 exit status

According to flex documentation
(https://github.com/westes/flex/blob/master/doc/flex.texi), -lfl is used
to provide an implementation for yywrap(). However every flex file now
uses "%option noyywrap", which makes -lfl no longer mandatory. Remove
this option from checkpolicy Makefiles.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/Makefile      | 2 +-
 checkpolicy/test/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 53a307453282..875cf008cae0 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -20,7 +20,7 @@ CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
 CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o
 CHECKMODOBJS = $(CHECKOBJS) checkmodule.o
 
-LDLIBS=$(LIBDIR)/libsepol.a -lfl
+LDLIBS=$(LIBDIR)/libsepol.a
 
 GENERATED=lex.yy.c y.tab.c y.tab.h
 
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index c2367e191fe3..e7bd717a7c9a 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -9,7 +9,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 CFLAGS ?= -g -Wall -W -Werror -O2 -pipe
 override CFLAGS += -I$(INCLUDEDIR)
 
-LDLIBS=-lfl $(LIBDIR)/libsepol.a -L$(LIBDIR)
+LDLIBS=$(LIBDIR)/libsepol.a -L$(LIBDIR)
 
 all: dispol dismod
 
-- 
2.10.2
