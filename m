Date: Thu, 12 Jun 2008 02:01:54 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: use do_each_thread as a proper do/while block
Message-ID: <Xine.LNX.4.64.0806120201140.5379@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please review.

----
Use do_each_thread as a proper do/while block.  Sparse complained.

Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/hooks.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6e8d0e9..4130d64 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5196,12 +5196,12 @@ static int selinux_setprocattr(struct task_struct *p,
 			struct task_struct *g, *t;
 			struct mm_struct *mm = p->mm;
 			read_lock(&tasklist_lock);
-			do_each_thread(g, t)
+			do_each_thread(g, t) {
 				if (t->mm == mm && t != p) {
 					read_unlock(&tasklist_lock);
 					return -EPERM;
 				}
-			while_each_thread(g, t);
+			} while_each_thread(g, t);
 			read_unlock(&tasklist_lock);
 		}
 
-- 
1.5.5.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
