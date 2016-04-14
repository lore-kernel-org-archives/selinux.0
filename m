From: Prarit Bhargava <prarit@redhat.com>
To: linux-security-module@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Perepechko <anserper@ya.ru>,
 Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>, Paul Moore <pmoore@redhat.com>,
 David Howells <dhowells@redhat.com>
Subject: [PATCH] security/selinux: Change bool variable name to index.
Date: Thu, 14 Apr 2016 10:40:57 -0400
Message-Id: <1460644857-29218-1-git-send-email-prarit@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

security_get_bool_value(int bool) argument "bool" conflicts with in-kernel
macros such as BUILD_BUG().  This patch changes this to index which isn't
a type.

Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>
Cc: James Morris <james.l.morris@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andrew Perepechko <anserper@ya.ru>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: selinux@tycho.nsa.gov
Cc: Eric Paris <eparis@redhat.com>
Cc: Paul Moore <pmoore@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 security/selinux/include/conditional.h |    2 +-
 security/selinux/ss/services.c         |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
index 67ce7a8..ff4fddc 100644
--- a/security/selinux/include/conditional.h
+++ b/security/selinux/include/conditional.h
@@ -17,6 +17,6 @@ int security_get_bools(int *len, char ***names, int **values);
 
 int security_set_bools(int len, int *values);
 
-int security_get_bool_value(int bool);
+int security_get_bool_value(int index);
 
 #endif
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ebda973..89df646 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2696,7 +2696,7 @@ out:
 	return rc;
 }
 
-int security_get_bool_value(int bool)
+int security_get_bool_value(int index)
 {
 	int rc;
 	int len;
@@ -2705,10 +2705,10 @@ int security_get_bool_value(int bool)
 
 	rc = -EFAULT;
 	len = policydb.p_bools.nprim;
-	if (bool >= len)
+	if (index >= len)
 		goto out;
 
-	rc = policydb.bool_val_to_struct[bool]->state;
+	rc = policydb.bool_val_to_struct[index]->state;
 out:
 	read_unlock(&policy_rwlock);
 	return rc;
-- 
1.7.9.3
