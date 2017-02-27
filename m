Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1RKdnvc023546
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 15:39:53 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1A4DC5605F9
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 21:39:51 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/6] libsemanage/tests: include libsepol headers from $DESTDIR
Date: Mon, 27 Feb 2017 21:39:33 +0100
Message-Id: <20170227203935.23674-4-nicolas.iooss@m4x.org>
In-Reply-To: <20170227203935.23674-1-nicolas.iooss@m4x.org>
References: <20170227203935.23674-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When building and running tests on a system without SELinux with a
command similar to "make DESTDIR=/tmp/destdir install test", libsemanage
tests fail to build with the following error:

    In file included from utilities.h:20:0,
                     from utilities.c:24:
    ../src/handle.h:29:26: fatal error: sepol/handle.h: No such file or
    directory
     #include <sepol/handle.h>
                              ^

Fix this by adding the newly-installed directory under $DESTDIR (using
variable $PREFIX) in the search paths of the compiler.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml                | 2 --
 libsemanage/tests/Makefile | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 7d7424459344..fa25d1b336ac 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -105,14 +105,12 @@ script:
   - make all -k
 
   # Set up environment variables for the tests
-  - export CFLAGS="-I$DESTDIR/usr/include"
   - export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
   - export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
   - export PYTHONPATH="$PYSITEDIR"
   - export RUBYLIB="$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
 
   # Show variables (to help debugging issues)
-  - echo "$CFLAGS"
   - echo "$LD_LIBRARY_PATH"
   - echo "$PATH"
   - echo "$PYTHONPATH"
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 3fe7d16f3e72..885b54430155 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -11,7 +11,7 @@ LIBS = ../src/libsemanage.a -L$(LIBDIR) -lselinux -lsepol
 
 EXECUTABLE = libsemanage-tests
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
-INCLUDE = -I../src -I../include
+INCLUDE = -I../src -I../include -I$(PREFIX)/include
 LDFLAGS += -lcunit -lbz2 -laudit
 OBJECTS = $(SOURCES:.c=.o) 
 
-- 
2.11.1
