Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB1KccpL032504
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 15:38:38 -0500
Received: from g4t0017.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB1KaXQx021161
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 20:36:34 GMT
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id 2DBC6385C1
	for <selinux@tycho.nsa.gov>; Mon,  1 Dec 2008 20:38:38 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH] selinux: deprecate and schedule the removal of the the
	compat_net functionality
To: selinux@tycho.nsa.gov
Date: Mon, 01 Dec 2008 15:38:34 -0500
Message-ID: <20081201203833.16302.16424.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch is the first step towards removing the old "compat_net" code from
the kernel.  Secmark, the "compat_net" replacement has been around for several
kernel releases and the major Linux distributions with SELinux support have
transitioned to Secmark so it is time to start deprecating the "compat_net"
mechanism.  Testing a patched version of 2.6.28-rc6 with the initial release of
Fedora Core 5 did not show any problems when running in enforcing mode.

This patch adds an entry to the feature-removal-schedule.txt file and removes
the SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT configuration option, forcing
Secmark on by default although it can still be disabled at runtime.  The patch
also makes the Secmark permission checks "dynamic" in the sense that they are
only executed when Secmark is configured; this should help prevent problems
with older distributions that have not yet migrated to Secmark.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 Documentation/feature-removal-schedule.txt |   12 ++++++++++++
 security/selinux/Kconfig                   |   27 ---------------------------
 security/selinux/hooks.c                   |    6 +++---
 security/selinux/selinuxfs.c               |   16 ++++++++--------
 4 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index c28a2ac..ab5d702 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -343,3 +343,15 @@ When:	2.6.29 (ideally) or 2.6.30 (more likely)
 Why:	Deprecated by the new (standard) device driver binding model. Use
 	i2c_driver->probe() and ->remove() instead.
 Who:	Jean Delvare <khali@linux-fr.org>
+
+---------------------------
+
+What:	SELinux "compat_net" functionality
+When:	2.6.30 at the earliest
+Why:	Several kernel releases ago the Secmark concept was introduced to
+	replace the "compat_net" network access control functionality of
+	SELinux.  Secmark offers both better performance and greater
+	flexibility than the "compat_net" mechanism.  Now that the major Linux
+	distributions have moved to Secmark, it is time to deprecate the older
+	mechanism and start the process of removing the old code.
+Who:	Paul Moore <paul.moore@hp.com>
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 26301dd..bca1b74 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -94,33 +94,6 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
 
 	  If you are unsure how to answer this question, answer 1.
 
-config SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT
-	bool "NSA SELinux enable new secmark network controls by default"
-	depends on SECURITY_SELINUX
-	default n
-	help
-	  This option determines whether the new secmark-based network
-	  controls will be enabled by default.  If not, the old internal
-	  per-packet controls will be enabled by default, preserving
-	  old behavior.
-
-	  If you enable the new controls, you will need updated
-	  SELinux userspace libraries, tools and policy.  Typically,
-	  your distribution will provide these and enable the new controls
-	  in the kernel they also distribute.
-
-	  Note that this option can be overridden at boot with the
-	  selinux_compat_net parameter, and after boot via
-	  /selinux/compat_net.  See Documentation/kernel-parameters.txt
-	  for details on this parameter.
-
-	  If you enable the new network controls, you will likely
-	  also require the SECMARK and CONNSECMARK targets, as
-	  well as any conntrack helpers for protocols which you
-	  wish to control.
-
-	  If you are unsure what to do here, select N.
-
 config SECURITY_SELINUX_POLICYDB_VERSION_MAX
 	bool "NSA SELinux maximum supported policy format version"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f85597a..ce92306 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4078,7 +4078,7 @@ static int selinux_sock_rcv_skb_iptables_compat(struct sock *sk,
 static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
-	int err;
+	int err = 0;
 	struct sk_security_struct *sksec = sk->sk_security;
 	u32 peer_sid;
 	u32 sk_sid = sksec->sid;
@@ -4095,7 +4095,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 	if (selinux_compat_net)
 		err = selinux_sock_rcv_skb_iptables_compat(sk, skb, &ad,
 							   family, addrp);
-	else
+	else if (selinux_secmark_enabled())
 		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 	if (err)
@@ -4598,7 +4598,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		if (selinux_ip_postroute_iptables_compat(skb->sk, ifindex,
 							 &ad, family, addrp))
 			return NF_DROP;
-	} else {
+	} else if (selinux_secmark_enabled()) {
 		if (avc_has_perm(sksec->sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 69c9dcc..829edce 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -47,13 +47,7 @@ static char *policycap_names[] = {
 
 unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
 
-#ifdef CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT
-#define SELINUX_COMPAT_NET_VALUE 0
-#else
-#define SELINUX_COMPAT_NET_VALUE 1
-#endif
-
-int selinux_compat_net = SELINUX_COMPAT_NET_VALUE;
+int selinux_compat_net = 0;
 
 static int __init checkreqprot_setup(char *str)
 {
@@ -489,7 +483,13 @@ static ssize_t sel_write_compat_net(struct file *file, const char __user *buf,
 	if (sscanf(page, "%d", &new_value) != 1)
 		goto out;
 
-	selinux_compat_net = new_value ? 1 : 0;
+	if (new_value) {
+		printk(KERN_NOTICE
+		       "SELinux: compat_net is deprecated, please use secmark"
+		       " instead\n");
+		selinux_compat_net = 1;
+	} else
+		selinux_compat_net = 0;
 	length = count;
 out:
 	free_page((unsigned long) page);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
