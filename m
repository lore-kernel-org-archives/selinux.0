Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4CJw18i028640
 for <selinux@tycho.nsa.gov>; Thu, 12 May 2016 15:58:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zimbra.inuits.be (Postfix) with ESMTP id C0AF244209
 for <selinux@tycho.nsa.gov>; Thu, 12 May 2016 21:57:57 +0200 (CEST)
From: Julien Pivotto <roidelapluie@inuits.eu>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsemanage: Support overriding Makefile RANLIB
Date: Thu, 12 May 2016 21:57:54 +0200
Message-Id: <1463083074-8550-1-git-send-email-roidelapluie@inuits.eu>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libsemanage/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index d1fcc0b..71eadd6 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -61,7 +61,7 @@ SWIG_CFLAGS += -Wno-error -Wno-unused-but-set-variable -Wno-unused-variable -Wno
 		-Wno-unused-parameter
 
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
-RANLIB=ranlib
+RANLIB ?= ranlib
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
-- 
2.6.1
