Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5KFwFNj011795
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2012 11:58:15 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH kernel/omap] Add security table to netfilter config
Date: Wed, 20 Jun 2012 11:58:05 -0400
Message-Id: <1340207887-30359-5-git-send-email-jbrindle@tresys.com>
In-Reply-To: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
References: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Joshua Brindle <jbrindle@tresys.com>

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 arch/arm/configs/tuna_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/tuna_defconfig b/arch/arm/configs/tuna_defconfig
index 775e34b..fb1d1ff 100644
--- a/arch/arm/configs/tuna_defconfig
+++ b/arch/arm/configs/tuna_defconfig
@@ -439,4 +439,6 @@ CONFIG_NETWORK_SECMARK=y
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
 CONFIG_NETFILTER_XT_TARGET_SECMARK=y
+CONFIG_NETFILTER_ADVANCED=y
+CONFIG_IP_NF_SECURITY=y
 
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
