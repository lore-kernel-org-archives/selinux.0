Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0TBiu6o012307
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 06:44:56 -0500
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0TBitfr011988
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 11:44:55 GMT
Date: Tue, 29 Jan 2008 22:44:15 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: linux-security-module@vger.kernel.org
cc: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Subject: [RFC] security: add iptables "security" table for MAC rules
Message-ID: <Xine.LNX.4.64.0801292230080.29814@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch implements a new "security" table for iptables, so 
that MAC (SELinux etc.) networking rules can be managed separately to 
standard DAC rules.

This is to help with distro integration of the new secmark-based network 
controls, per various previous discussions.

The need for a separate table arises from the fact that existing tools and 
usage of iptables will likely clash with centralized MAC policy 
management.

The SECMARK and CONNSECMARK targets will still be valid in the mangle 
table, to prevent breakage of existing users, although I suspect that 
these targets are not in significant use and we could probably make them 
valid only in the security table without major issues.   (Comments?)

I've set the table priority to just after NF_IP_FILTER, to allow DAC 
rules to take effect before MAC rules.

There is also not (yet) any LSM hooking for modifying the MAC rules, as it 
will be more invasive, and we have coarse coverage via CAP_NET_ADMIN.  
(Comments?)

IPv6 is not done yet as this is just at RFC stage.

Please review and let me know if this looks like a viable approach for 
distro integration.  If it is, we will then need to run it past the 
Netfilter & netdev folk.

---

Add a "security" table to iptables for managing Mandatory Access
Control (MAC) rules.  This is intended for use with the SECMARK
and CONNSECMARK targets.

Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/netfilter_ipv4.h        |    1 +
 net/ipv4/netfilter/Kconfig            |   10 ++
 net/ipv4/netfilter/Makefile           |    1 +
 net/ipv4/netfilter/iptable_security.c |  181 +++++++++++++++++++++++++++++++++
 net/netfilter/xt_CONNSECMARK.c        |   10 ++-
 net/netfilter/xt_SECMARK.c            |   10 ++-
 6 files changed, 207 insertions(+), 6 deletions(-)
 create mode 100644 net/ipv4/netfilter/iptable_security.c

diff --git a/include/linux/netfilter_ipv4.h b/include/linux/netfilter_ipv4.h
index 1a63adf..aec8961 100644
--- a/include/linux/netfilter_ipv4.h
+++ b/include/linux/netfilter_ipv4.h
@@ -60,6 +60,7 @@ enum nf_ip_hook_priorities {
 	NF_IP_PRI_MANGLE = -150,
 	NF_IP_PRI_NAT_DST = -100,
 	NF_IP_PRI_FILTER = 0,
+	NF_IP_PRI_SECURITY = 50,
 	NF_IP_PRI_NAT_SRC = 100,
 	NF_IP_PRI_SELINUX_LAST = 225,
 	NF_IP_PRI_CONNTRACK_HELPER = INT_MAX - 2,
diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index 9aca9c5..84d0d31 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -373,6 +373,16 @@ config IP_NF_RAW
 	  If you want to compile it as a module, say M here and read
 	  <file:Documentation/kbuild/modules.txt>.  If unsure, say `N'.
 
+# security table for MAC policy
+config IP_NF_SECURITY
+	tristate "Security table"
+	depends on IP_NF_IPTABLES
+	help
+	  This option adds a `security' table to iptables, for use
+	  with Mandatory Access Control (MAC) policy.
+	  
+	  If unsure, say N.
+
 # ARP tables
 config IP_NF_ARPTABLES
 	tristate "ARP tables support"
diff --git a/net/ipv4/netfilter/Makefile b/net/ipv4/netfilter/Makefile
index 7456833..90fcdd6 100644
--- a/net/ipv4/netfilter/Makefile
+++ b/net/ipv4/netfilter/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_IP_NF_FILTER) += iptable_filter.o
 obj-$(CONFIG_IP_NF_MANGLE) += iptable_mangle.o
 obj-$(CONFIG_NF_NAT) += iptable_nat.o
 obj-$(CONFIG_IP_NF_RAW) += iptable_raw.o
+obj-$(CONFIG_IP_NF_SECURITY) += iptable_security.o
 
 # matches
 obj-$(CONFIG_IP_NF_MATCH_ADDRTYPE) += ipt_addrtype.o
diff --git a/net/ipv4/netfilter/iptable_security.c b/net/ipv4/netfilter/iptable_security.c
new file mode 100644
index 0000000..640f200
--- /dev/null
+++ b/net/ipv4/netfilter/iptable_security.c
@@ -0,0 +1,181 @@
+/*
+ * "security" table
+ *
+ * This is for use by Mandatory Access Control (MAC) security models,
+ * which need to be able to manage security policy in separate context
+ * to DAC.
+ *
+ * Based on iptable_mangle.c
+ *
+ * Copyright (C) 1999 Paul `Rusty' Russell & Michael J. Neuling
+ * Copyright (C) 2000-2004 Netfilter Core Team <coreteam@netfilter.org>
+ * Copyright (C) 2008 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+#include <net/route.h>
+#include <linux/ip.h>
+#include <net/ip.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("James Morris <jmorris@redhat.com>");
+MODULE_DESCRIPTION("iptables security table, for MAC rules");
+
+#define SECURITY_VALID_HOOKS	(1 << NF_IP_LOCAL_IN) | \
+				(1 << NF_IP_FORWARD) | \
+				(1 << NF_IP_LOCAL_OUT)
+
+static struct
+{
+	struct ipt_replace repl;
+	struct ipt_standard entries[3];
+	struct ipt_error term;
+} initial_table __initdata = {
+	.repl = {
+		.name = "security",
+		.valid_hooks = SECURITY_VALID_HOOKS,
+		.num_entries = 4,
+		.size = sizeof(struct ipt_standard) * 3 + sizeof(struct ipt_error),
+		.hook_entry = {
+			[NF_IP_LOCAL_IN] 	= 0,
+			[NF_IP_FORWARD] 	= sizeof(struct ipt_standard),
+			[NF_IP_LOCAL_OUT] 	= sizeof(struct ipt_standard) * 2,
+		},
+		.underflow = {
+			[NF_IP_LOCAL_IN] 	= 0,
+			[NF_IP_FORWARD] 	= sizeof(struct ipt_standard),
+			[NF_IP_LOCAL_OUT] 	= sizeof(struct ipt_standard) * 2,
+		},
+	},
+	.entries = {
+		IPT_STANDARD_INIT(NF_ACCEPT),	/* LOCAL_IN */
+		IPT_STANDARD_INIT(NF_ACCEPT),	/* FORWARD */
+		IPT_STANDARD_INIT(NF_ACCEPT),	/* LOCAL_OUT */
+	},
+	.term = IPT_ERROR_INIT,			/* ERROR */
+};
+
+static struct xt_table security_mangler = {
+	.name		= "security",
+	.valid_hooks	= SECURITY_VALID_HOOKS,
+	.lock		= RW_LOCK_UNLOCKED,
+	.me		= THIS_MODULE,
+	.af		= AF_INET,
+};
+
+/* The work comes in here from netfilter.c. */
+static unsigned int
+ipt_route_hook(unsigned int hook,
+	 struct sk_buff *skb,
+	 const struct net_device *in,
+	 const struct net_device *out,
+	 int (*okfn)(struct sk_buff *))
+{
+	return ipt_do_table(skb, hook, in, out, &security_mangler);
+}
+
+static unsigned int
+ipt_local_hook(unsigned int hook,
+		   struct sk_buff *skb,
+		   const struct net_device *in,
+		   const struct net_device *out,
+		   int (*okfn)(struct sk_buff *))
+{
+	unsigned int ret;
+	const struct iphdr *iph;
+	u_int8_t tos;
+	__be32 saddr, daddr;
+	u_int32_t mark;
+
+	/* Somebody is playing with raw sockets. */
+	if (skb->len < sizeof(struct iphdr)
+	    || ip_hdrlen(skb) < sizeof(struct iphdr)) {
+		if (net_ratelimit())
+			printk(KERN_INFO "iptable_mangle: ignoring short "
+			       "SOCK_RAW packet.\n");
+		return NF_ACCEPT;
+	}
+
+	/* Save things which could affect route */
+	mark = skb->mark;
+	iph = ip_hdr(skb);
+	saddr = iph->saddr;
+	daddr = iph->daddr;
+	tos = iph->tos;
+
+	ret = ipt_do_table(skb, hook, in, out, &security_mangler);
+	/* Reroute for ANY change. */
+	if (ret != NF_DROP && ret != NF_STOLEN && ret != NF_QUEUE) {
+		iph = ip_hdr(skb);
+
+		if (iph->saddr != saddr ||
+		    iph->daddr != daddr ||
+		    skb->mark != mark ||
+		    iph->tos != tos)
+			if (ip_route_me_harder(skb, RTN_UNSPEC))
+				ret = NF_DROP;
+	}
+
+	return ret;
+}
+
+static struct nf_hook_ops ipt_ops[] = {
+	{
+		.hook		= ipt_route_hook,
+		.owner		= THIS_MODULE,
+		.pf		= PF_INET,
+		.hooknum	= NF_IP_LOCAL_IN,
+		.priority	= NF_IP_PRI_SECURITY,
+	},
+	{
+		.hook		= ipt_route_hook,
+		.owner		= THIS_MODULE,
+		.pf		= PF_INET,
+		.hooknum	= NF_IP_FORWARD,
+		.priority	= NF_IP_PRI_SECURITY,
+	},
+	{
+		.hook		= ipt_local_hook,
+		.owner		= THIS_MODULE,
+		.pf		= PF_INET,
+		.hooknum	= NF_IP_LOCAL_OUT,
+		.priority	= NF_IP_PRI_SECURITY,
+	},
+};
+
+static int __init iptable_security_init(void)
+{
+	int ret;
+
+	/* Register table */
+	ret = ipt_register_table(&security_mangler, &initial_table.repl);
+	if (ret < 0)
+		return ret;
+
+	/* Register hooks */
+	ret = nf_register_hooks(ipt_ops, ARRAY_SIZE(ipt_ops));
+	if (ret < 0)
+		goto cleanup_table;
+
+	return ret;
+
+cleanup_table:
+	ipt_unregister_table(&security_mangler);
+	return ret;
+}
+
+static void __exit iptable_security_fini(void)
+{
+	nf_unregister_hooks(ipt_ops, ARRAY_SIZE(ipt_ops));
+	ipt_unregister_table(&security_mangler);
+}
+
+module_init(iptable_security_init);
+module_exit(iptable_security_fini);
diff --git a/net/netfilter/xt_CONNSECMARK.c b/net/netfilter/xt_CONNSECMARK.c
index d8feba9..5dd584b 100644
--- a/net/netfilter/xt_CONNSECMARK.c
+++ b/net/netfilter/xt_CONNSECMARK.c
@@ -8,7 +8,7 @@
  *   Copyright (C) 2002,2004 MARA Systems AB <http://www.marasystems.com>
  *    by Henrik Nordstrom <hno@marasystems.com>
  *
- * (C) 2006 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * (C) 2006,2008 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -90,6 +90,12 @@ static bool checkentry(const char *tablename, const void *entry,
 {
 	const struct xt_connsecmark_target_info *info = targinfo;
 
+	if (strcmp(tablename, "mangle") && strcmp(tablename, "security")) {
+		printk(KERN_INFO PFX "target only valid in the \'mangle\' "
+		       "or \'security\' tables, not \'%s\'.\n", tablename);
+		return false;
+	}
+
 	switch (info->mode) {
 	case CONNSECMARK_SAVE:
 	case CONNSECMARK_RESTORE:
@@ -122,7 +128,6 @@ static struct xt_target xt_connsecmark_target[] __read_mostly = {
 		.destroy	= destroy,
 		.target		= target,
 		.targetsize	= sizeof(struct xt_connsecmark_target_info),
-		.table		= "mangle",
 		.me		= THIS_MODULE,
 	},
 	{
@@ -132,7 +137,6 @@ static struct xt_target xt_connsecmark_target[] __read_mostly = {
 		.destroy	= destroy,
 		.target		= target,
 		.targetsize	= sizeof(struct xt_connsecmark_target_info),
-		.table		= "mangle",
 		.me		= THIS_MODULE,
 	},
 };
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 235806e..7c92d87 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -5,7 +5,7 @@
  * Based on the nfmark match by:
  * (C) 1999-2001 Marc Boucher <marc@mbsi.ca>
  *
- * (C) 2006 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * (C) 2006,2008 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -87,6 +87,12 @@ static bool checkentry(const char *tablename, const void *entry,
 {
 	struct xt_secmark_target_info *info = targinfo;
 
+	if (strcmp(tablename, "mangle") && strcmp(tablename, "security")) {
+		printk(KERN_INFO PFX "target only valid in the \'mangle\' "
+		       "or \'security\' tables, not \'%s\'.\n", tablename);
+		return false;
+	}
+
 	if (mode && mode != info->mode) {
 		printk(KERN_INFO PFX "mode already set to %hu cannot mix with "
 		       "rules for mode %hu\n", mode, info->mode);
@@ -116,7 +122,6 @@ static struct xt_target xt_secmark_target[] __read_mostly = {
 		.checkentry	= checkentry,
 		.target		= target,
 		.targetsize	= sizeof(struct xt_secmark_target_info),
-		.table		= "mangle",
 		.me		= THIS_MODULE,
 	},
 	{
@@ -125,7 +130,6 @@ static struct xt_target xt_secmark_target[] __read_mostly = {
 		.checkentry	= checkentry,
 		.target		= target,
 		.targetsize	= sizeof(struct xt_secmark_target_info),
-		.table		= "mangle",
 		.me		= THIS_MODULE,
 	},
 };
-- 
1.5.3.8


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
