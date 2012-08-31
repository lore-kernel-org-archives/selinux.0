From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 10/18] libselinux: label_file: move regex sorting to the header
Date: Fri, 31 Aug 2012 10:49:46 -0700
Message-Id: <1346435394-1954-10-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We want to do the same thing in the compiler and as we do in in the code
which reads regexes in from the text file.  Move that sorting into the header.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 21 +++------------------
 libselinux/src/label_file.h | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 8216840..0fba6aa 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -262,8 +262,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	char subs_file[PATH_MAX + 1];
 	char *line_buf = NULL;
 	size_t line_len = 0;
-	unsigned int lineno, pass, i, j, maxnspec;
-	struct spec *spec_copy = NULL;
+	unsigned int lineno, pass, maxnspec;
 	int status = -1, baseonly = 0;
 	struct stat sb;
 
@@ -389,26 +388,12 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	}
 	free(line_buf);
 
-	/* Move exact pathname specifications to the end. */
-	spec_copy = malloc(sizeof(*spec_copy) * data->nspec);
-	if (!spec_copy)
-		goto finish;
-	j = 0;
-	for (i = 0; i < data->nspec; i++)
-		if (data->spec_arr[i].hasMetaChars)
-			memcpy(&spec_copy[j++],
-			       &data->spec_arr[i], sizeof(spec_copy[j]));
-	for (i = 0; i < data->nspec; i++)
-		if (!data->spec_arr[i].hasMetaChars)
-			memcpy(&spec_copy[j++],
-			       &data->spec_arr[i], sizeof(spec_copy[j]));
-	free(data->spec_arr);
-	data->spec_arr = spec_copy;
+	status = sort_specs(data);
 
 	status = 0;
 finish:
 	fclose(fp);
-	if (data->spec_arr != spec_copy)
+	if (status)
 		free(data->spec_arr);
 	if (homedirfp)
 		fclose(homedirfp);
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index e520acc..c6c8ad3 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -114,6 +114,28 @@ static inline void spec_hasMetaChars(struct spec *spec)
 	return;
 }
 
+/* Move exact pathname specifications to the end. */
+static inline int sort_specs(struct saved_data *data)
+{
+	struct spec *spec_copy;
+	int i, j;
+
+	spec_copy = malloc(sizeof(*spec_copy) * data->nspec);
+	if (!spec_copy)
+		return -1;
+	j = 0;
+	for (i = 0; i < data->nspec; i++)
+		if (data->spec_arr[i].hasMetaChars)
+			memcpy(&spec_copy[j++], &data->spec_arr[i], sizeof(spec_copy[j]));
+	for (i = 0; i < data->nspec; i++)
+		if (!data->spec_arr[i].hasMetaChars)
+			memcpy(&spec_copy[j++], &data->spec_arr[i], sizeof(spec_copy[j]));
+	free(data->spec_arr);
+	data->spec_arr = spec_copy;
+
+	return 0;
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
