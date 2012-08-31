From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 01/18] libselinux: label_file: use PCRE instead of glibc regex functions
Date: Fri, 31 Aug 2012 10:49:37 -0700
Message-Id: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The PCRE functions are about x10 faster than the glibc functions.  So
use the external library.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/Makefile     |  2 ++
 libselinux/src/label_file.c | 63 ++++++++++++++++++++++++---------------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 74e53bb..ac019df 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -20,6 +20,8 @@ RUBYINC ?= $(shell pkg-config --cflags ruby-$(RUBYLIBVER))
 RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 LIBBASE=$(shell basename $(LIBDIR))
 
+LDFLAGS ?= -lpcre
+
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
 
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 82a608c..5e7e712 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -16,7 +16,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <limits.h>
-#include <regex.h>
+#include <pcre.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -33,7 +33,8 @@ typedef struct spec {
 	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
 	char *regex_str;	/* regular expession string for diagnostics */
 	char *type_str;		/* type string for diagnostic messages */
-	regex_t regex;		/* compiled regular expression */
+	pcre *regex;		/* compiled regular expression */
+	pcre_extra *sd;		/* extra compiled stuff */
 	char regcomp;           /* regex_str has been compiled to regex */
 	mode_t mode;		/* mode format value */
 	int matches;		/* number of matching pathnames */
@@ -224,12 +225,13 @@ static void spec_hasMetaChars(struct spec *spec)
 	return;
 }
 
-static int compile_regex(struct saved_data *data, spec_t *spec, char **errbuf)
+static int compile_regex(struct saved_data *data, spec_t *spec, const char **errbuf)
 {
+	const char *tmperrbuf;
 	char *reg_buf, *anchored_regex, *cp;
 	stem_t *stem_arr = data->stem_arr;
 	size_t len;
-	int regerr;
+	int erroff;
 
 	if (spec->regcomp)
 		return 0; /* already done */
@@ -246,6 +248,7 @@ static int compile_regex(struct saved_data *data, spec_t *spec, char **errbuf)
 	cp = anchored_regex = malloc(len + 3);
 	if (!anchored_regex)
 		return -1;
+
 	/* Create ^...$ regexp.  */
 	*cp++ = '^';
 	cp = mempcpy(cp, reg_buf, len);
@@ -253,21 +256,20 @@ static int compile_regex(struct saved_data *data, spec_t *spec, char **errbuf)
 	*cp = '\0';
 
 	/* Compile the regular expression. */
-	regerr = regcomp(&spec->regex, anchored_regex, 
-			 REG_EXTENDED | REG_NOSUB);
-	if (regerr != 0) {
-		size_t errsz = 0;
-		errsz = regerror(regerr, &spec->regex, NULL, 0);
-		if (errsz && errbuf)
-			*errbuf = malloc(errsz);
-		if (errbuf && *errbuf)
-			(void)regerror(regerr, &spec->regex,
-				       *errbuf, errsz);
-
-		free(anchored_regex);
+	spec->regex = pcre_compile(anchored_regex, 0, &tmperrbuf, &erroff, NULL);
+	free(anchored_regex);
+	if (!spec->regex) {
+		if (errbuf)
+			*errbuf=tmperrbuf;
+		return -1;
+	}
+
+	spec->sd = pcre_study(spec->regex, 0, &tmperrbuf);
+	if (!spec->sd) {
+		if (errbuf)
+			*errbuf=tmperrbuf;
 		return -1;
 	}
-	free(anchored_regex);
 
 	/* Done. */
 	spec->regcomp = 1;
@@ -333,7 +335,7 @@ static int process_line(struct selabel_handle *rec,
 
 	if (pass == 1) {
 		/* On the second pass, process and store the specification in spec. */
-		char *errbuf = NULL;
+		const char *errbuf = NULL;
 		spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
 		spec_arr[nspec].regex_str = regex;
 		if (rec->validating && compile_regex(data, &spec_arr[nspec], &errbuf)) {
@@ -592,7 +594,10 @@ static void closef(struct selabel_handle *rec)
 		free(spec->type_str);
 		free(spec->lr.ctx_raw);
 		free(spec->lr.ctx_trans);
-		regfree(&spec->regex);
+		if (spec->regcomp) {
+			pcre_free(spec->regex);
+			pcre_free_study(spec->sd);
+		}
 	}
 
 	for (i = 0; i < (unsigned int)data->num_stems; i++) {
@@ -651,26 +656,24 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 	 * the last matching specification is used.
 	 */
 	for (i = data->nspec - 1; i >= 0; i--) {
+		spec_t *spec = &spec_arr[i];
 		/* if the spec in question matches no stem or has the same
 		 * stem as the file AND if the spec in question has no mode
 		 * specified or if the mode matches the file mode then we do
 		 * a regex check        */
-		if ((spec_arr[i].stem_id == -1
-		     || spec_arr[i].stem_id == file_stem)
-		    && (!mode || !spec_arr[i].mode
-			|| mode == spec_arr[i].mode)) {
-			if (compile_regex(data, &spec_arr[i], NULL) < 0)
+		if ((spec->stem_id == -1 || spec->stem_id == file_stem) &&
+		    (!mode || !spec->mode || mode == spec->mode)) {
+			if (compile_regex(data, spec, NULL) < 0)
 				goto finish;
-			if (spec_arr[i].stem_id == -1)
-				rc = regexec(&spec_arr[i].regex, key, 0, 0, 0);
+			if (spec->stem_id == -1)
+				rc = pcre_exec(spec->regex, spec->sd, key, strlen(key), 0, 0, NULL, 0);
 			else
-				rc = regexec(&spec_arr[i].regex, buf, 0, 0, 0);
+				rc = pcre_exec(spec->regex, spec->sd, buf, strlen(buf), 0, 0, NULL, 0);
 
 			if (rc == 0) {
-				spec_arr[i].matches++;
+				spec->matches++;
 				break;
-			}
-			if (rc == REG_NOMATCH)
+			} else if (rc == PCRE_ERROR_NOMATCH)
 				continue;
 			/* else it's an error */
 			goto finish;
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
