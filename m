From: shivnandan.k@samsung.com
To: sds@tycho.nsa.gov, james.l.morris@oracle.com, eparis@parisplace.org,
 selinux@tycho.nsa.gov
Subject: [PATCH] Security: List corruption occured during file system
 automation test
Date: Wed, 13 Aug 2014 17:04:13 +0530
Message-id: <1407929653-27228-1-git-send-email-shivnandan.k@samsung.com>
Cc: mohammad.a2@samsung.com, ashish.kalra@samsung.com, vidushi.koul@samsung.com,
 linux-kernel@vger.kernel.org, shiv.jnumca08@gmail.com, cpgs@samsung.com,
 rajat.suri@samsung.com, shivnandan.k@samsung.com, narendra.m1@samsung.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Shivnandan Kumar <shivnandan.k@samsung.com>

List element was freed by  inode_free_security and then it uses rcu
element to point inode_free_rcu, since it inside a union so it
shares memory, sb_finish_set_opts now also try to free list element,
but since it is overriden by rcu element , it found list is corrupted
which leads to kernel panic, We have removed union element so now
memory is not shared by list and rcu element

Signed-off-by: Shivnandan Kumar <shivnandan.k@samsung.com>
---
 selinux/include/objsec.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/selinux/include/objsec.h b/selinux/include/objsec.h
index 7b1830b..2ba21ca 100644
--- a/selinux/include/objsec.h
+++ b/selinux/include/objsec.h
@@ -38,10 +38,8 @@ struct task_security_struct {
 
 struct inode_security_struct {
 	struct inode *inode;	/* back pointer to inode object */
-	union {
-		struct list_head list;	/* list of inode_security_struct */
-		struct rcu_head rcu;	/* for freeing the inode_security_struct */
-	};
+	struct list_head list;	/* list of inode_security_struct */
+	struct rcu_head rcu;	/* for freeing the inode_security_struct */
 	u32 task_sid;		/* SID of creating task */
 	u32 sid;		/* SID of this object */
 	u16 sclass;		/* security class of this object */
-- 
1.7.9.5
