Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9QLfxCo032159
 for <selinux@tycho.nsa.gov>; Wed, 26 Oct 2016 17:41:59 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 72A2A1A1A8
 for <selinux@tycho.nsa.gov>; Wed, 26 Oct 2016 23:41:57 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id MkT4Ciop4Eqb for <selinux@tycho.nsa.gov>;
 Wed, 26 Oct 2016 23:41:54 +0200 (CEST)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:a03f:6c:e500:edf:2fd8:fc0a:f176])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id C29D11A06E
 for <selinux@tycho.nsa.gov>; Wed, 26 Oct 2016 23:41:54 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2] libselinux: Add clean-pywrap and clean-rubywrap targets
Date: Wed, 26 Oct 2016 23:41:54 +0200
Message-Id: <20161026214154.32509-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Add clean targets to just clean the python and ruby wrapper objects

Also clean $(SWIGRUBYSO) and $(AUDIT2WHYLOBJ) objects

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 libselinux/Makefile     |  6 ++++++
 libselinux/src/Makefile | 12 +++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index ef971f4..979e225 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -57,4 +57,10 @@ install-pywrap:
 install-rubywrap: 
 	$(MAKE) -C src install-rubywrap $@
 
+clean-pywrap:
+	$(MAKE) -C src clean-pywrap $@
+
+clean-rubywrap:
+	$(MAKE) -C src clean-rubywrap $@
+
 test:
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ccd8442..c9f35b1 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -187,8 +187,14 @@ install-rubywrap: rubywrap
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
-clean: 
-	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGRUBYLOBJ) $(SWIGSO) $(TARGET) $(AUDIT2WHYSO) *.o *.lo *~
+clean-pywrap:
+	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
+
+clean-rubywrap:
+	-rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
+
+clean: clean-pywrap clean-rubywrap
+	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) *.o *.lo *~
 
 distclean: clean
 	rm -f $(GENERATED) $(SWIGFILES)
@@ -196,4 +202,4 @@ distclean: clean
 indent:
 	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
 
-.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
+.PHONY: all clean clean-pywrap clean-rubywrap pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
-- 
2.10.1
