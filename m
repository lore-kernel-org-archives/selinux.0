Subject: [PATCH] SELinux: don't BUG if fs reuses a superblock
From: Eric Paris <eparis@redhat.com>
To: linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov
Cc: steved@redhat.com, jlayton@redhat.com, sds@tycho.nsa.gov,
        jmorris@namei.org, trond.myklebust@fys.uio.no, chuck.lever@oracle.com
Content-Type: text/plain
Date: Wed, 09 Apr 2008 14:08:35 -0400
Message-Id: <1207764515.3070.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I (wrongly) assumed that nfs_xdev_get_sb() would not ever share a
superblock and so cloning mount options would always be correct.  Turns
out that isn't the case and we could fall over a BUG_ON() that wasn't a
BUG at all.  Since there is little we can do to reconcile different
mount options this patch just leaves the sb alone and the first set of
options wins.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/hooks.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 89bb6d3..d39b59c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -760,13 +760,13 @@ static void selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 	 * this early in the boot process. */
 	BUG_ON(!ss_initialized);
 
-	/* this might go away sometime down the line if there is a new user
-	 * of clone, but for now, nfs better not get here... */
-	BUG_ON(newsbsec->initialized);
-
 	/* how can we clone if the old one wasn't set up?? */
 	BUG_ON(!oldsbsec->initialized);
 
+	/* if fs is reusing a sb, just let its options stand... */
+	if (newsbsec->initialized)
+		return;
+
 	mutex_lock(&newsbsec->lock);
 
 	newsbsec->flags = oldsbsec->flags;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
