Subject: [PATCH] SELinux: always check SIGCHLD in selinux_task_wait
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, roland@redhat.com
Content-Type: text/plain
Date: Mon, 22 Oct 2007 16:10:31 -0400
Message-Id: <1193083831.2950.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When checking if we can wait on a child we were looking at
p->exit_signal and trying to make the decision based on if the signal
would eventually be allowed.  One big flaw is that p->exit_signal is -1
for NPTL threads and so aignal_to_av was not actually checking SIGCHLD
which is what would have been sent.  Even is exit_signal was set to
something strange it wouldn't change the fact that the child was there
and needed to be waited on.  This patch just assumes wait is based on
SIGCHLD.  Specific permission checks are made when the child actually
attempts to send a signal.

This resolves the problem of things like using GDB on confined domains
such as in RH BZ 232371.  The confined domain did not have permission to
send a generic signal (exit_signal == -1) back to the unconfined GDB.
With this patch the GDB wait works and since the actual signal sent is
allowed everything functions as it should.

Signed-off-by: Eric Paris <eparis@redhat.com>

---
 security/selinux/hooks.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 24e1b18..9f3124b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2977,11 +2977,7 @@ static int selinux_task_prctl(int option,
 
 static int selinux_task_wait(struct task_struct *p)
 {
-	u32 perm;
-
-	perm = signal_to_av(p->exit_signal);
-
-	return task_has_perm(p, current, perm);
+	return task_has_perm(p, current, PROCESS__SIGCHLD);
 }
 
 static void selinux_task_reparent_to_init(struct task_struct *p)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
