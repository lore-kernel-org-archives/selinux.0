Subject: Re: [patch] libselinux:  lazily compile regexes to reduce overhead
	of matchpathcon / selabel_lookup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Jim Meyering <jim@meyering.net>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <1195148439.18480.46.camel@moss-spartans.epoch.ncsc.mil>
References: <1195148439.18480.46.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 15 Nov 2007 12:55:01 -0500
Message-Id: <1195149301.18480.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-15 at 12:40 -0500, Stephen Smalley wrote:
> Ulrich Drepper noted that we could reduce the overhead of matchpathcon
> by lazily compiling the pathname regexes on demand when there is a stem
> match rather than compiling them all.  Below is a patch that does that
> for the libselinux 2.x series.  As with the context validation, the
> regex compilation defaults to being done lazily for typical users, but
> will still be done up front if the caller requested validation, as
> setfiles does.  Thus, setfiles will still compile and check the entire
> specification up front for errors, while most other programs will
> compile the regexes lazily.  Back porting to the libselinux 1.x series
> wouldn't be difficult, although it would have to be done manually.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Revised to drop some unused vars.

---

 src/label_file.c |  123 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 73 insertions(+), 50 deletions(-)

Index: libselinux/src/label_file.c
===================================================================
--- libselinux/src/label_file.c	(revision 2683)
+++ libselinux/src/label_file.c	(working copy)
@@ -30,6 +30,7 @@
 	char *regex_str;	/* regular expession string for diagnostics */
 	char *type_str;		/* type string for diagnostic messages */
 	regex_t regex;		/* compiled regular expression */
+	char regcomp;           /* regex_str has been compiled to regex */
 	mode_t mode;		/* mode format value */
 	int matches;		/* number of matching pathnames */
 	int hasMetaChars;	/* regular expression has meta-chars */
@@ -50,6 +51,7 @@
 	 */
 	spec_t *spec_arr;
 	unsigned int nspec;
+	unsigned int ncomp;
 
 	/*
 	 * The array of regular expression stems.
@@ -88,21 +90,18 @@
 
 /* find the stem of a file spec, returns the index into stem_arr for a new
  * or existing stem, (or -1 if there is no possible stem - IE for a file in
- * the root directory or a regex that is too complex for us).  Makes buf
- * point to the text AFTER the stem. */
-static int find_stem_from_spec(struct saved_data *data, const char **buf)
+ * the root directory or a regex that is too complex for us). */
+static int find_stem_from_spec(struct saved_data *data, const char *buf)
 {
 	int i, num = data->num_stems;
-	int stem_len = get_stem_from_spec(*buf);
+	int stem_len = get_stem_from_spec(buf);
 
 	if (!stem_len)
 		return -1;
 	for (i = 0; i < num; i++) {
 		if (stem_len == data->stem_arr[i].len
-		    && !strncmp(*buf, data->stem_arr[i].buf, stem_len)) {
-			*buf += stem_len;
+		    && !strncmp(buf, data->stem_arr[i].buf, stem_len))
 			return i;
-		}
 	}
 	if (data->alloc_stems == num) {
 		stem_t *tmp_arr;
@@ -117,10 +116,10 @@
 	data->stem_arr[num].buf = malloc(stem_len + 1);
 	if (!data->stem_arr[num].buf)
 		return -1;
-	memcpy(data->stem_arr[num].buf, *buf, stem_len);
+	memcpy(data->stem_arr[num].buf, buf, stem_len);
 	data->stem_arr[num].buf[stem_len] = '\0';
 	data->num_stems++;
-	*buf += stem_len;
+	buf += stem_len;
 	return num;
 }
 
@@ -220,13 +219,64 @@
 	return;
 }
 
+static int compile_regex(struct saved_data *data, spec_t *spec, char **errbuf)
+{
+	char *reg_buf, *anchored_regex, *cp;
+	stem_t *stem_arr = data->stem_arr;
+	size_t len;
+	int regerr;
+
+	if (spec->regcomp)
+		return 0; /* already done */
+
+	data->ncomp++; /* how many compiled regexes required */
+
+	/* Skip the fixed stem. */
+	reg_buf = spec->regex_str;
+	if (spec->stem_id >= 0)
+		reg_buf += stem_arr[spec->stem_id].len;
+
+	/* Anchor the regular expression. */
+	len = strlen(reg_buf);
+	cp = anchored_regex = malloc(len + 3);
+	if (!anchored_regex)
+		return -1;
+	/* Create ^...$ regexp.  */
+	*cp++ = '^';
+	cp = mempcpy(cp, reg_buf, len);
+	*cp++ = '$';
+	*cp = '\0';
+
+	/* Compile the regular expression. */
+	regerr = regcomp(&spec->regex, anchored_regex, 
+			 REG_EXTENDED | REG_NOSUB);
+	if (regerr != 0) {
+		size_t errsz = 0;
+		errsz = regerror(regerr, &spec->regex, NULL, 0);
+		if (errsz && errbuf)
+			*errbuf = malloc(errsz);
+		if (errbuf && *errbuf)
+			(void)regerror(regerr, &spec->regex,
+				       *errbuf, errsz);
+
+		free(anchored_regex);
+		return -1;
+	}
+	free(anchored_regex);
+
+	/* Done. */
+	spec->regcomp = 1;
+
+	return 0;
+}
+
+
 static int process_line(struct selabel_handle *rec,
 			const char *path, const char *prefix,
 			char *line_buf, int pass, unsigned lineno)
 {
-	int items, len, regerr;
-	char *buf_p, *regex, *anchored_regex, *type, *context;
-	const char *reg_buf;
+	int items, len;
+	char *buf_p, *regex, *type, *context;
 	struct saved_data *data = (struct saved_data *)rec->data;
 	spec_t *spec_arr = data->spec_arr;
 	unsigned int nspec = data->nspec;
@@ -253,8 +303,7 @@
 		type = 0;
 	}
 
-	reg_buf = regex;
-	len = get_stem_from_spec(reg_buf);
+	len = get_stem_from_spec(regex);
 	if (len && prefix && strncmp(prefix, regex, len)) {
 		/* Stem of regex does not match requested prefix, discard. */
 		free(regex);
@@ -264,45 +313,16 @@
 	}
 
 	if (pass == 1) {
-		/* On the second pass, compile and store the specification in spec. */
-		char *cp;
-		spec_arr[nspec].stem_id = find_stem_from_spec(data, &reg_buf);
+		/* On the second pass, process and store the specification in spec. */
+		char *errbuf = NULL;
+		spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
 		spec_arr[nspec].regex_str = regex;
-
-		/* Anchor the regular expression. */
-		len = strlen(reg_buf);
-		cp = anchored_regex = malloc(len + 3);
-		if (!anchored_regex)
-			return -1;
-		/* Create ^...$ regexp.  */
-		*cp++ = '^';
-		cp = mempcpy(cp, reg_buf, len);
-		*cp++ = '$';
-		*cp = '\0';
-
-		/* Compile the regular expression. */
-		regerr =
-			regcomp(&spec_arr[nspec].regex,
-				anchored_regex, REG_EXTENDED | REG_NOSUB);
-		if (regerr != 0) {
-			size_t errsz = 0;
-			char *errbuf = NULL;
-			errsz = regerror(regerr, &spec_arr[nspec].regex,
-					 errbuf, errsz);
-			if (errsz)
-				errbuf = malloc(errsz);
-			if (errbuf)
-				(void)regerror(regerr,
-					       &spec_arr[nspec].regex,
-					       errbuf, errsz);
+		if (rec->validating && compile_regex(data, &spec_arr[nspec], &errbuf)) {
 			COMPAT_LOG(SELINUX_WARNING,
-				    "%s:  line %d has invalid regex %s:  %s\n",
-				    path, lineno, anchored_regex,
-				    (errbuf ? errbuf : "out of memory"));
-			free(anchored_regex);
-			return 0;
+				   "%s:  line %d has invalid regex %s:  %s\n",
+				   path, lineno, regex,
+				   (errbuf ? errbuf : "out of memory"));
 		}
-		free(anchored_regex);
 
 		/* Convert the type string to a mode format */
 		spec_arr[nspec].type_str = type;
@@ -437,6 +457,7 @@
 	for (pass = 0; pass < 2; pass++) {
 		lineno = 0;
 		data->nspec = 0;
+		data->ncomp = 0;
 		while (getline(&line_buf, &line_len, fp) > 0
 		       && data->nspec < maxnspec) {
 			if (process_line(rec, path, prefix, line_buf,
@@ -574,6 +595,8 @@
 		     || spec_arr[i].stem_id == file_stem)
 		    && (!mode || !spec_arr[i].mode
 			|| mode == spec_arr[i].mode)) {
+			if (compile_regex(data, &spec_arr[i], NULL) < 0)
+				return NULL;
 			if (spec_arr[i].stem_id == -1)
 				rc = regexec(&spec_arr[i].regex, key, 0, 0, 0);
 			else

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
