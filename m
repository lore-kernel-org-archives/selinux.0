Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5GIvsuf006847
	for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2012 14:57:54 -0400
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov, method@manicmethod.com
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH kernel/goldfish] enable secmark labeling for SE Android network access controls
Date: Sat, 16 Jun 2012 14:56:39 -0400
Message-Id: <1339872999-30243-6-git-send-email-jbrindle@tresys.com>
In-Reply-To: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>
References: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 arch/x86/configs/i386_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index edba00d..09db997 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -2128,6 +2128,10 @@ CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_FILE_CAPABILITIES=y
 # CONFIG_SECURITY_ROOTPLUG is not set
 CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=65536
+CONFIG_NETWORK_SECMARK=y
+CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
+CONFIG_NETFILTER_XT_TARGET_SECMARK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
