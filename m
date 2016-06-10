From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] selinuxfs: fix type mismatch
Date: Fri, 10 Jun 2016 23:14:26 +0200
Message-Id: <1465593266-10135-1-git-send-email-xypron.glpk@gmx.de>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

avc_cache_threshold is of type unsigned int.

Do not use a signed new_value in
sscanf(page, "%u", &new_value).

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 1b1fd27..0765c5b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1347,7 +1347,7 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 {
 	char *page;
 	ssize_t ret;
-	int new_value;
+	unsigned int new_value;
 
 	ret = task_has_security(current, SECURITY__SETSECPARAM);
 	if (ret)
-- 
2.1.4
