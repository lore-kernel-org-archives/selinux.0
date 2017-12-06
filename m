From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Date: Wed, 06 Dec 2017 11:02:54 -0500
Message-ID: <151257617428.11847.3254426726512996878.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux: skip bounded transition processing if the
 policy isn't loaded
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

We can't do anything reasonable in security_bounded_transition() if we
don't have a policy loaded, and in fact we could run into problems
with some of the code inside expecting a policy.  Fix these problems
like we do many others in security/selinux/ss/services.c by checking
to see if the policy is loaded (ss_initialized) and returning quickly
if it isn't.

Reported-by: syzbot <syzkaller-bugs@googlegroups.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/ss/services.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d05496deb229..8900ea5cbabf 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -867,6 +867,9 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 	int index;
 	int rc;
 
+	if (!ss_initialized)
+		return 0;
+
 	read_lock(&policy_rwlock);
 
 	rc = -EINVAL;
