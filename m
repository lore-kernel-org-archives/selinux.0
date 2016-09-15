From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov
Subject: [PATCH v3] libselinux: correct error path to always try text
Date: Thu, 15 Sep 2016 16:13:58 -0700
Message-Id: <1473981238-11051-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

patch 5e15a52aaa cleans up the process_file() but introduced
a bug. If the binary file cannot be opened, always attempt
to fall back to the textual file, this was not occurring.

The logic should be:
1. Open the newest file based on base path + suffix vs
   base_path + suffix + ".bin".
2. If anything fails, attempt base_path + suffix.

In the case that the file_contexts was the newest file and
used for processing fails, it will attempt the same failure
recovery, which will fail. It was decided to keep it this
was for simplicity.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/label_file.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 9faecdb..0dee059 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -447,7 +447,7 @@ static bool fcontext_is_binary(FILE *fp)
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 static FILE *open_file(const char *path, const char *suffix,
-		       char *save_path, size_t len, struct stat *sb)
+		       char *save_path, size_t len, struct stat *sb, bool force_text)
 {
 	unsigned int i;
 	int rc;
@@ -469,7 +469,11 @@ static FILE *open_file(const char *path, const char *suffix,
 		return NULL;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(fdetails); i++) {
+	size_t array_size = ARRAY_SIZE(fdetails);
+	if (force_text)
+		array_size--;
+
+	for (i = 0; i < array_size; i++) {
 
 		/* This handles the case if suffix is null */
 		path = rolling_append(stack_path, fdetails[i].suffix,
@@ -515,24 +519,33 @@ static int process_file(const char *path, const char *suffix,
 			  const char *prefix, struct selabel_digest *digest)
 {
 	int rc;
+	unsigned int i;
 	struct stat sb;
 	FILE *fp = NULL;
 	char found_path[PATH_MAX];
 
-	fp = open_file(path, suffix, found_path, sizeof(found_path), &sb);
-	if (fp == NULL)
-		return -1;
+	/*
+	 * first path open the newest modified file, if it fails, the second
+	 * pass falls through to the plain text file.
+	 */
+	for(i=0; i < 2; i++) {
+		fp = open_file(path, suffix, found_path, sizeof(found_path), &sb,
+				i > 0);
+		if (fp == NULL)
+			return -1;
 
-	rc = fcontext_is_binary(fp) ?
-			load_mmap(fp, sb.st_size, rec, found_path) :
-			process_text_file(fp, prefix, rec, found_path);
-	if (rc < 0)
-		goto out;
+		rc = fcontext_is_binary(fp) ?
+				load_mmap(fp, sb.st_size, rec, found_path) :
+				process_text_file(fp, prefix, rec, found_path);
+		if (!rc)
+			rc = digest_add_specfile(digest, fp, NULL, sb.st_size, found_path);
 
-	rc = digest_add_specfile(digest, fp, NULL, sb.st_size, found_path);
-out:
-	fclose(fp);
-	return rc;
+		fclose(fp);
+
+		if(!rc)
+			return 0;
+	}
+	return -1;
 }
 
 static void closef(struct selabel_handle *rec);
-- 
1.9.1
