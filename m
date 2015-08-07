From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: do not treat an empty file_contexts(.local) as an
 error
Date: Fri,  7 Aug 2015 12:14:30 -0400
Message-Id: <1438964070-30652-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

file_contexts can be legitimately empty, particularly when dealing with
a file_contexts.local file.  The change to test for file_contexts.bin
format by magic number was treating an EOF condition as a fatal error,
thereby causing an error on empty file_contexts.local files.  Only
treat it as an error if there was truly an error on the read, as
checked via ferror().  Otherwise, clear the error and EOF indicators
so that they do not persist when we rewind the file and try to read
it as text.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b91e1e6..687d0a7 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -447,10 +447,14 @@ static int process_file(const char *path, const char *suffix,
 			return -1;
 		}
 
+		magic = 0;
 		if (fread(&magic, sizeof magic, 1, fp) != 1) {
-			errno = EINVAL;
-			fclose(fp);
-			return -1;
+			if (ferror(fp)) {
+				errno = EINVAL;
+				fclose(fp);
+				return -1;
+			}
+			clearerr(fp);
 		}
 
 		if (magic == SELINUX_MAGIC_COMPILED_FCONTEXT) {
-- 
2.1.0
