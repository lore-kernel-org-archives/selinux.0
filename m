From: Sebastien Buisson <sbuisson.ddn@gmail.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Cc: serge@hallyn.com, james.l.morris@oracle.com, eparis@parisplace.org,
 sds@tycho.nsa.gov, paul@paul-moore.com, danielj@mellanox.com,
 Sebastien Buisson <sbuisson@ddn.com>
Subject: [PATCH 3/3] selinux: expose policy SHA256 checksum via selinuxfs
Date: Thu, 27 Apr 2017 00:02:16 +0900
Message-Id: <1493218936-18522-3-git-send-email-sbuisson@ddn.com>
In-Reply-To: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Expose policy SHA256 checksum via selinuxfs.

Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
---
 security/selinux/selinuxfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ce71718..b2d5deb 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 #include <linux/kobject.h>
 #include <linux/ctype.h>
+#include <crypto/sha.h>
 
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
@@ -99,6 +100,7 @@ enum sel_inos {
 	SEL_STATUS,	/* export current status using mmap() */
 	SEL_POLICY,	/* allow userspace to read the in kernel policy */
 	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
+	SEL_POLICYCKSUM,/* return policy SHA256 checkum */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -313,6 +315,22 @@ static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_read_policycksum(struct file *filp, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	size_t tmpbuflen = SHA256_DIGEST_SIZE*2 + 1;
+	char tmpbuf[tmpbuflen];
+	ssize_t length;
+
+	length = security_policydb_cksum(tmpbuf, tmpbuflen);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static const struct file_operations sel_policycksum_ops = {
+	.read		= sel_read_policycksum,
+	.llseek		= generic_file_llseek,
+};
+
 /* declaration for sel_write_load */
 static int sel_make_bools(void);
 static int sel_make_classes(void);
@@ -1825,6 +1843,8 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
+		[SEL_POLICYCKSUM] = {"policycksum", &sel_policycksum_ops,
+				     S_IRUGO},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
-- 
1.8.3.1
