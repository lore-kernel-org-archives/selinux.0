From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: bigon@debian.org, 863854-forwarded@bugs.debian.org,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: fix selabel_lookup*() double slash bug
Date: Thu,  1 Jun 2017 15:56:24 -0400
Message-Id: <20170601195624.16999-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As originally reported in
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863854
, "systemd-hwdb --usr update" was assigning /lib/udev/hwdb.bin the
wrong security context.  This turned out to be a result of systemd-hwdb
calling selabel_lookup_raw() with a path with a leading double slash
(//lib/udev/hwdb.bin). While the selabel file backend already removes
duplicate slashes, this was occurring after any substitution matching
and replacement had occurred in the generic selabel frontend, and thus
the double slash was still preventing the /lib -> /usr/lib substitution
specified by file_contexts.subs_dist from occurring.  As a consequence,
the final path (/lib/udev/hwdb.bin) used to look up did not match the
/usr/lib/udev/[^/]* entry in file_contexts.

There were two options for resolving:
1) move the double slash removal to the selabel frontend code before
substitutions, or
2) move the substitution processing to the selabel file backend code
after double slash removal.

Since substitutions are currently only supported for the file backend,
and since the slash character may have no particular meaning in the
keys for other backends, it seems more correct to do the latter.
This has the advantage of taking all of the substitution data
structures and code private to the selabel file backend.

Test case:
Compare the output of:
	selabel_lookup -r -b file -k //lib/udev/hwdb.bin
versus:
	selabel_lookup -r -b file -k /lib/udev/hwdb.bin
when using refpolicy.

Bug: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863854
Reported-by: Russell Coker <russell@coker.com.au>
Reported-by: Michael Biebl <biebl@debian.org>
Reported-by: Laurent Bigonville <bigon@debian.org>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label.c          | 177 +---------------------------------------
 libselinux/src/label_file.c     | 159 +++++++++++++++++++++++++++++++++++-
 libselinux/src/label_file.h     |  11 +++
 libselinux/src/label_internal.h |  12 ---
 4 files changed, 169 insertions(+), 190 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index b27c103..48f4d2d 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -54,127 +54,6 @@ static selabel_initfunc initfuncs[] = {
 	CONFIG_ANDROID_BACKEND(selabel_service_init),
 };
 
-static void selabel_subs_fini(struct selabel_sub *ptr)
-{
-	struct selabel_sub *next;
-
-	while (ptr) {
-		next = ptr->next;
-		free(ptr->src);
-		free(ptr->dst);
-		free(ptr);
-		ptr = next;
-	}
-}
-
-static char *selabel_sub(struct selabel_sub *ptr, const char *src)
-{
-	char *dst = NULL;
-	int len;
-
-	while (ptr) {
-		if (strncmp(src, ptr->src, ptr->slen) == 0 ) {
-			if (src[ptr->slen] == '/' || 
-			    src[ptr->slen] == 0) {
-				if ((src[ptr->slen] == '/') &&
-				    (strcmp(ptr->dst, "/") == 0))
-					len = ptr->slen + 1;
-				else
-					len = ptr->slen;
-				if (asprintf(&dst, "%s%s", ptr->dst, &src[len]) < 0)
-					return NULL;
-				return dst;
-			}
-		}
-		ptr = ptr->next;
-	}
-	return NULL;
-}
-
-int selabel_subs_init(const char *path, struct selabel_digest *digest,
-		       struct selabel_sub **out_subs)
-{
-	char buf[1024];
-	FILE *cfg = fopen(path, "re");
-	struct selabel_sub *list = NULL, *sub = NULL;
-	struct stat sb;
-	int status = -1;
-
-	*out_subs = NULL;
-	if (!cfg) {
-		/* If the file does not exist, it is not fatal */
-		return (errno == ENOENT) ? 0 : -1;
-	}
-
-	if (fstat(fileno(cfg), &sb) < 0)
-		goto out;
-
-	while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
-		char *ptr = NULL;
-		char *src = buf;
-		char *dst = NULL;
-
-		while (*src && isspace(*src))
-			src++;
-		if (src[0] == '#') continue;
-		ptr = src;
-		while (*ptr && ! isspace(*ptr))
-			ptr++;
-		*ptr++ = '\0';
-		if (! *src) continue;
-
-		dst = ptr;
-		while (*dst && isspace(*dst))
-			dst++;
-		ptr=dst;
-		while (*ptr && ! isspace(*ptr))
-			ptr++;
-		*ptr='\0';
-		if (! *dst)
-			continue;
-
-		sub = malloc(sizeof(*sub));
-		if (! sub)
-			goto err;
-		memset(sub, 0, sizeof(*sub));
-
-		sub->src=strdup(src);
-		if (! sub->src)
-			goto err;
-
-		sub->dst=strdup(dst);
-		if (! sub->dst)
-			goto err;
-
-		sub->slen = strlen(src);
-		sub->next = list;
-		list = sub;
-		sub = NULL;
-	}
-
-	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
-		goto err;
-
-	*out_subs = list;
-	status = 0;
-
-out:
-	fclose(cfg);
-	return status;
-err:
-	if (sub)
-		free(sub->src);
-	free(sub);
-	while (list) {
-		sub = list->next;
-		free(list->src);
-		free(list->dst);
-		free(list);
-		list = sub;
-	}
-	goto out;
-}
-
 static inline struct selabel_digest *selabel_is_digest_set
 				    (const struct selinux_opt *opts,
 				    unsigned n,
@@ -260,27 +139,6 @@ out:
 }
 
 /* Public API helpers */
-static char *selabel_sub_key(struct selabel_handle *rec, const char *key)
-{
-	char *ptr = NULL;
-	char *dptr = NULL;
-
-	ptr = selabel_sub(rec->subs, key);
-	if (ptr) {
-		dptr = selabel_sub(rec->dist_subs, ptr);
-		if (dptr) {
-			free(ptr);
-			ptr = dptr;
-		}
-	} else {
-		ptr = selabel_sub(rec->dist_subs, key);
-	}
-	if (ptr)
-		return ptr;
-
-	return NULL;
-}
-
 static int selabel_fini(struct selabel_handle *rec,
 			    struct selabel_lookup_rec *lr,
 			    int translating)
@@ -300,20 +158,13 @@ selabel_lookup_common(struct selabel_handle *rec, int translating,
 		      const char *key, int type)
 {
 	struct selabel_lookup_rec *lr;
-	char *ptr = NULL;
 
 	if (key == NULL) {
 		errno = EINVAL;
 		return NULL;
 	}
 
-	ptr = selabel_sub_key(rec, key);
-	if (ptr) {
-		lr = rec->func_lookup(rec, ptr, type);
-		free(ptr);
-	} else {
-		lr = rec->func_lookup(rec, key, type);
-	}
+	lr = rec->func_lookup(rec, key, type);
 	if (!lr)
 		return NULL;
 
@@ -328,20 +179,13 @@ selabel_lookup_bm_common(struct selabel_handle *rec, int translating,
 		      const char *key, int type, const char **aliases)
 {
 	struct selabel_lookup_rec *lr;
-	char *ptr = NULL;
 
 	if (key == NULL) {
 		errno = EINVAL;
 		return NULL;
 	}
 
-	ptr = selabel_sub_key(rec, key);
-	if (ptr) {
-		lr = rec->func_lookup_best_match(rec, ptr, aliases, type);
-		free(ptr);
-	} else {
-		lr = rec->func_lookup_best_match(rec, key, aliases, type);
-	}
+	lr = rec->func_lookup_best_match(rec, key, aliases, type);
 	if (!lr)
 		return NULL;
 
@@ -379,8 +223,6 @@ struct selabel_handle *selabel_open(unsigned int backend,
 	rec->backend = backend;
 	rec->validating = selabel_is_validate_set(opts, nopts);
 
-	rec->subs = NULL;
-	rec->dist_subs = NULL;
 	rec->digest = selabel_is_digest_set(opts, nopts, rec->digest);
 
 	if ((*initfuncs[backend])(rec, opts, nopts)) {
@@ -421,9 +263,6 @@ int selabel_lookup_raw(struct selabel_handle *rec, char **con,
 
 bool selabel_partial_match(struct selabel_handle *rec, const char *key)
 {
-	char *ptr;
-	bool ret;
-
 	if (!rec->func_partial_match) {
 		/*
 		 * If the label backend does not support partial matching,
@@ -432,15 +271,7 @@ bool selabel_partial_match(struct selabel_handle *rec, const char *key)
 		return true;
 	}
 
-	ptr = selabel_sub_key(rec, key);
-	if (ptr) {
-		ret = rec->func_partial_match(rec, ptr);
-		free(ptr);
-	} else {
-		ret = rec->func_partial_match(rec, key);
-	}
-
-	return ret;
+	return rec->func_partial_match(rec, key);
 }
 
 int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
@@ -506,8 +337,6 @@ int selabel_digest(struct selabel_handle *rec,
 
 void selabel_close(struct selabel_handle *rec)
 {
-	selabel_subs_fini(rec->subs);
-	selabel_subs_fini(rec->dist_subs);
 	if (rec->digest)
 		selabel_digest_fini(rec->digest);
 	rec->func_close(rec);
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index c05b37a..f84d470 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -559,6 +559,148 @@ static int process_file(const char *path, const char *suffix,
 	return -1;
 }
 
+static void selabel_subs_fini(struct selabel_sub *ptr)
+{
+	struct selabel_sub *next;
+
+	while (ptr) {
+		next = ptr->next;
+		free(ptr->src);
+		free(ptr->dst);
+		free(ptr);
+		ptr = next;
+	}
+}
+
+static char *selabel_sub(struct selabel_sub *ptr, const char *src)
+{
+	char *dst = NULL;
+	int len;
+
+	while (ptr) {
+		if (strncmp(src, ptr->src, ptr->slen) == 0 ) {
+			if (src[ptr->slen] == '/' ||
+			    src[ptr->slen] == 0) {
+				if ((src[ptr->slen] == '/') &&
+				    (strcmp(ptr->dst, "/") == 0))
+					len = ptr->slen + 1;
+				else
+					len = ptr->slen;
+				if (asprintf(&dst, "%s%s", ptr->dst, &src[len]) < 0)
+					return NULL;
+				return dst;
+			}
+		}
+		ptr = ptr->next;
+	}
+	return NULL;
+}
+
+static int selabel_subs_init(const char *path, struct selabel_digest *digest,
+		       struct selabel_sub **out_subs)
+{
+	char buf[1024];
+	FILE *cfg = fopen(path, "re");
+	struct selabel_sub *list = NULL, *sub = NULL;
+	struct stat sb;
+	int status = -1;
+
+	*out_subs = NULL;
+	if (!cfg) {
+		/* If the file does not exist, it is not fatal */
+		return (errno == ENOENT) ? 0 : -1;
+	}
+
+	if (fstat(fileno(cfg), &sb) < 0)
+		goto out;
+
+	while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
+		char *ptr = NULL;
+		char *src = buf;
+		char *dst = NULL;
+
+		while (*src && isspace(*src))
+			src++;
+		if (src[0] == '#') continue;
+		ptr = src;
+		while (*ptr && ! isspace(*ptr))
+			ptr++;
+		*ptr++ = '\0';
+		if (! *src) continue;
+
+		dst = ptr;
+		while (*dst && isspace(*dst))
+			dst++;
+		ptr=dst;
+		while (*ptr && ! isspace(*ptr))
+			ptr++;
+		*ptr='\0';
+		if (! *dst)
+			continue;
+
+		sub = malloc(sizeof(*sub));
+		if (! sub)
+			goto err;
+		memset(sub, 0, sizeof(*sub));
+
+		sub->src=strdup(src);
+		if (! sub->src)
+			goto err;
+
+		sub->dst=strdup(dst);
+		if (! sub->dst)
+			goto err;
+
+		sub->slen = strlen(src);
+		sub->next = list;
+		list = sub;
+		sub = NULL;
+	}
+
+	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
+		goto err;
+
+	*out_subs = list;
+	status = 0;
+
+out:
+	fclose(cfg);
+	return status;
+err:
+	if (sub)
+		free(sub->src);
+	free(sub);
+	while (list) {
+		sub = list->next;
+		free(list->src);
+		free(list->dst);
+		free(list);
+		list = sub;
+	}
+	goto out;
+}
+
+static char *selabel_sub_key(struct saved_data *data, const char *key)
+{
+	char *ptr = NULL;
+	char *dptr = NULL;
+
+	ptr = selabel_sub(data->subs, key);
+	if (ptr) {
+		dptr = selabel_sub(data->dist_subs, ptr);
+		if (dptr) {
+			free(ptr);
+			ptr = dptr;
+		}
+	} else {
+		ptr = selabel_sub(data->dist_subs, key);
+	}
+	if (ptr)
+		return ptr;
+
+	return NULL;
+}
+
 static void closef(struct selabel_handle *rec);
 
 static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
@@ -589,23 +731,23 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	if (!path) {
 		status = selabel_subs_init(
 			selinux_file_context_subs_dist_path(),
-			rec->digest, &rec->dist_subs);
+			rec->digest, &data->dist_subs);
 		if (status)
 			goto finish;
 		status = selabel_subs_init(selinux_file_context_subs_path(),
-			rec->digest, &rec->subs);
+			rec->digest, &data->subs);
 		if (status)
 			goto finish;
 		path = selinux_file_context_path();
 	} else {
 		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", path);
 		status = selabel_subs_init(subs_file, rec->digest,
-					   &rec->dist_subs);
+					   &data->dist_subs);
 		if (status)
 			goto finish;
 		snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
 		status = selabel_subs_init(subs_file, rec->digest,
-					   &rec->subs);
+					   &data->subs);
 		if (status)
 			goto finish;
 	}
@@ -660,6 +802,9 @@ static void closef(struct selabel_handle *rec)
 	struct stem *stem;
 	unsigned int i;
 
+	selabel_subs_fini(data->subs);
+	selabel_subs_fini(data->dist_subs);
+
 	for (i = 0; i < data->nspec; i++) {
 		spec = &data->spec_arr[i];
 		free(spec->lr.ctx_trans);
@@ -707,6 +852,7 @@ static struct spec *lookup_common(struct selabel_handle *rec,
 	char *clean_key = NULL;
 	const char *prev_slash, *next_slash;
 	unsigned int sofar = 0;
+	char *sub = NULL;
 
 	if (!data->nspec) {
 		errno = ENOENT;
@@ -729,6 +875,10 @@ static struct spec *lookup_common(struct selabel_handle *rec,
 		key = clean_key;
 	}
 
+	sub = selabel_sub_key(data, key);
+	if (sub)
+		key = sub;
+
 	buf = key;
 	file_stem = find_stem_from_file(data, &buf);
 	mode &= S_IFMT;
@@ -777,6 +927,7 @@ static struct spec *lookup_common(struct selabel_handle *rec,
 
 finish:
 	free(clean_key);
+	free(sub);
 	return ret;
 }
 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 4ac64d5..de804ae 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -29,6 +29,13 @@
 #define SELINUX_COMPILED_FCONTEXT_MAX_VERS \
 	SELINUX_COMPILED_FCONTEXT_REGEX_ARCH
 
+struct selabel_sub {
+	char *src;
+	int slen;
+	char *dst;
+	struct selabel_sub *next;
+};
+
 /* A file security context specification. */
 struct spec {
 	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
@@ -76,6 +83,10 @@ struct saved_data {
 	int num_stems;
 	int alloc_stems;
 	struct mmap_area *mmap_areas;
+
+	/* substitution support */
+	struct selabel_sub *dist_subs;
+	struct selabel_sub *subs;
 };
 
 static inline mode_t string_to_mode(char *mode)
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 10f1e57..c55efb7 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -46,12 +46,6 @@ int selabel_service_init(struct selabel_handle *rec,
 /*
  * Labeling internal structures
  */
-struct selabel_sub {
-	char *src;
-	int slen;
-	char *dst;
-	struct selabel_sub *next;
-};
 
 /*
  * Calculate an SHA1 hash of all the files used to build the specs.
@@ -75,9 +69,6 @@ extern int digest_add_specfile(struct selabel_digest *digest, FILE *fp,
 						    const char *path);
 extern void digest_gen_hash(struct selabel_digest *digest);
 
-extern int selabel_subs_init(const char *path, struct selabel_digest *digest,
-			     struct selabel_sub **out_subs);
-
 struct selabel_lookup_rec {
 	char * ctx_raw;
 	char * ctx_trans;
@@ -112,9 +103,6 @@ struct selabel_handle {
 	 */
 	char *spec_file;
 
-	/* substitution support */
-	struct selabel_sub *dist_subs;
-	struct selabel_sub *subs;
 	/* ptr to SHA1 hash information if SELABEL_OPT_DIGEST set */
 	struct selabel_digest *digest;
 };
-- 
2.9.4
