Message-ID: <1427158895.16851.70.camel@perches.com>
Subject: [PATCH] selinuxfs: Fix sel_write_enforce broken return value
From: Joe Perches <joe@perches.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov
Date: Mon, 23 Mar 2015 18:01:35 -0700
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Return a negative error value like the rest
of the entries in this function.

Signed-off-by: Joe Perches <joe@perches.com>
---
Maybe this should be stable, it goes back to
commit b77a493b1dc8 ("SELinux: standardize return code
handling in selinuxfs.c") back in Nov 2010, but it's
guarded by a #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
so it probably doesn't matter much.

 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 1684bcc..5fde343 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -152,7 +152,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 		goto out;
 
 	/* No partial writes. */
-	length = EINVAL;
+	length = -EINVAL;
 	if (*ppos != 0)
 		goto out;
 
