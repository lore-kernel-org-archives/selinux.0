From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 06/18] libselinux: label_file: move stem/spec handling to header
Date: Fri, 31 Aug 2012 10:49:42 -0700
Message-Id: <1346435394-1954-6-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We want to be able to find the stem and the spec from our new utility.
So move those functions to the header file.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 52 ---------------------------------------------
 libselinux/src/label_file.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index d4ec878..9c0bfa0 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -30,23 +30,6 @@
 
 #define MAX_PREFIX 100
 
-/* Return the length of the text that can be considered the stem, returns 0
- * if there is no identifiable stem */
-static int get_stem_from_spec(const char *const buf)
-{
-	const char *tmp = strchr(buf + 1, '/');
-	const char *ind;
-
-	if (!tmp)
-		return 0;
-
-	for (ind = buf; ind < tmp; ind++) {
-		if (strchr(".^$?*+|[({", (int)*ind))
-			return 0;
-	}
-	return tmp - buf;
-}
-
 /* return the length of the text that is the stem of a file name */
 static int get_stem_from_file_name(const char *const buf)
 {
@@ -57,41 +40,6 @@ static int get_stem_from_file_name(const char *const buf)
 	return tmp - buf;
 }
 
-/* find the stem of a file spec, returns the index into stem_arr for a new
- * or existing stem, (or -1 if there is no possible stem - IE for a file in
- * the root directory or a regex that is too complex for us). */
-static int find_stem_from_spec(struct saved_data *data, const char *buf)
-{
-	int i, num = data->num_stems;
-	int stem_len = get_stem_from_spec(buf);
-
-	if (!stem_len)
-		return -1;
-	for (i = 0; i < num; i++) {
-		if (stem_len == data->stem_arr[i].len
-		    && !strncmp(buf, data->stem_arr[i].buf, stem_len))
-			return i;
-	}
-	if (data->alloc_stems == num) {
-		struct stem *tmp_arr;
-		data->alloc_stems = data->alloc_stems * 2 + 16;
-		tmp_arr = realloc(data->stem_arr,
-				  sizeof(*tmp_arr) * data->alloc_stems);
-		if (!tmp_arr)
-			return -1;
-		data->stem_arr = tmp_arr;
-	}
-	data->stem_arr[num].len = stem_len;
-	data->stem_arr[num].buf = malloc(stem_len + 1);
-	if (!data->stem_arr[num].buf)
-		return -1;
-	memcpy(data->stem_arr[num].buf, buf, stem_len);
-	data->stem_arr[num].buf[stem_len] = '\0';
-	data->num_stems++;
-	buf += stem_len;
-	return num;
-}
-
 /* find the stem of a file name, returns the index into stem_arr (or -1 if
  * there is no match - IE for a file in the root directory or a regex that is
  * too complex for us).  Makes buf point to the text AFTER the stem. */
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 9d31c18..de58d1e 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -74,4 +74,56 @@ static inline mode_t string_to_mode(char *mode)
 	return 0;
 }
 
+/* Return the length of the text that can be considered the stem, returns 0
+ * if there is no identifiable stem */
+static inline int get_stem_from_spec(const char *const buf)
+{
+	const char *tmp = strchr(buf + 1, '/');
+	const char *ind;
+
+	if (!tmp)
+		return 0;
+
+	for (ind = buf; ind < tmp; ind++) {
+		if (strchr(".^$?*+|[({", (int)*ind))
+			return 0;
+	}
+	return tmp - buf;
+}
+
+/* find the stem of a file spec, returns the index into stem_arr for a new
+ * or existing stem, (or -1 if there is no possible stem - IE for a file in
+ * the root directory or a regex that is too complex for us). */
+static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
+{
+	int i, num = data->num_stems;
+	int stem_len = get_stem_from_spec(buf);
+
+	if (!stem_len)
+		return -1;
+	for (i = 0; i < num; i++) {
+		if (stem_len == data->stem_arr[i].len
+		    && !strncmp(buf, data->stem_arr[i].buf, stem_len))
+			return i;
+	}
+	if (data->alloc_stems == num) {
+		struct stem *tmp_arr;
+		data->alloc_stems = data->alloc_stems * 2 + 16;
+		tmp_arr = realloc(data->stem_arr,
+				  sizeof(*tmp_arr) * data->alloc_stems);
+		if (!tmp_arr)
+			return -1;
+		data->stem_arr = tmp_arr;
+	}
+	data->stem_arr[num].len = stem_len;
+	data->stem_arr[num].buf = malloc(stem_len + 1);
+	if (!data->stem_arr[num].buf)
+		return -1;
+	memcpy(data->stem_arr[num].buf, buf, stem_len);
+	data->stem_arr[num].buf[stem_len] = '\0';
+	data->num_stems++;
+	buf += stem_len;
+	return num;
+}
+
 #endif /* _SELABEL_FILE_H_ */
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
