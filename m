From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: fail hard on invalid file_contexts entries
Date: Thu,  6 Aug 2015 14:52:57 -0400
Message-Id: <1438887177-17699-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fail hard on any error during file_contexts processing.
We want to catch any such errors early and not proceed
with a potentially mislabeled system.  This was the original
logic but was loosened long ago to more gracefully handle
user error in Linux distributions (a single typo could lead
to not being able to label anything, even if the relevant
entry for the files in question was correct).  However,
in Android, file_contexts is not modified at runtime and
we want to fully validate it at build, so we want to fail
hard in these cases, and in modern Linux, file_contexts is
modified using tools (semanage, semodule) and a library
(libsemanage) that should already be fully validating values
before adding entries, and that trigger a setfiles -c validation
(equivalent to Android checkfc) before committing the transaction.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index db961ba..e6a687a 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -392,12 +392,13 @@ static inline int process_line(struct selabel_handle *rec,
 		return items;
 
 	if (items < 2) {
-		COMPAT_LOG(SELINUX_WARNING,
-			    "%s:  line %u is missing fields, skipping\n", path,
+		COMPAT_LOG(SELINUX_ERROR,
+			    "%s:  line %u is missing fields\n", path,
 			    lineno);
 		if (items == 1)
 			free(regex);
-		return 0;
+		errno = EINVAL;
+		return -1;
 	} else if (items == 2) {
 		/* The type field is optional. */
 		context = type;
@@ -424,10 +425,12 @@ static inline int process_line(struct selabel_handle *rec,
 	spec_arr[nspec].regex_str = regex;
 	if (rec->validating &&
 			    compile_regex(data, &spec_arr[nspec], &errbuf)) {
-		COMPAT_LOG(SELINUX_WARNING,
+		COMPAT_LOG(SELINUX_ERROR,
 			   "%s:  line %u has invalid regex %s:  %s\n",
 			   path, lineno, regex,
 			   (errbuf ? errbuf : "out of memory"));
+		errno = EINVAL;
+		return -1;
 	}
 
 	/* Convert the type string to a mode format */
@@ -437,10 +440,11 @@ static inline int process_line(struct selabel_handle *rec,
 		mode_t mode = string_to_mode(type);
 
 		if (mode == (mode_t)-1) {
-			COMPAT_LOG(SELINUX_WARNING,
+			COMPAT_LOG(SELINUX_ERROR,
 				   "%s:  line %u has invalid file type %s\n",
 				   path, lineno, type);
-			mode = 0;
+			errno = EINVAL;
+			return -1;
 		}
 		spec_arr[nspec].mode = mode;
 	}
-- 
2.1.0
