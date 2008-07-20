Date: Mon, 21 Jul 2008 02:10:27 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Eric Paris <eparis@parisplace.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
Subject: [patch] SELinux: trivial, unify iterator variable naming, part 2
Message-ID: <Pine.LNX.4.64L.0807210204100.8125@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Again, renamed iterators "iter" to "i", to be in harmony
with the old unwritten C convention, and with the rest of the code.

Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>

---

 security/selinux/hooks.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)



--- security-testing-2.6/security/selinux/hooks.c	2008-07-20 18:29:22.000000000 +0300
+++ security-testing-2.6-vmk/security/selinux/hooks.c	2008-07-21 01:59:04.000000000 +0300
@@ -5670,23 +5670,23 @@ static struct nf_hook_ops selinux_ipv6_o
 static int __init selinux_nf_ip_init(void)
 {
 	int err = 0;
-	u32 iter;
+	u32 i;

 	if (!selinux_enabled)
 		goto out;

 	printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");

-	for (iter = 0; iter < ARRAY_SIZE(selinux_ipv4_ops); iter++) {
-		err = nf_register_hook(&selinux_ipv4_ops[iter]);
+	for (i = 0; i < ARRAY_SIZE(selinux_ipv4_ops); i++) {
+		err = nf_register_hook(&selinux_ipv4_ops[i]);
 		if (err)
 			panic("SELinux: nf_register_hook for IPv4: error %d\n",
 			      err);
 	}

 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-	for (iter = 0; iter < ARRAY_SIZE(selinux_ipv6_ops); iter++) {
-		err = nf_register_hook(&selinux_ipv6_ops[iter]);
+	for (i = 0; i < ARRAY_SIZE(selinux_ipv6_ops); i++) {
+		err = nf_register_hook(&selinux_ipv6_ops[i]);
 		if (err)
 			panic("SELinux: nf_register_hook for IPv6: error %d\n",
 			      err);
@@ -5702,15 +5702,15 @@ __initcall(selinux_nf_ip_init);
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static void selinux_nf_ip_exit(void)
 {
-	u32 iter;
+	u32 i;

 	printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");

-	for (iter = 0; iter < ARRAY_SIZE(selinux_ipv4_ops); iter++)
-		nf_unregister_hook(&selinux_ipv4_ops[iter]);
+	for (i = 0; i < ARRAY_SIZE(selinux_ipv4_ops); i++)
+		nf_unregister_hook(&selinux_ipv4_ops[i]);
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
-	for (iter = 0; iter < ARRAY_SIZE(selinux_ipv6_ops); iter++)
-		nf_unregister_hook(&selinux_ipv6_ops[iter]);
+	for (i = 0; i < ARRAY_SIZE(selinux_ipv6_ops); i++)
+		nf_unregister_hook(&selinux_ipv6_ops[i]);
 #endif	/* IPV6 */
 }
 #endif

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
