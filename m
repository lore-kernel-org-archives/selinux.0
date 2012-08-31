From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 02/18] libselinux: label_file: remove all typedefs
Date: Fri, 31 Aug 2012 10:49:38 -0700
Message-Id: <1346435394-1954-2-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I hate them.  They just indirectly you needlessly.  Just use the struct
definitions.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 5e7e712..f0e3d2a 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -29,7 +29,7 @@
 
 #define MAX_PREFIX 100
 /* A file security context specification. */
-typedef struct spec {
+struct spec {
 	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
 	char *regex_str;	/* regular expession string for diagnostics */
 	char *type_str;		/* type string for diagnostic messages */
@@ -40,13 +40,13 @@ typedef struct spec {
 	int matches;		/* number of matching pathnames */
 	int hasMetaChars;	/* regular expression has meta-chars */
 	int stem_id;		/* indicates which stem-compression item */
-} spec_t;
+};
 
 /* A regular expression stem */
-typedef struct stem {
+struct stem {
 	char *buf;
 	int len;
-} stem_t;
+};
 
 /* Our stored configuration */
 struct saved_data {
@@ -54,14 +54,14 @@ struct saved_data {
 	 * The array of specifications, initially in the same order as in 
 	 * the specification file. Sorting occurs based on hasMetaChars.
 	 */
-	spec_t *spec_arr;
+	struct spec *spec_arr;
 	unsigned int nspec;
 	unsigned int ncomp;
 
 	/*
 	 * The array of regular expression stems.
 	 */
-	stem_t *stem_arr;
+	struct stem *stem_arr;
 	int num_stems;
 	int alloc_stems;
 };
@@ -109,10 +109,10 @@ static int find_stem_from_spec(struct saved_data *data, const char *buf)
 			return i;
 	}
 	if (data->alloc_stems == num) {
-		stem_t *tmp_arr;
+		struct stem *tmp_arr;
 		data->alloc_stems = data->alloc_stems * 2 + 16;
 		tmp_arr = realloc(data->stem_arr,
-				  sizeof(stem_t) * data->alloc_stems);
+				  sizeof(*tmp_arr) * data->alloc_stems);
 		if (!tmp_arr)
 			return -1;
 		data->stem_arr = tmp_arr;
@@ -225,11 +225,11 @@ static void spec_hasMetaChars(struct spec *spec)
 	return;
 }
 
-static int compile_regex(struct saved_data *data, spec_t *spec, const char **errbuf)
+static int compile_regex(struct saved_data *data, struct spec *spec, const char **errbuf)
 {
 	const char *tmperrbuf;
 	char *reg_buf, *anchored_regex, *cp;
-	stem_t *stem_arr = data->stem_arr;
+	struct stem *stem_arr = data->stem_arr;
 	size_t len;
 	int erroff;
 
@@ -285,7 +285,7 @@ static int process_line(struct selabel_handle *rec,
 	int items, len;
 	char *buf_p, *regex, *type, *context;
 	struct saved_data *data = (struct saved_data *)rec->data;
-	spec_t *spec_arr = data->spec_arr;
+	struct spec *spec_arr = data->spec_arr;
 	unsigned int nspec = data->nspec;
 
 	len = strlen(line_buf);
@@ -423,7 +423,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	char *line_buf = NULL;
 	size_t line_len = 0;
 	unsigned int lineno, pass, i, j, maxnspec;
-	spec_t *spec_copy = NULL;
+	struct spec *spec_copy = NULL;
 	int status = -1, baseonly = 0;
 	struct stat sb;
 
@@ -491,7 +491,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	 * The second pass performs detailed validation of the input
 	 * and fills in the spec array.
 	 */
-	maxnspec = UINT_MAX / sizeof(spec_t);
+	maxnspec = UINT_MAX / sizeof(struct spec);
 	for (pass = 0; pass < 2; pass++) {
 		data->nspec = 0;
 		data->ncomp = 0;
@@ -536,7 +536,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 				status = 0;
 				goto finish;
 			}
-			data->spec_arr = calloc(data->nspec, sizeof(spec_t));
+			data->spec_arr = calloc(data->nspec, sizeof(*data->spec_arr));
 			if (!data->spec_arr)
 				goto finish;
 
@@ -551,18 +551,18 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	free(line_buf);
 
 	/* Move exact pathname specifications to the end. */
-	spec_copy = malloc(sizeof(spec_t) * data->nspec);
+	spec_copy = malloc(sizeof(*spec_copy) * data->nspec);
 	if (!spec_copy)
 		goto finish;
 	j = 0;
 	for (i = 0; i < data->nspec; i++)
 		if (data->spec_arr[i].hasMetaChars)
 			memcpy(&spec_copy[j++],
-			       &data->spec_arr[i], sizeof(spec_t));
+			       &data->spec_arr[i], sizeof(spec_copy[j]));
 	for (i = 0; i < data->nspec; i++)
 		if (!data->spec_arr[i].hasMetaChars)
 			memcpy(&spec_copy[j++],
-			       &data->spec_arr[i], sizeof(spec_t));
+			       &data->spec_arr[i], sizeof(spec_copy[j]));
 	free(data->spec_arr);
 	data->spec_arr = spec_copy;
 
@@ -617,7 +617,7 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 					 const char *key, int type)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
-	spec_t *spec_arr = data->spec_arr;
+	struct spec *spec_arr = data->spec_arr;
 	int i, rc, file_stem;
 	mode_t mode = (mode_t)type;
 	const char *buf;
@@ -656,7 +656,7 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 	 * the last matching specification is used.
 	 */
 	for (i = data->nspec - 1; i >= 0; i--) {
-		spec_t *spec = &spec_arr[i];
+		struct spec *spec = &spec_arr[i];
 		/* if the spec in question matches no stem or has the same
 		 * stem as the file AND if the spec in question has no mode
 		 * specified or if the mode matches the file mode then we do
@@ -697,7 +697,7 @@ static void stats(struct selabel_handle *rec)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	unsigned int i, nspec = data->nspec;
-	spec_t *spec_arr = data->spec_arr;
+	struct spec *spec_arr = data->spec_arr;
 
 	for (i = 0; i < nspec; i++) {
 		if (spec_arr[i].matches == 0) {
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
