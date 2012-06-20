Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5KFwFNp011795
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2012 11:58:17 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH kernel/samsung] enable secmark labeling and netfilter security table for SE Android network access controls
Date: Wed, 20 Jun 2012 11:58:06 -0400
Message-Id: <1340207887-30359-6-git-send-email-jbrindle@tresys.com>
In-Reply-To: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
References: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Joshua Brindle <jbrindle@tresys.com>

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 arch/arm/configs/herring_defconfig |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/herring_defconfig b/arch/arm/configs/herring_defconfig
index 5986957..6aebfd6 100644
--- a/arch/arm/configs/herring_defconfig
+++ b/arch/arm/configs/herring_defconfig
@@ -391,4 +391,10 @@ CONFIG_SECURITY=y
 CONFIG_LSM_MMAP_MIN_ADDR=4096
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
+CONFIG_NETWORK_SECMARK=y
+CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
+CONFIG_NETFILTER_XT_TARGET_SECMARK=y
+CONFIG_NETFILTER_ADVANCED=y
+CONFIG_IP_NF_SECURITY=y
 
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
