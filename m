Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5N8Kjmw028188
 for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2017 04:20:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E81ACC0293A2
 for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2017 08:20:37 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] mcstrans: Allow overriding libsepol.a location during build
Date: Fri, 23 Jun 2017 10:20:33 +0200
Message-Id: <20170623082033.19291-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 mcstrans/src/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index 709e1e02..3f4a89c3 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -4,6 +4,7 @@ LIBDIR ?= $(PREFIX)/lib
 SBINDIR ?= $(DESTDIR)/sbin
 INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
 SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
+LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 PROG_SRC=mcstrans.c  mcscolor.c  mcstransd.c  mls_level.c
 PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
@@ -15,7 +16,7 @@ override CFLAGS += -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 all: $(PROG)
 
 $(PROG): $(PROG_OBJS)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a
+	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBSEPOLA)
 
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
-- 
2.13.0
