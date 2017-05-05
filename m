Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v45ACfJO026689
 for <selinux@tycho.nsa.gov>; Fri, 5 May 2017 06:12:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24C84C04B92A
 for <selinux@tycho.nsa.gov>; Fri,  5 May 2017 10:12:39 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol/utils: Fix build without system sepol.h
Date: Fri,  5 May 2017 12:12:33 +0200
Message-Id: <20170505101233.13767-2-plautrba@redhat.com>
In-Reply-To: <20170505101233.13767-1-plautrba@redhat.com>
References: <6e6bc5c8-2a86-2189-8e1c-dc512de699e2@redhat.com>
 <20170505101233.13767-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

fcb5d5c removed ../include from CFLAGS from libsepol/utils/Makefile so
that a build tool can't find sepol/sepol.h when only libsepol is built
and a system is without sepol.h in standard paths. It should use its own
sepol.h file during build. `oveeride` needs to be used in order not to
be overridden by values provided on a command line. Same problem applies
to LDFLAGS.

Fixes:
$ make CFLAGS="" LDFLAGS=""
make[1]: Entering directory '/root/selinux/libsepol/utils'
cc     chkcon.c  -lsepol -o chkcon
chkcon.c:1:25: fatal error: sepol/sepol.h: No such file or directory
 #include <sepol/sepol.h>

$ make CFLAGS="" LDFLAGS=""
...
make -C utils
make[1]: Entering directory '/root/selinux/libsepol/utils'
cc  -I../include    chkcon.c  -lsepol -o chkcon
/usr/bin/ld: cannot find -lsepol
collect2: error: ld returned 1 exit status

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsepol/utils/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
index a13164e1..3b2fb771 100644
--- a/libsepol/utils/Makefile
+++ b/libsepol/utils/Makefile
@@ -3,7 +3,8 @@ PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 
 CFLAGS ?= -Wall -Werror
-LDFLAGS += -L../src
+override CFLAGS += -I../include
+override LDFLAGS += -L../src
 LDLIBS += -lsepol
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
-- 
2.12.2
