Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5KFwFNk011795
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2012 11:58:15 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH build] add selinux-network.sh to SELINUX_DEPENDS for SELinux network labeling
Date: Wed, 20 Jun 2012 11:58:02 -0400
Message-Id: <1340207887-30359-2-git-send-email-jbrindle@tresys.com>
In-Reply-To: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
References: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Joshua Brindle <jbrindle@tresys.com>

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 core/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/core/Makefile b/core/Makefile
index 146d56e..7d3af0f 100644
--- a/core/Makefile
+++ b/core/Makefile
@@ -343,7 +343,7 @@ INTERNAL_RAMDISK_FILES := $(filter $(TARGET_ROOT_OUT)/%, \
 BUILT_RAMDISK_TARGET := $(PRODUCT_OUT)/ramdisk.img
 
 ifeq ($(HAVE_SELINUX),true)
-SELINUX_DEPENDS := sepolicy file_contexts seapp_contexts property_contexts
+SELINUX_DEPENDS := sepolicy file_contexts seapp_contexts property_contexts selinux-network.sh
 endif
 
 #ifeq ($(HAVE_MAC),true)
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
