From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux:  label_file:  handle newlines in file names
Date: Tue, 24 Feb 2015 10:43:01 -0500
Message-Id: <1424792581-17675-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Nick Kralevich <nnk@google.com>

restorecon on file names with newlines are not handled properly.
Use PCRE_DOTALL so that dots in regular expressions match all
characters, and don't exclude the newline character.

See https://www.mail-archive.com/seandroid-list@tycho.nsa.gov/msg02001.html
for background.

Change-Id: I0dde8f2567305f746d19ebd75a9e2add7406eb9a
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 71b085a..9d116eb 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -129,7 +129,7 @@ static int compile_regex(struct saved_data *data, struct spec *spec, const char
 	*cp = '\0';
 
 	/* Compile the regular expression. */
-	spec->regex = pcre_compile(anchored_regex, 0, &tmperrbuf, &erroff, NULL);
+	spec->regex = pcre_compile(anchored_regex, PCRE_DOTALL, &tmperrbuf, &erroff, NULL);
 	free(anchored_regex);
 	if (!spec->regex) {
 		if (errbuf)
-- 
1.9.3
