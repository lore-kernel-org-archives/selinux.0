From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 Daniel Jurgens <danielj@mellanox.com>, Doug Ledford
 <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 12 Jun 2018 10:09:03 +0200
Message-ID: <20180612080912.7827-5-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 04/13] selinux: Cleanup printk logging in hooks
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/hooks.c | 68 +++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4cafe6a19167..3ab9687ac4c8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -531,7 +531,7 @@ static int sb_finish_set_opts(struct super_block *sb)
 		   the first boot of the SELinux kernel before we have
 		   assigned xattr values to the filesystem. */
 		if (!(root_inode->i_opflags & IOP_XATTR)) {
-			printk(KERN_WARNING "SELinux: (dev %s, type %s) has no "
+			pr_warn("SELinux: (dev %s, type %s) has no "
 			       "xattr support\n", sb->s_id, sb->s_type->name);
 			rc = -EOPNOTSUPP;
 			goto out;
@@ -540,11 +540,11 @@ static int sb_finish_set_opts(struct super_block *sb)
 		rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
 		if (rc < 0 && rc != -ENODATA) {
 			if (rc == -EOPNOTSUPP)
-				printk(KERN_WARNING "SELinux: (dev %s, type "
+				pr_warn("SELinux: (dev %s, type "
 				       "%s) has no security xattr handler\n",
 				       sb->s_id, sb->s_type->name);
 			else
-				printk(KERN_WARNING "SELinux: (dev %s, type "
+				pr_warn("SELinux: (dev %s, type "
 				       "%s) getxattr errno %d\n", sb->s_id,
 				       sb->s_type->name, -rc);
 			goto out;
@@ -743,7 +743,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			goto out;
 		}
 		rc = -EINVAL;
-		printk(KERN_WARNING "SELinux: Unable to set superblock options "
+		pr_warn("SELinux: Unable to set superblock options "
 			"before the security server is initialized\n");
 		goto out;
 	}
@@ -785,7 +785,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 						 mount_options[i], &sid,
 						 GFP_KERNEL);
 		if (rc) {
-			printk(KERN_WARNING "SELinux: security_context_str_to_sid"
+			pr_warn("SELinux: security_context_str_to_sid"
 			       "(%s) failed for (dev %s, type %s) errno=%d\n",
 			       mount_options[i], sb->s_id, name, rc);
 			goto out;
@@ -861,8 +861,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		 */
 		rc = security_fs_use(&selinux_state, sb);
 		if (rc) {
-			printk(KERN_WARNING
-				"%s: security_fs_use(%s) returned %d\n",
+			pr_warn("%s: security_fs_use(%s) returned %d\n",
 					__func__, sb->s_type->name, rc);
 			goto out;
 		}
@@ -948,7 +947,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		if (sbsec->behavior != SECURITY_FS_USE_XATTR &&
 			sbsec->behavior != SECURITY_FS_USE_NATIVE) {
 			rc = -EINVAL;
-			printk(KERN_WARNING "SELinux: defcontext option is "
+			pr_warn("SELinux: defcontext option is "
 			       "invalid for this filesystem type\n");
 			goto out;
 		}
@@ -970,7 +969,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	return rc;
 out_double_mount:
 	rc = -EINVAL;
-	printk(KERN_WARNING "SELinux: mount invalid.  Same superblock, different "
+	pr_warn("SELinux: mount invalid.  Same superblock, different "
 	       "security settings for (dev %s, type %s)\n", sb->s_id, name);
 	goto out;
 }
@@ -999,7 +998,7 @@ static int selinux_cmp_sb_context(const struct super_block *oldsb,
 	}
 	return 0;
 mismatch:
-	printk(KERN_WARNING "SELinux: mount invalid.  Same superblock, "
+	pr_warn("SELinux: mount invalid.  Same superblock, "
 			    "different security settings for (dev %s, "
 			    "type %s)\n", newsb->s_id, newsb->s_type->name);
 	return -EBUSY;
@@ -1107,7 +1106,7 @@ static int selinux_parse_opts_str(char *options,
 		case Opt_context:
 			if (context || defcontext) {
 				rc = -EINVAL;
-				printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
+				pr_warn(SEL_MOUNT_FAIL_MSG);
 				goto out_err;
 			}
 			context = match_strdup(&args[0]);
@@ -1120,7 +1119,7 @@ static int selinux_parse_opts_str(char *options,
 		case Opt_fscontext:
 			if (fscontext) {
 				rc = -EINVAL;
-				printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
+				pr_warn(SEL_MOUNT_FAIL_MSG);
 				goto out_err;
 			}
 			fscontext = match_strdup(&args[0]);
@@ -1133,7 +1132,7 @@ static int selinux_parse_opts_str(char *options,
 		case Opt_rootcontext:
 			if (rootcontext) {
 				rc = -EINVAL;
-				printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
+				pr_warn(SEL_MOUNT_FAIL_MSG);
 				goto out_err;
 			}
 			rootcontext = match_strdup(&args[0]);
@@ -1146,7 +1145,7 @@ static int selinux_parse_opts_str(char *options,
 		case Opt_defcontext:
 			if (context || defcontext) {
 				rc = -EINVAL;
-				printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
+				pr_warn(SEL_MOUNT_FAIL_MSG);
 				goto out_err;
 			}
 			defcontext = match_strdup(&args[0]);
@@ -1159,7 +1158,7 @@ static int selinux_parse_opts_str(char *options,
 			break;
 		default:
 			rc = -EINVAL;
-			printk(KERN_WARNING "SELinux:  unknown mount option\n");
+			pr_warn("SELinux:  unknown mount option\n");
 			goto out_err;
 
 		}
@@ -1615,7 +1614,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		dput(dentry);
 		if (rc < 0) {
 			if (rc != -ENODATA) {
-				printk(KERN_WARNING "SELinux: %s:  getxattr returned "
+				pr_warn("SELinux: %s:  getxattr returned "
 				       "%d for dev=%s ino=%ld\n", __func__,
 				       -rc, inode->i_sb->s_id, inode->i_ino);
 				kfree(context);
@@ -1635,11 +1634,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 				if (rc == -EINVAL) {
 					if (printk_ratelimit())
-						printk(KERN_NOTICE "SELinux: inode=%lu on dev=%s was found to have an invalid "
+						pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
 							"context=%s.  This indicates you may need to relabel the inode or the "
 							"filesystem in question.\n", ino, dev, context);
 				} else {
-					printk(KERN_WARNING "SELinux: %s:  context_to_sid(%s) "
+					pr_warn("SELinux: %s:  context_to_sid(%s) "
 					       "returned %d for dev=%s ino=%ld\n",
 					       __func__, context, -rc, dev, ino);
 				}
@@ -1772,8 +1771,7 @@ static int cred_has_capability(const struct cred *cred,
 		sclass = initns ? SECCLASS_CAPABILITY2 : SECCLASS_CAP2_USERNS;
 		break;
 	default:
-		printk(KERN_ERR
-		       "SELinux:  out of range capability %d\n", cap);
+		pr_err("SELinux:  out of range capability %d\n", cap);
 		BUG();
 		return -EINVAL;
 	}
@@ -2016,7 +2014,7 @@ static int may_link(struct inode *dir,
 		av = DIR__RMDIR;
 		break;
 	default:
-		printk(KERN_WARNING "SELinux: %s:  unrecognized kind %d\n",
+		pr_warn("SELinux: %s:  unrecognized kind %d\n",
 			__func__, kind);
 		return 0;
 	}
@@ -2862,7 +2860,7 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 						 mount_options[i], &sid,
 						 GFP_KERNEL);
 		if (rc) {
-			printk(KERN_WARNING "SELinux: security_context_str_to_sid"
+			pr_warn("SELinux: security_context_str_to_sid"
 			       "(%s) failed for (dev %s, type %s) errno=%d\n",
 			       mount_options[i], sb->s_id, sb->s_type->name, rc);
 			goto out_free_opts;
@@ -2901,7 +2899,7 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 	free_secdata(secdata);
 	return rc;
 out_bad_option:
-	printk(KERN_WARNING "SELinux: unable to change security options "
+	pr_warn("SELinux: unable to change security options "
 	       "during remount (dev %s, type=%s)\n", sb->s_id,
 	       sb->s_type->name);
 	goto out_free_opts;
@@ -3343,7 +3341,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 	rc = security_context_to_sid_force(&selinux_state, value, size,
 					   &newsid);
 	if (rc) {
-		printk(KERN_ERR "SELinux:  unable to map context to SID"
+		pr_err("SELinux:  unable to map context to SID"
 		       "for (%s, %lu), rc=%d\n",
 		       inode->i_sb->s_id, inode->i_ino, -rc);
 		return;
@@ -4406,7 +4404,7 @@ static int selinux_parse_skb(struct sk_buff *skb, struct common_audit_data *ad,
 	}
 
 parse_error:
-	printk(KERN_WARNING
+	pr_warn(
 	       "SELinux: failure in selinux_parse_skb(),"
 	       " unable to parse packet\n");
 	return ret;
@@ -4449,7 +4447,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	err = security_net_peersid_resolve(&selinux_state, nlbl_sid,
 					   nlbl_type, xfrm_sid, sid);
 	if (unlikely(err)) {
-		printk(KERN_WARNING
+		pr_warn(
 		       "SELinux: failure in selinux_skb_peerlbl_sid(),"
 		       " unable to determine packet's peer label\n");
 		return -EACCES;
@@ -7091,11 +7089,11 @@ static __init int selinux_init(void)
 	}
 
 	if (!selinux_enabled) {
-		printk(KERN_INFO "SELinux:  Disabled at boot.\n");
+		pr_info("SELinux:  Disabled at boot.\n");
 		return 0;
 	}
 
-	printk(KERN_INFO "SELinux:  Initializing.\n");
+	pr_info("SELinux:  Initializing.\n");
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
 	enforcing_set(&selinux_state, selinux_enforcing_boot);
@@ -7131,9 +7129,9 @@ static __init int selinux_init(void)
 		panic("SELinux: Unable to register AVC LSM notifier callback\n");
 
 	if (selinux_enforcing_boot)
-		printk(KERN_DEBUG "SELinux:  Starting in enforcing mode\n");
+		pr_debug("SELinux:  Starting in enforcing mode\n");
 	else
-		printk(KERN_DEBUG "SELinux:  Starting in permissive mode\n");
+		pr_debug("SELinux:  Starting in permissive mode\n");
 
 	return 0;
 }
@@ -7145,10 +7143,10 @@ static void delayed_superblock_init(struct super_block *sb, void *unused)
 
 void selinux_complete_init(void)
 {
-	printk(KERN_DEBUG "SELinux:  Completing initialization.\n");
+	pr_debug("SELinux:  Completing initialization.\n");
 
 	/* Set up any superblocks initialized prior to the policy load. */
-	printk(KERN_DEBUG "SELinux:  Setting up existing superblocks.\n");
+	pr_debug("SELinux:  Setting up existing superblocks.\n");
 	iterate_supers(delayed_superblock_init, NULL);
 }
 
@@ -7223,7 +7221,7 @@ static int __init selinux_nf_ip_init(void)
 	if (!selinux_enabled)
 		return 0;
 
-	printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");
+	pr_debug("SELinux:  Registering netfilter hooks\n");
 
 	err = register_pernet_subsys(&selinux_net_ops);
 	if (err)
@@ -7236,7 +7234,7 @@ __initcall(selinux_nf_ip_init);
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static void selinux_nf_ip_exit(void)
 {
-	printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");
+	pr_debug("SELinux:  Unregistering netfilter hooks\n");
 
 	unregister_pernet_subsys(&selinux_net_ops);
 }
@@ -7265,7 +7263,7 @@ int selinux_disable(struct selinux_state *state)
 
 	state->disabled = 1;
 
-	printk(KERN_INFO "SELinux:  Disabled at runtime.\n");
+	pr_info("SELinux:  Disabled at runtime.\n");
 
 	selinux_enabled = 0;
 
-- 
2.15.1
