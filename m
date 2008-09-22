Subject: [RFC][PATCH] selinux:  use default proc sid on symlinks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul.moore@hp.com>
Content-Type: text/plain
Date: Mon, 22 Sep 2008 15:41:19 -0400
Message-Id: <1222112479.18735.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Patch below for the recent /proc/net bug related to selinux thread on linux-kernel.
If this looks sane, then possibly it should be re-sent on that thread.

As we are not concerned with fine-grained control over reading of
symlinks in proc, always use the default proc SID for all proc symlinks.
This should help avoid permission issues upon changes to the proc tree
as in the /proc/net -> /proc/self/net example.
This does not alter labeling of symlinks within /proc/pid directories.
ls -Zd /proc/net output before and after the patch should show the difference.

Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 89f446d..4a7374c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1291,7 +1291,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		/* Default to the fs superblock SID. */
 		isec->sid = sbsec->sid;
 
-		if (sbsec->proc) {
+		if (sbsec->proc && !S_ISLNK(inode->i_mode)) {
 			struct proc_inode *proci = PROC_I(inode);
 			if (proci->pde) {
 				isec->sclass = inode_mode_to_security_class(inode->i_mode);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
