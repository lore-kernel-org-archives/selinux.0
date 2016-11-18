From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, paul@paul-moore.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: normalize input to /sys/fs/selinux/enforce
Date: Fri, 18 Nov 2016 09:30:38 -0500
Message-Id: <1479479438-7123-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

At present, one can write any signed integer value to
/sys/fs/selinux/enforce and it will be stored,
e.g. echo -1 > /sys/fs/selinux/enforce or echo 2 >
/sys/fs/selinux/enforce. This makes no real difference
to the kernel, since it only ever cares if it is zero or non-zero,
but some userspace code compares it with 1 to decide if SELinux
is enforcing, and this could confuse it. Only a process that is
already root and is allowed the setenforce permission in SELinux
policy can write to /sys/fs/selinux/enforce, so this is not considered
to be a security issue, but it should be fixed.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/selinuxfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 72c145d..4c3e439 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -163,6 +163,8 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	if (sscanf(page, "%d", &new_value) != 1)
 		goto out;
 
+	new_value = !!new_value;
+
 	if (new_value != selinux_enforcing) {
 		length = task_has_security(current, SECURITY__SETENFORCE);
 		if (length)
-- 
2.7.4
