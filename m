From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 14/18] libselinux: label_file: break up find_stem_from_spec
Date: Fri, 31 Aug 2012 10:49:50 -0700
Message-Id: <1346435394-1954-14-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Right now find_stem_from_spec does a number of things:
- calculate the length of th stem
- look for that stem
- duplicate the stem
- add the stem to the array

break those things up a bit because the mmap version isn't going to need
to do some of those things.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.h | 61 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index ddb7fbd..1208d8b 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -184,23 +184,30 @@ static inline int get_stem_from_spec(const char *const buf)
 	return tmp - buf;
 }
 
-/* find the stem of a file spec, returns the index into stem_arr for a new
- * or existing stem, (or -1 if there is no possible stem - IE for a file in
- * the root directory or a regex that is too complex for us). */
-static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
+/*
+ * return the stemid given a string and a length
+ */
+static inline int find_stem(struct saved_data *data, const char *buf, int stem_len)
 {
-	int i, num = data->num_stems;
-	int stem_len = get_stem_from_spec(buf);
+	int i;
 
-	if (!stem_len)
-		return -1;
-	for (i = 0; i < num; i++) {
-		if (stem_len == data->stem_arr[i].len
-		    && !strncmp(buf, data->stem_arr[i].buf, stem_len))
+	for (i = 0; i < data->num_stems; i++) {
+		if (stem_len == data->stem_arr[i].len &&
+		    !strncmp(buf, data->stem_arr[i].buf, stem_len))
 			return i;
 	}
+
+	return -1;
+}
+
+/* returns the index of the new stored object */
+static inline int store_stem(struct saved_data *data, char *buf, int stem_len)
+{
+	int num = data->num_stems;
+
 	if (data->alloc_stems == num) {
 		struct stem *tmp_arr;
+
 		data->alloc_stems = data->alloc_stems * 2 + 16;
 		tmp_arr = realloc(data->stem_arr,
 				  sizeof(*tmp_arr) * data->alloc_stems);
@@ -209,14 +216,34 @@ static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
 		data->stem_arr = tmp_arr;
 	}
 	data->stem_arr[num].len = stem_len;
-	data->stem_arr[num].buf = malloc(stem_len + 1);
-	if (!data->stem_arr[num].buf)
-		return -1;
-	memcpy(data->stem_arr[num].buf, buf, stem_len);
-	data->stem_arr[num].buf[stem_len] = '\0';
+	data->stem_arr[num].buf = buf;
 	data->num_stems++;
-	buf += stem_len;
+
 	return num;
 }
 
+/* find the stem of a file spec, returns the index into stem_arr for a new
+ * or existing stem, (or -1 if there is no possible stem - IE for a file in
+ * the root directory or a regex that is too complex for us). */
+static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
+{
+	int stem_len = get_stem_from_spec(buf);
+	int stemid;
+	char *stem;
+
+	if (!stem_len)
+		return -1;
+
+	stemid = find_stem(data, buf, stem_len);
+	if (stemid >= 0)
+		return stemid;
+
+	/* not found, allocate a new one */
+	stem = strndup(buf, stem_len);
+	if (!stem)
+		return -1;
+
+	return store_stem(data, stem, stem_len);
+}
+
 #endif /* _SELABEL_FILE_H_ */
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
