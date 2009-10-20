Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9KFjclw010442
	for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2009 11:45:38 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9KFlNgG006423
	for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2009 15:47:24 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: Manoj Srivastava <srivasta@debian.org>
Subject: [PATCH] [topic--exception-fix] exception.sh contains bashisms
Date: Tue, 20 Oct 2009 10:34:40 -0500
Message-Id: <1256052880-9147-1-git-send-email-srivasta@golden-gryphon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Manoj Srivastava <srivasta@debian.org>

Hi folks,

   The script, src/exception.sh, contains so called bashisms
 (constructs not supported by POSIX, but present as bash
 extensions). This means when trying to build on systems where /bin/sh
 is not bash, the build fails with an error. This patch uses bash to
 run exception.sh. This bug affects a significant subset of Debian and
 Debian derivative machines.

	manoj

Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 libselinu/xsrc/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 74b1e6a..d0fb0e3 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -83,7 +83,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET) 
 
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
-	sh exception.sh > $@ 
+	bash exception.sh > $@ 
 
 audit2why.lo: audit2why.c
 	$(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
-- 
1.6.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
