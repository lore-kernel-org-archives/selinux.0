From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, sds@tycho.nsa.gov, Gary Tierney <gary.tierney@gmx.com>
Subject: [PATCH 1/2] selinux: log errors when loading new policy
Date: Sat, 17 Dec 2016 20:48:38 +0000
Message-Id: <1482007719-14313-2-git-send-email-gary.tierney@gmx.com>
In-Reply-To: <1482007719-14313-1-git-send-email-gary.tierney@gmx.com>
References: <1482007719-14313-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Adds error and warning messages to the codepaths which can fail when
loading a new policy.  If a policy fails to load, an error message will
be printed to dmesg with a description of what failed.  Previously if
there was an error during policy loading there would be no indication
that it failed.

Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
---
 security/selinux/selinuxfs.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 0aac402..2139cc7 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -522,20 +522,32 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		goto out;
 
 	length = security_load_policy(data, count);
-	if (length)
+	if (length) {
+		pr_err("SELinux: %s: failed to load policy\n",
+		      __func__);
 		goto out;
+	}
 
 	length = sel_make_bools();
-	if (length)
+	if (length) {
+		pr_warn("SELinux: %s: failed to load policy booleans\n",
+		       __func__);
 		goto out1;
+	}
 
 	length = sel_make_classes();
-	if (length)
+	if (length) {
+		pr_warn("SELinux: %s: failed to load policy classes\n",
+		       __func__);
 		goto out1;
+	}
 
 	length = sel_make_policycap();
-	if (length)
+	if (length) {
+		pr_warn("SELinux: %s: failed to load policy capabilities\n",
+		       __func__);
 		goto out1;
+	}
 
 	length = count;
 
@@ -1299,9 +1311,13 @@ static int sel_make_bools(void)
 
 		isec = (struct inode_security_struct *)inode->i_security;
 		ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
-		if (ret)
+		if (ret) {
+			pr_warn_ratelimited("SELinux: %s: failed to lookup sid for %s\n",
+					   __func__, page);
 			goto out;
 
+		}
+
 		isec->sid = sid;
 		isec->initialized = LABEL_INITIALIZED;
 		inode->i_fop = &sel_bool_ops;
-- 
2.7.4
