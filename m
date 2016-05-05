Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u45C3Cu8013308
 for <selinux@tycho.nsa.gov>; Thu, 5 May 2016 08:03:14 -0400
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id CB19D564837
 for <selinux@tycho.nsa.gov>; Thu,  5 May 2016 14:03:04 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsepol: remove libsepol.map when cleaning
Date: Thu,  5 May 2016 14:02:40 +0200
Message-Id: <1462449760-9072-4-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1462449760-9072-1-git-send-email-nicolas.iooss@m4x.org>
References: <1462449760-9072-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index db6c2bac7692..c0c3274a9197 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -76,7 +76,7 @@ relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
-	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) $(CIL_GENERATED)
+	-rm -f $(LIBPC) $(LIBMAP) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) $(CIL_GENERATED)
 
 indent:
 	../../scripts/Lindent $(wildcard *.[ch])
-- 
2.8.2
