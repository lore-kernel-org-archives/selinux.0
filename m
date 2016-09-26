From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] sefcontext_compile: do not fail silently
Date: Mon, 26 Sep 2016 15:28:09 -0400
Message-Id: <1474918089-7298-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sefcontext_compile was failing silently on various error paths.
Generate a suitable error message to stderr for each error.

Before:
$ sefcontext_compile /path/to/unwritabledirectory/file_contexts
<no output, although non-zero exit status>

After:
$ sefcontext_compile /path/to/unwritabledirectory/file_contexts
sefcontext_compile: mkstemp /path/to/unwritabledirectory/file_contexts.binNmQJqa failed: Permission denied

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/utils/sefcontext_compile.c | 48 +++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 70853e7..ebd1264 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -309,7 +309,7 @@ int main(int argc, char *argv[])
 
 	path = argv[optind];
 	if (stat(path, &buf) < 0) {
-		fprintf(stderr, "Can not stat: %s: %m\n", path);
+		fprintf(stderr, "%s: could not stat: %s: %s\n", argv[0], path, strerror(errno));
 		exit(EXIT_FAILURE);
 	}
 
@@ -318,14 +318,14 @@ int main(int argc, char *argv[])
 		policy_fp = fopen(policy_file, "r");
 
 		if (!policy_fp) {
-			fprintf(stderr, "Failed to open policy: %s\n",
-							    policy_file);
+			fprintf(stderr, "%s: failed to open %s: %s\n",
+				argv[0], policy_file, strerror(errno));
 			exit(EXIT_FAILURE);
 		}
 
 		if (sepol_set_policydb_from_file(policy_fp) < 0) {
-			fprintf(stderr, "Failed to load policy: %s\n",
-							    policy_file);
+			fprintf(stderr, "%s: failed to load policy from %s\n",
+				argv[0], policy_file);
 			fclose(policy_fp);
 			exit(EXIT_FAILURE);
 		}
@@ -334,7 +334,7 @@ int main(int argc, char *argv[])
 	/* Generate dummy handle for process_line() function */
 	rec = (struct selabel_handle *)calloc(1, sizeof(*rec));
 	if (!rec) {
-		fprintf(stderr, "Failed to calloc handle\n");
+		fprintf(stderr, "%s: calloc failed: %s\n", argv[0], strerror(errno));
 		if (policy_fp)
 			fclose(policy_fp);
 		exit(EXIT_FAILURE);
@@ -353,7 +353,7 @@ int main(int argc, char *argv[])
 
 	data = (struct saved_data *)calloc(1, sizeof(*data));
 	if (!data) {
-		fprintf(stderr, "Failed to calloc saved_data\n");
+		fprintf(stderr, "%s: calloc failed: %s\n", argv[0], strerror(errno));
 		free(rec);
 		if (policy_fp)
 			fclose(policy_fp);
@@ -363,46 +363,62 @@ int main(int argc, char *argv[])
 	rec->data = data;
 
 	rc = process_file(rec, path);
-	if (rc < 0)
+	if (rc < 0) {
+		fprintf(stderr, "%s: process_file failed\n", argv[0]);
 		goto err;
+	}
 
 	rc = sort_specs(data);
-	if (rc)
+	if (rc) {
+		fprintf(stderr, "%s: sort_specs failed\n", argv[0]);
 		goto err;
+	}
 
 	if (out_file)
 		rc = snprintf(stack_path, sizeof(stack_path), "%s", out_file);
 	else
 		rc = snprintf(stack_path, sizeof(stack_path), "%s.bin", path);
 
-	if (rc < 0 || rc >= (int)sizeof(stack_path))
+	if (rc < 0 || rc >= (int)sizeof(stack_path)) {
+		fprintf(stderr, "%s: snprintf failed\n", argv[0]);
 		goto err;
+	}
 
 	tmp = malloc(strlen(stack_path) + 7);
-	if (!tmp)
+	if (!tmp) {
+		fprintf(stderr, "%s: malloc failed: %s\n", argv[0], strerror(errno));
 		goto err;
+	}
 
 	rc = sprintf(tmp, "%sXXXXXX", stack_path);
-	if (rc < 0)
+	if (rc < 0) {
+		fprintf(stderr, "%s: sprintf failed\n", argv[0]);
 		goto err;
+	}
 
 	fd  = mkstemp(tmp);
-	if (fd < 0)
+	if (fd < 0) {
+		fprintf(stderr, "%s: mkstemp %s failed: %s\n", argv[0], tmp, strerror(errno));
 		goto err;
+	}
 
 	rc = fchmod(fd, buf.st_mode);
 	if (rc < 0) {
-		perror("fchmod failed to set permission on compiled regexs");
+		fprintf(stderr, "%s: fchmod %s failed: %s\n", argv[0], tmp, strerror(errno));
 		goto err_unlink;
 	}
 
 	rc = write_binary_file(data, fd, do_write_precompregex);
-	if (rc < 0)
+	if (rc < 0) {
+		fprintf(stderr, "%s: write_binary_file %s failed\n", argv[0], tmp);
 		goto err_unlink;
+	}
 
 	rc = rename(tmp, stack_path);
-	if (rc < 0)
+	if (rc < 0) {
+		fprintf(stderr, "%s: rename %s -> %s failed: %s\n", argv[0], tmp, stack_path, strerror(errno));
 		goto err_unlink;
+	}
 
 	rc = 0;
 out:
-- 
2.7.4
