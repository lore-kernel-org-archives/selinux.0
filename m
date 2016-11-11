From: Shailendra Verma <shailendra.v@samsung.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shailendra Verma <shailendra.v@samsung.com>,
 Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: vidushi.koul@samsung.com
Subject: [PATCH] Security: selinux - Improvement in code readability when
Date: Fri, 11 Nov 2016 14:18:40 +0530
Message-id: <1478854120-25311-1-git-send-email-shailendra.v@samsung.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: "Shailendra Verma" <shailendra.v@samsung.com>

There is no need to call kfree() if memdup_user() fails, as no memory
was allocated and the error in the error-valued pointer should be returned.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 security/selinux/selinuxfs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 72c145d..b6d0a23 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1166,7 +1166,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 
 	length = -EINVAL;
 	if (sscanf(page, "%d", &new_value) != 1)
-		goto out;
+		goto out1;
 
 	if (new_value)
 		new_value = 1;
@@ -1174,9 +1174,10 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	bool_pending_values[index] = new_value;
 	length = count;
 
+out1:
+	kfree(page);
 out:
 	mutex_unlock(&sel_mutex);
-	kfree(page);
 	return length;
 }
 
-- 
1.7.9.5
