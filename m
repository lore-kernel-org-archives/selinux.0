From: Sebastien Buisson <sbuisson.ddn@gmail.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Cc: serge@hallyn.com, james.l.morris@oracle.com, eparis@parisplace.org,
 sds@tycho.nsa.gov, paul@paul-moore.com,
 Sebastien Buisson <sbuisson@ddn.com>
Subject: [PATCH v2 2/2] selinux: expose policy brief via selinuxfs
Date: Fri,  5 May 2017 19:10:53 +0900
Message-Id: <1493979053-16691-2-git-send-email-sbuisson@ddn.com>
In-Reply-To: <1493979053-16691-1-git-send-email-sbuisson@ddn.com>
References: <1493979053-16691-1-git-send-email-sbuisson@ddn.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Expose policy brief via selinuxfs.

Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
---
 security/selinux/selinuxfs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index b959ee7..8782b79 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -101,6 +101,7 @@ enum sel_inos {
 	SEL_STATUS,	/* export current status using mmap() */
 	SEL_POLICY,	/* allow userspace to read the in kernel policy */
 	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
+	SEL_POLICYBRIEF,/* return policy summary */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -316,6 +317,29 @@ static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_read_policybrief(struct file *filp, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	char *tmpbuf;
+	size_t len;
+	ssize_t rc;
+
+	rc = security_policydb_brief(&tmpbuf, &len, true);
+	if (rc)
+		return rc;
+
+	rc = simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
+
+	kfree(tmpbuf);
+
+	return rc;
+}
+
+static const struct file_operations sel_policybrief_ops = {
+	.read		= sel_read_policybrief,
+	.llseek		= generic_file_llseek,
+};
+
 /* declaration for sel_write_load */
 static int sel_make_bools(void);
 static int sel_make_classes(void);
@@ -1829,6 +1853,8 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
+		[SEL_POLICYBRIEF] = {"policybrief", &sel_policybrief_ops,
+				     S_IRUGO},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
-- 
1.8.3.1
