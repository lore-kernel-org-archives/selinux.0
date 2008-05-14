Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4EFRrNs025914
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 11:27:53 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4EFRlTh024218
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 15:27:52 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4EFRkcu031277
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 11:27:46 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4EFRknw020913
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 11:27:46 -0400
Received: from [10.11.15.254] (vpn-15-254.rdu.redhat.com [10.11.15.254])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4EFRk7s032388
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 11:27:46 -0400
Subject: [PATCH] SELinux: keep the code clean formating and syntax
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 14 May 2008 11:27:45 -0400
Message-Id: <1210778865.3216.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Formatting and syntax changes

whitespace, tabs to spaces, trailing space
put open { on same line as struct def
remove unneeded {} after if statements
change printk("Lu") to printk("llu")
convert asm/uaccess.h to linux/uaacess.h includes
remove unnecessary asm/bug.h includes
convert all users of simple_strtol to strict_strtol

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/hooks.c         |   18 +++++++++++-------
 security/selinux/include/audit.h |    4 ++--
 security/selinux/include/avc.h   |   15 +++++++--------
 security/selinux/netnode.c       |    1 -
 security/selinux/netport.c       |    3 +--
 security/selinux/selinuxfs.c     |   10 +++++++---
 security/selinux/ss/avtab.c      |    2 +-
 security/selinux/ss/mls.c        |    8 ++++----
 security/selinux/ss/services.c   |    4 ++--
 9 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1c864c0..60900ad 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -53,7 +53,7 @@
 #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
 #include <net/net_namespace.h>
 #include <net/netlabel.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/ioctls.h>
 #include <asm/atomic.h>
 #include <linux/bitops.h>
@@ -104,7 +104,9 @@ int selinux_enforcing;
 
 static int __init enforcing_setup(char *str)
 {
-	selinux_enforcing = simple_strtol(str, NULL, 0);
+	unsigned long enforcing;
+	if (!strict_strtoul(str, 0, &enforcing))
+		selinux_enforcing = enforcing ? 1 : 0;
 	return 1;
 }
 __setup("enforcing=", enforcing_setup);
@@ -115,7 +117,9 @@ int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;
 
 static int __init selinux_enabled_setup(char *str)
 {
-	selinux_enabled = simple_strtol(str, NULL, 0);
+	unsigned long enabled;
+	if (!strict_strtoul(str, 0, &enabled))
+		selinux_enabled = enabled ? 1 : 0;
 	return 1;
 }
 __setup("selinux=", selinux_enabled_setup);
@@ -594,7 +598,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 */
 	if (sbsec->initialized && (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)
 	    && (num_opts == 0))
-	        goto out;
+		goto out;
 
 	/*
 	 * parse the mount options, check if they are valid sids.
@@ -2690,7 +2694,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 }
 
 static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
-                                        const void *value, size_t size,
+					const void *value, size_t size,
 					int flags)
 {
 	struct inode *inode = dentry->d_inode;
@@ -5378,7 +5382,7 @@ static struct security_operations selinux_ops = {
 	.inode_listsecurity =		selinux_inode_listsecurity,
 	.inode_need_killpriv =		selinux_inode_need_killpriv,
 	.inode_killpriv =		selinux_inode_killpriv,
-	.inode_getsecid =               selinux_inode_getsecid,
+	.inode_getsecid =		selinux_inode_getsecid,
 
 	.file_permission =		selinux_file_permission,
 	.file_alloc_security =		selinux_file_alloc_security,
@@ -5419,7 +5423,7 @@ static struct security_operations selinux_ops = {
 	.task_to_inode =		selinux_task_to_inode,
 
 	.ipc_permission =		selinux_ipc_permission,
-	.ipc_getsecid =                 selinux_ipc_getsecid,
+	.ipc_getsecid =			selinux_ipc_getsecid,
 
 	.msg_msg_alloc_security =	selinux_msg_msg_alloc_security,
 	.msg_msg_free_security =	selinux_msg_msg_free_security,
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 6c8b9ef..1bdf973 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -1,7 +1,7 @@
 /*
  * SELinux support for the Audit LSM hooks
  *
- * Most of below header was moved from include/linux/selinux.h which 
+ * Most of below header was moved from include/linux/selinux.h which
  * is released under below copyrights:
  *
  * Author: James Morris <jmorris@redhat.com>
@@ -52,7 +52,7 @@ void selinux_audit_rule_free(void *rule);
  *	-errno on failure.
  */
 int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule,
-                             struct audit_context *actx);
+			     struct audit_context *actx);
 
 /**
  *	selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 8e23d7a..7b9769f 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -75,13 +75,12 @@ struct avc_audit_data {
 
 /* Initialize an AVC audit data structure. */
 #define AVC_AUDIT_DATA_INIT(_d,_t) \
-        { memset((_d), 0, sizeof(struct avc_audit_data)); (_d)->type = AVC_AUDIT_DATA_##_t; }
+	{ memset((_d), 0, sizeof(struct avc_audit_data)); (_d)->type = AVC_AUDIT_DATA_##_t; }
 
 /*
  * AVC statistics
  */
-struct avc_cache_stats
-{
+struct avc_cache_stats {
 	unsigned int lookups;
 	unsigned int hits;
 	unsigned int misses;
@@ -97,8 +96,8 @@ struct avc_cache_stats
 void __init avc_init(void);
 
 void avc_audit(u32 ssid, u32 tsid,
-               u16 tclass, u32 requested,
-               struct av_decision *avd, int result, struct avc_audit_data *auditdata);
+	       u16 tclass, u32 requested,
+	       struct av_decision *avd, int result, struct avc_audit_data *auditdata);
 
 #define AVC_STRICT 1 /* Ignore permissive mode. */
 int avc_has_perm_noaudit(u32 ssid, u32 tsid,
@@ -107,8 +106,8 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 			 struct av_decision *avd);
 
 int avc_has_perm(u32 ssid, u32 tsid,
-                 u16 tclass, u32 requested,
-                 struct avc_audit_data *auditdata);
+		 u16 tclass, u32 requested,
+		 struct avc_audit_data *auditdata);
 
 u32 avc_policy_seqno(void);
 
@@ -122,7 +121,7 @@ u32 avc_policy_seqno(void);
 #define AVC_CALLBACK_AUDITDENY_DISABLE	128
 
 int avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
-                                     u16 tclass, u32 perms,
+				     u16 tclass, u32 perms,
 				     u32 *out_retained),
 		     u32 events, u32 ssid, u32 tsid,
 		     u16 tclass, u32 perms);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index b6ccd09..7100072 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -38,7 +38,6 @@
 #include <linux/ipv6.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
-#include <asm/bug.h>
 
 #include "netnode.h"
 #include "objsec.h"
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 90b4cff..fe7fba6 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -37,7 +37,6 @@
 #include <linux/ipv6.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
-#include <asm/bug.h>
 
 #include "netport.h"
 #include "objsec.h"
@@ -272,7 +271,7 @@ static __init int sel_netport_init(void)
 	}
 
 	ret = avc_add_callback(sel_netport_avc_callback, AVC_CALLBACK_RESET,
-	                       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
+			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
 	if (ret != 0)
 		panic("avc_add_callback() failed, error %d\n", ret);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ac1ccc1..07a5db6 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -27,7 +27,7 @@
 #include <linux/seq_file.h>
 #include <linux/percpu.h>
 #include <linux/audit.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
@@ -57,14 +57,18 @@ int selinux_compat_net = SELINUX_COMPAT_NET_VALUE;
 
 static int __init checkreqprot_setup(char *str)
 {
-	selinux_checkreqprot = simple_strtoul(str, NULL, 0) ? 1 : 0;
+	unsigned long checkreqprot;
+	if (!strict_strtoul(str, 0, &checkreqprot))
+		selinux_checkreqprot = checkreqprot ? 1 : 0;
 	return 1;
 }
 __setup("checkreqprot=", checkreqprot_setup);
 
 static int __init selinux_compat_net_setup(char *str)
 {
-	selinux_compat_net = simple_strtoul(str, NULL, 0) ? 1 : 0;
+	unsigned long compat_net;
+	if (!strict_strtoul(str, 0, &compat_net))
+		selinux_compat_net = compat_net ? 1 : 0;
 	return 1;
 }
 __setup("selinux_compat_net=", selinux_compat_net_setup);
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 9e66263..a1be97f 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -311,7 +311,7 @@ void avtab_hash_eval(struct avtab *h, char *tag)
 	}
 
 	printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
-	       "longest chain length %d sum of chain length^2 %Lu\n",
+	       "longest chain length %d sum of chain length^2 %llu\n",
 	       tag, h->nel, slots_used, h->nslot, max_chain_len,
 	       chain2_len_sum);
 }
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 8b1706b..0033cfe 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -436,13 +436,13 @@ int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
 		struct mls_level *usercon_clr = &(usercon->range.level[1]);
 
 		/* Honor the user's default level if we can */
-		if (mls_level_between(user_def, fromcon_sen, fromcon_clr)) {
+		if (mls_level_between(user_def, fromcon_sen, fromcon_clr))
 			*usercon_sen = *user_def;
-		} else if (mls_level_between(fromcon_sen, user_def, user_clr)) {
+		else if (mls_level_between(fromcon_sen, user_def, user_clr))
 			*usercon_sen = *fromcon_sen;
-		} else if (mls_level_between(fromcon_clr, user_low, user_def)) {
+		else if (mls_level_between(fromcon_clr, user_low, user_def))
 			*usercon_sen = *user_low;
-		} else
+		else
 			return -EINVAL;
 
 		/* Lower the clearance of available contexts
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index dcc2e1c..c4b4442 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2420,7 +2420,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 }
 
 int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
-                             struct audit_context *actx)
+			     struct audit_context *actx)
 {
 	struct context *ctxt;
 	struct mls_level *level;
@@ -2534,7 +2534,7 @@ out:
 static int (*aurule_callback)(void) = audit_update_lsm_rules;
 
 static int aurule_avc_callback(u32 event, u32 ssid, u32 tsid,
-                               u16 class, u32 perms, u32 *retained)
+			       u16 class, u32 perms, u32 *retained)
 {
 	int err = 0;
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
