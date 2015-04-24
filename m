From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: Binary modules do not support ioctl rules.
Date: Fri, 24 Apr 2015 14:25:13 -0400
Message-Id: <1429899913-19190-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Prevent writing a binary policy module if the source
included an ioctl operation rule because we do not support ioctl
operation rules in the binary module format.  It doesn't seem
worthwhile to introduce a new binary policy module version since
CIL is now merged and we will have to implement the support in CIL
regardless; might as well only support it in CIL modules.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/write.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 5e12d6b..6e78eb3 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1546,6 +1546,12 @@ static int avrule_write(avrule_t * avrule, struct policy_file *fp)
 	uint32_t buf[32], len;
 	class_perm_node_t *cur;
 
+	if (avrule->specified & AVRULE_OP) {
+		ERR(fp->handle, "module policy does not support ioctl operation"
+				" rules and one was specified");
+		return POLICYDB_ERROR;
+	}
+
 	items = 0;
 	buf[items++] = cpu_to_le32(avrule->specified);
 	buf[items++] = cpu_to_le32(avrule->flags);
@@ -1603,7 +1609,8 @@ static int avrule_write_list(avrule_t * avrules, struct policy_file *fp)
 
 	avrule = avrules;
 	while (avrule) {
-		avrule_write(avrule, fp);
+		if (avrule_write(avrule, fp))
+			return POLICYDB_ERROR;
 		avrule = avrule->next;
 	}
 
-- 
2.1.0
