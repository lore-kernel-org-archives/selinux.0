From: Geliang Tang <geliangtang@163.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: Geliang Tang <geliangtang@163.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selinux: ioctl_has_perm should be static
Date: Sun, 27 Sep 2015 23:10:24 +0800
Message-Id: <ff802942c34154cceee8ab2256d8c5ce6a665d21.1443366384.git.geliangtang@163.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes the following sparse warning:

 security/selinux/hooks.c:3242:5: warning: symbol 'ioctl_has_perm' was
 not declared. Should it be static?

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 84d21f9..5265c74 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3239,7 +3239,7 @@ static void selinux_file_free_security(struct file *file)
  * Check whether a task has the ioctl permission and cmd
  * operation to an inode.
  */
-int ioctl_has_perm(const struct cred *cred, struct file *file,
+static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		u32 requested, u16 cmd)
 {
 	struct common_audit_data ad;
-- 
2.5.0
