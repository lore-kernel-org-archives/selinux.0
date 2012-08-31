From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 12/18] libselinux: label_file: only run regex files one time
Date: Fri, 31 Aug 2012 10:49:48 -0700
Message-Id: <1346435394-1954-12-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We currectly run all of the regex files 2 times.  The first time counts
the lines and does the simple validatation.  We then allocate an array
of exactly the right size to hold the entries and run them a second time
doing stronger validation, regex compile, etc.

This is dumb.  Just run them one time and use realloc to grow the size
of the array as needed.  At the end the array will get sized perfectly
to fit by the sorting function, so even if we accidentally allocated
entra memory we'll get it back.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 152 +++++++++++++++++---------------------------
 libselinux/src/label_file.h |  26 ++++++++
 2 files changed, 85 insertions(+), 93 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 0f4f9a5..d53bc21 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -148,13 +148,14 @@ static int compile_regex(struct saved_data *data, struct spec *spec, const char
 
 static int process_line(struct selabel_handle *rec,
 			const char *path, const char **prefix_array,
-			char *line_buf, int pass, unsigned lineno)
+			char *line_buf, unsigned lineno)
 {
-	int items, len;
+	int items, len, rc;
 	char *buf_p, *regex, *type, *context;
 	struct saved_data *data = (struct saved_data *)rec->data;
-	struct spec *spec_arr = data->spec_arr;
+	struct spec *spec_arr;
 	unsigned int nspec = data->nspec;
+	const char *errbuf = NULL;
 
 	len = strlen(line_buf);
 	if (line_buf[len - 1] == '\n')
@@ -201,49 +202,44 @@ static int process_line(struct selabel_handle *rec,
 		}
 	}
 
-	if (pass == 1) {
-		/* On the second pass, process and store the specification in spec. */
-		const char *errbuf = NULL;
-		spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
-		spec_arr[nspec].regex_str = regex;
-		if (rec->validating && compile_regex(data, &spec_arr[nspec], &errbuf)) {
-			COMPAT_LOG(SELINUX_WARNING,
-				   "%s:  line %d has invalid regex %s:  %s\n",
-				   path, lineno, regex,
-				   (errbuf ? errbuf : "out of memory"));
-		}
+	rc = grow_specs(data);
+	if (rc)
+		return rc;
 
-		/* Convert the type string to a mode format */
-		spec_arr[nspec].type_str = type;
-		spec_arr[nspec].mode = 0;
-		if (type) {
-			mode_t mode = string_to_mode(type);
-			if (mode == -1) {
-				COMPAT_LOG(SELINUX_WARNING,
-					"%s:  line %d has invalid file type %s\n",
-					path, lineno, type);
-				mode = 0;
-			}
-			spec_arr[nspec].mode = mode;
+	spec_arr = data->spec_arr;
+
+	/* process and store the specification in spec. */
+	spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
+	spec_arr[nspec].regex_str = regex;
+	if (rec->validating && compile_regex(data, &spec_arr[nspec], &errbuf)) {
+		COMPAT_LOG(SELINUX_WARNING, "%s:  line %d has invalid regex %s:  %s\n",
+			   path, lineno, regex, (errbuf ? errbuf : "out of memory"));
+	}
+
+	/* Convert the type string to a mode format */
+	spec_arr[nspec].type_str = type;
+	spec_arr[nspec].mode = 0;
+	if (type) {
+		mode_t mode = string_to_mode(type);
+		if (mode == -1) {
+			COMPAT_LOG(SELINUX_WARNING, "%s:  line %d has invalid file type %s\n",
+				   path, lineno, type);
+			mode = 0;
 		}
+		spec_arr[nspec].mode = mode;
+	}
 
-		spec_arr[nspec].lr.ctx_raw = context;
+	spec_arr[nspec].lr.ctx_raw = context;
 
-		/* Determine if specification has 
-		 * any meta characters in the RE */
-		spec_hasMetaChars(&spec_arr[nspec]);
+	/* Determine if specification has 
+	 * any meta characters in the RE */
+	spec_hasMetaChars(&spec_arr[nspec]);
 
-		if (strcmp(context, "<<none>>") && rec->validating)
-			compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
-	}
+	if (strcmp(context, "<<none>>") && rec->validating)
+		compat_validate(rec, &spec_arr[nspec].lr, path, lineno);
 
 	data->nspec = ++nspec;
-	if (pass == 0) {
-		free(regex);
-		if (type)
-			free(type);
-		free(context);
-	}
+
 	return 0;
 }
 
@@ -262,7 +258,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	char subs_file[PATH_MAX + 1];
 	char *line_buf = NULL;
 	size_t line_len = 0;
-	unsigned int lineno, pass, maxnspec;
+	unsigned int lineno;
 	int status = -1, baseonly = 0;
 	struct stat sb;
 
@@ -323,69 +319,39 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	rec->spec_file = strdup(path);
 
 	/* 
-	 * Perform two passes over the specification file.
-	 * The first pass counts the number of specifications and
-	 * performs simple validation of the input.  At the end
-	 * of the first pass, the spec array is allocated.
-	 * The second pass performs detailed validation of the input
-	 * and fills in the spec array.
+	 * The do detailed validation of the input and fill the spec array
 	 */
-	maxnspec = UINT_MAX / sizeof(struct spec);
-	for (pass = 0; pass < 2; pass++) {
-		data->nspec = 0;
+	data->nspec = 0;
 
-		lineno = 0;
-		while (getline(&line_buf, &line_len, fp) > 0) {
-			if (data->nspec >= maxnspec)
-				break;
-			status = process_line(rec, path, prefix_array, line_buf, pass, ++lineno);
+	lineno = 0;
+	while (getline(&line_buf, &line_len, fp) > 0) {
+		status = process_line(rec, path, prefix_array, line_buf, ++lineno);
+		if (status)
+			goto finish;
+	}
+
+	if (rec->validating) {
+		status = nodups_specs(data, path);
+		if (status)
+			goto finish;
+	}
+
+	lineno = 0;
+	if (homedirfp)
+		while (getline(&line_buf, &line_len, homedirfp) > 0) {
+			status = process_line(rec, homedir_path, prefix_array, line_buf, ++lineno);
 			if (status)
 				goto finish;
 		}
 
-		if (pass == 1 && rec->validating) {
-			status = nodups_specs(data, path);
+	lineno = 0;
+	if (localfp)
+		while (getline(&line_buf, &line_len, localfp) > 0) {
+			status = process_line(rec, local_path, prefix_array, line_buf, ++lineno);
 			if (status)
 				goto finish;
 		}
 
-		lineno = 0;
-		if (homedirfp)
-			while (getline(&line_buf, &line_len, homedirfp) > 0) {
-				if (data->nspec >= maxnspec)
-					break;
-				status = process_line(rec, homedir_path, prefix_array, line_buf, pass, ++lineno);
-				if (status)
-					goto finish;
-			}
-
-		lineno = 0;
-		if (localfp)
-			while (getline(&line_buf, &line_len, localfp) > 0) {
-				if (data->nspec >= maxnspec)
-					break;
-				status = process_line(rec, local_path, prefix_array, line_buf, pass, ++lineno);
-				if (status)
-					goto finish;
-			}
-
-		if (pass == 0) {
-			if (data->nspec == 0) {
-				status = 0;
-				goto finish;
-			}
-			data->spec_arr = calloc(data->nspec, sizeof(*data->spec_arr));
-			if (!data->spec_arr)
-				goto finish;
-
-			maxnspec = data->nspec;
-			rewind(fp);
-			if (homedirfp)
-				rewind(homedirfp);
-			if (localfp)
-				rewind(localfp);
-		}
-	}
 	free(line_buf);
 
 	status = sort_specs(data);
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 8c213d2..ddb7fbd 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -33,6 +33,7 @@ struct saved_data {
 	 */
 	struct spec *spec_arr;
 	unsigned int nspec;
+	unsigned int alloc_specs;
 
 	/*
 	 * The array of regular expression stems.
@@ -78,6 +79,31 @@ static inline mode_t string_to_mode(char *mode)
 	return 0;
 }
 
+static inline int grow_specs(struct saved_data *data)
+{
+	struct spec *specs;
+	size_t new_specs, total_specs;
+
+	if (data->nspec < data->alloc_specs)
+		return 0;
+
+	new_specs = data->nspec + 16;
+	total_specs = data->nspec + new_specs;
+	
+	specs = realloc(data->spec_arr, total_specs * sizeof(*specs));
+	if (!specs) {
+		perror("realloc");
+		return -1;
+	}
+
+	/* blank the new entries */
+	memset(&specs[data->nspec], 0, new_specs * sizeof(*specs));
+
+	data->spec_arr = specs;
+	data->alloc_specs = total_specs;
+	return 0;
+}
+
 /* Determine if the regular expression specification has any meta characters. */
 static inline void spec_hasMetaChars(struct spec *spec)
 {
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
