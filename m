From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux:  Correctly handle an empty file_contexts file.
Date: Mon, 22 Jun 2015 09:23:10 -0400
Message-Id: <1434979390-12058-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If you add some local file contexts via semanage fcontext -a and
later delete them all via semanage fcontext -D, you get an empty
file_contexts.local file.  Then when you try to load it, getline()
returns 0 and we fall through to the out path without having set rc.
In label_file.c, rc will always be non-zero at this point because
we will have failed the load_mmap() call.  In sefcontext_compile,
rc may contain random garbage at this point.  Explicitly set rc
before the loop.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c           | 3 ++-
 libselinux/utils/sefcontext_compile.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 1d6c36e..4faf808 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -425,9 +425,10 @@ static int process_file(const char *path, const char *suffix,
 		goto out;
 
 	/*
-	 * The do detailed validation of the input and fill the spec array
+	 * Then do detailed validation of the input and fill the spec array
 	 */
 	lineno = 0;
+	rc = 0;
 	while (getline(&line_buf, &line_len, fp) > 0) {
 		rc = process_line(rec, path, prefix, line_buf, ++lineno);
 		if (rc)
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 1c46af8..a93105d 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -35,6 +35,7 @@ static int process_file(struct selabel_handle *rec, const char *filename)
 	}
 
 	line_num = 0;
+	rc = 0;
 	while (getline(&line_buf, &line_len, context_file) > 0) {
 		rc = process_line(rec, filename, prefix, line_buf, ++line_num);
 		if (rc)
-- 
2.1.0
