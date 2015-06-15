Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5FCYOph023757
 for <selinux@tycho.nsa.gov>; Mon, 15 Jun 2015 08:34:24 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Fix property processing and cleanup formatting
Date: Mon, 15 Jun 2015 13:34:08 +0100
Message-Id: <1434371648-2737-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix memory issues flagged by valgrind.
These changes bring the property service in line with Android [1]
apart from some minor build differences.

[1] https://android-review.googlesource.com/#/c/153580/

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label_android_property.c | 62 ++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
index dadb160..1160777 100644
--- a/libselinux/src/label_android_property.c
+++ b/libselinux/src/label_android_property.c
@@ -16,7 +16,7 @@
 /* A property security context specification. */
 typedef struct spec {
 	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
-	char *property_key;	/* property key string */
+	char *property_key;		/* property key string */
 } spec_t;
 
 /* Our stored configuration */
@@ -56,21 +56,23 @@ static int nodups_specs(struct saved_data *data, const char *path)
 	for (ii = 0; ii < data->nspec; ii++) {
 		curr_spec = &spec_arr[ii];
 		for (jj = ii + 1; jj < data->nspec; jj++) {
-			if (!strcmp(spec_arr[jj].property_key, curr_spec->property_key)) {
+			if (!strcmp(spec_arr[jj].property_key,
+					    curr_spec->property_key)) {
 				rc = -1;
 				errno = EINVAL;
-				if (strcmp(spec_arr[jj].lr.ctx_raw, curr_spec->lr.ctx_raw)) {
-					selinux_log(SELINUX_ERROR,
-						    "%s: Multiple different specifications for %s  (%s and %s).\n",
-						    path,
-						    curr_spec->property_key,
-						    spec_arr[jj].lr.ctx_raw,
-						    curr_spec->lr.ctx_raw);
+				if (strcmp(spec_arr[jj].lr.ctx_raw,
+						    curr_spec->lr.ctx_raw)) {
+					selinux_log
+						(SELINUX_ERROR,
+						 "%s: Multiple different specifications for %s  (%s and %s).\n",
+						 path, curr_spec->property_key,
+						 spec_arr[jj].lr.ctx_raw,
+						 curr_spec->lr.ctx_raw);
 				} else {
-					selinux_log(SELINUX_ERROR,
-						    "%s: Multiple same specifications for %s.\n",
-						    path,
-						    curr_spec->property_key);
+					selinux_log
+						(SELINUX_ERROR,
+						 "%s: Multiple same specifications for %s.\n",
+						 path, curr_spec->property_key);
 				}
 			}
 		}
@@ -95,32 +97,35 @@ static int process_line(struct selabel_handle *rec,
 		selinux_log(SELINUX_WARNING,
 			    "%s:  line %u is missing fields, skipping\n", path,
 			    lineno);
+		free(prop);
 		return 0;
 	}
 
-	if (pass == 1) {
+	if (pass == 0) {
+		free(prop);
+		free(context);
+	} else if (pass == 1) {
 		/* On the second pass, process and store the specification in spec. */
-		spec_arr[nspec].property_key = strdup(prop);
+		spec_arr[nspec].property_key = prop;
 		if (!spec_arr[nspec].property_key) {
 			selinux_log(SELINUX_WARNING,
-				    "%s:  out of memory at line %u on prop %s\n",
+				    "%s:  out of memory at line %d on prop %s\n",
 				    path, lineno, prop);
-			return -1;
-
+		return -1;
 		}
 
-		spec_arr[nspec].lr.ctx_raw = strdup(context);
+		spec_arr[nspec].lr.ctx_raw = context;
 		if (!spec_arr[nspec].lr.ctx_raw) {
 			selinux_log(SELINUX_WARNING,
-				    "%s:  out of memory at line %u on context %s\n",
+				    "%s:  out of memory at line %d on context %s\n",
 				    path, lineno, context);
-			return -1;
+		return -1;
 		}
 
 		if (rec->validating) {
 			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
 				selinux_log(SELINUX_WARNING,
-					    "%s:  line %u has invalid context %s\n",
+					    "%s:  line %d has invalid context %s\n",
 					    path, lineno, spec_arr[nspec].lr.ctx_raw);
 			}
 		}
@@ -149,7 +154,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 			break;
 		}
 
-	if (!path) 
+	if (!path)
 		return -1;
 
 	/* Open the specification file. */
@@ -174,7 +179,8 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 
 		while (fgets(line_buf, sizeof line_buf - 1, fp)
 		       && data->nspec < maxnspec) {
-			if (process_line(rec, path, line_buf, pass, ++lineno) != 0)
+			if (process_line(rec, path, line_buf, pass, ++lineno)
+									  != 0)
 				goto finish;
 		}
 
@@ -186,7 +192,6 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 		}
 
 		if (pass == 0) {
-
 			if (data->nspec == 0) {
 				status = 0;
 				goto finish;
@@ -234,7 +239,7 @@ static void closef(struct selabel_handle *rec)
 
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 					 const char *key,
-					 int __attribute__ ((unused)) type)
+					 int __attribute__((unused)) type)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	spec_t *spec_arr = data->spec_arr;
@@ -267,12 +272,13 @@ finish:
 	return ret;
 }
 
-static void stats(struct selabel_handle __attribute__ ((unused)) * rec)
+static void stats(struct selabel_handle __attribute__((unused)) *rec)
 {
 	selinux_log(SELINUX_WARNING, "'stats' functionality not implemented.\n");
 }
 
-int selabel_property_init(struct selabel_handle *rec, struct selinux_opt *opts,
+int selabel_property_init(struct selabel_handle *rec,
+			  struct selinux_opt *opts,
 			  unsigned nopts)
 {
 	struct saved_data *data;
-- 
2.1.0
