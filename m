From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: add selabel_cmp interface and label_file backend
Date: Wed,  5 Aug 2015 12:52:33 -0400
Message-Id: <1438793553-15041-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add a selabel_cmp() interface for comparing two label configurations,
and implement it for the file backend (i.e. for file_contexts). This
allows comparing two file_contexts configurations to see if the first
is a subset of, equal/identical to, a superset of, or incomparable to
the second.  The motivating use case is to allow comparing two
file_contexts.bin files in Android CTS to confirm that a device
file_contexts.bin file contains all of the entries in the AOSP
general file_contexts.

Change-Id: I0fe63e0c7f11ae067b5aac2f468f7842e5d76986
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/include/selinux/label.h | 20 +++++++++
 libselinux/src/label.c             |  9 ++++
 libselinux/src/label_file.c        | 92 ++++++++++++++++++++++++++++++++++++++
 libselinux/src/label_internal.h    |  2 +
 4 files changed, 123 insertions(+)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 8d013d8..14793a1 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -106,6 +106,26 @@ int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
 int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
 			      const char *key, const char **aliases, int type);
 
+enum selabel_cmp_result {
+	SELABEL_SUBSET,
+	SELABEL_EQUAL,
+	SELABEL_SUPERSET,
+	SELABEL_INCOMPARABLE
+};
+
+/**
+ * selabel_cmp - Compare two label configurations.
+ * @h1: handle for the first label configuration
+ * @h2: handle for the first label configuration
+ *
+ * Compare two label configurations.
+ * Return %SELABEL_SUBSET if @h1 is a subset of @h2, %SELABEL_EQUAL
+ * if @h1 is identical to @h2, %SELABEL_SUPERSET if @h1 is a superset
+ * of @h2, and %SELABEL_INCOMPARABLE if @h1 and @h2 are incomparable.
+ */
+enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
+				    struct selabel_handle *h2);
+
 /**
  * selabel_stats - log labeling operation statistics.
  * @handle: specifies backend instance to query
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index adc0722..222b6b3 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -369,6 +369,15 @@ int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
 	return *con ? 0 : -1;
 }
 
+enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
+				    struct selabel_handle *h2)
+{
+	if (!h1->func_cmp || h1->func_cmp != h2->func_cmp)
+		return SELABEL_INCOMPARABLE;
+
+	return h1->func_cmp(h1, h2);
+}
+
 void selabel_close(struct selabel_handle *rec)
 {
 	selabel_subs_fini(rec->subs);
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b658968..3509394 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -5,6 +5,7 @@
  * Author : Stephen Smalley <sds@tycho.nsa.gov>
  */
 
+#include <assert.h>
 #include <fcntl.h>
 #include <stdarg.h>
 #include <string.h>
@@ -753,6 +754,96 @@ out:
 	return lr;
 }
 
+static enum selabel_cmp_result incomp(struct spec *spec1, struct spec *spec2, const char *reason, int i, int j)
+{
+	selinux_log(SELINUX_INFO,
+		    "selabel_cmp: mismatched %s on entry %d: (%s, %x, %s) vs entry %d: (%s, %x, %s)\n",
+		    reason,
+		    i, spec1->regex_str, spec1->mode, spec1->lr.ctx_raw,
+		    j, spec2->regex_str, spec2->mode, spec2->lr.ctx_raw);
+	return SELABEL_INCOMPARABLE;
+}
+
+static enum selabel_cmp_result cmp(struct selabel_handle *h1,
+				   struct selabel_handle *h2)
+{
+	struct saved_data *data1 = (struct saved_data *)h1->data;
+	struct saved_data *data2 = (struct saved_data *)h2->data;
+	unsigned int i, nspec1 = data1->nspec, j, nspec2 = data2->nspec;
+	struct spec *spec_arr1 = data1->spec_arr, *spec_arr2 = data2->spec_arr;
+	struct stem *stem_arr1 = data1->stem_arr, *stem_arr2 = data2->stem_arr;
+	bool skipped1 = false, skipped2 = false;
+
+	i = 0;
+	j = 0;
+	while (i < nspec1 && j < nspec2) {
+		struct spec *spec1 = &spec_arr1[i];
+		struct spec *spec2 = &spec_arr2[j];
+
+		/*
+		 * Because sort_specs() moves exact pathnames to the
+		 * end, we might need to skip over additional regex
+		 * entries that only exist in one of the configurations.
+		 */
+		if (!spec1->hasMetaChars && spec2->hasMetaChars) {
+			j++;
+			skipped2 = true;
+			continue;
+		}
+
+		if (spec1->hasMetaChars && !spec2->hasMetaChars) {
+			i++;
+			skipped1 = true;
+			continue;
+		}
+
+		if (spec1->regcomp && spec2->regcomp) {
+			size_t len1, len2;
+			int rc;
+
+			rc = pcre_fullinfo(spec1->regex, NULL, PCRE_INFO_SIZE, &len1);
+			assert(rc == 0);
+			rc = pcre_fullinfo(spec2->regex, NULL, PCRE_INFO_SIZE, &len2);
+			assert(rc == 0);
+			if (len1 != len2 ||
+			    memcmp(spec1->regex, spec2->regex, len1))
+				return incomp(spec1, spec2, "regex", i, j);
+		} else {
+			if (strcmp(spec1->regex_str, spec2->regex_str))
+				return incomp(spec1, spec2, "regex_str", i, j);
+		}
+
+		if (spec1->mode != spec2->mode)
+			return incomp(spec1, spec2, "mode", i, j);
+
+		if (spec1->stem_id == -1 && spec2->stem_id != -1)
+			return incomp(spec1, spec2, "stem_id", i, j);
+		if (spec2->stem_id == -1 && spec1->stem_id != -1)
+			return incomp(spec1, spec2, "stem_id", i, j);
+		if (spec1->stem_id != -1 && spec2->stem_id != -1) {
+			struct stem *stem1 = &stem_arr1[spec1->stem_id];
+			struct stem *stem2 = &stem_arr2[spec2->stem_id];
+			if (stem1->len != stem2->len ||
+			    strncmp(stem1->buf, stem2->buf, stem1->len))
+				return incomp(spec1, spec2, "stem", i, j);
+		}
+
+		if (strcmp(spec1->lr.ctx_raw, spec2->lr.ctx_raw))
+			return incomp(spec1, spec2, "ctx_raw", i, j);
+
+		i++;
+		j++;
+	}
+
+	if ((skipped1 || i < nspec1) && !skipped2)
+		return SELABEL_SUPERSET;
+	if ((skipped2 || j < nspec2) && !skipped1)
+		return SELABEL_SUBSET;
+	if (skipped1 && skipped2)
+		return SELABEL_INCOMPARABLE;
+	return SELABEL_EQUAL;
+}
+
 
 static void stats(struct selabel_handle *rec)
 {
@@ -795,6 +886,7 @@ int selabel_file_init(struct selabel_handle *rec,
 	rec->func_lookup = &lookup;
 	rec->func_partial_match = &partial_match;
 	rec->func_lookup_best_match = &lookup_best_match;
+	rec->func_cmp = &cmp;
 
 	return init(rec, opts, nopts);
 }
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 861eca1..6d00f5a 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -68,6 +68,8 @@ struct selabel_handle {
 						    const char *key,
 						    const char **aliases,
 						    int type);
+	enum selabel_cmp_result (*func_cmp)(struct selabel_handle *h1,
+					    struct selabel_handle *h2);
 
 	/* supports backend-specific state information */
 	void *data;
-- 
2.1.0
