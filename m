From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 16/18] libselinux: label_file: only run array once when sorting
Date: Fri, 31 Aug 2012 10:49:52 -0700
Message-Id: <1346435394-1954-16-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Instead of running the array two times, sorting the 'hasMeta' the first
time and the !hasMeta the second, run the array once putting hasMeta in
the front and !hasMeta in the back.  Then ONLY run the !hasMeta section
a second time reversing its order so its sorted as it should be.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.h | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index ef97213..8e6f550 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -149,18 +149,42 @@ static inline void spec_hasMetaChars(struct spec *spec)
 static inline int sort_specs(struct saved_data *data)
 {
 	struct spec *spec_copy;
-	int i, j;
+	struct spec spec;
+	int i;
+	int front, back;
+	size_t len = sizeof(*spec_copy);
 
-	spec_copy = malloc(sizeof(*spec_copy) * data->nspec);
+	spec_copy = malloc(len * data->nspec);
 	if (!spec_copy)
 		return -1;
-	j = 0;
-	for (i = 0; i < data->nspec; i++)
+
+	/* first move the exact pathnames to the back */
+	front = 0;
+	back = data->nspec - 1;
+	for (i = 0; i < data->nspec; i++) {
 		if (data->spec_arr[i].hasMetaChars)
-			memcpy(&spec_copy[j++], &data->spec_arr[i], sizeof(spec_copy[j]));
-	for (i = 0; i < data->nspec; i++)
-		if (!data->spec_arr[i].hasMetaChars)
-			memcpy(&spec_copy[j++], &data->spec_arr[i], sizeof(spec_copy[j]));
+			memcpy(&spec_copy[front++], &data->spec_arr[i], len);
+		else
+			memcpy(&spec_copy[back--], &data->spec_arr[i], len);
+	}
+
+	/*
+	 * now the exact pathnames are at the end, but they are in the reverse order.
+	 * since 'front' is now the first of the 'exact' we can run that part of the
+	 * array switching the front and back element.
+	 */
+	back = data->nspec - 1;
+	while (front < back) {
+		/* save the front */
+		memcpy(&spec, &spec_copy[front], len);
+		/* move the back to the front */
+		memcpy(&spec_copy[front], &spec_copy[back], len);
+		/* put the old front in the back */
+		memcpy(&spec_copy[back], &spec, len);
+		front++;
+		back--;
+	}
+
 	free(data->spec_arr);
 	data->spec_arr = spec_copy;
 
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
