Subject: [PATCH 3/7] SELinux: define bits in the mask in a header
To: selinux@tycho.nsa.gov
From: Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov
Date: Fri, 24 Aug 2012 15:59:00 -0400
Message-ID: <20120824195900.22970.80440.stgit@paris.rdu.redhat.com>
In-Reply-To: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
References: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We had this random hard coded value of '8' in the code (I put it there)
for the number of bits to check for mount options.  This is stupid.  Instead
put the number of bits in the header so we don't hit problems down the road.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/hooks.c            |    5 ++++-
 security/selinux/include/security.h |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 74a738d..e55ff04 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -461,9 +461,12 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 	if (!ss_initialized)
 		return -EINVAL;
 
+	/* make sure we always check enough bits to cover the mask */
+	BUILD_BUG_ON(SE_MNTMASK >= (1 << SE_MNTMASK_BITS));
+
 	tmp = sbsec->flags & SE_MNTMASK;
 	/* count the number of mount options for this sb */
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < SE_MNTMASK_BITS; i++) {
 		if (tmp & 0x01)
 			opts->num_mnt_opts++;
 		tmp >>= 1;
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 927fc14..335753b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -44,6 +44,7 @@
 
 /* Mask for just the mount related flags */
 #define SE_MNTMASK	0x0f
+#define SE_MNTMASK_BITS	4
 /* Super block security struct flags for mount options */
 #define CONTEXT_MNT	0x01
 #define FSCONTEXT_MNT	0x02


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
