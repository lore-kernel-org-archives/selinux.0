Subject: [PATCH] SELinux: no BUG_ON(!ss_initialized) in
	selinux_clone_mnt_opts
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov, stable@kernel.org
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Mon, 21 Apr 2008 16:24:11 -0400
Message-Id: <1208809451.2985.82.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The Fedora installer actually makes multiple NFS mounts before it loads
selinux policy.  The code in selinux_clone_mnt_opts() assumed that the
init process would always be loading policy before NFS was up and
running.  It might be possible to hit this in a diskless environment as
well, I'm not sure.  There is no need to BUG_ON() in this situation
since we can safely continue given the circumstances.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/hooks.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f9927f0..92c8910 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -755,9 +755,18 @@ static void selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
 	int set_rootcontext =	(oldsbsec->flags & ROOTCONTEXT_MNT);
 
-	/* we can't error, we can't save the info, this shouldn't get called
-	 * this early in the boot process. */
-	BUG_ON(!ss_initialized);
+	/*
+	 * if the parent was able to be mounted it clearly had no special lsm
+	 * mount options.  thus we can safely put this sb on the list and deal
+	 * with it later
+	 */
+	if (!ss_initialized) {
+		spin_lock(&sb_security_lock);
+		if (list_empty(&newsbsec->list))
+			list_add(&newsbsec->list, &superblock_security_head);
+		spin_unlock(&sb_security_lock);
+		return;
+	}
 
 	/* how can we clone if the old one wasn't set up?? */
 	BUG_ON(!oldsbsec->initialized);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
