Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5QF3BPS019427
 for <selinux@tycho.nsa.gov>; Fri, 26 Jun 2015 11:03:12 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH V2] libselinux: Fix if file_contexts not '\n' terminated
Date: Fri, 26 Jun 2015 16:03:01 +0100
Message-Id: <1435330981-25214-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If the last line of a file_contexts file is not '\n' terminated
or if any line has additional isspace(3) characters at end, it
gave an invalid file type error.
read_spec_entries now handles these situations.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label_support.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index cf91dfa..b3ab8ab 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -17,9 +17,8 @@
  */
 
 /* Read an entry from a spec file (e.g. file_contexts) */
-static inline int read_spec_entry(char **entry, char **ptr)
+static inline int read_spec_entry(char **entry, char **ptr, int *len)
 {
-	int entry_len = 0;
 	*entry = NULL;
 	char *tmp_buf = NULL;
 
@@ -27,15 +26,18 @@ static inline int read_spec_entry(char **entry, char **ptr)
 		(*ptr)++;
 
 	tmp_buf = *ptr;
+	*len = 0;
 
 	while (!isspace(**ptr) && **ptr != '\0') {
 		(*ptr)++;
-		entry_len++;
+		(*len)++;
 	}
 
-	*entry = strndup(tmp_buf, entry_len);
-	if (!*entry)
-		return -1;
+	if (*len) {
+		*entry = strndup(tmp_buf, *len);
+		if (!*entry)
+			return -1;
+	}
 
 	return 0;
 }
@@ -51,12 +53,17 @@ static inline int read_spec_entry(char **entry, char **ptr)
 int hidden read_spec_entries(char *line_buf, int num_args, ...)
 {
 	char **spec_entry, *buf_p;
-	int len, rc, items;
+	int len, rc, items, entry_len = 0;
 	va_list ap;
 
 	len = strlen(line_buf);
 	if (line_buf[len - 1] == '\n')
 		line_buf[len - 1] = '\0';
+	else
+		/* Handle case if line not \n terminated by bumping
+		 * the len for the check below (as the line is NUL
+		 * terminated by getline(3)) */
+		len++;
 
 	buf_p = line_buf;
 	while (isspace(*buf_p))
@@ -69,7 +76,8 @@ int hidden read_spec_entries(char *line_buf, int num_args, ...)
 	/* Process the spec file entries */
 	va_start(ap, num_args);
 
-	for (items = 0; items < num_args; items++) {
+	items = 0;
+	while (items < num_args) {
 		spec_entry = va_arg(ap, char **);
 
 		if (len - 1 == buf_p - line_buf) {
@@ -77,11 +85,13 @@ int hidden read_spec_entries(char *line_buf, int num_args, ...)
 			return items;
 		}
 
-		rc = read_spec_entry(spec_entry, &buf_p);
+		rc = read_spec_entry(spec_entry, &buf_p, &entry_len);
 		if (rc < 0) {
 			va_end(ap);
 			return rc;
 		}
+		if (entry_len)
+			items++;
 	}
 	va_end(ap);
 	return items;
-- 
2.1.0
