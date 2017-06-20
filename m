Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KKUFBh001529
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 16:30:17 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 6B2FA5648B5
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 22:30:09 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libsemanage/tests: fix linking
Date: Tue, 20 Jun 2017 22:29:53 +0200
Message-Id: <20170620202955.11587-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When -lbz2 is written before libsemanage.a in the linker command line,
the linker may fail to find all needed symbols. This occurs for example
when building on Ubuntu 14.04 without the gold linker (cf. Travis build
result https://travis-ci.org/fishilico/selinux/builds/245072498):

    gcc libsemanage-tests.o test_semanage_store.o test_utilities.o utilities.o
    -L/home/travis/build/fishilico/selinux/installdir/usr/lib -o libsemanage-tests
    -lcunit -lbz2 -laudit ../src/libsemanage.a -lselinux -lsepol
    ../src/libsemanage.a(direct_api.o): In function `bzip':
    direct_api.c:(.text+0xee6): undefined reference to `BZ2_bzWriteOpen'
    direct_api.c:(.text+0xf11): undefined reference to `BZ2_bzWriteClose'
    direct_api.c:(.text+0xf79): undefined reference to `BZ2_bzWrite'
    direct_api.c:(.text+0xfa1): undefined reference to `BZ2_bzWriteClose'
    direct_api.c:(.text+0xfe0): undefined reference to `BZ2_bzWriteClose'
    ../src/libsemanage.a(direct_api.o): In function `bunzip':
    direct_api.c:(.text+0x114e): undefined reference to `BZ2_bzReadOpen'
    direct_api.c:(.text+0x1249): undefined reference to `BZ2_bzRead'
    direct_api.c:(.text+0x13b4): undefined reference to `BZ2_bzReadClose'
    ../src/libsemanage.a(seusers_local.o): In function `semanage_seuser_audit':
    seusers_local.c:(.text+0x4c5): undefined reference to `audit_open'
    seusers_local.c:(.text+0x5b6): undefined reference to `audit_log_semanage_message'
    seusers_local.c:(.text+0x5cd): undefined reference to `audit_close'

As ../src/libsemanage.a is a dependency of $(EXECUTABLE) in the
Makefile, use $^ to include it in the command line. While at it, put $^
after $(LDFLAGS) as other Makefiles do.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/tests/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index fcd616fabf52..2ef8d30d92af 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -9,14 +9,14 @@ SOURCES = $(sort $(wildcard *.c))
 EXECUTABLE = libsemanage-tests
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 override CFLAGS += -I../src -I../include
-override LDLIBS += -lcunit -lbz2 -laudit ../src/libsemanage.a -lselinux -lsepol
+override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 
 OBJECTS = $(SOURCES:.c=.o) 
 
 all: $(EXECUTABLE) 
 
 $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
-	$(CC) $(OBJECTS) $(LDFLAGS) -o $@ $(LDLIBS)
+	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 clean distclean: 
 	rm -rf $(OBJECTS) $(EXECUTABLE)
-- 
2.13.1
