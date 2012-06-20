Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5KFwFNo011795
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2012 11:58:16 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH kernel/goldfish] enable netfilter, secmark, and security tables
Date: Wed, 20 Jun 2012 11:58:07 -0400
Message-Id: <1340207887-30359-7-git-send-email-jbrindle@tresys.com>
In-Reply-To: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
References: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Joshua Brindle <jbrindle@tresys.com>

ARM kernels needed netfilter enabled in addition to secmark and security tables
The x86 kernel had secmark enabled and only needed security tables

This enables netfilter based SE Android network access controls

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 arch/arm/configs/goldfish_armv7_defconfig |   41 +++++++++++++++++++++++++++--
 arch/arm/configs/goldfish_defconfig       |   40 ++++++++++++++++++++++++++--
 arch/x86/configs/goldfish_defconfig       |    3 ++-
 3 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/goldfish_armv7_defconfig b/arch/arm/configs/goldfish_armv7_defconfig
index 9f51a14..24b3d4f 100644
--- a/arch/arm/configs/goldfish_armv7_defconfig
+++ b/arch/arm/configs/goldfish_armv7_defconfig
@@ -333,8 +333,45 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 CONFIG_IPV6=y
 CONFIG_ANDROID_PARANOID_NETWORK=y
-# CONFIG_NETWORK_SECMARK is not set
-# CONFIG_NETFILTER is not set
+
+CONFIG_NETFILTER=y
+CONFIG_NETFILTER_ADVANCED=y
+
+#
+# Core Netfilter Configuration
+#
+CONFIG_NETFILTER_NETLINK=y
+CONFIG_NETFILTER_NETLINK_LOG=y
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NF_CONNTRACK_FTP=y
+CONFIG_NF_CONNTRACK_IRC=y
+CONFIG_NF_CONNTRACK_SIP=y
+CONFIG_NF_CT_NETLINK=y
+CONFIG_NETFILTER_XTABLES=y
+CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
+CONFIG_NETFILTER_XT_TARGET_MARK=y
+CONFIG_NETFILTER_XT_TARGET_NFLOG=y
+CONFIG_NETFILTER_XT_TARGET_SECMARK=y
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
+CONFIG_NETFILTER_XT_MATCH_MARK=y
+CONFIG_NETFILTER_XT_MATCH_STATE=y
+CONFIG_NETWORK_SECMARK=y
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_NF_CONNTRACK_IPV4=y
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_REJECT=y
+CONFIG_IP_NF_TARGET_LOG=y
+CONFIG_IP_NF_TARGET_ULOG=y
+CONFIG_IP_NF_MANGLE=y
+CONFIG_IP_NF_SECURITY=y
+
 # CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
 # CONFIG_TIPC is not set
diff --git a/arch/arm/configs/goldfish_defconfig b/arch/arm/configs/goldfish_defconfig
index f7e49ea..58e498a 100644
--- a/arch/arm/configs/goldfish_defconfig
+++ b/arch/arm/configs/goldfish_defconfig
@@ -330,8 +330,44 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 CONFIG_IPV6=y
 CONFIG_ANDROID_PARANOID_NETWORK=y
-# CONFIG_NETWORK_SECMARK is not set
-# CONFIG_NETFILTER is not set
+CONFIG_NETFILTER=y
+CONFIG_NETFILTER_ADVANCED=y
+
+#
+# Core Netfilter Configuration
+#
+CONFIG_NETFILTER_NETLINK=y
+CONFIG_NETFILTER_NETLINK_LOG=y
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NF_CONNTRACK_FTP=y
+CONFIG_NF_CONNTRACK_IRC=y
+CONFIG_NF_CONNTRACK_SIP=y
+CONFIG_NF_CT_NETLINK=y
+CONFIG_NETFILTER_XTABLES=y
+CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
+CONFIG_NETFILTER_XT_TARGET_MARK=y
+CONFIG_NETFILTER_XT_TARGET_NFLOG=y
+CONFIG_NETFILTER_XT_TARGET_SECMARK=y
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
+CONFIG_NETFILTER_XT_MATCH_MARK=y
+CONFIG_NETFILTER_XT_MATCH_STATE=y
+CONFIG_NETWORK_SECMARK=y
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_NF_CONNTRACK_IPV4=y
+CONFIG_NF_CONNTRACK_PROC_COMPAT=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_REJECT=y
+CONFIG_IP_NF_TARGET_LOG=y
+CONFIG_IP_NF_TARGET_ULOG=y
+CONFIG_IP_NF_MANGLE=y
+CONFIG_IP_NF_SECURITY=y
+
 # CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
 # CONFIG_TIPC is not set
diff --git a/arch/x86/configs/goldfish_defconfig b/arch/x86/configs/goldfish_defconfig
index fceb7e2f..508f540 100644
--- a/arch/x86/configs/goldfish_defconfig
+++ b/arch/x86/configs/goldfish_defconfig
@@ -451,9 +451,10 @@ CONFIG_IPV6=y
 CONFIG_NETLABEL=y
 CONFIG_ANDROID_PARANOID_NETWORK=y
 CONFIG_NETWORK_SECMARK=y
+CONFIG_IP_NF_SECURITY=y
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_DEBUG is not set
-# CONFIG_NETFILTER_ADVANCED is not set
+CONFIG_NETFILTER_ADVANCED=y
 
 #
 # Core Netfilter Configuration
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
