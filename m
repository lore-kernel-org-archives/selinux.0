Subject: [PATCH 7/7] SELinux: mount option to force xattr test
To: selinux@tycho.nsa.gov
From: Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov
Date: Fri, 24 Aug 2012 15:59:28 -0400
Message-ID: <20120824195928.22970.16209.stgit@paris.rdu.redhat.com>
In-Reply-To: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
References: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At the moment we hard code in policy which filesystems support xattrs and
which do not.  Although FUSE supports xattrs it has a deadlock if the
kernel makes an xattr call before mount(8) (NOT mount(2)) returns successfully.
This is especially broken since even during mount(2) the kernel believes
the FS is ready for use immediately after the filesystem ops init call.
Obviously at this point mount(2) and mount(8) aren't finished so doing so
will deadlock FUSE.

So we have to hard code in SELinux policy that FUSE does not support xattrs.
There is a version of FUSE which solves this problem by doing work in parallel
to the mount(8).  However we cannot distinguish which version is which!  This
gives meaning to the existing 'seclabel' mount option which is currently
ignored.  It will use the option to force the kernel to check if xattrs on the
filesystem can be used, imitating the same behaviour as if the policy declared
the filesystem type xattr capable.

The intention is that future FUSE will be able to set the seclabel mount option
once it is able to handle xattr calls during mount(2) while we retain the
policy statement that FUSE does not support xattrs.  Old FUSE will continue to
work as it does today and new FUSE will seamlessly be able to transition to
using xattrs.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/hooks.c       |   16 ++++++++++++++--
 security/selinux/ss/services.c |    2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ffded97..8a2af68 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -605,8 +605,10 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	for (i = 0; i < num_opts; i++) {
 		u32 sid;
 
-		if (flags[i] == SE_SBLABELSUPP)
+		if (flags[i] == SE_SBLABELSUPP) {
+			sbsec->flags |= SE_SBLABELSUPP;
 			continue;
+		}
 		rc = security_context_to_sid(mount_options[i],
 					     strlen(mount_options[i]), &sid);
 		if (rc) {
@@ -815,7 +817,7 @@ static int selinux_parse_opts_str(char *options,
 	char *p;
 	char *context = NULL, *defcontext = NULL;
 	char *fscontext = NULL, *rootcontext = NULL;
-	int rc, num_mnt_opts = 0;
+	int rc, num_mnt_opts = 0, forceseclabel = 0;
 
 	opts->num_mnt_opts = 0;
 
@@ -882,6 +884,12 @@ static int selinux_parse_opts_str(char *options,
 			}
 			break;
 		case Opt_labelsupport:
+			if (context) {
+				rc = -EINVAL;
+				printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
+				goto out_err;
+			}
+			forceseclabel = 1;
 			break;
 		default:
 			rc = -EINVAL;
@@ -902,6 +910,10 @@ static int selinux_parse_opts_str(char *options,
 		goto out_err;
 	}
 
+	if (forceseclabel) {
+		opts->mnt_opts[num_mnt_opts] = NULL;
+		opts->mnt_opts_flags[num_mnt_opts++] = SE_SBLABELSUPP;
+	}
 	if (fscontext) {
 		opts->mnt_opts[num_mnt_opts] = fscontext;
 		opts->mnt_opts_flags[num_mnt_opts++] = FSCONTEXT_MNT;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 295e937..b1522f1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2361,6 +2361,8 @@ int security_fs_use(const char *fstype, struct superblock_security_struct *sbsec
 			sbsec->behavior = SECURITY_FS_USE_GENFS;
 		}
 	}
+	if (sbsec->flags & SE_SBLABELSUPP)
+		sbsec->behavior = SECURITY_FS_USE_XATTR;
 
 out:
 	read_unlock(&policy_rwlock);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
