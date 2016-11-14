Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAELXa4B025945
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 16:33:37 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id CC0B85648AD
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 22:33:34 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] secilc: do not build secilc man page if it is up to date
Date: Mon, 14 Nov 2016 22:33:24 +0100
Message-Id: <20161114213324.16130-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When running "make all" several times in the root directory of the
project, the following lines always appear (and the command takes some
seconds to complete on my system with a slow hard drive):

    xmlto man secilc.8.xml
    Note: Writing secilc.8

This is because "make man" always builds secilc.8 even though
secilc.8.xml has not been modified. Introduce an intermediate target to
avoid this behavior.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 secilc/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/secilc/Makefile b/secilc/Makefile
index 9bea186ba0b9..40254ce44caf 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -25,7 +25,9 @@ $(SECILC): $(SECILC_OBJS)
 test: $(SECILC)
 	./$(SECILC) test/policy.cil
 
-man: $(MANPAGE).xml
+man: $(MANPAGE)
+
+$(MANPAGE): $(MANPAGE).xml
 	$(XMLTO) man $(MANPAGE).xml
 
 install: all man
-- 
2.10.2
