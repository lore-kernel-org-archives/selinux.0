Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA5L20GN003386
 for <selinux@tycho.nsa.gov>; Sat, 5 Nov 2016 17:02:00 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id B0B785647FD
 for <selinux@tycho.nsa.gov>; Sat,  5 Nov 2016 22:01:57 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsemanage: remove ruby_semanage.so with "make clean"
Date: Sat,  5 Nov 2016 22:01:45 +0100
Message-Id: <20161105210145.9067-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The Python wrapper is already removed in the clean target (with
$(SWIGSO)) so remove the Ruby wrapper too.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 68aab72cb619..55e3f469b0ba 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -158,7 +158,7 @@ relabel:
 	/sbin/restorecon $(LIBDIR)/$(LIBSO)
 
 clean: 
-	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c *.o *.lo *~
+	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(SWIGRUBYSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c *.o *.lo *~
 
 distclean: clean
 	rm -f $(GENERATED) $(SWIGFILES)
-- 
2.10.2
