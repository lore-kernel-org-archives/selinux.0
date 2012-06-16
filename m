Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5GIvsue006847
	for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2012 14:57:54 -0400
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov, method@manicmethod.com
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH build] add iptables-selinux.sh to SELINUX_DEPENDS
Date: Sat, 16 Jun 2012 14:56:35 -0400
Message-Id: <1339872999-30243-2-git-send-email-jbrindle@tresys.com>
In-Reply-To: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>
References: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 core/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/core/Makefile b/core/Makefile
index 146d56e..ade39ae 100644
--- a/core/Makefile
+++ b/core/Makefile
@@ -343,7 +343,7 @@ INTERNAL_RAMDISK_FILES := $(filter $(TARGET_ROOT_OUT)/%, \
 BUILT_RAMDISK_TARGET := $(PRODUCT_OUT)/ramdisk.img
 
 ifeq ($(HAVE_SELINUX),true)
-SELINUX_DEPENDS := sepolicy file_contexts seapp_contexts property_contexts
+SELINUX_DEPENDS := sepolicy file_contexts seapp_contexts property_contexts iptables-selinux.sh
 endif
 
 #ifeq ($(HAVE_MAC),true)
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
