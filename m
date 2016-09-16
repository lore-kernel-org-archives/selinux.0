From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov
Subject: [PATCH v4] libselinux: correct error path to always try text
Date: Fri, 16 Sep 2016 11:32:16 -0700
Message-Id: <1474050736-8237-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

patch 5e15a52aaa cleans up the process_file() routine,
but introduced a bug. If the binary file cannot be
opened, always attempt to fall back to the textual file,
this was not occurring.

The logic should be:
1. Open the newest file between base path + suffix and
   base_path + suffix + ".bin"
2. If anything fails, attempt to load the oldest file.

The result, with a concrete example, would be:
If file_contexts is the newest file, and it cannot be
processed, the code will fall back to file_contexts.bin
and vice versa.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/label_file.c | 48 +++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 9faecdb..4f3700c 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -447,7 +447,7 @@ static bool fcontext_is_binary(FILE *fp)
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 static FILE *open_file(const char *path, const char *suffix,
-		       char *save_path, size_t len, struct stat *sb)
+	       char *save_path, size_t len, struct stat *sb, bool open_oldest)
 {
 	unsigned int i;
 	int rc;
@@ -493,9 +493,17 @@ static FILE *open_file(const char *path, const char *suffix,
 		 * includes equality. This provides a precedence on
 		 * secondary suffixes even when the timestamp is the
 		 * same. Ie choose file_contexts.bin over file_contexts
-		 * even if the time stamp is the same.
+		 * even if the time stamp is the same. Invert this logic
+		 * on open_oldest set to true. The idea is that if the
+		 * newest file failed to process, we can attempt to
+		 * process the oldest. The logic here is subtle and depends
+		 * on the array ordering in fdetails for the case when time
+		 * stamps are the same.
 		 */
-		if (fdetails[i].sb.st_mtime >= found->sb.st_mtime) {
+		if ((!open_oldest
+			&& fdetails[i].sb.st_mtime >= found->sb.st_mtime)
+			|| (open_oldest
+			&& fdetails[i].sb.st_mtime < found->sb.st_mtime)) {
 			found = &fdetails[i];
 			strcpy(save_path, path);
 		}
@@ -515,24 +523,34 @@ static int process_file(const char *path, const char *suffix,
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
+	 * pass opens the oldest file. If both passes fail, its a fatal error.
+	 */
+	for (i = 0; i < 2; i++) {
+		fp = open_file(path, suffix, found_path, sizeof(found_path),
+			&sb, i > 0);
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
+			rc = digest_add_specfile(digest, fp, NULL, sb.st_size,
+				found_path);
 
-	rc = digest_add_specfile(digest, fp, NULL, sb.st_size, found_path);
-out:
-	fclose(fp);
-	return rc;
+		fclose(fp);
+
+		if (!rc)
+			return 0;
+	}
+	return -1;
 }
 
 static void closef(struct selabel_handle *rec);
-- 
1.9.1
