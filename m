Subject: [PATCH] SELinux: hold tasklist_lock and siglock while waking
 wait_chldexit
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Tue, 04 Nov 2008 15:18:26 -0500
Message-Id: <1225829906.3320.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

SELinux has long been calling wake_up_interruptible() on
current->parent->signal->wait_chldexit without holding any locks.  It
appears that this operation should hold the tasklist_lock to dereference
current->parent and we should hold the siglock when waking up the
signal->wait_chldexit.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)


diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f85597a..1e45c6c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2269,7 +2269,9 @@ static void selinux_bprm_post_apply_creds(struct linux_binprm *bprm)
 	struct rlimit *rlim, *initrlim;
 	struct itimerval itimer;
 	struct bprm_security_struct *bsec;
+	struct sighand_struct *psig;
 	int rc, i;
+	unsigned long flags;
 
 	tsec = current->security;
 	bsec = bprm->security;
@@ -2330,7 +2332,12 @@ static void selinux_bprm_post_apply_creds(struct linux_binprm *bprm)
 
 	/* Wake up the parent if it is waiting so that it can
 	   recheck wait permission to the new task SID. */
+	read_lock_irq(&tasklist_lock);
+	psig = current->parent->sighand;
+	spin_lock_irqsave(&psig->siglock, flags);
 	wake_up_interruptible(&current->parent->signal->wait_chldexit);
+	spin_unlock_irqrestore(&psig->siglock, flags);
+	read_unlock_irq(&tasklist_lock);
 }
 
 /* superblock security operations */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
