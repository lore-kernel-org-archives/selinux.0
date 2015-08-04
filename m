From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: support file_contexts.bin without file_contexts
Date: Tue,  4 Aug 2015 11:26:11 -0400
Message-Id: <1438701971-2659-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Change the label_file backend in libselinux to support systems
that only have file_contexts.bin files installed and do not ship
a file_contexts file at all.  Only fail if neither file can be
loaded.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b927681..3252523 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -418,21 +418,32 @@ static int process_file(const char *path, const char *suffix,
 	}
 
 	/* Open the specification file. */
-	if ((fp = fopen(path, "r")) == NULL)
-		return -1;
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
+	fp = fopen(path, "r");
+	if (fp) {
+		__fsetlocking(fp, FSETLOCKING_BYCALLER);
 
-	if (fstat(fileno(fp), &sb) < 0)
-		return -1;
-	if (!S_ISREG(sb.st_mode)) {
-		errno = EINVAL;
-		return -1;
+		if (fstat(fileno(fp), &sb) < 0)
+			return -1;
+		if (!S_ISREG(sb.st_mode)) {
+			errno = EINVAL;
+			return -1;
+		}
+	} else {
+		/*
+		 * Text file does not exist, so clear the timestamp
+		 * so that we will always pass the timestamp comparison
+		 * with the bin file in load_mmap().
+		 */
+		sb.st_mtime = 0;
 	}
 
 	rc = load_mmap(rec, path, &sb);
 	if (rc == 0)
 		goto out;
 
+	if (!fp)
+		return -1; /* no text or bin file */
+
 	/*
 	 * Then do detailed validation of the input and fill the spec array
 	 */
@@ -446,7 +457,8 @@ static int process_file(const char *path, const char *suffix,
 
 out:
 	free(line_buf);
-	fclose(fp);
+	if (fp)
+		fclose(fp);
 	return rc;
 }
 
-- 
2.1.0
