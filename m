From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 Daniel Jurgens <danielj@mellanox.com>, Doug Ledford
 <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 12 Jun 2018 10:09:06 +0200
Message-ID: <20180612080912.7827-8-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 07/13] selinux: Cleanup printk logging in selinuxfs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/selinuxfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c0cadbc5f85c..2adfade99945 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -620,7 +620,7 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
 		goto out;
 	}
@@ -956,7 +956,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
 		goto out;
 	}
@@ -1147,7 +1147,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
 		goto out;
 	}
@@ -1996,7 +1996,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		goto err;
 	return 0;
 err:
-	printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
+	pr_err("SELinux: %s:  failed while creating inodes\n",
 		__func__);
 
 	selinux_fs_info_free(sb);
@@ -2046,7 +2046,7 @@ static int __init init_sel_fs(void)
 
 	selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
 	if (IS_ERR(selinuxfs_mount)) {
-		printk(KERN_ERR "selinuxfs:  could not mount!\n");
+		pr_err("selinuxfs:  could not mount!\n");
 		err = PTR_ERR(selinuxfs_mount);
 		selinuxfs_mount = NULL;
 	}
-- 
2.15.1
