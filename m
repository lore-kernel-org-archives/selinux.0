Subject: [PATCH] change printks from KERN_INFO to KERN_DEBUG
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 16:15:33 -0500
Message-Id: <1166562934.20187.87.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch goes through SELinux code and demotes a number of
printk from KERN_INFO to KERN_DEBUG.  This still leaves a number of
KERN_INFO inside security/selinux which are listed below.  If anyone
feels that any (all?) of those should be demoted as well just let me
know and i'll post another patch.

hooks.c: printk(KERN_INFO "%s:  There is already a secondary security "
hooks.c: printk(KERN_INFO "%s:  Registering secondary module %s\n",
hooks.c: printk(KERN_INFO "%s:  trying to unregister a security module "
hooks.c: printk(KERN_INFO "SELinux:  Disabled at boot.\n");
hooks.c: printk(KERN_INFO "SELinux:  Initializing.\n");
hooks.c: printk(KERN_INFO "SELinux:  Starting in enforcing mode\n");
hooks.c: printk(KERN_INFO "SELinux:  Starting in permissive mode\n");
hooks.c: printk(KERN_INFO "SELinux:  Disabled at runtime.\n");
ss/avtab.c: printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest " <- wrapped in DEBUG_HASHES
ss/policydb.c: printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, " <- wrapped in DEBUG_HASHES
ss/policydb.c: printk(KERN_INFO "security:  %d users, %d roles, %d types, %d bools",
ss/policydb.c: printk(KERN_INFO "security:  %d classes, %d rules\n",
ss/services.c: printk(KERN_INFO <- missing class definitions in policy
ss/services.c: printk(KERN_INFO <- missing permission definitions in policy
ss/services.c: printk(KERN_INFO <- missing inherit definitions in policy
ss/sidtab.c: printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest " <- inside #if 0

Did I take too much or too little?

-Eric

 security/selinux/hooks.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 65fb5e8..e7cc553 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -654,11 +654,11 @@ static int superblock_doinit(struct super_block *sb, void *data)
 	sbsec->initialized = 1;
 
 	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors)) {
-		printk(KERN_INFO "SELinux: initialized (dev %s, type %s), unknown behavior\n",
+		printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), unknown behavior\n",
 		       sb->s_id, sb->s_type->name);
 	}
 	else {
-		printk(KERN_INFO "SELinux: initialized (dev %s, type %s), %s\n",
+		printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), %s\n",
 		       sb->s_id, sb->s_type->name,
 		       labeling_behaviors[sbsec->behavior-1]);
 	}
@@ -4408,7 +4408,7 @@ static int selinux_register_security (const char *name, struct security_operatio
 static int selinux_unregister_security (const char *name, struct security_operations *ops)
 {
 	if (ops != secondary_ops) {
-		printk (KERN_INFO "%s:  trying to unregister a security module "
+		printk(KERN_INFO "%s:  trying to unregister a security module "
 		        "that is not registered.\n", __FUNCTION__);
 		return -EINVAL;
 	}
@@ -4864,10 +4864,10 @@ static __init int selinux_init(void)
 
 void selinux_complete_init(void)
 {
-	printk(KERN_INFO "SELinux:  Completing initialization.\n");
+	printk(KERN_DEBUG "SELinux:  Completing initialization.\n");
 
 	/* Set up any superblocks initialized prior to the policy load. */
-	printk(KERN_INFO "SELinux:  Setting up existing superblocks.\n");
+	printk(KERN_DEBUG "SELinux:  Setting up existing superblocks.\n");
 	spin_lock(&sb_lock);
 	spin_lock(&sb_security_lock);
 next_sb:
@@ -4926,7 +4926,7 @@ static int __init selinux_nf_ip_init(void)
 	if (!selinux_enabled)
 		goto out;
 		
-	printk(KERN_INFO "SELinux:  Registering netfilter hooks\n");
+	printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");
 	
 	err = nf_register_hook(&selinux_ipv4_op);
 	if (err)
@@ -4949,7 +4949,7 @@ __initcall(selinux_nf_ip_init);
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static void selinux_nf_ip_exit(void)
 {
-	printk(KERN_INFO "SELinux:  Unregistering netfilter hooks\n");
+	printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");
 
 	nf_unregister_hook(&selinux_ipv4_op);
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
