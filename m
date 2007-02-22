Subject: [PATCH] Reassign printk levels in selinux kernel code
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Thu, 22 Feb 2007 18:11:31 -0500
Message-Id: <1172185891.3142.48.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is a patch which demotes many printk lines to KERN_DEBUG from
KERN_INFO.  It should help stop the spamming of logs with messages in
which users are not interested nor is there any action that users should
take.  It also promotes some KERN_INFO to KERN_ERR such as when there
are improper attempts to register/unregister security modules.

A similar patch was discussed a while back on list:
http://marc.theaimsgroup.com/?t=116656343500003&r=1&w=2
This patch addresses almost all of the issues raised.  I believe the
only advice not taken was in the demoting of messages related to
undefined permissions and classes.

Signed-off-by: Eric Paris <eparis@redhat.com>

 security/selinux/hooks.c       |   20 ++++++++++----------
 security/selinux/ss/avtab.c    |    2 +-
 security/selinux/ss/policydb.c |    6 +++---
 security/selinux/ss/sidtab.c   |    2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b1ac22d..afb82fd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -653,11 +653,11 @@ static int superblock_doinit(struct super_block *sb, void *data)
 	sbsec->initialized = 1;
 
 	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors)) {
-		printk(KERN_INFO "SELinux: initialized (dev %s, type %s), unknown behavior\n",
+		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
 		       sb->s_id, sb->s_type->name);
 	}
 	else {
-		printk(KERN_INFO "SELinux: initialized (dev %s, type %s), %s\n",
+		printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), %s\n",
 		       sb->s_id, sb->s_type->name,
 		       labeling_behaviors[sbsec->behavior-1]);
 	}
@@ -4434,7 +4434,7 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 static int selinux_register_security (const char *name, struct security_operations *ops)
 {
 	if (secondary_ops != original_ops) {
-		printk(KERN_INFO "%s:  There is already a secondary security "
+		printk(KERN_ERR "%s:  There is already a secondary security "
 		       "module registered.\n", __FUNCTION__);
 		return -EINVAL;
  	}
@@ -4451,7 +4451,7 @@ static int selinux_register_security (const char *name, struct security_operatio
 static int selinux_unregister_security (const char *name, struct security_operations *ops)
 {
 	if (ops != secondary_ops) {
-		printk (KERN_INFO "%s:  trying to unregister a security module "
+		printk(KERN_ERR "%s:  trying to unregister a security module "
 		        "that is not registered.\n", __FUNCTION__);
 		return -EINVAL;
 	}
@@ -4889,9 +4889,9 @@ static __init int selinux_init(void)
 		panic("SELinux: Unable to register with kernel.\n");
 
 	if (selinux_enforcing) {
-		printk(KERN_INFO "SELinux:  Starting in enforcing mode\n");
+		printk(KERN_DEBUG "SELinux:  Starting in enforcing mode\n");
 	} else {
-		printk(KERN_INFO "SELinux:  Starting in permissive mode\n");
+		printk(KERN_DEBUG "SELinux:  Starting in permissive mode\n");
 	}
 
 #ifdef CONFIG_KEYS
@@ -4907,10 +4907,10 @@ static __init int selinux_init(void)
 
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
@@ -4969,7 +4969,7 @@ static int __init selinux_nf_ip_init(void)
 	if (!selinux_enabled)
 		goto out;
 		
-	printk(KERN_INFO "SELinux:  Registering netfilter hooks\n");
+	printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");
 	
 	err = nf_register_hook(&selinux_ipv4_op);
 	if (err)
@@ -4992,7 +4992,7 @@ __initcall(selinux_nf_ip_init);
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static void selinux_nf_ip_exit(void)
 {
-	printk(KERN_INFO "SELinux:  Unregistering netfilter hooks\n");
+	printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");
 
 	nf_unregister_hook(&selinux_ipv4_op);
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 9142073..3122908 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -277,7 +277,7 @@ void avtab_hash_eval(struct avtab *h, char *tag)
 		}
 	}
 
-	printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest "
+	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
 	       "chain length %d\n", tag, h->nel, slots_used, AVTAB_SIZE,
 	       max_chain_len);
 }
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index cd79c63..0ac1021 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -374,7 +374,7 @@ static void symtab_hash_eval(struct symtab *s)
 		struct hashtab_info info;
 
 		hashtab_stat(h, &info);
-		printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, "
+		printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, "
 		       "longest chain length %d\n", symtab_name[i], h->nel,
 		       info.slots_used, h->size, info.max_chain_len);
 	}
@@ -391,14 +391,14 @@ static int policydb_index_others(struct policydb *p)
 {
 	int i, rc = 0;
 
-	printk(KERN_INFO "security:  %d users, %d roles, %d types, %d bools",
+	printk(KERN_DEBUG "security:  %d users, %d roles, %d types, %d bools",
 	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
 	if (selinux_mls_enabled)
 		printk(", %d sens, %d cats", p->p_levels.nprim,
 		       p->p_cats.nprim);
 	printk("\n");
 
-	printk(KERN_INFO "security:  %d classes, %d rules\n",
+	printk(KERN_DEBUG "security:  %d classes, %d rules\n",
 	       p->p_classes.nprim, p->te_avtab.nel);
 
 #ifdef DEBUG_HASHES
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index d78f9ff..53a54a7 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -253,7 +253,7 @@ void sidtab_hash_eval(struct sidtab *h, char *tag)
 		}
 	}
 
-	printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest "
+	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
 	       "chain length %d\n", tag, h->nel, slots_used, SIDTAB_SIZE,
 	       max_chain_len);
 }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
