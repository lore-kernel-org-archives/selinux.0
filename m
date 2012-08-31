From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 04/18] libselinux: label_file: do string to mode_t conversion in a helper function
Date: Fri, 31 Aug 2012 10:49:40 -0700
Message-Id: <1346435394-1954-4-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So the string to mode_t conversion in a helper function so it can be
used later by a regex compilation program.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 41 ++---------------------------------------
 libselinux/src/label_file.h | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index a3ea934..3ae9985 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -241,7 +241,6 @@ static int compile_regex(struct saved_data *data, struct spec *spec, const char
 	return 0;
 }
 
-
 static int process_line(struct selabel_handle *rec,
 			const char *path, const char **prefix_array,
 			char *line_buf, int pass, unsigned lineno)
@@ -312,45 +311,9 @@ static int process_line(struct selabel_handle *rec,
 		/* Convert the type string to a mode format */
 		spec_arr[nspec].type_str = type;
 		spec_arr[nspec].mode = 0;
-		if (!type)
-			goto skip_type;
-		len = strlen(type);
-		if (type[0] != '-' || len != 2) {
-			COMPAT_LOG(SELINUX_WARNING,
-				    "%s:  line %d has invalid file type %s\n",
-				    path, lineno, type);
-			return 0;
-		}
-		switch (type[1]) {
-		case 'b':
-			spec_arr[nspec].mode = S_IFBLK;
-			break;
-		case 'c':
-			spec_arr[nspec].mode = S_IFCHR;
-			break;
-		case 'd':
-			spec_arr[nspec].mode = S_IFDIR;
-			break;
-		case 'p':
-			spec_arr[nspec].mode = S_IFIFO;
-			break;
-		case 'l':
-			spec_arr[nspec].mode = S_IFLNK;
-			break;
-		case 's':
-			spec_arr[nspec].mode = S_IFSOCK;
-			break;
-		case '-':
-			spec_arr[nspec].mode = S_IFREG;
-			break;
-		default:
-			COMPAT_LOG(SELINUX_WARNING,
-				    "%s:  line %d has invalid file type %s\n",
-				    path, lineno, type);
-			return 0;
-		}
+		if (type)
+			spec_arr[nspec].mode = string_to_mode(type, path, lineno);
 
-	skip_type:
 		spec_arr[nspec].lr.ctx_raw = context;
 
 		/* Determine if specification has 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index da2e350..297ea25 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -1,6 +1,8 @@
 #ifndef _SELABEL_FILE_H_
 #define _SELABEL_FILE_H_
 
+#include <sys/stat.h>
+
 #include "label_internal.h"
 
 /* A file security context specification. */
@@ -40,4 +42,41 @@ struct saved_data {
 	int num_stems;
 	int alloc_stems;
 };
+
+static inline mode_t string_to_mode(char *mode, const char *path, unsigned lineno)
+{
+	size_t len;
+
+	len = strlen(mode);
+	if (mode[0] != '-' || len != 2) {
+		COMPAT_LOG(SELINUX_WARNING,
+			    "%s:  line %d has invalid file type %s\n",
+			    path, lineno, mode);
+		return 0;
+	}
+	switch (mode[1]) {
+	case 'b':
+		return S_IFBLK;
+	case 'c':
+		return S_IFCHR;
+	case 'd':
+		return S_IFDIR;
+	case 'p':
+		return S_IFIFO;
+	case 'l':
+		return S_IFLNK;
+	case 's':
+		return S_IFSOCK;
+	case '-':
+		return S_IFREG;
+	default:
+		COMPAT_LOG(SELINUX_WARNING,
+			    "%s:  line %d has invalid file type %s\n",
+			    path, lineno, mode);
+		return 0;
+	}
+	/* impossible to get here */
+	return 0;
+}
+
 #endif /* _SELABEL_FILE_H_ */
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
