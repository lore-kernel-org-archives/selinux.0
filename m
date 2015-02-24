From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: sefcontext_compile: handle newlines in file names
Date: Tue, 24 Feb 2015 12:25:06 -0500
Message-Id: <1424798706-20751-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

restorecon on file names with newlines are not handled properly.
Use PCRE_DOTALL so that dots in regular expressions match all
characters, and don't exclude the newline character.

See https://www.mail-archive.com/seandroid-list@tycho.nsa.gov/msg02001.html
for background.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/utils/sefcontext_compile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 504699d..b359e1c 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -100,7 +100,7 @@ static int process_file(struct saved_data *data, const char *filename)
 
 		spec_hasMetaChars(spec);
 
-		re = pcre_compile(anchored_regex, 0, &err, &erroff, NULL);
+		re = pcre_compile(anchored_regex, PCRE_DOTALL, &err, &erroff, NULL);
 		if (!re) {
 			fprintf(stderr, "PCRE compilation failed for %s at offset %d: %s\n", anchored_regex, erroff, err);
 			return -1;
-- 
1.9.3
