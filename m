From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 3/3] selinux: fix overflow and 0 length allocations
Date: Tue, 23 Aug 2016 13:49:25 -0700
Message-Id: <1471985365-1197-3-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
References: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
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
 security/selinux/ss/conditional.c | 3 +++
 security/selinux/ss/policydb.c    | 4 ++++
 security/selinux/ss/private.h     | 7 +++++++
 3 files changed, 14 insertions(+)
 create mode 100644 security/selinux/ss/private.h

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 456e1a9..ecc0fb6 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -16,6 +16,7 @@
 #include "security.h"
 #include "conditional.h"
 #include "services.h"
+#include "private.h"
 
 /*
  * cond_evaluate_expr evaluates a conditional expr
@@ -242,6 +243,8 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 		goto err;
 
 	len = le32_to_cpu(buf[2]);
+	if (zero_or_saturated(len))
+		goto err;
 
 	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_KERNEL);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 4b24385..0e881f3 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -38,6 +38,7 @@
 #include "conditional.h"
 #include "mls.h"
 #include "services.h"
+#include "private.h"
 
 #define _DEBUG_HASHES
 
@@ -1094,6 +1095,9 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 	int rc;
 	char *str;
 
+	if (zero_or_saturated(len))
+		return -EINVAL;
+
 	str = kmalloc(len + 1, flags);
 	if (!str)
 		return -ENOMEM;
diff --git a/security/selinux/ss/private.h b/security/selinux/ss/private.h
new file mode 100644
index 0000000..0e81a78
--- /dev/null
+++ b/security/selinux/ss/private.h
@@ -0,0 +1,7 @@
+#ifndef PRIVATE_H_
+#define PRIVATE_H_
+
+#define is_saturated(x) (x == (typeof(x))-1)
+#define zero_or_saturated(x) ((x == 0) || is_saturated(x))
+
+#endif
-- 
1.9.1
