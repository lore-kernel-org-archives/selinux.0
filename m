Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9IIvVjc022041
 for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2016 14:57:31 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/7] libsepol/cil: Check if identifier is NULL when verifying
 name
Date: Tue, 18 Oct 2016 14:58:45 -0400
Message-Id: <1476817128-16108-5-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Nicolas Looss found while fuzzing secilc with AFL that the statement
"(class C (()))" will cause a segfault.

When CIL checks the syntax of the class statement it sees "(())" as a
valid permission list, but since "()" is not an identifier a NULL is
passed as the string for name verification. A segfault occurs because
name verification assumes that the string being checked is non-NULL.

Check if identifier is NULL when verifying name.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_verify.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 038f77a..47dcfaa 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -50,9 +50,15 @@
 int __cil_verify_name(const char *name)
 {
 	int rc = SEPOL_ERR;
-	int len = strlen(name);
+	int len;
 	int i = 0;
 
+	if (name == NULL) {
+		cil_log(CIL_ERR, "Name is NULL\n");
+		goto exit;
+	}
+
+	len = strlen(name);
 	if (len >= CIL_MAX_NAME_LENGTH) {
 		cil_log(CIL_ERR, "Name length greater than max name length of %d", 
 			CIL_MAX_NAME_LENGTH);
-- 
2.7.4
