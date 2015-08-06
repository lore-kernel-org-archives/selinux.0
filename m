From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: fail hard on invalid property_contexts entries
Date: Thu,  6 Aug 2015 14:55:20 -0400
Message-Id: <1438887320-17995-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fail hard on any error during property_contexts (or service_contexts)
processing.  We want to catch any such errors early and not proceed
with a potentially mislabeled system.

Also remove some obsoleted tests for NULL; they were necessary
in earlier versions of the code where we were copying the strings
at this point, but no longer.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_android_property.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
index 4af9896..af06c4a 100644
--- a/libselinux/src/label_android_property.c
+++ b/libselinux/src/label_android_property.c
@@ -94,11 +94,12 @@ static int process_line(struct selabel_handle *rec,
 	if (items <= 0)
 		return items;
 	if (items != 2) {
-		selinux_log(SELINUX_WARNING,
-			    "%s:  line %u is missing fields, skipping\n", path,
+		selinux_log(SELINUX_ERROR,
+			    "%s:  line %u is missing fields\n", path,
 			    lineno);
 		free(prop);
-		return 0;
+		errno = EINVAL;
+		return -1;
 	}
 
 	if (pass == 0) {
@@ -107,26 +108,15 @@ static int process_line(struct selabel_handle *rec,
 	} else if (pass == 1) {
 		/* On the second pass, process and store the specification in spec. */
 		spec_arr[nspec].property_key = prop;
-		if (!spec_arr[nspec].property_key) {
-			selinux_log(SELINUX_WARNING,
-				    "%s:  out of memory at line %u on prop %s\n",
-				    path, lineno, prop);
-			return -1;
-		}
-
 		spec_arr[nspec].lr.ctx_raw = context;
-		if (!spec_arr[nspec].lr.ctx_raw) {
-			selinux_log(SELINUX_WARNING,
-				    "%s:  out of memory at line %u on context %s\n",
-				    path, lineno, context);
-			return -1;
-		}
 
 		if (rec->validating) {
 			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
-				selinux_log(SELINUX_WARNING,
+				selinux_log(SELINUX_ERROR,
 					    "%s:  line %u has invalid context %s\n",
 					    path, lineno, spec_arr[nspec].lr.ctx_raw);
+				errno = EINVAL;
+				return -1;
 			}
 		}
 	}
-- 
2.1.0
