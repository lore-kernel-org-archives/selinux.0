From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 paul@paul-moore.com
Subject: [PATCH v2] selinux: fix overflow and 0 length allocations
Date: Tue, 30 Aug 2016 09:28:11 -0700
Message-Id: <1472574491-31233-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Throughout the SE Linux LSM, values taken from sepolicy are
used in places where length == 0 or length == <saturated>
matter, find and fix these.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 security/selinux/ss/conditional.c | 2 ++
 security/selinux/ss/policydb.c    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 456e1a9..34afead 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -242,6 +242,8 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 		goto err;
 
 	len = le32_to_cpu(buf[2]);
+	if (((len == 0) || (len == (u32)-1)))
+		goto err;
 
 	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_KERNEL);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 4b24385..8c661f0 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1094,6 +1094,9 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 	int rc;
 	char *str;
 
+	if ((len == 0) || (len == (u32)-1))
+		return -EINVAL;
+
 	str = kmalloc(len + 1, flags);
 	if (!str)
 		return -ENOMEM;
-- 
1.9.1
