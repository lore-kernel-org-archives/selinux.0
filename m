From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 08/18] libselinux: label_file: move spec_hasMetaChars to header
Date: Fri, 31 Aug 2012 10:49:44 -0700
Message-Id: <1346435394-1954-8-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So we can use it in the new compile utility, move the
spec_hasMetaChars() function, which looks for things like .*?+^$ in
regular expressions into the internal header file.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 41 -----------------------------------------
 libselinux/src/label_file.h | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 0dc0332..8216840 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -96,47 +96,6 @@ static int nodups_specs(struct saved_data *data, const char *path)
 	return rc;
 }
 
-/* Determine if the regular expression specification has any meta characters. */
-static void spec_hasMetaChars(struct spec *spec)
-{
-	char *c;
-	int len;
-	char *end;
-
-	c = spec->regex_str;
-	len = strlen(spec->regex_str);
-	end = c + len;
-
-	spec->hasMetaChars = 0;
-
-	/* Look at each character in the RE specification string for a 
-	 * meta character. Return when any meta character reached. */
-	while (c != end) {
-		switch (*c) {
-		case '.':
-		case '^':
-		case '$':
-		case '?':
-		case '*':
-		case '+':
-		case '|':
-		case '[':
-		case '(':
-		case '{':
-			spec->hasMetaChars = 1;
-			return;
-		case '\\':	/* skip the next character */
-			c++;
-			break;
-		default:
-			break;
-
-		}
-		c++;
-	}
-	return;
-}
-
 static int compile_regex(struct saved_data *data, struct spec *spec, const char **errbuf)
 {
 	const char *tmperrbuf;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 560035d..b839a23 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -73,6 +73,47 @@ static inline mode_t string_to_mode(char *mode)
 	return 0;
 }
 
+/* Determine if the regular expression specification has any meta characters. */
+static inline void spec_hasMetaChars(struct spec *spec)
+{
+	char *c;
+	int len;
+	char *end;
+
+	c = spec->regex_str;
+	len = strlen(spec->regex_str);
+	end = c + len;
+
+	spec->hasMetaChars = 0;
+
+	/* Look at each character in the RE specification string for a 
+	 * meta character. Return when any meta character reached. */
+	while (c != end) {
+		switch (*c) {
+		case '.':
+		case '^':
+		case '$':
+		case '?':
+		case '*':
+		case '+':
+		case '|':
+		case '[':
+		case '(':
+		case '{':
+			spec->hasMetaChars = 1;
+			return;
+		case '\\':	/* skip the next character */
+			c++;
+			break;
+		default:
+			break;
+
+		}
+		c++;
+	}
+	return;
+}
+
 /* Return the length of the text that can be considered the stem, returns 0
  * if there is no identifiable stem */
 static inline int get_stem_from_spec(const char *const buf)
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
