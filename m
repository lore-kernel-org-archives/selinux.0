From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: pcre_study can return NULL without error.
Date: Mon,  2 Feb 2015 16:11:47 -0500
Message-Id: <1422911507-10456-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Per the man page, pcre_study can return NULL without error if
it could not find any additional information.  Errors are indicated
by the combination of a NULL return value and a non-NULL error string.
Fix the handling so that we do not incorrectly reject file_contexts
entries.

Change-Id: I2e7b7e01d85d96dd7fe78545d3ee3834281c4eba
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 8e7b288..71b085a 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -138,7 +138,7 @@ static int compile_regex(struct saved_data *data, struct spec *spec, const char
 	}
 
 	spec->sd = pcre_study(spec->regex, 0, &tmperrbuf);
-	if (!spec->sd) {
+	if (!spec->sd && tmperrbuf) {
 		if (errbuf)
 			*errbuf=tmperrbuf;
 		return -1;
-- 
1.9.3
