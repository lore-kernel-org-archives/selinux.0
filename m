From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/2] SELinux: implement the new sb_remount LSM hook
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, eparis@redhat.com
Date: Tue, 01 Mar 2011 16:58:28 -0500
Message-ID: <20110301215828.26496.68739.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110301215822.26496.45621.stgit@paris.rdu.redhat.com>
References: <20110301215822.26496.45621.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For SELinux we do not allow security information to change during a remount
operation.  Thus this hook simply strips the security module options from
the data and verifies that those are the same options as exist on the
current superblock.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0dca8b6..f848a28 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2365,6 +2365,91 @@ out:
 	return rc;
 }
 
+static int selinux_sb_remount(struct super_block *sb, void *data)
+{
+	int rc, i, *flags;
+	struct security_mnt_opts opts;
+	char *secdata, **mount_options;
+	struct superblock_security_struct *sbsec = sb->s_security;
+
+	if (!(sbsec->flags & SE_SBINITIALIZED))
+		return 0;
+
+	if (!data)
+		return 0;
+
+	if (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)
+		return 0;
+
+	security_init_mnt_opts(&opts);
+	secdata = alloc_secdata();
+	if (!secdata)
+		return -ENOMEM;
+	rc = selinux_sb_copy_data(data, secdata);
+	if (rc)
+		goto out_free_secdata;
+
+	rc = selinux_parse_opts_str(secdata, &opts);
+	if (rc)
+		goto out_free_secdata;
+
+	mount_options = opts.mnt_opts;
+	flags = opts.mnt_opts_flags;
+
+	for (i = 0; i < opts.num_mnt_opts; i++) {
+		u32 sid;
+		size_t len;
+
+		if (flags[i] == SE_SBLABELSUPP)
+			continue;
+		len = strlen(mount_options[i]);
+		rc = security_context_to_sid(mount_options[i], len, &sid);
+		if (rc) {
+			printk(KERN_WARNING "SELinux: security_context_to_sid"
+			       "(%s) failed for (dev %s, type %s) errno=%d\n",
+			       mount_options[i], sb->s_id, sb->s_type->name, rc);
+			goto out_free_opts;
+		}
+		rc = -EINVAL;
+		switch (flags[i]) {
+		case FSCONTEXT_MNT:
+			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
+				goto out_bad_option;
+			break;
+		case CONTEXT_MNT:
+			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
+				goto out_bad_option;
+			break;
+		case ROOTCONTEXT_MNT: {
+			struct inode_security_struct *root_isec;
+			root_isec = sb->s_root->d_inode->i_security;
+
+			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
+				goto out_bad_option;
+			break;
+		}
+		case DEFCONTEXT_MNT:
+			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
+				goto out_bad_option;
+			break;
+		default:
+			goto out_free_opts;
+		}
+	}
+
+	rc = 0;
+out_free_opts:
+	security_free_mnt_opts(&opts);
+out_free_secdata:
+	free_secdata(secdata);
+	return rc;
+out_bad_option:
+	printk(KERN_WARNING "SELinux: unable to change security options "
+	       "during remount (dev %s, type=%s)\n", sb->s_id,
+	       sb->s_type->name);
+	goto out_free_opts;
+}
+
 static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
 	const struct cred *cred = current_cred();
@@ -5362,6 +5447,7 @@ static struct security_operations selinux_ops = {
 	.sb_alloc_security =		selinux_sb_alloc_security,
 	.sb_free_security =		selinux_sb_free_security,
 	.sb_copy_data =			selinux_sb_copy_data,
+	.sb_remount =			selinux_sb_remount,
 	.sb_kern_mount =		selinux_sb_kern_mount,
 	.sb_show_options =		selinux_sb_show_options,
 	.sb_statfs =			selinux_sb_statfs,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
