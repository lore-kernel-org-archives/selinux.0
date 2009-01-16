From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: jmorris@namei.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 2/3] SELinux: Add new security mount option to indicate security label support.
Date: Fri, 16 Jan 2009 09:22:03 -0500
Message-Id: <1232115724-2621-3-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
References: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is no easy way to tell if a file system supports SELinux security labeling.
Because of this a new flag is being added to the super block security structure
to indicate that the particular super block supports labeling. This flag is set
for file systems using the xattr, task, and transition labeling methods unless
that behavior is overridden by context mounts.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 security/selinux/hooks.c            |   39 ++++++++++++++++++++++++++++++----
 security/selinux/include/security.h |    2 +
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 473adc5..3d099ee 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -89,7 +89,7 @@
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
-#define NUM_SEL_MNT_OPTS 4
+#define NUM_SEL_MNT_OPTS 5
 
 extern unsigned int policydb_loaded_version;
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
@@ -353,6 +353,7 @@ enum {
 	Opt_fscontext = 2,
 	Opt_defcontext = 3,
 	Opt_rootcontext = 4,
+	Opt_labelsupport = 5,
 };
 
 static const match_table_t tokens = {
@@ -360,6 +361,7 @@ static const match_table_t tokens = {
 	{Opt_fscontext, FSCONTEXT_STR "%s"},
 	{Opt_defcontext, DEFCONTEXT_STR "%s"},
 	{Opt_rootcontext, ROOTCONTEXT_STR "%s"},
+	{Opt_labelsupport, LABELSUPP_STR},
 	{Opt_error, NULL},
 };
 
@@ -431,7 +433,7 @@ static int sb_finish_set_opts(struct super_block *sb)
 		}
 	}
 
-	sbsec->flags |= SE_SBINITIALIZED;
+	sbsec->flags |= (SE_SBINITIALIZED | SE_SBLABELSUPP);
 
 	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
 		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
@@ -441,6 +443,12 @@ static int sb_finish_set_opts(struct super_block *sb)
 		       sb->s_id, sb->s_type->name,
 		       labeling_behaviors[sbsec->behavior-1]);
 
+	if (sbsec->behavior == SECURITY_FS_USE_GENFS || 
+	    sbsec->behavior == SECURITY_FS_USE_MNTPOINT ||
+	    sbsec->behavior == SECURITY_FS_USE_NONE ||
+	    sbsec->behavior > ARRAY_SIZE(labeling_behaviors))
+		sbsec->flags &= ~SE_SBLABELSUPP;
+			 
 	/* Initialize the root inode. */
 	rc = inode_doinit_with_dentry(root_inode, root);
 
@@ -500,6 +508,9 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 			opts->num_mnt_opts++;
 		tmp >>= 1;
 	}
+	/* Check if the Label support flag is set */
+	if (sbsec->flags & SE_SBLABELSUPP)
+		opts->num_mnt_opts++;
 
 	opts->mnt_opts = kcalloc(opts->num_mnt_opts, sizeof(char *), GFP_ATOMIC);
 	if (!opts->mnt_opts) {
@@ -545,6 +556,10 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 		opts->mnt_opts[i] = context;
 		opts->mnt_opts_flags[i++] = ROOTCONTEXT_MNT;
 	}
+	if (sbsec->flags & SE_SBLABELSUPP) {
+		opts->mnt_opts[i] = NULL;
+		opts->mnt_opts_flags[i++] = SE_SBLABELSUPP;
+	}
 
 	BUG_ON(i != opts->num_mnt_opts);
 
@@ -635,6 +650,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 */
 	for (i = 0; i < num_opts; i++) {
 		u32 sid;
+		
+		if (flags[i] == SE_SBLABELSUPP)
+			continue;			
 		rc = security_context_to_sid(mount_options[i],
 					     strlen(mount_options[i]), &sid);
 		if (rc) {
@@ -915,7 +933,8 @@ static int selinux_parse_opts_str(char *options,
 				goto out_err;
 			}
 			break;
-
+		case Opt_labelsupport:
+			break;
 		default:
 			rc = -EINVAL;
 			printk(KERN_WARNING "SELinux:  unknown mount option\n");
@@ -997,7 +1016,12 @@ static void selinux_write_opts(struct seq_file *m,
 	char *prefix;
 
 	for (i = 0; i < opts->num_mnt_opts; i++) {
-		char *has_comma = strchr(opts->mnt_opts[i], ',');
+		char *has_comma;
+
+		if (opts->mnt_opts[i])
+			has_comma = strchr(opts->mnt_opts[i], ',');
+		else
+			has_comma = NULL;
 
 		switch (opts->mnt_opts_flags[i]) {
 		case CONTEXT_MNT:
@@ -1012,6 +1036,10 @@ static void selinux_write_opts(struct seq_file *m,
 		case DEFCONTEXT_MNT:
 			prefix = DEFCONTEXT_STR;
 			break;
+		case SE_SBLABELSUPP:
+			seq_putc(m, ',');
+			seq_puts(m, LABELSUPP_STR);
+			continue;
 		default:
 			BUG();
 		};
@@ -2398,7 +2426,8 @@ static inline int selinux_option(char *option, int len)
 	return (match_prefix(CONTEXT_STR, sizeof(CONTEXT_STR)-1, option, len) ||
 		match_prefix(FSCONTEXT_STR, sizeof(FSCONTEXT_STR)-1, option, len) ||
 		match_prefix(DEFCONTEXT_STR, sizeof(DEFCONTEXT_STR)-1, option, len) ||
-		match_prefix(ROOTCONTEXT_STR, sizeof(ROOTCONTEXT_STR)-1, option, len));
+		match_prefix(ROOTCONTEXT_STR, sizeof(ROOTCONTEXT_STR)-1, option, len) ||
+		match_prefix(LABELSUPP_STR, sizeof(LABELSUPP_STR)-1, option, len));
 }
 
 static inline void take_option(char **to, char *from, int *first, int len)
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ff4e19c..e1d9db7 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -47,11 +47,13 @@
 /* Non-mount related flags */
 #define SE_SBINITIALIZED	0x10
 #define SE_SBPROC		0x20
+#define SE_SBLABELSUPP	0x40
 
 #define CONTEXT_STR	"context="
 #define FSCONTEXT_STR	"fscontext="
 #define ROOTCONTEXT_STR	"rootcontext="
 #define DEFCONTEXT_STR	"defcontext="
+#define LABELSUPP_STR "seclabel"
 
 struct netlbl_lsm_secattr;
 
-- 
1.5.6.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
