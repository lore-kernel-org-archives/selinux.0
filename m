Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9JHQBEL023918
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 13:26:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3yHvY42SbCz1wyJn
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 16:30:16 +0000 (UTC)
Received: from UPBD19PA13.eemsg.mil (unknown [192.168.18.15])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3yHvY409hFz1wyJg
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 16:30:16 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Thu, 19 Oct 2017 16:56:47 +0100
Message-Id: <20171019155647.26565-1-richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-testsuite: Stop Infiniband building if not
 enabled
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The default is not to test, however it still tries to build
create_modify_qp.c that requires a header and library that may not
exist.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 tests/infiniband_pkey/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/infiniband_pkey/Makefile b/tests/infiniband_pkey/Makefile
index 60f0d24..4fa6fb2 100644
--- a/tests/infiniband_pkey/Makefile
+++ b/tests/infiniband_pkey/Makefile
@@ -2,6 +2,14 @@ TARGETS=create_modify_qp
 
 LDLIBS+= -libverbs
 
-all: $(TARGETS)
+RESULT=$(shell grep "SELINUX_INFINIBAND_PKEY_TEST=0" ./ibpkey_test.conf)
+
+ifeq  ($(RESULT), )
+    all: $(TARGETS)
+else
+    all:
+	@echo "Infiniband test disabled"
+endif
+
 clean:
 	rm -f $(TARGETS)
-- 
2.13.6
