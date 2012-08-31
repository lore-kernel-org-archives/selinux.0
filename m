From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 05/18] libselinux: label_file: move error reporting back into caller
Date: Fri, 31 Aug 2012 10:49:41 -0700
Message-Id: <1346435394-1954-5-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If we want to use these functions in utilities we shouldn't call such
libselinux internal functions.  Move the error reporting up to the
caller.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 12 ++++++++++--
 libselinux/src/label_file.h | 17 ++++++-----------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 3ae9985..d4ec878 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -311,8 +311,16 @@ static int process_line(struct selabel_handle *rec,
 		/* Convert the type string to a mode format */
 		spec_arr[nspec].type_str = type;
 		spec_arr[nspec].mode = 0;
-		if (type)
-			spec_arr[nspec].mode = string_to_mode(type, path, lineno);
+		if (type) {
+			mode_t mode = string_to_mode(type);
+			if (mode == -1) {
+				COMPAT_LOG(SELINUX_WARNING,
+					"%s:  line %d has invalid file type %s\n",
+					path, lineno, type);
+				mode = 0;
+			}
+			spec_arr[nspec].mode = mode;
+		}
 
 		spec_arr[nspec].lr.ctx_raw = context;
 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 297ea25..9d31c18 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -43,17 +43,15 @@ struct saved_data {
 	int alloc_stems;
 };
 
-static inline mode_t string_to_mode(char *mode, const char *path, unsigned lineno)
+static inline mode_t string_to_mode(char *mode)
 {
 	size_t len;
 
-	len = strlen(mode);
-	if (mode[0] != '-' || len != 2) {
-		COMPAT_LOG(SELINUX_WARNING,
-			    "%s:  line %d has invalid file type %s\n",
-			    path, lineno, mode);
+	if (!mode)
 		return 0;
-	}
+	len = strlen(mode);
+	if (mode[0] != '-' || len != 2)
+		return -1;
 	switch (mode[1]) {
 	case 'b':
 		return S_IFBLK;
@@ -70,10 +68,7 @@ static inline mode_t string_to_mode(char *mode, const char *path, unsigned linen
 	case '-':
 		return S_IFREG;
 	default:
-		COMPAT_LOG(SELINUX_WARNING,
-			    "%s:  line %d has invalid file type %s\n",
-			    path, lineno, mode);
-		return 0;
+		return -1;
 	}
 	/* impossible to get here */
 	return 0;
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
