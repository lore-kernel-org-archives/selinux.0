From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 03/18] libselinux: label_file: move definitions to include file
Date: Fri, 31 Aug 2012 10:49:39 -0700
Message-Id: <1346435394-1954-3-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We want to use some label_file internals in a utility to compile
fcontext files into binary data for fast use.  So start pushing
structures and such into a header file.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 38 +-------------------------------------
 libselinux/src/label_file.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 37 deletions(-)
 create mode 100644 libselinux/src/label_file.h

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index f0e3d2a..a3ea934 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -22,49 +22,13 @@
 #include <unistd.h>
 #include "callbacks.h"
 #include "label_internal.h"
+#include "label_file.h"
 
 /*
  * Internals, mostly moved over from matchpathcon.c
  */
 
 #define MAX_PREFIX 100
-/* A file security context specification. */
-struct spec {
-	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
-	char *regex_str;	/* regular expession string for diagnostics */
-	char *type_str;		/* type string for diagnostic messages */
-	pcre *regex;		/* compiled regular expression */
-	pcre_extra *sd;		/* extra compiled stuff */
-	char regcomp;           /* regex_str has been compiled to regex */
-	mode_t mode;		/* mode format value */
-	int matches;		/* number of matching pathnames */
-	int hasMetaChars;	/* regular expression has meta-chars */
-	int stem_id;		/* indicates which stem-compression item */
-};
-
-/* A regular expression stem */
-struct stem {
-	char *buf;
-	int len;
-};
-
-/* Our stored configuration */
-struct saved_data {
-	/*
-	 * The array of specifications, initially in the same order as in 
-	 * the specification file. Sorting occurs based on hasMetaChars.
-	 */
-	struct spec *spec_arr;
-	unsigned int nspec;
-	unsigned int ncomp;
-
-	/*
-	 * The array of regular expression stems.
-	 */
-	struct stem *stem_arr;
-	int num_stems;
-	int alloc_stems;
-};
 
 /* Return the length of the text that can be considered the stem, returns 0
  * if there is no identifiable stem */
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
new file mode 100644
index 0000000..da2e350
--- /dev/null
+++ b/libselinux/src/label_file.h
@@ -0,0 +1,43 @@
+#ifndef _SELABEL_FILE_H_
+#define _SELABEL_FILE_H_
+
+#include "label_internal.h"
+
+/* A file security context specification. */
+struct spec {
+	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
+	char *regex_str;	/* regular expession string for diagnostics */
+	char *type_str;		/* type string for diagnostic messages */
+	pcre *regex;		/* compiled regular expression */
+	pcre_extra *sd;		/* extra compiled stuff */
+	char regcomp;		/* regex_str has been compiled to regex */
+	mode_t mode;		/* mode format value */
+	int matches;		/* number of matching pathnames */
+	int hasMetaChars;	/* regular expression has meta-chars */
+	int stem_id;		/* indicates which stem-compression item */
+};
+
+/* A regular expression stem */
+struct stem {
+	char *buf;
+	int len;
+};
+
+/* Our stored configuration */
+struct saved_data {
+	/*
+	 * The array of specifications, initially in the same order as in 
+	 * the specification file. Sorting occurs based on hasMetaChars.
+	 */
+	struct spec *spec_arr;
+	unsigned int nspec;
+	unsigned int ncomp;
+
+	/*
+	 * The array of regular expression stems.
+	 */
+	struct stem *stem_arr;
+	int num_stems;
+	int alloc_stems;
+};
+#endif /* _SELABEL_FILE_H_ */
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
