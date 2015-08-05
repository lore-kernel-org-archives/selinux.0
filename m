From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: test for file_contexts.bin format
Date: Wed,  5 Aug 2015 16:26:08 -0400
Message-Id: <1438806368-23238-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Check to see if the file whose path is passed to selabel_open() starts
with the file_contexts.bin magic number, and if so, automatically
treat it as a file_contexts.bin file.  This allows one to open
file_contexts.bin formatted files without necessarily having a .bin
file suffix.  This removes the need for the previously added
.bin file suffix test.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 3509394..04b3826 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -98,7 +98,7 @@ static int nodups_specs(struct saved_data *data, const char *path)
 }
 
 static int load_mmap(struct selabel_handle *rec, const char *path,
-						    struct stat *sb)
+		     struct stat *sb, bool isbinary)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	char mmap_path[PATH_MAX + 1];
@@ -112,8 +112,8 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 	uint32_t i, magic, version;
 	uint32_t entry_len, stem_map_len, regex_array_len;
 
-	len = strlen(path);
-	if (len > 4 && !strcmp(&path[len-4], ".bin")) {
+	if (isbinary) {
+		len = strlen(path);
 		if (len >= sizeof(mmap_path))
 			return -1;
 		strcpy(mmap_path, path);
@@ -413,6 +413,8 @@ static int process_file(const char *path, const char *suffix,
 	char *line_buf = NULL;
 	int rc;
 	char stack_path[PATH_MAX + 1];
+	bool isbinary = false;
+	uint32_t magic;
 
 	/* append the path suffix if we have one */
 	if (suffix) {
@@ -436,6 +438,21 @@ static int process_file(const char *path, const char *suffix,
 			errno = EINVAL;
 			return -1;
 		}
+
+		if (fread(&magic, sizeof magic, 1, fp) != 1) {
+			errno = EINVAL;
+			fclose(fp);
+			return -1;
+		}
+
+		if (magic == SELINUX_MAGIC_COMPILED_FCONTEXT) {
+			/* file_contexts.bin format */
+			fclose(fp);
+			fp = NULL;
+			isbinary = true;
+		} else {
+			rewind(fp);
+		}
 	} else {
 		/*
 		 * Text file does not exist, so clear the timestamp
@@ -445,7 +462,7 @@ static int process_file(const char *path, const char *suffix,
 		sb.st_mtime = 0;
 	}
 
-	rc = load_mmap(rec, path, &sb);
+	rc = load_mmap(rec, path, &sb, isbinary);
 	if (rc == 0)
 		goto out;
 
-- 
2.1.0
