Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LEUlXG016399
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 10:30:47 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LEUkTB001221
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:30:47 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/9] LSM: Permit commit_creds() to take a const pointer
To: serge.hallyn@canonical.com, eparis@redhat.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        David Howells <dhowells@redhat.com>, Eric Paris <eparis@redhat.com>
Date: Thu, 21 Apr 2011 15:30:40 +0100
Message-ID: <20110421143040.31318.75379.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

Permit commit_creds() to take a pointer to an already published set of
credentials (which will have a const pointer).  commit_creds() doesn't actually
modify the credentials it is given (barring the usage count), so this shouldn't
be a problem.

Signed-off-by: David Howells <dhowells@redhat.com>
Cc: Eric Paris <eparis@redhat.com>
---

 include/linux/cred.h |    2 +-
 kernel/cred.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 9aeeb0b..6a9cec4 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -157,7 +157,7 @@ extern const struct cred *get_task_cred(struct task_struct *);
 extern struct cred *cred_alloc_blank(void);
 extern struct cred *prepare_creds(void);
 extern struct cred *prepare_exec_creds(void);
-extern int commit_creds(struct cred *);
+extern int commit_creds(const struct cred *);
 extern void abort_creds(struct cred *);
 extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
diff --git a/kernel/cred.c b/kernel/cred.c
index 5557b55..1873e87 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -464,7 +464,7 @@ error_put:
  * Always returns 0 thus allowing this function to be tail-called at the end
  * of, say, sys_setgid().
  */
-int commit_creds(struct cred *new)
+int commit_creds(const struct cred *new)
 {
 	struct task_struct *task = current;
 	const struct cred *old = task->real_cred;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
