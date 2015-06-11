From: Waiman Long <Waiman.Long@hp.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov
Subject: [PATCH v2] selinux: reduce locking overhead in inode_free_security()
Date: Thu, 11 Jun 2015 17:31:24 -0400
Message-Id: <1434058284-56634-1-git-send-email-Waiman.Long@hp.com>
Cc: Waiman Long <Waiman.Long@hp.com>, Scott J Norton <scott.norton@hp.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Douglas Hatch <doug.hatch@hp.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The inode_free_security() function just took the superblock's isec_lock
before checking and trying to remove the inode security struct from the
linked list. In many cases, the list was empty and so the lock taking
is wasteful as no useful work is done. On multi-socket systems with
a large number of CPUs, there can also be a fair amount of spinlock
contention on the isec_lock if many tasks are exiting at the same time.

This patch changes the code to check the state of the list first
before taking the lock and attempting to dequeue it. As this function
is called indirectly from __destroy_inode(), there can't be another
instance of inode_free_security() running on the same inode.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 security/selinux/hooks.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

v1->v2:
 - Take out the second list_empty() test inside the lock.

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7dade28..e5cdad7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -254,10 +254,19 @@ static void inode_free_security(struct inode *inode)
 	struct inode_security_struct *isec = inode->i_security;
 	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 
-	spin_lock(&sbsec->isec_lock);
-	if (!list_empty(&isec->list))
+	/*
+	 * As not all inode security structures are in a list, we check for
+	 * empty list outside of the lock to make sure that we won't waste
+	 * time taking a lock doing nothing. As inode_free_security() is
+	 * being called indirectly from __destroy_inode(), there is no way
+	 * there can be two or more concurrent calls. So doing the list_empty()
+	 * test outside the loop should be safe.
+	 */
+	if (!list_empty(&isec->list)) {
+		spin_lock(&sbsec->isec_lock);
 		list_del_init(&isec->list);
-	spin_unlock(&sbsec->isec_lock);
+		spin_unlock(&sbsec->isec_lock);
+	}
 
 	/*
 	 * The inode may still be referenced in a path walk and
-- 
1.7.1
