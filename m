Subject: [PATCH] selinux:  Fix send_sigiotask hook
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, David Howells <dhowells@redhat.com>
Content-Type: text/plain
Date: Mon, 04 May 2009 15:43:18 -0400
Message-Id: <1241466198.3023.237.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The CRED patch incorrectly converted the SELinux send_sigiotask hook to
use the current task SID rather than the target task SID in its
permission check, yielding the wrong permission check.  This fixes the
hook function.  Detected by the ltp selinux testsuite and confirmed to
correct the test failure.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ba808ef..2fcad7c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3153,7 +3153,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 				       struct fown_struct *fown, int signum)
 {
 	struct file *file;
-	u32 sid = current_sid();
+	u32 sid = task_sid(tsk);
 	u32 perm;
 	struct file_security_struct *fsec;
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
