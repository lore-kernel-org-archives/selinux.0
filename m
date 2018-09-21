From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 torvalds@linux-foundation.org, dhowells@redhat.com,
 ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date: Fri, 21 Sep 2018 17:31:27 +0100
Message-ID: <153754748795.17872.16927661345949556851.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH 10/34] selinux: Implement the new mount API LSM hooks [ver #12]
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Implement the new mount API LSM hooks for SELinux.  At some point the old
hooks will need to be removed.

Question: Should the ->fs_context_parse_source() hook be implemented to
check the labels on any source devices specified?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paul Moore <paul@paul-moore.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov
cc: linux-security-module@vger.kernel.org
---

 security/selinux/hooks.c            |  336 ++++++++++++++++++++++++++++++++---
 security/selinux/include/security.h |   16 +-
 2 files changed, 319 insertions(+), 33 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9102a8fecb15..5f2af9dd44fa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -48,6 +48,8 @@
 #include <linux/fdtable.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
 #include <linux/tty.h>
@@ -439,24 +441,23 @@ static inline int inode_doinit(struct inode *inode)
 }
 
 enum {
-	Opt_error = -1,
-	Opt_context = 1,
+	Opt_context = 0,
+	Opt_defcontext = 1,
 	Opt_fscontext = 2,
-	Opt_defcontext = 3,
-	Opt_rootcontext = 4,
-	Opt_labelsupport = 5,
-	Opt_nextmntopt = 6,
+	Opt_rootcontext = 3,
+	Opt_seclabel = 4,
+	nr__selinux_params
 };
 
-#define NUM_SEL_MNT_OPTS	(Opt_nextmntopt - 1)
+#define NUM_SEL_MNT_OPTS	(nr__selinux_params - 1)
 
 static const match_table_t tokens = {
-	{Opt_context, CONTEXT_STR "%s"},
-	{Opt_fscontext, FSCONTEXT_STR "%s"},
-	{Opt_defcontext, DEFCONTEXT_STR "%s"},
-	{Opt_rootcontext, ROOTCONTEXT_STR "%s"},
-	{Opt_labelsupport, LABELSUPP_STR},
-	{Opt_error, NULL},
+	{Opt_context, CONTEXT_STR "=%s"},
+	{Opt_fscontext, FSCONTEXT_STR "=%s"},
+	{Opt_defcontext, DEFCONTEXT_STR "=%s"},
+	{Opt_rootcontext, ROOTCONTEXT_STR "=%s"},
+	{Opt_seclabel, SECLABEL_STR},
+	{-1, NULL},
 };
 
 #define SEL_MOUNT_FAIL_MSG "SELinux:  duplicate or incompatible mount options\n"
@@ -615,15 +616,11 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 	if (!selinux_state.initialized)
 		return -EINVAL;
 
-	/* make sure we always check enough bits to cover the mask */
-	BUILD_BUG_ON(SE_MNTMASK >= (1 << NUM_SEL_MNT_OPTS));
-
 	tmp = sbsec->flags & SE_MNTMASK;
 	/* count the number of mount options for this sb */
 	for (i = 0; i < NUM_SEL_MNT_OPTS; i++) {
-		if (tmp & 0x01)
+		if (tmp & (1 << i))
 			opts->num_mnt_opts++;
-		tmp >>= 1;
 	}
 	/* Check if the Label support flag is set */
 	if (sbsec->flags & SBLABEL_MNT)
@@ -1154,7 +1151,7 @@ static int selinux_parse_opts_str(char *options,
 				goto out_err;
 			}
 			break;
-		case Opt_labelsupport:
+		case Opt_seclabel:
 			break;
 		default:
 			rc = -EINVAL;
@@ -1259,7 +1256,7 @@ static void selinux_write_opts(struct seq_file *m,
 			break;
 		case SBLABEL_MNT:
 			seq_putc(m, ',');
-			seq_puts(m, LABELSUPP_STR);
+			seq_puts(m, SECLABEL_STR);
 			continue;
 		default:
 			BUG();
@@ -1268,6 +1265,7 @@ static void selinux_write_opts(struct seq_file *m,
 		/* we need a comma before each option */
 		seq_putc(m, ',');
 		seq_puts(m, prefix);
+		seq_putc(m, '=');
 		if (has_comma)
 			seq_putc(m, '\"');
 		seq_escape(m, opts->mnt_opts[i], "\"\n\\");
@@ -2753,11 +2751,11 @@ static inline int match_prefix(char *prefix, int plen, char *option, int olen)
 
 static inline int selinux_option(char *option, int len)
 {
-	return (match_prefix(CONTEXT_STR, sizeof(CONTEXT_STR)-1, option, len) ||
-		match_prefix(FSCONTEXT_STR, sizeof(FSCONTEXT_STR)-1, option, len) ||
-		match_prefix(DEFCONTEXT_STR, sizeof(DEFCONTEXT_STR)-1, option, len) ||
-		match_prefix(ROOTCONTEXT_STR, sizeof(ROOTCONTEXT_STR)-1, option, len) ||
-		match_prefix(LABELSUPP_STR, sizeof(LABELSUPP_STR)-1, option, len));
+	return (match_prefix(CONTEXT_STR"=", sizeof(CONTEXT_STR)-1, option, len) ||
+		match_prefix(FSCONTEXT_STR"=", sizeof(FSCONTEXT_STR)-1, option, len) ||
+		match_prefix(DEFCONTEXT_STR"=", sizeof(DEFCONTEXT_STR)-1, option, len) ||
+		match_prefix(ROOTCONTEXT_STR"=", sizeof(ROOTCONTEXT_STR)-1, option, len) ||
+		match_prefix(SECLABEL_STR"=", sizeof(SECLABEL_STR)-1, option, len));
 }
 
 static inline void take_option(char **to, char *from, int *first, int len)
@@ -2972,6 +2970,284 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 				   FILESYSTEM__UNMOUNT, NULL);
 }
 
+/* fsopen mount context operations */
+
+static int selinux_fs_context_alloc(struct fs_context *fc,
+				    struct dentry *reference)
+{
+	struct security_mnt_opts *opts;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+
+	fc->security = opts;
+	return 0;
+}
+
+static int selinux_fs_context_dup(struct fs_context *fc,
+				  struct fs_context *src_fc)
+{
+	const struct security_mnt_opts *src = src_fc->security;
+	struct security_mnt_opts *opts;
+	int i, n;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+	fc->security = opts;
+
+	if (!src || !src->num_mnt_opts)
+		return 0;
+	n = opts->num_mnt_opts = src->num_mnt_opts;
+
+	if (src->mnt_opts) {
+		opts->mnt_opts = kcalloc(n, sizeof(char *), GFP_KERNEL);
+		if (!opts->mnt_opts)
+			return -ENOMEM;
+
+		for (i = 0; i < n; i++) {
+			if (src->mnt_opts[i]) {
+				opts->mnt_opts[i] = kstrdup(src->mnt_opts[i],
+							    GFP_KERNEL);
+				if (!opts->mnt_opts[i])
+					return -ENOMEM;
+			}
+		}
+	}
+
+	if (src->mnt_opts_flags) {
+		opts->mnt_opts_flags = kmemdup(src->mnt_opts_flags,
+					       n * sizeof(int), GFP_KERNEL);
+		if (!opts->mnt_opts_flags)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void selinux_fs_context_free(struct fs_context *fc)
+{
+	struct security_mnt_opts *opts = fc->security;
+
+	if (opts) {
+		security_free_mnt_opts(opts);
+		fc->security = NULL;
+	}
+}
+
+static const struct fs_parameter_spec selinux_param_specs[nr__selinux_params] = {
+	[Opt_context]		= { fs_param_is_string },
+	[Opt_defcontext]	= { fs_param_is_string },
+	[Opt_fscontext]		= { fs_param_is_string },
+	[Opt_rootcontext]	= { fs_param_is_string },
+	[Opt_seclabel]		= { fs_param_is_flag },
+};
+
+static const char *const selinux_param_keys[nr__selinux_params] = {
+	[Opt_context]		= CONTEXT_STR,
+	[Opt_defcontext]	= DEFCONTEXT_STR,
+	[Opt_fscontext]		= FSCONTEXT_STR,
+	[Opt_rootcontext]	= ROOTCONTEXT_STR,
+	[Opt_seclabel]		= SECLABEL_STR,
+};
+
+static const struct fs_parameter_description selinux_fs_parameters = {
+	.name		= "SELinux",
+	.nr_params	= nr__selinux_params,
+	.keys		= selinux_param_keys,
+	.specs		= selinux_param_specs,
+	.no_source	= true,
+};
+
+static int selinux_fs_context_parse_param(struct fs_context *fc,
+					  struct fs_parameter *param)
+{
+	struct security_mnt_opts *opts = fc->security;
+	struct fs_parse_result result;
+	unsigned int have;
+	char **oo;
+	int opt, ctx, i, *of;
+
+	opt = fs_parse(fc, &selinux_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	have = 0;
+	for (i = 0; i < opts->num_mnt_opts; i++)
+		have |= 1 << opts->mnt_opts_flags[i];
+	if (have & (1 << opt))
+		return -EINVAL;
+
+	switch (opt) {
+	case Opt_context:
+		if (have & (1 << Opt_defcontext))
+			goto incompatible;
+		ctx = CONTEXT_MNT;
+		goto copy_context_string;
+
+	case Opt_fscontext:
+		ctx = FSCONTEXT_MNT;
+		goto copy_context_string;
+
+	case Opt_rootcontext:
+		ctx = ROOTCONTEXT_MNT;
+		goto copy_context_string;
+
+	case Opt_defcontext:
+		if (have & (1 << Opt_context))
+			goto incompatible;
+		ctx = DEFCONTEXT_MNT;
+		goto copy_context_string;
+
+	case Opt_seclabel:
+		return 1;
+
+	default:
+		return -EINVAL;
+	}
+
+copy_context_string:
+	if (opts->num_mnt_opts > 3)
+		return -EINVAL;
+
+	of = krealloc(opts->mnt_opts_flags,
+		      (opts->num_mnt_opts + 1) * sizeof(int), GFP_KERNEL);
+	if (!of)
+		return -ENOMEM;
+	of[opts->num_mnt_opts] = 0;
+	opts->mnt_opts_flags = of;
+
+	oo = krealloc(opts->mnt_opts,
+		      (opts->num_mnt_opts + 1) * sizeof(char *), GFP_KERNEL);
+	if (!oo)
+		return -ENOMEM;
+	oo[opts->num_mnt_opts] = NULL;
+	opts->mnt_opts = oo;
+
+	opts->mnt_opts[opts->num_mnt_opts] = param->string;
+	opts->mnt_opts_flags[opts->num_mnt_opts] = ctx;
+	opts->num_mnt_opts++;
+	param->string = NULL;
+	return 1;
+
+incompatible:
+	return -EINVAL;
+}
+
+/*
+ * Validate the security parameters supplied for a reconfiguration/remount
+ * event.
+ */
+static int selinux_validate_for_sb_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+	struct superblock_security_struct *sbsec = sb->s_security;
+	struct security_mnt_opts *opts = fc->security;
+	int rc, i, *flags;
+	char **mount_options;
+
+	if (!(sbsec->flags & SE_SBINITIALIZED))
+		return 0;
+
+	mount_options = opts->mnt_opts;
+	flags = opts->mnt_opts_flags;
+
+	for (i = 0; i < opts->num_mnt_opts; i++) {
+		u32 sid;
+
+		if (flags[i] == SBLABEL_MNT)
+			continue;
+
+		rc = security_context_str_to_sid(&selinux_state, mount_options[i],
+						 &sid, GFP_KERNEL);
+		if (rc) {
+			pr_warn("SELinux: security_context_str_to_sid"
+				"(%s) failed for (dev %s, type %s) errno=%d\n",
+				mount_options[i], sb->s_id, sb->s_type->name, rc);
+			goto inval;
+		}
+
+		switch (flags[i]) {
+		case FSCONTEXT_MNT:
+			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
+				goto bad_option;
+			break;
+		case CONTEXT_MNT:
+			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
+				goto bad_option;
+			break;
+		case ROOTCONTEXT_MNT: {
+			struct inode_security_struct *root_isec;
+			root_isec = backing_inode_security(sb->s_root);
+
+			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
+				goto bad_option;
+			break;
+		}
+		case DEFCONTEXT_MNT:
+			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
+				goto bad_option;
+			break;
+		default:
+			goto inval;
+		}
+	}
+
+	rc = 0;
+out:
+	return rc;
+
+bad_option:
+	pr_warn("SELinux: unable to change security options "
+		"during remount (dev %s, type=%s)\n",
+		sb->s_id, sb->s_type->name);
+inval:
+	rc = -EINVAL;
+	goto out;
+}
+
+/*
+ * Validate the security context assembled from the option data supplied to
+ * mount.
+ */
+static int selinux_fs_context_validate(struct fs_context *fc)
+{
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
+		return selinux_validate_for_sb_reconfigure(fc);
+	return 0;
+}
+
+/*
+ * Set the security context on a superblock.
+ */
+static int selinux_sb_get_tree(struct fs_context *fc)
+{
+	const struct cred *cred = current_cred();
+	struct common_audit_data ad;
+	int rc;
+
+	rc = selinux_set_mnt_opts(fc->root->d_sb, fc->security, 0, NULL);
+	if (rc)
+		return rc;
+
+	/* Allow all mounts performed by the kernel */
+	if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
+		return 0;
+
+	ad.type = LSM_AUDIT_DATA_DENTRY;
+	ad.u.dentry = fc->root;
+	return superblock_has_perm(cred, fc->root->d_sb, FILESYSTEM__MOUNT, &ad);
+}
+
+static int selinux_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
+				 unsigned int mnt_flags)
+{
+	const struct cred *cred = current_cred();
+
+	return path_has_perm(cred, mountpoint, FILE__MOUNTON);
+}
+
 /* inode security operations */
 
 static int selinux_inode_alloc_security(struct inode *inode)
@@ -6918,6 +7194,14 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
 
+	LSM_HOOK_INIT(fs_context_alloc, selinux_fs_context_alloc),
+	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
+	LSM_HOOK_INIT(fs_context_free, selinux_fs_context_free),
+	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
+	LSM_HOOK_INIT(fs_context_validate, selinux_fs_context_validate),
+	LSM_HOOK_INIT(sb_get_tree, selinux_sb_get_tree),
+	LSM_HOOK_INIT(sb_mountpoint, selinux_sb_mountpoint),
+
 	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
 	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(sb_copy_data, selinux_sb_copy_data),
@@ -7185,6 +7469,8 @@ static __init int selinux_init(void)
 	else
 		pr_debug("SELinux:  Starting in permissive mode\n");
 
+	fs_validate_description(&selinux_fs_parameters);
+
 	return 0;
 }
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 23e762d529fa..7c100283b66f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -50,20 +50,20 @@
 /* Super block security struct flags for mount options */
 /* BE CAREFUL, these need to be the low order bits for selinux_get_mnt_opts */
 #define CONTEXT_MNT	0x01
-#define FSCONTEXT_MNT	0x02
-#define ROOTCONTEXT_MNT	0x04
-#define DEFCONTEXT_MNT	0x08
+#define DEFCONTEXT_MNT	0x02
+#define FSCONTEXT_MNT	0x04
+#define ROOTCONTEXT_MNT	0x08
 #define SBLABEL_MNT	0x10
 /* Non-mount related flags */
 #define SE_SBINITIALIZED	0x0100
 #define SE_SBPROC		0x0200
 #define SE_SBGENFS		0x0400
 
-#define CONTEXT_STR	"context="
-#define FSCONTEXT_STR	"fscontext="
-#define ROOTCONTEXT_STR	"rootcontext="
-#define DEFCONTEXT_STR	"defcontext="
-#define LABELSUPP_STR "seclabel"
+#define CONTEXT_STR	"context"
+#define FSCONTEXT_STR	"fscontext"
+#define ROOTCONTEXT_STR	"rootcontext"
+#define DEFCONTEXT_STR	"defcontext"
+#define SECLABEL_STR	"seclabel"
 
 struct netlbl_lsm_secattr;
 
