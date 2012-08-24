Subject: [PATCH 6/7] SELinux: do not handle seclabel as a special flag
To: selinux@tycho.nsa.gov
From: Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov
Date: Fri, 24 Aug 2012 15:59:21 -0400
Message-ID: <20120824195921.22970.8969.stgit@paris.rdu.redhat.com>
In-Reply-To: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
References: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Instead of having special code around the 'non-mount' seclabel mount option
just handle it like the mount options.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/hooks.c            |    3 ---
 security/selinux/include/security.h |   10 +++++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2121e1d..ffded97 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -469,9 +469,6 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 			opts->num_mnt_opts++;
 		tmp >>= 1;
 	}
-	/* Check if the Label support flag is set */
-	if (sbsec->flags & SE_SBLABELSUPP)
-		opts->num_mnt_opts++;
 
 	opts->mnt_opts = kcalloc(opts->num_mnt_opts, sizeof(char *), GFP_ATOMIC);
 	if (!opts->mnt_opts) {
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 7142995..238ed4c 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -43,17 +43,17 @@
 #endif
 
 /* Mask for just the mount related flags */
-#define SE_MNTMASK	0x0f
-#define SE_MNTMASK_BITS	4
+#define SE_MNTMASK	0x1f
+#define SE_MNTMASK_BITS	5
 /* Super block security struct flags for mount options */
 #define CONTEXT_MNT	0x01
 #define FSCONTEXT_MNT	0x02
 #define ROOTCONTEXT_MNT	0x04
 #define DEFCONTEXT_MNT	0x08
+#define SE_SBLABELSUPP	0x10
 /* Non-mount related flags */
-#define SE_SBINITIALIZED	0x10
-#define SE_SBPROC		0x20
-#define SE_SBLABELSUPP	0x40
+#define SE_SBINITIALIZED	0x20
+#define SE_SBPROC		0x40
 
 #define CONTEXT_STR	"context="
 #define FSCONTEXT_STR	"fscontext="


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
