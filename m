From: Joe Perches <joe@perches.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>
Cc: Peter Enderborg <peter.enderborg@sony.com>, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org
Date: Tue, 19 Jun 2018 23:39:46 -0700
Message-Id: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
Subject: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

pr_fmt can be used with the pr_<level> macros to prefix
arbitrary content to logging messages.

So add '#define pr_fmt(fmt) "SELinux: " fmt' to selinux files
that use pr_<level> and remove embedded "SELinux: " prefixes
from the format strings.

Miscellanea:

o Coalesce formats and realign arguments
o Add missing space to a coalesced format
o Remove "SELinux: " from SEL_MOUNT_FAIL_MSG as that is directly
  used only in pr_warn
o Add missing terminating \n to some formats
o Consistently use single space after logging prefixes

Signed-off-by: Joe Perches <joe@perches.com>
---
 security/selinux/avc.c            |   7 ++-
 security/selinux/hooks.c          | 124 +++++++++++++++++---------------------
 security/selinux/netif.c          |   7 ++-
 security/selinux/netlink.c        |   7 ++-
 security/selinux/netnode.c        |   4 +-
 security/selinux/netport.c        |   4 +-
 security/selinux/selinuxfs.c      |  33 +++++-----
 security/selinux/ss/avtab.c       |  61 +++++++++----------
 security/selinux/ss/conditional.c |  18 +++---
 security/selinux/ss/ebitmap.c     |  20 +++---
 security/selinux/ss/policydb.c    | 123 +++++++++++++++++--------------------
 security/selinux/ss/services.c    | 110 +++++++++++++--------------------
 security/selinux/ss/sidtab.c      |  12 ++--
 13 files changed, 247 insertions(+), 283 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 635e5c1e3e48..680d91ed0721 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -13,6 +13,9 @@
  *	it under the terms of the GNU General Public License version 2,
  *	as published by the Free Software Foundation.
  */
+
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
@@ -650,8 +653,8 @@ static int avc_latest_notif_update(struct selinux_avc *avc,
 	spin_lock_irqsave(&notif_lock, flag);
 	if (is_insert) {
 		if (seqno < avc->avc_cache.latest_notif) {
-			pr_warn("SELinux: avc:  seqno %d < latest_notif %d\n",
-			       seqno, avc->avc_cache.latest_notif);
+			pr_warn("avc: seqno %d < latest_notif %d\n",
+				seqno, avc->avc_cache.latest_notif);
 			ret = -EAGAIN;
 		}
 	} else {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 10a5d2ce3870..311156d8932e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -24,6 +24,8 @@
  *	as published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/init.h>
 #include <linux/kd.h>
 #include <linux/kernel.h>
@@ -217,7 +219,7 @@ static void cred_init_security(void)
 
 	tsec = kzalloc(sizeof(struct task_security_struct), GFP_KERNEL);
 	if (!tsec)
-		panic("SELinux:  Failed to initialize initial task.\n");
+		panic("Failed to initialize initial task\n");
 
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 	cred->security = tsec;
@@ -460,7 +462,7 @@ static const match_table_t tokens = {
 	{Opt_error, NULL},
 };
 
-#define SEL_MOUNT_FAIL_MSG "SELinux:  duplicate or incompatible mount options\n"
+#define SEL_MOUNT_FAIL_MSG "duplicate or incompatible mount options\n"
 
 static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
@@ -532,8 +534,8 @@ static int sb_finish_set_opts(struct super_block *sb)
 		   the first boot of the SELinux kernel before we have
 		   assigned xattr values to the filesystem. */
 		if (!(root_inode->i_opflags & IOP_XATTR)) {
-			pr_warn("SELinux: (dev %s, type %s) has no "
-			       "xattr support\n", sb->s_id, sb->s_type->name);
+			pr_warn("(dev %s, type %s) has no xattr support\n",
+				sb->s_id, sb->s_type->name);
 			rc = -EOPNOTSUPP;
 			goto out;
 		}
@@ -541,13 +543,11 @@ static int sb_finish_set_opts(struct super_block *sb)
 		rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
 		if (rc < 0 && rc != -ENODATA) {
 			if (rc == -EOPNOTSUPP)
-				pr_warn("SELinux: (dev %s, type "
-				       "%s) has no security xattr handler\n",
-				       sb->s_id, sb->s_type->name);
+				pr_warn("(dev %s, type %s) has no security xattr handler\n",
+					sb->s_id, sb->s_type->name);
 			else
-				pr_warn("SELinux: (dev %s, type "
-				       "%s) getxattr errno %d\n", sb->s_id,
-				       sb->s_type->name, -rc);
+				pr_warn("(dev %s, type %s) getxattr errno %d\n",
+					sb->s_id, sb->s_type->name, -rc);
 			goto out;
 		}
 	}
@@ -744,8 +744,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			goto out;
 		}
 		rc = -EINVAL;
-		pr_warn("SELinux: Unable to set superblock options "
-			"before the security server is initialized\n");
+		pr_warn("Unable to set superblock options before the security server is initialized\n");
 		goto out;
 	}
 	if (kern_flags && !set_kern_flags) {
@@ -786,9 +785,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 						 mount_options[i], &sid,
 						 GFP_KERNEL);
 		if (rc) {
-			pr_warn("SELinux: security_context_str_to_sid"
-			       "(%s) failed for (dev %s, type %s) errno=%d\n",
-			       mount_options[i], sb->s_id, name, rc);
+			pr_warn("security_context_str_to_sid(%s) failed for (dev %s, type %s) errno=%d\n",
+				mount_options[i], sb->s_id, name, rc);
 			goto out;
 		}
 		switch (flags[i]) {
@@ -948,8 +946,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		if (sbsec->behavior != SECURITY_FS_USE_XATTR &&
 			sbsec->behavior != SECURITY_FS_USE_NATIVE) {
 			rc = -EINVAL;
-			pr_warn("SELinux: defcontext option is "
-			       "invalid for this filesystem type\n");
+			pr_warn("defcontext option is invalid for this filesystem type\n");
 			goto out;
 		}
 
@@ -970,8 +967,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	return rc;
 out_double_mount:
 	rc = -EINVAL;
-	pr_warn("SELinux: mount invalid.  Same superblock, different "
-	       "security settings for (dev %s, type %s)\n", sb->s_id, name);
+	pr_warn("mount invalid.  Same superblock, different security settings for (dev %s, type %s)\n",
+		sb->s_id, name);
 	goto out;
 }
 
@@ -999,9 +996,8 @@ static int selinux_cmp_sb_context(const struct super_block *oldsb,
 	}
 	return 0;
 mismatch:
-	pr_warn("SELinux: mount invalid.  Same superblock, "
-			    "different security settings for (dev %s, "
-			    "type %s)\n", newsb->s_id, newsb->s_type->name);
+	pr_warn("mount invalid.  Same superblock, different security settings for (dev %s, type %s)\n",
+		newsb->s_id, newsb->s_type->name);
 	return -EBUSY;
 }
 
@@ -1159,7 +1155,7 @@ static int selinux_parse_opts_str(char *options,
 			break;
 		default:
 			rc = -EINVAL;
-			pr_warn("SELinux:  unknown mount option\n");
+			pr_warn("unknown mount option\n");
 			goto out_err;
 
 		}
@@ -1624,9 +1620,9 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		dput(dentry);
 		if (rc < 0) {
 			if (rc != -ENODATA) {
-				pr_warn("SELinux: %s:  getxattr returned "
-				       "%d for dev=%s ino=%ld\n", __func__,
-				       -rc, inode->i_sb->s_id, inode->i_ino);
+				pr_warn("%s: getxattr returned %d for dev=%s ino=%ld\n",
+					__func__,
+					-rc, inode->i_sb->s_id, inode->i_ino);
 				kfree(context);
 				goto out;
 			}
@@ -1644,13 +1640,12 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 				if (rc == -EINVAL) {
 					if (printk_ratelimit())
-						pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
-							"context=%s.  This indicates you may need to relabel the inode or the "
-							"filesystem in question.\n", ino, dev, context);
+						pr_notice("inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
+							  ino, dev, context);
 				} else {
-					pr_warn("SELinux: %s:  context_to_sid(%s) "
-					       "returned %d for dev=%s ino=%ld\n",
-					       __func__, context, -rc, dev, ino);
+					pr_warn("%s: context_to_sid(%s) returned %d for dev=%s ino=%ld\n",
+						__func__, context, -rc,
+						dev, ino);
 				}
 				kfree(context);
 				/* Leave with the unlabeled SID */
@@ -1786,7 +1781,7 @@ static int cred_has_capability(const struct cred *cred,
 		sclass = initns ? SECCLASS_CAPABILITY2 : SECCLASS_CAP2_USERNS;
 		break;
 	default:
-		pr_err("SELinux:  out of range capability %d\n", cap);
+		pr_err("out of range capability %d\n", cap);
 		BUG();
 		return -EINVAL;
 	}
@@ -2029,8 +2024,7 @@ static int may_link(struct inode *dir,
 		av = DIR__RMDIR;
 		break;
 	default:
-		pr_warn("SELinux: %s:  unrecognized kind %d\n",
-			__func__, kind);
+		pr_warn("%s: unrecognized kind %d\n", __func__, kind);
 		return 0;
 	}
 
@@ -2876,9 +2870,9 @@ static int selinux_sb_remount(struct super_block *sb, void *data, size_t data_si
 						 mount_options[i], &sid,
 						 GFP_KERNEL);
 		if (rc) {
-			pr_warn("SELinux: security_context_str_to_sid"
-			       "(%s) failed for (dev %s, type %s) errno=%d\n",
-			       mount_options[i], sb->s_id, sb->s_type->name, rc);
+			pr_warn("security_context_str_to_sid(%s) failed for (dev %s, type %s) errno=%d\n",
+				mount_options[i],
+				sb->s_id, sb->s_type->name, rc);
 			goto out_free_opts;
 		}
 		rc = -EINVAL;
@@ -2915,9 +2909,8 @@ static int selinux_sb_remount(struct super_block *sb, void *data, size_t data_si
 	free_secdata(secdata);
 	return rc;
 out_bad_option:
-	pr_warn("SELinux: unable to change security options "
-	       "during remount (dev %s, type=%s)\n", sb->s_id,
-	       sb->s_type->name);
+	pr_warn("unable to change security options during remount (dev %s, type=%s)\n",
+		sb->s_id, sb->s_type->name);
 	goto out_free_opts;
 }
 
@@ -3124,9 +3117,9 @@ static int selinux_validate_for_sb_reconfigure(struct fs_context *fc)
 		rc = security_context_str_to_sid(&selinux_state, mount_options[i],
 						 &sid, GFP_KERNEL);
 		if (rc) {
-			pr_warn("SELinux: security_context_str_to_sid"
-				"(%s) failed for (dev %s, type %s) errno=%d\n",
-				mount_options[i], sb->s_id, sb->s_type->name, rc);
+			pr_warn("security_context_str_to_sid(%s) failed for (dev %s, type %s) errno=%d\n",
+				mount_options[i],
+				sb->s_id, sb->s_type->name, rc);
 			goto inval;
 		}
 
@@ -3161,8 +3154,7 @@ static int selinux_validate_for_sb_reconfigure(struct fs_context *fc)
 	return rc;
 
 bad_option:
-	pr_warn("SELinux: unable to change security options "
-		"during remount (dev %s, type=%s)\n",
+	pr_warn("unable to change security options during remount (dev %s, type=%s)\n",
 		sb->s_id, sb->s_type->name);
 inval:
 	rc = -EINVAL;
@@ -3595,8 +3587,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 	rc = security_context_to_sid_force(&selinux_state, value, size,
 					   &newsid);
 	if (rc) {
-		pr_err("SELinux:  unable to map context to SID"
-		       "for (%s, %lu), rc=%d\n",
+		pr_err("unable to map context to SID for (%s, %lu), rc=%d\n",
 		       inode->i_sb->s_id, inode->i_ino, -rc);
 		return;
 	}
@@ -4658,9 +4649,7 @@ static int selinux_parse_skb(struct sk_buff *skb, struct common_audit_data *ad,
 	}
 
 parse_error:
-	pr_warn(
-	       "SELinux: failure in selinux_parse_skb(),"
-	       " unable to parse packet\n");
+	pr_warn("failure in selinux_parse_skb(), unable to parse packet\n");
 	return ret;
 
 okay:
@@ -4701,9 +4690,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	err = security_net_peersid_resolve(&selinux_state, nlbl_sid,
 					   nlbl_type, xfrm_sid, sid);
 	if (unlikely(err)) {
-		pr_warn(
-		       "SELinux: failure in selinux_skb_peerlbl_sid(),"
-		       " unable to determine packet's peer label\n");
+		pr_warn("failure in selinux_skb_peerlbl_sid(), unable to determine packet's peer label\n");
 		return -EACCES;
 	}
 
@@ -5790,12 +5777,11 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
 	if (err) {
 		if (err == -EINVAL) {
-			pr_warn_ratelimited("SELinux: unrecognized netlink"
-			       " message: protocol=%hu nlmsg_type=%hu sclass=%s"
-			       " pig=%d comm=%s\n",
-			       sk->sk_protocol, nlh->nlmsg_type,
-			       secclass_map[sksec->sclass - 1].name,
-			       task_pid_nr(current), current->comm);
+			pr_warn_ratelimited("unrecognized netlink message: protocol=%hu nlmsg_type=%hu sclass=%s pig=%d comm=%s\n",
+					    sk->sk_protocol, nlh->nlmsg_type,
+					    secclass_map[sksec->sclass - 1].name,
+					    task_pid_nr(current),
+					    current->comm);
 			if (!enforcing_enabled(&selinux_state) ||
 			    security_get_allow_unknown(&selinux_state))
 				err = 0;
@@ -7371,11 +7357,11 @@ static __init int selinux_init(void)
 	}
 
 	if (!selinux_enabled) {
-		pr_info("SELinux:  Disabled at boot.\n");
+		pr_info("Disabled at boot\n");
 		return 0;
 	}
 
-	pr_info("SELinux:  Initializing.\n");
+	pr_info("Initializing\n");
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
 	enforcing_set(&selinux_state, selinux_enforcing_boot);
@@ -7411,9 +7397,9 @@ static __init int selinux_init(void)
 		panic("SELinux: Unable to register AVC LSM notifier callback\n");
 
 	if (selinux_enforcing_boot)
-		pr_debug("SELinux:  Starting in enforcing mode\n");
+		pr_debug("Starting in enforcing mode\n");
 	else
-		pr_debug("SELinux:  Starting in permissive mode\n");
+		pr_debug("Starting in permissive mode\n");
 
 	return 0;
 }
@@ -7425,10 +7411,10 @@ static void delayed_superblock_init(struct super_block *sb, void *unused)
 
 void selinux_complete_init(void)
 {
-	pr_debug("SELinux:  Completing initialization.\n");
+	pr_debug("Completing initialization\n");
 
 	/* Set up any superblocks initialized prior to the policy load. */
-	pr_debug("SELinux:  Setting up existing superblocks.\n");
+	pr_debug("Setting up existing superblocks\n");
 	iterate_supers(delayed_superblock_init, NULL);
 }
 
@@ -7503,7 +7489,7 @@ static int __init selinux_nf_ip_init(void)
 	if (!selinux_enabled)
 		return 0;
 
-	pr_debug("SELinux:  Registering netfilter hooks\n");
+	pr_debug("Registering netfilter hooks\n");
 
 	err = register_pernet_subsys(&selinux_net_ops);
 	if (err)
@@ -7516,7 +7502,7 @@ __initcall(selinux_nf_ip_init);
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static void selinux_nf_ip_exit(void)
 {
-	pr_debug("SELinux:  Unregistering netfilter hooks\n");
+	pr_debug("Unregistering netfilter hooks\n");
 
 	unregister_pernet_subsys(&selinux_net_ops);
 }
@@ -7545,7 +7531,7 @@ int selinux_disable(struct selinux_state *state)
 
 	state->disabled = 1;
 
-	pr_info("SELinux:  Disabled at runtime.\n");
+	pr_info("Disabled at runtime\n");
 
 	selinux_enabled = 0;
 
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 8c738c189942..b4f2e3f3e468 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -14,6 +14,9 @@
  * it under the terms of the GNU General Public License version 2,
  * as published by the Free Software Foundation.
  */
+
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -145,7 +148,7 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 
 	dev = dev_get_by_index(ns, ifindex);
 	if (unlikely(dev == NULL)) {
-		pr_warn("SELinux: failure in %s(), invalid network interface (%d)\n",
+		pr_warn("failure in %s(), invalid network interface (%d)\n",
 			__func__, ifindex);
 		return -ENOENT;
 	}
@@ -176,7 +179,7 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 	spin_unlock_bh(&sel_netif_lock);
 	dev_put(dev);
 	if (unlikely(ret)) {
-		pr_warn("SELinux: failure in %s(), unable to determine network interface label (%d)\n",
+		pr_warn("failure in %s(), unable to determine network interface label (%d)\n",
 			__func__, ifindex);
 		kfree(new);
 	}
diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 8a8a72507437..d9a7176940a1 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -9,6 +9,9 @@
  * it under the terms of the GNU General Public License version 2,
  * as published by the Free Software Foundation.
  */
+
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -94,7 +97,7 @@ static void selnl_notify(int msgtype, void *data)
 out_kfree_skb:
 	kfree_skb(skb);
 oom:
-	pr_err("SELinux:  OOM in %s\n", __func__);
+	pr_err("OOM in %s\n", __func__);
 	goto out;
 }
 
@@ -117,7 +120,7 @@ static int __init selnl_init(void)
 
 	selnl = netlink_kernel_create(&init_net, NETLINK_SELINUX, &cfg);
 	if (selnl == NULL)
-		panic("SELinux:  Cannot create netlink socket.");
+		panic("SELinux: Cannot create netlink socket.");
 	return 0;
 }
 
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index afa0d432436b..ab86fd74c55a 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -28,6 +28,8 @@
  *
  */
 
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/types.h>
 #include <linux/rcupdate.h>
 #include <linux/list.h>
@@ -238,7 +240,7 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 out:
 	spin_unlock_bh(&sel_netnode_lock);
 	if (unlikely(ret)) {
-		pr_warn("SELinux: failure in %s(), unable to determine network node label\n",
+		pr_warn("failure in %s(), unable to determine network node label\n",
 			__func__);
 		kfree(new);
 	}
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 7a141cadbffc..74e61b081db7 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -27,6 +27,8 @@
  *
  */
 
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/types.h>
 #include <linux/rcupdate.h>
 #include <linux/list.h>
@@ -173,7 +175,7 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 out:
 	spin_unlock_bh(&sel_netport_lock);
 	if (unlikely(ret)) {
-		pr_warn("SELinux: failure in %s(), unable to determine network port label\n",
+		pr_warn("failure in %s(), unable to determine network port label\n",
 			__func__);
 		kfree(new);
 	}
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ac7ce7bba288..1e46a5841371 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -14,6 +14,8 @@
  *	the Free Software Foundation, version 2.
  */
 
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
@@ -515,19 +517,19 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi)
 
 	ret = sel_make_bools(fsi);
 	if (ret) {
-		pr_err("SELinux: failed to load policy booleans\n");
+		pr_err("failed to load policy booleans\n");
 		return ret;
 	}
 
 	ret = sel_make_classes(fsi);
 	if (ret) {
-		pr_err("SELinux: failed to load policy classes\n");
+		pr_err("failed to load policy classes\n");
 		return ret;
 	}
 
 	ret = sel_make_policycap(fsi);
 	if (ret) {
-		pr_err("SELinux: failed to load policy capabilities\n");
+		pr_err("failed to load policy capabilities\n");
 		return ret;
 	}
 
@@ -570,7 +572,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 	length = security_load_policy(fsi->state, data, count);
 	if (length) {
-		pr_warn_ratelimited("SELinux: failed to load policy\n");
+		pr_warn_ratelimited("failed to load policy\n");
 		goto out;
 	}
 
@@ -620,8 +622,8 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		pr_err("SELinux: %s:  context size (%u) exceeds "
-			"payload max\n", __func__, len);
+		pr_err("%s: context size (%u) exceeds payload max\n",
+		       __func__, len);
 		goto out;
 	}
 
@@ -956,8 +958,8 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		pr_err("SELinux: %s:  context size (%u) exceeds "
-			"payload max\n", __func__, len);
+		pr_err("%s: context size (%u) exceeds payload max\n",
+		       __func__, len);
 		goto out;
 	}
 
@@ -1147,8 +1149,8 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		pr_err("SELinux: %s:  context size (%u) exceeds "
-			"payload max\n", __func__, len);
+		pr_err("%s: context size (%u) exceeds payload max\n",
+		       __func__, len);
 		goto out;
 	}
 
@@ -1389,8 +1391,8 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
 		ret = security_genfs_sid(fsi->state, "selinuxfs", page,
 					 SECCLASS_FILE, &sid);
 		if (ret) {
-			pr_warn_ratelimited("SELinux: no sid found, defaulting to security isid for %s\n",
-					   page);
+			pr_warn_ratelimited("no sid found, defaulting to security isid for %s\n",
+					    page);
 			sid = SECINITSID_SECURITY;
 		}
 
@@ -1997,8 +1999,7 @@ static int sel_fill_super(struct super_block *sb, void *data, size_t data_size,
 		goto err;
 	return 0;
 err:
-	pr_err("SELinux: %s:  failed while creating inodes\n",
-		__func__);
+	pr_err("%s: failed while creating inodes\n", __func__);
 
 	selinux_fs_info_free(sb);
 
@@ -2048,14 +2049,14 @@ static int __init init_sel_fs(void)
 
 	selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
 	if (IS_ERR(selinuxfs_mount)) {
-		pr_err("selinuxfs:  could not mount!\n");
+		pr_err("selinuxfs: could not mount!\n");
 		err = PTR_ERR(selinuxfs_mount);
 		selinuxfs_mount = NULL;
 	}
 	selinux_null.dentry = d_hash_and_lookup(selinux_null.mnt->mnt_root,
 						&null_name);
 	if (IS_ERR(selinux_null.dentry)) {
-		pr_err("selinuxfs:  could not lookup null!\n");
+		pr_err("selinuxfs: could not lookup null!\n");
 		err = PTR_ERR(selinux_null.dentry);
 		selinux_null.dentry = NULL;
 	}
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index c0417cf17fee..81945845cd15 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -17,6 +17,8 @@
  *	Tuned number of hash slots for avtab to reduce memory usage
  */
 
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -338,8 +340,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 	h->nel = 0;
 	h->nslot = nslot;
 	h->mask = mask;
-	pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
-	       h->nslot, nrules);
+	pr_debug("%d avtab hash slots, %d rules\n", h->nslot, nrules);
 	return 0;
 }
 
@@ -368,10 +369,9 @@ void avtab_hash_eval(struct avtab *h, char *tag)
 		}
 	}
 
-	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
-	       "longest chain length %d sum of chain length^2 %llu\n",
-	       tag, h->nel, slots_used, h->nslot, max_chain_len,
-	       chain2_len_sum);
+	pr_debug("%s: %d entries and %d/%d buckets used, longest chain length %d sum of chain length^2 %llu\n",
+		 tag, h->nel, slots_used, h->nslot, max_chain_len,
+		 chain2_len_sum);
 }
 
 static uint16_t spec_order[] = {
@@ -407,18 +407,18 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	if (vers < POLICYDB_VERSION_AVTAB) {
 		rc = next_entry(buf32, fp, sizeof(u32));
 		if (rc) {
-			pr_err("SELinux: avtab: truncated entry\n");
+			pr_err("avtab: truncated entry\n");
 			return rc;
 		}
 		items2 = le32_to_cpu(buf32[0]);
 		if (items2 > ARRAY_SIZE(buf32)) {
-			pr_err("SELinux: avtab: entry overflow\n");
+			pr_err("avtab: entry overflow\n");
 			return -EINVAL;
 
 		}
 		rc = next_entry(buf32, fp, sizeof(u32)*items2);
 		if (rc) {
-			pr_err("SELinux: avtab: truncated entry\n");
+			pr_err("avtab: truncated entry\n");
 			return rc;
 		}
 		items = 0;
@@ -426,19 +426,19 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		val = le32_to_cpu(buf32[items++]);
 		key.source_type = (u16)val;
 		if (key.source_type != val) {
-			pr_err("SELinux: avtab: truncated source type\n");
+			pr_err("avtab: truncated source type\n");
 			return -EINVAL;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_type = (u16)val;
 		if (key.target_type != val) {
-			pr_err("SELinux: avtab: truncated target type\n");
+			pr_err("avtab: truncated target type\n");
 			return -EINVAL;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_class = (u16)val;
 		if (key.target_class != val) {
-			pr_err("SELinux: avtab: truncated target class\n");
+			pr_err("avtab: truncated target class\n");
 			return -EINVAL;
 		}
 
@@ -446,16 +446,16 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
 
 		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
-			pr_err("SELinux: avtab: null entry\n");
+			pr_err("avtab: null entry\n");
 			return -EINVAL;
 		}
 		if ((val & AVTAB_AV) &&
 		    (val & AVTAB_TYPE)) {
-			pr_err("SELinux: avtab: entry has both access vectors and types\n");
+			pr_err("avtab: entry has both access vectors and types\n");
 			return -EINVAL;
 		}
 		if (val & AVTAB_XPERMS) {
-			pr_err("SELinux: avtab: entry has extended permissions\n");
+			pr_err("avtab: entry has extended permissions\n");
 			return -EINVAL;
 		}
 
@@ -470,7 +470,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		}
 
 		if (items != items2) {
-			pr_err("SELinux: avtab: entry only had %d items, expected %d\n",
+			pr_err("avtab: entry only had %d items, expected %d\n",
 			       items2, items);
 			return -EINVAL;
 		}
@@ -479,7 +479,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 
 	rc = next_entry(buf16, fp, sizeof(u16)*4);
 	if (rc) {
-		pr_err("SELinux: avtab: truncated entry\n");
+		pr_err("avtab: truncated entry\n");
 		return rc;
 	}
 
@@ -492,7 +492,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	if (!policydb_type_isvalid(pol, key.source_type) ||
 	    !policydb_type_isvalid(pol, key.target_type) ||
 	    !policydb_class_isvalid(pol, key.target_class)) {
-		pr_err("SELinux: avtab: invalid type or class\n");
+		pr_err("avtab: invalid type or class\n");
 		return -EINVAL;
 	}
 
@@ -502,31 +502,30 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 			set++;
 	}
 	if (!set || set > 1) {
-		pr_err("SELinux:  avtab:  more than one specifier\n");
+		pr_err("avtab: more than one specifier\n");
 		return -EINVAL;
 	}
 
 	if ((vers < POLICYDB_VERSION_XPERMS_IOCTL) &&
 			(key.specified & AVTAB_XPERMS)) {
-		pr_err("SELinux:  avtab:  policy version %u does not "
-				"support extended permissions rules and one "
-				"was specified\n", vers);
+		pr_err("avtab: policy version %u does not support extended permissions rules and one was specified\n",
+		       vers);
 		return -EINVAL;
 	} else if (key.specified & AVTAB_XPERMS) {
 		memset(&xperms, 0, sizeof(struct avtab_extended_perms));
 		rc = next_entry(&xperms.specified, fp, sizeof(u8));
 		if (rc) {
-			pr_err("SELinux: avtab: truncated entry\n");
+			pr_err("avtab: truncated entry\n");
 			return rc;
 		}
 		rc = next_entry(&xperms.driver, fp, sizeof(u8));
 		if (rc) {
-			pr_err("SELinux: avtab: truncated entry\n");
+			pr_err("avtab: truncated entry\n");
 			return rc;
 		}
 		rc = next_entry(buf32, fp, sizeof(u32)*ARRAY_SIZE(xperms.perms.p));
 		if (rc) {
-			pr_err("SELinux: avtab: truncated entry\n");
+			pr_err("avtab: truncated entry\n");
 			return rc;
 		}
 		for (i = 0; i < ARRAY_SIZE(xperms.perms.p); i++)
@@ -535,14 +534,14 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	} else {
 		rc = next_entry(buf32, fp, sizeof(u32));
 		if (rc) {
-			pr_err("SELinux: avtab: truncated entry\n");
+			pr_err("avtab: truncated entry\n");
 			return rc;
 		}
 		datum.u.data = le32_to_cpu(*buf32);
 	}
 	if ((key.specified & AVTAB_TYPE) &&
 	    !policydb_type_isvalid(pol, datum.u.data)) {
-		pr_err("SELinux: avtab: invalid type\n");
+		pr_err("avtab: invalid type\n");
 		return -EINVAL;
 	}
 	return insertf(a, &key, &datum, p);
@@ -563,12 +562,12 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc < 0) {
-		pr_err("SELinux: avtab: truncated table\n");
+		pr_err("avtab: truncated table\n");
 		goto bad;
 	}
 	nel = le32_to_cpu(buf[0]);
 	if (!nel) {
-		pr_err("SELinux: avtab: table is empty\n");
+		pr_err("avtab: table is empty\n");
 		rc = -EINVAL;
 		goto bad;
 	}
@@ -581,9 +580,9 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
 		if (rc) {
 			if (rc == -ENOMEM)
-				pr_err("SELinux: avtab: out of memory\n");
+				pr_err("avtab: out of memory\n");
 			else if (rc == -EEXIST)
-				pr_err("SELinux: avtab: duplicate entry\n");
+				pr_err("avtab: duplicate entry\n");
 
 			goto bad;
 		}
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index f49e522e932d..e96820d92b61 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -7,6 +7,8 @@
  *	the Free Software Foundation, version 2.
  */
 
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -96,7 +98,7 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
 	if (new_state != node->cur_state) {
 		node->cur_state = new_state;
 		if (new_state == -1)
-			pr_err("SELinux: expression result was undefined - disabling all rules.\n");
+			pr_err("expression result was undefined - disabling all rules\n");
 		/* turn the rules on or off */
 		for (cur = node->true_list; cur; cur = cur->next) {
 			if (new_state <= 0)
@@ -287,7 +289,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 	 */
 	if (k->specified & AVTAB_TYPE) {
 		if (avtab_search(&p->te_avtab, k)) {
-			pr_err("SELinux: type rule already exists outside of a conditional.\n");
+			pr_err("type rule already exists outside of a conditional\n");
 			goto err;
 		}
 		/*
@@ -302,7 +304,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
 			if (node_ptr) {
 				if (avtab_search_node_next(node_ptr, k->specified)) {
-					pr_err("SELinux: too many conflicting type rules.\n");
+					pr_err("too many conflicting type rules\n");
 					goto err;
 				}
 				found = 0;
@@ -313,13 +315,13 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 					}
 				}
 				if (!found) {
-					pr_err("SELinux: conflicting type rules.\n");
+					pr_err("conflicting type rules\n");
 					goto err;
 				}
 			}
 		} else {
 			if (avtab_search(&p->te_cond_avtab, k)) {
-				pr_err("SELinux: conflicting type rules when adding type rule for true.\n");
+				pr_err("conflicting type rules when adding type rule for true\n");
 				goto err;
 			}
 		}
@@ -327,7 +329,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 
 	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
 	if (!node_ptr) {
-		pr_err("SELinux: could not insert rule.\n");
+		pr_err("could not insert rule\n");
 		rc = -ENOMEM;
 		goto err;
 	}
@@ -387,12 +389,12 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
-		pr_err("SELinux: conditional expressions uses unknown operator.\n");
+		pr_err("conditional expressions uses unknown operator\n");
 		return 0;
 	}
 
 	if (expr->bool > p->p_bools.nprim) {
-		pr_err("SELinux: conditional expressions uses unknown bool.\n");
+		pr_err("conditional expressions uses unknown bool\n");
 		return 0;
 	}
 	return 1;
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 8f624f80055b..50d5470ec3ca 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -16,6 +16,8 @@
  *      Applied standard bit operations to improve bitmap scanning.
  */
 
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
@@ -362,8 +364,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	count = le32_to_cpu(buf[2]);
 
 	if (mapunit != BITS_PER_U64) {
-		pr_err("SELinux: ebitmap: map size %u does not "
-		       "match my size %zd (high bit was %d)\n",
+		pr_err("ebitmap: map size %u does not match my size %zd (high bit was %d)\n",
 		       mapunit, BITS_PER_U64, e->highbit);
 		goto bad;
 	}
@@ -383,20 +384,18 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	for (i = 0; i < count; i++) {
 		rc = next_entry(&startbit, fp, sizeof(u32));
 		if (rc < 0) {
-			pr_err("SELinux: ebitmap: truncated map\n");
+			pr_err("ebitmap: truncated map\n");
 			goto bad;
 		}
 		startbit = le32_to_cpu(startbit);
 
 		if (startbit & (mapunit - 1)) {
-			pr_err("SELinux: ebitmap start bit (%d) is "
-			       "not a multiple of the map unit size (%u)\n",
+			pr_err("ebitmap start bit (%d) is not a multiple of the map unit size (%u)\n",
 			       startbit, mapunit);
 			goto bad;
 		}
 		if (startbit > e->highbit - mapunit) {
-			pr_err("SELinux: ebitmap start bit (%d) is "
-			       "beyond the end of the bitmap (%u)\n",
+			pr_err("ebitmap start bit (%d) is beyond the end of the bitmap (%u)\n",
 			       startbit, (e->highbit - mapunit));
 			goto bad;
 		}
@@ -405,7 +404,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 			struct ebitmap_node *tmp;
 			tmp = kmem_cache_zalloc(ebitmap_node_cachep, GFP_KERNEL);
 			if (!tmp) {
-				pr_err("SELinux: ebitmap: out of memory\n");
+				pr_err("ebitmap: out of memory\n");
 				rc = -ENOMEM;
 				goto bad;
 			}
@@ -417,15 +416,14 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 				e->node = tmp;
 			n = tmp;
 		} else if (startbit <= n->startbit) {
-			pr_err("SELinux: ebitmap: start bit %d"
-			       " comes after start bit %d\n",
+			pr_err("ebitmap: start bit %d comes after start bit %d\n",
 			       startbit, n->startbit);
 			goto bad;
 		}
 
 		rc = next_entry(&map, fp, sizeof(u64));
 		if (rc < 0) {
-			pr_err("SELinux: ebitmap: truncated map\n");
+			pr_err("ebitmap: truncated map\n");
 			goto bad;
 		}
 		map = le64_to_cpu(map);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e9394e7adc84..01433d4bf51a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -30,6 +30,8 @@
  *	the Free Software Foundation, version 2.
  */
 
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -504,9 +506,9 @@ static void hash_eval(struct hashtab *h, const char *hash_name)
 	struct hashtab_info info;
 
 	hashtab_stat(h, &info);
-	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
-	       "longest chain length %d\n", hash_name, h->nel,
-	       info.slots_used, h->size, info.max_chain_len);
+	pr_debug("%s: %d entries and %d/%d buckets used, longest chain length %d\n",
+		 hash_name, h->nel,
+		 info.slots_used, h->size, info.max_chain_len);
 }
 
 static void symtab_hash_eval(struct symtab *s)
@@ -534,16 +536,15 @@ static int policydb_index(struct policydb *p)
 	int i, rc;
 
 	if (p->mls_enabled)
-		pr_debug("SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats\n",
+		pr_debug("%d users, %d roles, %d types, %d bools, %d sens, %d cats\n",
 			 p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
 			 p->p_bools.nprim, p->p_levels.nprim, p->p_cats.nprim);
 	else
-		pr_debug("SELinux:  %d users, %d roles, %d types, %d bools\n",
+		pr_debug("%d users, %d roles, %d types, %d bools\n",
 			 p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
 			 p->p_bools.nprim);
 
-	pr_debug("SELinux:  %d classes, %d rules\n",
-		 p->p_classes.nprim, p->te_avtab.nel);
+	pr_debug("%d classes, %d rules\n", p->p_classes.nprim, p->te_avtab.nel);
 
 #ifdef DEBUG_HASHES
 	avtab_hash_eval(&p->te_avtab, "rules");
@@ -899,7 +900,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 
 	rc = sidtab_init(s);
 	if (rc) {
-		pr_err("SELinux:  out of memory on SID table init\n");
+		pr_err("out of memory on SID table init\n");
 		goto out;
 	}
 
@@ -907,15 +908,13 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	for (c = head; c; c = c->next) {
 		rc = -EINVAL;
 		if (!c->context[0].user) {
-			pr_err("SELinux:  SID %s was never defined.\n",
-				c->u.name);
+			pr_err("SID %s was never defined\n", c->u.name);
 			goto out;
 		}
 
 		rc = sidtab_insert(s, c->sid[0], &c->context[0]);
 		if (rc) {
-			pr_err("SELinux:  unable to load initial SID %s.\n",
-				c->u.name);
+			pr_err("unable to load initial SID %s\n", c->u.name);
 			goto out;
 		}
 	}
@@ -1007,13 +1006,13 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 	rc = -EINVAL;
 	items = le32_to_cpu(buf[0]);
 	if (items > ARRAY_SIZE(buf)) {
-		pr_err("SELinux: mls:  range overflow\n");
+		pr_err("mls: range overflow\n");
 		goto out;
 	}
 
 	rc = next_entry(buf, fp, sizeof(u32) * items);
 	if (rc) {
-		pr_err("SELinux: mls:  truncated range\n");
+		pr_err("mls: truncated range\n");
 		goto out;
 	}
 
@@ -1025,19 +1024,19 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 
 	rc = ebitmap_read(&r->level[0].cat, fp);
 	if (rc) {
-		pr_err("SELinux: mls:  error reading low categories\n");
+		pr_err("mls: error reading low categories\n");
 		goto out;
 	}
 	if (items > 1) {
 		rc = ebitmap_read(&r->level[1].cat, fp);
 		if (rc) {
-			pr_err("SELinux: mls:  error reading high categories\n");
+			pr_err("mls: error reading high categories\n");
 			goto bad_high;
 		}
 	} else {
 		rc = ebitmap_cpy(&r->level[1].cat, &r->level[0].cat);
 		if (rc) {
-			pr_err("SELinux: mls:  out of memory\n");
+			pr_err("mls: out of memory\n");
 			goto bad_high;
 		}
 	}
@@ -1062,7 +1061,7 @@ static int context_read_and_validate(struct context *c,
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc) {
-		pr_err("SELinux: context truncated\n");
+		pr_err("context truncated\n");
 		goto out;
 	}
 	c->user = le32_to_cpu(buf[0]);
@@ -1071,14 +1070,14 @@ static int context_read_and_validate(struct context *c,
 	if (p->policyvers >= POLICYDB_VERSION_MLS) {
 		rc = mls_read_range_helper(&c->range, fp);
 		if (rc) {
-			pr_err("SELinux: error reading MLS range of context\n");
+			pr_err("error reading MLS range of context\n");
 			goto out;
 		}
 	}
 
 	rc = -EINVAL;
 	if (!policydb_context_isvalid(p, c)) {
-		pr_err("SELinux:  invalid security context\n");
+		pr_err("invalid security context\n");
 		context_destroy(c);
 		goto out;
 	}
@@ -1354,8 +1353,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 		rc = -EINVAL;
 		cladatum->comdatum = hashtab_search(p->p_commons.table, cladatum->comkey);
 		if (!cladatum->comdatum) {
-			pr_err("SELinux:  unknown common %s\n",
-			       cladatum->comkey);
+			pr_err("unknown common %s\n", cladatum->comkey);
 			goto bad;
 		}
 	}
@@ -1447,7 +1445,7 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (strcmp(key, OBJECT_R) == 0) {
 		rc = -EINVAL;
 		if (role->value != OBJECT_R_VAL) {
-			pr_err("SELinux: Role %s has wrong value %d\n",
+			pr_err("Role %s has wrong value %d\n",
 			       OBJECT_R, role->value);
 			goto bad;
 		}
@@ -1525,14 +1523,14 @@ static int mls_read_level(struct mls_level *lp, void *fp)
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc) {
-		pr_err("SELinux: mls: truncated level\n");
+		pr_err("mls: truncated level\n");
 		return rc;
 	}
 	lp->sens = le32_to_cpu(buf[0]);
 
 	rc = ebitmap_read(&lp->cat, fp);
 	if (rc) {
-		pr_err("SELinux: mls:  error reading level categories\n");
+		pr_err("mls: error reading level categories\n");
 		return rc;
 	}
 	return 0;
@@ -1686,8 +1684,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 		unsigned long bit;
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
-			pr_err("SELinux: user %s: "
-			       "too deep or looped boundary",
+			pr_err("user %s: too deep or looped boundary\n",
 			       (char *) key);
 			return -EINVAL;
 		}
@@ -1697,8 +1694,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 			if (ebitmap_get_bit(&upper->roles, bit))
 				continue;
 
-			pr_err("SELinux: boundary violated policy: "
-			       "user=%s role=%s bounds=%s\n",
+			pr_err("boundary violated policy: user=%s role=%s bounds=%s\n",
 			       sym_name(p, SYM_USERS, user->value - 1),
 			       sym_name(p, SYM_ROLES, bit),
 			       sym_name(p, SYM_USERS, upper->value - 1));
@@ -1722,9 +1718,8 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 		unsigned long bit;
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
-			pr_err("SELinux: role %s: "
-			       "too deep or looped bounds\n",
-			       (char *) key);
+			pr_err("role %s: too deep or looped bounds\n",
+			       (char *)key);
 			return -EINVAL;
 		}
 
@@ -1733,8 +1728,7 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 			if (ebitmap_get_bit(&upper->types, bit))
 				continue;
 
-			pr_err("SELinux: boundary violated policy: "
-			       "role=%s type=%s bounds=%s\n",
+			pr_err("boundary violated policy: role=%s type=%s bounds=%s\n",
 			       sym_name(p, SYM_ROLES, role->value - 1),
 			       sym_name(p, SYM_TYPES, bit),
 			       sym_name(p, SYM_ROLES, upper->value - 1));
@@ -1755,9 +1749,8 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 	upper = datum;
 	while (upper->bounds) {
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
-			pr_err("SELinux: type %s: "
-			       "too deep or looped boundary\n",
-			       (char *) key);
+			pr_err("type %s: too deep or looped boundary\n",
+			       (char *)key);
 			return -EINVAL;
 		}
 
@@ -1766,9 +1759,8 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 		BUG_ON(!upper);
 
 		if (upper->attribute) {
-			pr_err("SELinux: type %s: "
-			       "bounded by attribute %s",
-			       (char *) key,
+			pr_err("type %s: bounded by attribute %s\n",
+			       (char *)key,
 			       sym_name(p, SYM_TYPES, upper->value - 1));
 			return -EINVAL;
 		}
@@ -1889,7 +1881,7 @@ static int range_read(struct policydb *p, void *fp)
 
 		rc = -EINVAL;
 		if (!mls_range_isvalid(p, r)) {
-			pr_warn("SELinux:  rangetrans:  invalid range\n");
+			pr_warn("rangetrans: invalid range\n");
 			goto out;
 		}
 
@@ -2024,7 +2016,7 @@ static int genfs_read(struct policydb *p, void *fp)
 		     genfs_p = genfs, genfs = genfs->next) {
 			rc = -EINVAL;
 			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
-				pr_err("SELinux:  dup genfs fstype %s\n",
+				pr_err("dup genfs fstype %s\n",
 				       newgenfs->fstype);
 				goto out;
 			}
@@ -2074,7 +2066,7 @@ static int genfs_read(struct policydb *p, void *fp)
 				if (!strcmp(newc->u.name, c->u.name) &&
 				    (!c->v.sclass || !newc->v.sclass ||
 				     newc->v.sclass == c->v.sclass)) {
-					pr_err("SELinux:  dup genfs entry (%s,%s)\n",
+					pr_err("dup genfs entry (%s,%s)\n",
 					       genfs->fstype, c->u.name);
 					goto out;
 				}
@@ -2296,8 +2288,7 @@ int policydb_read(struct policydb *p, void *fp)
 
 	rc = -EINVAL;
 	if (le32_to_cpu(buf[0]) != POLICYDB_MAGIC) {
-		pr_err("SELinux:  policydb magic number 0x%x does "
-		       "not match expected magic number 0x%x\n",
+		pr_err("policydb magic number 0x%x does not match expected magic number 0x%x\n",
 		       le32_to_cpu(buf[0]), POLICYDB_MAGIC);
 		goto bad;
 	}
@@ -2305,8 +2296,7 @@ int policydb_read(struct policydb *p, void *fp)
 	rc = -EINVAL;
 	len = le32_to_cpu(buf[1]);
 	if (len != strlen(POLICYDB_STRING)) {
-		pr_err("SELinux:  policydb string length %d does not "
-		       "match expected length %zu\n",
+		pr_err("policydb string length %d does not match expected length %zu\n",
 		       len, strlen(POLICYDB_STRING));
 		goto bad;
 	}
@@ -2314,14 +2304,14 @@ int policydb_read(struct policydb *p, void *fp)
 	rc = -ENOMEM;
 	policydb_str = kmalloc(len + 1, GFP_KERNEL);
 	if (!policydb_str) {
-		pr_err("SELinux:  unable to allocate memory for policydb "
-		       "string of length %d\n", len);
+		pr_err("unable to allocate memory for policydb string of length %d\n",
+		       len);
 		goto bad;
 	}
 
 	rc = next_entry(policydb_str, fp, len);
 	if (rc) {
-		pr_err("SELinux:  truncated policydb string identifier\n");
+		pr_err("truncated policydb string identifier\n");
 		kfree(policydb_str);
 		goto bad;
 	}
@@ -2329,8 +2319,8 @@ int policydb_read(struct policydb *p, void *fp)
 	rc = -EINVAL;
 	policydb_str[len] = '\0';
 	if (strcmp(policydb_str, POLICYDB_STRING)) {
-		pr_err("SELinux:  policydb string %s does not match "
-		       "my string %s\n", policydb_str, POLICYDB_STRING);
+		pr_err("policydb string %s does not match my string %s\n",
+		       policydb_str, POLICYDB_STRING);
 		kfree(policydb_str);
 		goto bad;
 	}
@@ -2347,9 +2337,9 @@ int policydb_read(struct policydb *p, void *fp)
 	p->policyvers = le32_to_cpu(buf[0]);
 	if (p->policyvers < POLICYDB_VERSION_MIN ||
 	    p->policyvers > POLICYDB_VERSION_MAX) {
-		pr_err("SELinux:  policydb version %d does not match "
-		       "my version range %d-%d\n",
-		       le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
+		pr_err("policydb version %d does not match my version range %d-%d\n",
+		       le32_to_cpu(buf[0]),
+		       POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 		goto bad;
 	}
 
@@ -2358,9 +2348,8 @@ int policydb_read(struct policydb *p, void *fp)
 
 		rc = -EINVAL;
 		if (p->policyvers < POLICYDB_VERSION_MLS) {
-			pr_err("SELinux: security policydb version %d "
-				"(MLS) not backwards compatible\n",
-				p->policyvers);
+			pr_err("security policydb version %d (MLS) not backwards compatible\n",
+			       p->policyvers);
 			goto bad;
 		}
 	}
@@ -2382,17 +2371,16 @@ int policydb_read(struct policydb *p, void *fp)
 	rc = -EINVAL;
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
-		pr_err("SELinux:  unable to find policy compat info "
-		       "for version %d\n", p->policyvers);
+		pr_err("unable to find policy compat info for version %d\n",
+		       p->policyvers);
 		goto bad;
 	}
 
 	rc = -EINVAL;
 	if (le32_to_cpu(buf[2]) != info->sym_num ||
 		le32_to_cpu(buf[3]) != info->ocon_num) {
-		pr_err("SELinux:  policydb table sizes (%d,%d) do "
-		       "not match mine (%d,%d)\n", le32_to_cpu(buf[2]),
-			le32_to_cpu(buf[3]),
+		pr_err("policydb table sizes (%d,%d) do not match mine (%d,%d)\n",
+		       le32_to_cpu(buf[2]), le32_to_cpu(buf[3]),
 		       info->sym_num, info->ocon_num);
 		goto bad;
 	}
@@ -3418,9 +3406,8 @@ int policydb_write(struct policydb *p, void *fp)
 	 * careful if you ever try to remove this restriction
 	 */
 	if (p->policyvers < POLICYDB_VERSION_AVTAB) {
-		pr_err("SELinux: refusing to write policy version %d."
-		       "  Because it is less than version %d\n", p->policyvers,
-		       POLICYDB_VERSION_AVTAB);
+		pr_err("refusing to write policy version %d because it is less than version %d\n",
+		       p->policyvers, POLICYDB_VERSION_AVTAB);
 		return -EINVAL;
 	}
 
@@ -3447,8 +3434,8 @@ int policydb_write(struct policydb *p, void *fp)
 	/* Write the version, config, and table sizes. */
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
-		pr_err("SELinux: compatibility lookup failed for policy "
-		    "version %d", p->policyvers);
+		pr_err("compatibility lookup failed for policy version %d\n",
+		       p->policyvers);
 		return -EINVAL;
 	}
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f3def298a90e..a2e7f1773c74 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -39,6 +39,9 @@
  *	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
  */
+
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -136,8 +139,7 @@ static int selinux_set_mapping(struct policydb *pol,
 
 		p_out->value = string_to_security_class(pol, p_in->name);
 		if (!p_out->value) {
-			pr_info("SELinux:  Class %s not defined in policy.\n",
-			       p_in->name);
+			pr_info("Class %s not defined in policy\n", p_in->name);
 			if (pol->reject_unknown)
 				goto err;
 			p_out->num_perms = 0;
@@ -155,8 +157,8 @@ static int selinux_set_mapping(struct policydb *pol,
 			p_out->perms[k] = string_to_av_perm(pol, p_out->value,
 							    p_in->perms[k]);
 			if (!p_out->perms[k]) {
-				pr_info("SELinux:  Permission %s in class %s not defined in policy.\n",
-				       p_in->perms[k], p_in->name);
+				pr_info("Permission %s in class %s not defined in policy\n",
+					p_in->perms[k], p_in->name);
 				if (pol->reject_unknown)
 					goto err;
 				print_unknown_handle = true;
@@ -168,8 +170,8 @@ static int selinux_set_mapping(struct policydb *pol,
 	}
 
 	if (print_unknown_handle)
-		pr_info("SELinux: the above unknown classes and permissions will be %s\n",
-		       pol->allow_unknown ? "allowed" : "denied");
+		pr_info("the above unknown classes and permissions will be %s\n",
+			pol->allow_unknown ? "allowed" : "denied");
 
 	out_map->size = i;
 	return 0;
@@ -642,7 +644,7 @@ static void context_struct_compute_av(struct policydb *policydb,
 
 	if (unlikely(!tclass || tclass > policydb->p_classes.nprim)) {
 		if (printk_ratelimit())
-			pr_warn("SELinux:  Invalid class %hu\n", tclass);
+			pr_warn("Invalid class %hu\n", tclass);
 		return;
 	}
 
@@ -791,24 +793,21 @@ static int security_compute_validatetrans(struct selinux_state *state,
 
 	ocontext = sidtab_search(sidtab, oldsid);
 	if (!ocontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-			__func__, oldsid);
+		pr_err("%s: unrecognized SID %d\n", __func__, oldsid);
 		rc = -EINVAL;
 		goto out;
 	}
 
 	ncontext = sidtab_search(sidtab, newsid);
 	if (!ncontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-			__func__, newsid);
+		pr_err("%s: unrecognized SID %d\n", __func__, newsid);
 		rc = -EINVAL;
 		goto out;
 	}
 
 	tcontext = sidtab_search(sidtab, tasksid);
 	if (!tcontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-			__func__, tasksid);
+		pr_err("%s: unrecognized SID %d\n", __func__, tasksid);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -881,16 +880,14 @@ int security_bounded_transition(struct selinux_state *state,
 	rc = -EINVAL;
 	old_context = sidtab_search(sidtab, old_sid);
 	if (!old_context) {
-		pr_err("SELinux: %s: unrecognized SID %u\n",
-		       __func__, old_sid);
+		pr_err("%s: unrecognized SID %u\n", __func__, old_sid);
 		goto out;
 	}
 
 	rc = -EINVAL;
 	new_context = sidtab_search(sidtab, new_sid);
 	if (!new_context) {
-		pr_err("SELinux: %s: unrecognized SID %u\n",
-		       __func__, new_sid);
+		pr_err("%s: unrecognized SID %u\n", __func__, new_sid);
 		goto out;
 	}
 
@@ -1038,15 +1035,13 @@ void security_compute_xperms_decision(struct selinux_state *state,
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-		       __func__, ssid);
+		pr_err("%s: unrecognized SID %d\n", __func__, ssid);
 		goto out;
 	}
 
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-		       __func__, tsid);
+		pr_err("%s: unrecognized SID %d\n", __func__, tsid);
 		goto out;
 	}
 
@@ -1059,7 +1054,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 
 
 	if (unlikely(!tclass || tclass > policydb->p_classes.nprim)) {
-		pr_warn_ratelimited("SELinux:  Invalid class %hu\n", tclass);
+		pr_warn_ratelimited("Invalid class %hu\n", tclass);
 		goto out;
 	}
 
@@ -1127,8 +1122,7 @@ void security_compute_av(struct selinux_state *state,
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-		       __func__, ssid);
+		pr_err("%s: unrecognized SID %d\n", __func__, ssid);
 		goto out;
 	}
 
@@ -1138,8 +1132,7 @@ void security_compute_av(struct selinux_state *state,
 
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-		       __func__, tsid);
+		pr_err("%s: unrecognized SID %d\n", __func__, tsid);
 		goto out;
 	}
 
@@ -1181,8 +1174,7 @@ void security_compute_av_user(struct selinux_state *state,
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-		       __func__, ssid);
+		pr_err("%s: unrecognized SID %d\n", __func__, ssid);
 		goto out;
 	}
 
@@ -1192,8 +1184,7 @@ void security_compute_av_user(struct selinux_state *state,
 
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-		       __func__, tsid);
+		pr_err("%s: unrecognized SID %d\n", __func__, tsid);
 		goto out;
 	}
 
@@ -1308,8 +1299,8 @@ static int security_sid_to_context_core(struct selinux_state *state,
 			*scontext = scontextp;
 			goto out;
 		}
-		pr_err("SELinux: %s:  called before initial "
-		       "load_policy on unknown SID %d\n", __func__, sid);
+		pr_err("%s: called before initial load_policy on unknown SID %d\n",
+		       __func__, sid);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -1321,8 +1312,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 	else
 		context = sidtab_search(sidtab, sid);
 	if (!context) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-			__func__, sid);
+		pr_err("%s: unrecognized SID %d\n", __func__, sid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
@@ -1676,15 +1666,13 @@ static int security_compute_sid(struct selinux_state *state,
 
 	scontext = sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-		       __func__, ssid);
+		pr_err("%s: unrecognized SID %d\n", __func__, ssid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
 	tcontext = sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-		       __func__, tsid);
+		pr_err("%s: unrecognized SID %d\n", __func__, tsid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
@@ -1909,8 +1897,7 @@ static inline int convert_context_handle_invalid_context(
 		return -EINVAL;
 
 	if (!context_struct_to_string(policydb, context, &s, &len)) {
-		pr_warn("SELinux:  Context %s would be invalid if enforcing\n",
-			s);
+		pr_warn("Context %s would be invalid if enforcing\n", s);
 		kfree(s);
 	}
 	return 0;
@@ -1961,8 +1948,7 @@ static int convert_context(u32 key,
 					      c->len, &ctx, SECSID_NULL);
 		kfree(s);
 		if (!rc) {
-			pr_info("SELinux:  Context %s became valid (mapped).\n",
-			       c->str);
+			pr_info("Context %s became valid (mapped)\n", c->str);
 			/* Replace string with mapped representation. */
 			kfree(c->str);
 			memcpy(c, &ctx, sizeof(*c));
@@ -1973,7 +1959,7 @@ static int convert_context(u32 key,
 			goto out;
 		} else {
 			/* Other error condition, e.g. ENOMEM. */
-			pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
+			pr_err("Unable to map context %s, rc = %d\n",
 			       c->str, -rc);
 			goto out;
 		}
@@ -2032,8 +2018,7 @@ static int convert_context(u32 key,
 			oc = oc->next;
 		rc = -EINVAL;
 		if (!oc) {
-			pr_err("SELinux:  unable to look up"
-				" the initial SIDs list\n");
+			pr_err("unable to look up the initial SIDs list\n");
 			goto bad;
 		}
 		range = &oc->context[0].range;
@@ -2064,8 +2049,7 @@ static int convert_context(u32 key,
 	context_destroy(c);
 	c->str = s;
 	c->len = len;
-	pr_info("SELinux:  Context %s became invalid (unmapped).\n",
-	       c->str);
+	pr_info("Context %s became invalid (unmapped)\n", c->str);
 	rc = 0;
 	goto out;
 }
@@ -2080,14 +2064,13 @@ static void security_load_policycaps(struct selinux_state *state)
 		state->policycap[i] = ebitmap_get_bit(&p->policycaps, i);
 
 	for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
-		pr_info("SELinux:  policy capability %s=%d\n",
+		pr_info("policy capability %s=%d\n",
 			selinux_policycap_names[i],
 			ebitmap_get_bit(&p->policycaps, i));
 
 	ebitmap_for_each_positive_bit(&p->policycaps, node, i) {
 		if (i >= ARRAY_SIZE(selinux_policycap_names))
-			pr_info("SELinux:  unknown policy capability %u\n",
-				i);
+			pr_info("unknown policy capability %u\n", i);
 	}
 }
 
@@ -2169,13 +2152,13 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	newpolicydb->len = len;
 	/* If switching between different policy types, log MLS status */
 	if (policydb->mls_enabled && !newpolicydb->mls_enabled)
-		pr_info("SELinux: Disabling MLS support...\n");
+		pr_info("Disabling MLS support...\n");
 	else if (!policydb->mls_enabled && newpolicydb->mls_enabled)
-		pr_info("SELinux: Enabling MLS support...\n");
+		pr_info("Enabling MLS support...\n");
 
 	rc = policydb_load_isids(newpolicydb, &newsidtab);
 	if (rc) {
-		pr_err("SELinux:  unable to load the initial SIDs\n");
+		pr_err("unable to load the initial SIDs\n");
 		policydb_destroy(newpolicydb);
 		goto out;
 	}
@@ -2186,7 +2169,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 
 	rc = security_preserve_bools(state, newpolicydb);
 	if (rc) {
-		pr_err("SELinux:  unable to preserve booleans\n");
+		pr_err("unable to preserve booleans\n");
 		goto err;
 	}
 
@@ -2206,9 +2189,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	args.newp = newpolicydb;
 	rc = sidtab_map(&newsidtab, convert_context, &args);
 	if (rc) {
-		pr_err("SELinux:  unable to convert the internal"
-			" representation of contexts in the new SID"
-			" table\n");
+		pr_err("unable to convert the internal representation of contexts in the new SID table\n");
 		goto err;
 	}
 
@@ -2998,16 +2979,14 @@ int security_sid_mls_copy(struct selinux_state *state,
 	rc = -EINVAL;
 	context1 = sidtab_search(sidtab, sid);
 	if (!context1) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-			__func__, sid);
+		pr_err("%s: unrecognized SID %d\n", __func__, sid);
 		goto out_unlock;
 	}
 
 	rc = -EINVAL;
 	context2 = sidtab_search(sidtab, mls_sid);
 	if (!context2) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-			__func__, mls_sid);
+		pr_err("%s: unrecognized SID %d\n", __func__, mls_sid);
 		goto out_unlock;
 	}
 
@@ -3103,15 +3082,13 @@ int security_net_peersid_resolve(struct selinux_state *state,
 	rc = -EINVAL;
 	nlbl_ctx = sidtab_search(sidtab, nlbl_sid);
 	if (!nlbl_ctx) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-		       __func__, nlbl_sid);
+		pr_err("%s: unrecognized SID %d\n", __func__, nlbl_sid);
 		goto out;
 	}
 	rc = -EINVAL;
 	xfrm_ctx = sidtab_search(sidtab, xfrm_sid);
 	if (!xfrm_ctx) {
-		pr_err("SELinux: %s:  unrecognized SID %d\n",
-		       __func__, xfrm_sid);
+		pr_err("%s: unrecognized SID %d\n", __func__, xfrm_sid);
 		goto out;
 	}
 	rc = (mls_context_cmp(nlbl_ctx, xfrm_ctx) ? 0 : -EACCES);
@@ -3201,8 +3178,7 @@ int security_get_permissions(struct selinux_state *state,
 	rc = -EINVAL;
 	match = hashtab_search(policydb->p_classes.table, class);
 	if (!match) {
-		pr_err("SELinux: %s:  unrecognized class %s\n",
-			__func__, class);
+		pr_err("%s: unrecognized class %s\n", __func__, class);
 		goto out;
 	}
 
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index fd75a12fa8fc..929573dda76e 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -4,6 +4,9 @@
  *
  * Author : Stephen Smalley, <sds@tycho.nsa.gov>
  */
+
+#define pr_fmt(fmt) "SELinux: " fmt
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -214,8 +217,8 @@ int sidtab_context_to_sid(struct sidtab *s,
 		}
 		sid = s->next_sid++;
 		if (context->len)
-			pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
-			       context->str);
+			pr_info("Context %s is not valid (left unmapped)\n",
+				context->str);
 		ret = sidtab_insert(s, sid, context);
 		if (ret)
 			s->next_sid--;
@@ -252,9 +255,8 @@ void sidtab_hash_eval(struct sidtab *h, char *tag)
 		}
 	}
 
-	pr_debug("%s:  %d entries and %d/%d buckets used, longest "
-	       "chain length %d\n", tag, h->nel, slots_used, SIDTAB_SIZE,
-	       max_chain_len);
+	pr_debug("%s: %d entries and %d/%d buckets used, longest chain length %d\n",
+		 tag, h->nel, slots_used, SIDTAB_SIZE, max_chain_len);
 }
 
 void sidtab_destroy(struct sidtab *s)
-- 
2.15.0
