Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8UFTaWx030645
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 11:29:36 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [RFC PATCH V3] libselinux: Add selabel_digest function
Date: Wed, 30 Sep 2015 16:29:20 +0100
Message-Id: <1443626960-9326-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

selabel_digest(3) if enabled by the SELABEL_OPT_DIGEST option during
selabel_open(3) will return an SHA1 digest of the spec files, plus
a list of the specfiles used to calculate the digest. There is a
test utility supplied that will demonstrate the functionality.

The use case for selabel_digest(3) is to implement an selinux_restorecon
function based on the Android version that writes a hash of the
file_contexts files to an extended attribute to enhance performance
(see external/libselinux/src/android.c selinux_android_restorecon()).

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Changes:
Minor general cleanups and updated as per comments from:
http://marc.info/?l=selinux&m=144233357510422&w=2
V3 Changes:
As per comments from: http://marc.info/?l=selinux&m=144355202127208&w=2

 libselinux/include/selinux/label.h      |  21 +++-
 libselinux/man/man3/selabel_digest.3    |  61 +++++++++++
 libselinux/man/man3/selabel_open.3      |   5 +
 libselinux/src/Makefile                 |   2 +-
 libselinux/src/label.c                  |  85 ++++++++++++++-
 libselinux/src/label_android_property.c |   7 +-
 libselinux/src/label_db.c               |  13 +++
 libselinux/src/label_file.c             |  43 +++++---
 libselinux/src/label_internal.h         |  29 ++++-
 libselinux/src/label_media.c            |   7 +-
 libselinux/src/label_support.c          |  77 +++++++++++++-
 libselinux/src/label_x.c                |   7 +-
 libselinux/utils/Makefile               |   2 +-
 libselinux/utils/selabel_digest.c       | 183 ++++++++++++++++++++++++++++++++
 14 files changed, 519 insertions(+), 23 deletions(-)
 create mode 100644 libselinux/man/man3/selabel_digest.3
 create mode 100644 libselinux/utils/selabel_digest.c

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 14793a1..f0b1e10 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -49,8 +49,10 @@ struct selabel_handle;
 #define SELABEL_OPT_PATH	3
 /* select a subset of the search space as an optimization (file backend) */
 #define SELABEL_OPT_SUBSET	4
+/* require a hash calculation on spec files */
+#define SELABEL_OPT_DIGEST	5
 /* total number of options */
-#define SELABEL_NOPT		5
+#define SELABEL_NOPT		6
 
 /*
  * Label operations
@@ -106,6 +108,23 @@ int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
 int selabel_lookup_best_match_raw(struct selabel_handle *rec, char **con,
 			      const char *key, const char **aliases, int type);
 
+/**
+ * selabel_digest - Retrieve the SHA1 digest and the list of specfiles used to
+ *		    generate the digest. The SELABEL_OPT_DIGEST option must
+ *		    be set in selabel_open() to initiate the digest generation.
+ * @handle: specifies backend instance to query
+ * @digest: returns a pointer to the SHA1 digest.
+ * @digest_len: returns length of digest in bytes.
+ * @specfiles: a list of specfiles used in the SHA1 digest generation.
+ *	       The list is NULL terminated and will hold @num_specfiles entries.
+ * @num_specfiles: number of specfiles in the list.
+ *
+ * Return %0 on success, -%1 with @errno set on failure.
+ */
+int selabel_digest(struct selabel_handle *rec,
+			    unsigned char **digest, size_t *digest_len,
+			    char ***specfiles, size_t *num_specfiles);
+
 enum selabel_cmp_result {
 	SELABEL_SUBSET,
 	SELABEL_EQUAL,
diff --git a/libselinux/man/man3/selabel_digest.3 b/libselinux/man/man3/selabel_digest.3
new file mode 100644
index 0000000..56a008f
--- /dev/null
+++ b/libselinux/man/man3/selabel_digest.3
@@ -0,0 +1,61 @@
+.TH "selabel_digest" "3" "16 Sept 2015" "" "SELinux API documentation"
+.SH "NAME"
+selabel_digest \- Return digest of specfiles and list of files used
+.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.br
+.B #include <selinux/label.h>
+.sp
+.BI "int selabel_digest(struct selabel_handle *" hnd ,
+.in +\w'int selabel_digest('u
+.BI "unsigned char **" digest ,
+.BI "size_t *" digest_len ,
+.br
+.BI "char ***" specfiles,
+.BI "size_t *" num_specfiles ");"
+.in
+.
+.SH "DESCRIPTION"
+.BR selabel_digest ()
+performs an operation on the handle
+.IR hnd ,
+returning the results of the SHA1 digest pointed to by
+.IR digest ,
+whose length will be
+.IR digest_len .
+The list of specfiles used in the SHA1 digest calculation is returned in
+.I specfiles
+with the number of entries in
+.IR num_specfiles .
+.sp
+To enable
+.BR selabel_digest ()
+to return this information the
+.B SELABEL_OPT_DIGEST
+option must be enable in
+.BR selabel_open (3).
+.sp
+The result of
+.BR selabel_digest ()
+must not be used after
+.BR selabel_close (3).
+.
+.SH "RETURN VALUE"
+On success, zero is returned.  On error, \-1 is returned and
+.I errno
+is set appropriately.
+.
+.SH "ERRORS"
+.TP
+.B EINVAL
+No digest available (returned if
+.B SELABEL_OPT_DIGEST
+option not enabled).
+.TP
+.B ENOMEM
+An attempt to allocate memory failed.
+.
+.SH "SEE ALSO"
+.BR selabel_open (3),
+.BR selinux (8)
diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/selabel_open.3
index 405b6ec..971ebc1 100644
--- a/libselinux/man/man3/selabel_open.3
+++ b/libselinux/man/man3/selabel_open.3
@@ -67,6 +67,11 @@ A non-null value for this option enables context validation.  By default,
 is used; a custom validation function can be provided via
 .BR selinux_set_callback (3).
 Note that an invalid context may not be treated as an error unless it is actually encountered during a lookup operation.
+.TP
+.B SELABEL_OPT_DIGEST
+A non-null value for this option enables the generation of an SHA1 digest of
+the spec files loaded as described in
+.BR selabel_digest (3)
 .
 .SH "BACKENDS"
 .TP
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index a81acc7..2a0e889 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -111,7 +111,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) -shared -o $@ $^ -lpcre -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(CFLAGS) -shared -o $@ $^ -lpcre -ldl -lcrypto $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 222b6b3..c656fda 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -10,6 +10,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/stat.h>
 #include <selinux/selinux.h>
 #include "callbacks.h"
 #include "label_internal.h"
@@ -65,15 +66,21 @@ static char *selabel_sub(struct selabel_sub *ptr, const char *src)
 	return NULL;
 }
 
-struct selabel_sub *selabel_subs_init(const char *path, struct selabel_sub *list)
+struct selabel_sub *selabel_subs_init(const char *path,
+					    struct selabel_sub *list,
+					    struct selabel_digest *digest)
 {
 	char buf[1024];
 	FILE *cfg = fopen(path, "r");
-	struct selabel_sub *sub;
+	struct selabel_sub *sub = NULL;
+	struct stat sb;
 
 	if (!cfg)
 		return list;
 
+	if (fstat(fileno(cfg), &sb) < 0)
+		return list;
+
 	while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
 		char *ptr = NULL;
 		char *src = buf;
@@ -115,6 +122,10 @@ struct selabel_sub *selabel_subs_init(const char *path, struct selabel_sub *list
 		sub->next = list;
 		list = sub;
 	}
+
+	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
+		goto err;
+
 out:
 	fclose(cfg);
 	return list;
@@ -125,6 +136,57 @@ err:
 	goto out;
 }
 
+static inline struct selabel_digest *selabel_is_digest_set
+				    (const struct selinux_opt *opts,
+				    unsigned n,
+				    struct selabel_digest *entry)
+{
+	struct selabel_digest *digest = NULL;
+
+	while (n--) {
+		if (opts[n].type == SELABEL_OPT_DIGEST &&
+					    opts[n].value == (char *)1) {
+			digest = calloc(1, sizeof(*digest));
+			if (!digest)
+				goto err;
+
+			digest->digest = calloc(1, DIGEST_SPECFILE_SIZE + 1);
+			if (!digest->digest)
+				goto err;
+
+			digest->specfile_list = calloc(DIGEST_FILES_MAX,
+							    sizeof(char *));
+			if (!digest->specfile_list)
+				goto err;
+
+			entry = digest;
+			return entry;
+		}
+	}
+	return NULL;
+
+err:
+	free(digest->digest);
+	free(digest->specfile_list);
+	free(digest);
+	return NULL;
+}
+
+static void selabel_digest_fini(struct selabel_digest *ptr)
+{
+	int i;
+
+	free(ptr->digest);
+	free(ptr->hashbuf);
+
+	if (ptr->specfile_list) {
+		for (i = 0; ptr->specfile_list[i]; i++)
+			free(ptr->specfile_list[i]);
+		free(ptr->specfile_list);
+	}
+	free(ptr);
+}
+
 /*
  * Validation functions
  */
@@ -273,6 +335,7 @@ struct selabel_handle *selabel_open(unsigned int backend,
 
 	rec->subs = NULL;
 	rec->dist_subs = NULL;
+	rec->digest = selabel_is_digest_set(opts, nopts, rec->digest);
 
 	if ((*initfuncs[backend])(rec, opts, nopts)) {
 		free(rec);
@@ -378,10 +441,28 @@ enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
 	return h1->func_cmp(h1, h2);
 }
 
+int selabel_digest(struct selabel_handle *rec,
+				    unsigned char **digest, size_t *digest_len,
+				    char ***specfiles, size_t *num_specfiles)
+{
+	if (!rec->digest) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	*digest = rec->digest->digest;
+	*digest_len = DIGEST_SPECFILE_SIZE;
+	*specfiles = rec->digest->specfile_list;
+	*num_specfiles = rec->digest->specfile_cnt;
+	return 0;
+}
+
 void selabel_close(struct selabel_handle *rec)
 {
 	selabel_subs_fini(rec->subs);
 	selabel_subs_fini(rec->dist_subs);
+	if (rec->digest)
+		selabel_digest_fini(rec->digest);
 	rec->func_close(rec);
 	free(rec->spec_file);
 	free(rec);
diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
index af06c4a..b8fab79 100644
--- a/libselinux/src/label_android_property.c
+++ b/libselinux/src/label_android_property.c
@@ -199,7 +199,12 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 
 	qsort(data->spec_arr, data->nspec, sizeof(struct spec), cmp);
 
-	status = 0;
+	status = digest_add_specfile(rec->digest, fp, NULL, sb.st_size, path);
+	if (status)
+		goto finish;
+
+	status = digest_gen_hash(rec->digest);
+
 finish:
 	fclose(fp);
 	return status;
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index 6820ae3..18c5967 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -244,6 +244,7 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 	size_t		line_len = 0;
 	unsigned int	line_num = 0;
 	unsigned int	i;
+	struct stat sb;
 
 	/*
 	 * Initialize catalog data structure
@@ -280,6 +281,12 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 		free(catalog);
 		return NULL;
 	}
+	if (fstat(fileno(filp), &sb) < 0)
+		return NULL;
+	if (!S_ISREG(sb.st_mode)) {
+		errno = EINVAL;
+		return NULL;
+	}
 	rec->spec_file = strdup(path);
 
 	/*
@@ -312,6 +319,12 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 	}
 	free(line_buf);
 
+	if (digest_add_specfile(rec->digest, filp, NULL, sb.st_size, path) < 0)
+		goto out_error;
+
+	if (digest_gen_hash(rec->digest) < 0)
+		goto out_error;
+
 	fclose(filp);
 
 	return catalog;
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index bf91885..cb43cb9 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -98,7 +98,8 @@ static int nodups_specs(struct saved_data *data, const char *path)
 }
 
 static int load_mmap(struct selabel_handle *rec, const char *path,
-		     struct stat *sb, bool isbinary)
+				    struct stat *sb, bool isbinary,
+				    struct selabel_digest *digest)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	char mmap_path[PATH_MAX + 1];
@@ -403,8 +404,12 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 
 		data->nspec++;
 	}
-	/* win */
-	rc = 0;
+
+	rc = digest_add_specfile(digest, NULL, addr, mmap_stat.st_size,
+								    mmap_path);
+	if (rc)
+		goto err;
+
 err:
 	free(stem_map);
 
@@ -412,7 +417,8 @@ err:
 }
 
 static int process_file(const char *path, const char *suffix,
-			  struct selabel_handle *rec, const char *prefix)
+			  struct selabel_handle *rec,
+			  const char *prefix, struct selabel_digest *digest)
 {
 	FILE *fp;
 	struct stat sb;
@@ -474,7 +480,7 @@ static int process_file(const char *path, const char *suffix,
 		sb.st_mtime = 0;
 	}
 
-	rc = load_mmap(rec, path, &sb, isbinary);
+	rc = load_mmap(rec, path, &sb, isbinary, digest);
 	if (rc == 0)
 		goto out;
 
@@ -492,6 +498,8 @@ static int process_file(const char *path, const char *suffix,
 			goto out;
 	}
 
+	rc = digest_add_specfile(digest, fp, NULL, sb.st_size, path);
+
 out:
 	free(line_buf);
 	if (fp)
@@ -524,14 +532,19 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 
 	/* Process local and distribution substitution files */
 	if (!path) {
-		rec->dist_subs = selabel_subs_init(selinux_file_context_subs_dist_path(), rec->dist_subs);
-		rec->subs = selabel_subs_init(selinux_file_context_subs_path(), rec->subs);
+		rec->dist_subs =
+		    selabel_subs_init(selinux_file_context_subs_dist_path(),
+		    rec->dist_subs, rec->digest);
+		rec->subs = selabel_subs_init(selinux_file_context_subs_path(),
+		    rec->subs, rec->digest);
 		path = selinux_file_context_path();
 	} else {
 		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", path);
-		rec->dist_subs = selabel_subs_init(subs_file, rec->dist_subs);
+		rec->dist_subs = selabel_subs_init(subs_file, rec->dist_subs,
+							    rec->digest);
 		snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
-		rec->subs = selabel_subs_init(subs_file, rec->subs);
+		rec->subs = selabel_subs_init(subs_file, rec->subs,
+							    rec->digest);
 	}
 
 	rec->spec_file = strdup(path);
@@ -539,7 +552,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	/*
 	 * The do detailed validation of the input and fill the spec array
 	 */
-	status = process_file(path, NULL, rec, prefix);
+	status = process_file(path, NULL, rec, prefix, rec->digest);
 	if (status)
 		goto finish;
 
@@ -550,15 +563,21 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	}
 
 	if (!baseonly) {
-		status = process_file(path, "homedirs", rec, prefix);
+		status = process_file(path, "homedirs", rec, prefix,
+							    rec->digest);
 		if (status && errno != ENOENT)
 			goto finish;
 
-		status = process_file(path, "local", rec, prefix);
+		status = process_file(path, "local", rec, prefix,
+							    rec->digest);
 		if (status && errno != ENOENT)
 			goto finish;
 	}
 
+	status = digest_gen_hash(rec->digest);
+	if (status)
+		goto finish;
+
 	status = sort_specs(data);
 
 finish:
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 6d00f5a..45bbe6c 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -10,6 +10,8 @@
 
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdio.h>
+#include <openssl/sha.h>
 #include <selinux/selinux.h>
 #include <selinux/label.h>
 #include "dso.h"
@@ -43,8 +45,31 @@ struct selabel_sub {
 	struct selabel_sub *next;
 };
 
+/*
+ * Calculate an SHA1 hash of all the files used to build the specs.
+ * The hash value is held in rec->digest if SELABEL_OPT_DIGEST set. To
+ * calculate the hash the hashbuf will hold a concatenation of all the files
+ * used. This is released once the value has been calculated.
+ */
+#define DIGEST_SPECFILE_SIZE SHA_DIGEST_LENGTH
+#define DIGEST_FILES_MAX 8
+struct selabel_digest {
+	unsigned char *digest;	/* SHA1 digest of specfiles */
+	unsigned char *hashbuf;	/* buffer to hold specfiles */
+	size_t hashbuf_size;	/* buffer size */
+	size_t specfile_cnt;	/* how many specfiles processed */
+	char **specfile_list;	/* and their names */
+};
+
+extern int digest_add_specfile(struct selabel_digest *digest, FILE *fp,
+						    char *from_addr,
+						    size_t buf_len,
+						    const char *path);
+extern int digest_gen_hash(struct selabel_digest *digest);
+
 extern struct selabel_sub *selabel_subs_init(const char *path,
-					     struct selabel_sub *list);
+				    struct selabel_sub *list,
+				    struct selabel_digest *digest);
 
 struct selabel_lookup_rec {
 	char * ctx_raw;
@@ -83,6 +108,8 @@ struct selabel_handle {
 	/* substitution support */
 	struct selabel_sub *dist_subs;
 	struct selabel_sub *subs;
+	/* ptr to SHA1 hash information if SELABEL_OPT_DIGEST set */
+	struct selabel_digest *digest;
 };
 
 /*
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index c589ca3..16a7ced 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -136,7 +136,12 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	}
 	free(line_buf);
 
-	status = 0;
+	status = digest_add_specfile(rec->digest, fp, NULL, sb.st_size, path);
+	if (status)
+		goto finish;
+
+	status = digest_gen_hash(rec->digest);
+
 finish:
 	fclose(fp);
 	return status;
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index b3ab8ab..08757b2 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -8,6 +8,8 @@
 #include <stdarg.h>
 #include <ctype.h>
 #include <string.h>
+#include <stdio.h>
+#include <errno.h>
 #include "label_internal.h"
 
 /*
@@ -15,8 +17,6 @@
  * replace sscanf to read entries from spec files. The file and
  * property services now use these.
  */
-
-/* Read an entry from a spec file (e.g. file_contexts) */
 static inline int read_spec_entry(char **entry, char **ptr, int *len)
 {
 	*entry = NULL;
@@ -96,3 +96,76 @@ int hidden read_spec_entries(char *line_buf, int num_args, ...)
 	va_end(ap);
 	return items;
 }
+
+/* Once all the specfiles are in the hash_buf, generate the hash. */
+int hidden digest_gen_hash(struct selabel_digest *digest)
+{
+	if (!digest)
+		return -1;
+
+	SHA1(digest->hashbuf, digest->hashbuf_size, digest->digest);
+	free(digest->hashbuf);
+	digest->hashbuf = NULL;
+	return 0;
+}
+
+/**
+ * digest_add_specfile - Add a specfile to the hashbuf and if gen_hash true
+ *			 then generate the hash.
+ * @digest: pointer to the selabel_digest struct
+ * @fp: file pointer for fread(3) or NULL if not.
+ * @from_addr: pointer at start of buffer for memcpy or NULL if not (used for
+ *	       mmap(3) files).
+ * @buf_len: length of buffer to copy.
+ * @path: pointer to the specfile.
+ *
+ * Return %0 on success, -%1 with @errno set on failure.
+ */
+int hidden digest_add_specfile(struct selabel_digest *digest, FILE *fp,
+				    char *from_addr, size_t buf_len,
+				    const char *path)
+{
+	unsigned char *tmp_buf;
+
+	if (!digest)
+		return -1;
+
+	if (digest->hashbuf_size + buf_len < digest->hashbuf_size) {
+		errno = EOVERFLOW;
+		return -1;
+	}
+	digest->hashbuf_size += buf_len;
+
+	tmp_buf = realloc(digest->hashbuf, digest->hashbuf_size);
+	if (!tmp_buf)
+		return -1;
+
+	digest->hashbuf = tmp_buf;
+
+	if (fp) {
+		rewind(fp);
+		if (fread(digest->hashbuf + (digest->hashbuf_size - buf_len),
+					    1, buf_len, fp) != buf_len)
+			return -1;
+
+		rewind(fp);
+	} else if (from_addr) {
+		tmp_buf = memcpy(digest->hashbuf +
+				    (digest->hashbuf_size - buf_len),
+				    from_addr, buf_len);
+		if (!tmp_buf)
+			return -1;
+	}
+	/* Now add path to list */
+	digest->specfile_list[digest->specfile_cnt] = strdup(path);
+	if (!digest->specfile_list[digest->specfile_cnt])
+		return -1;
+
+	digest->specfile_cnt++;
+	if (digest->specfile_cnt > DIGEST_FILES_MAX) {
+		errno = EOVERFLOW;
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 3d13b23..309deae 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -163,7 +163,12 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	}
 	free(line_buf);
 
-	status = 0;
+	status = digest_add_specfile(rec->digest, fp, NULL, sb.st_size, path);
+	if (status)
+		goto finish;
+
+	status = digest_gen_hash(rec->digest);
+
 finish:
 	fclose(fp);
 	return status;
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index cac85c7..5dda66e 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -28,7 +28,7 @@ LDLIBS += -L../src -lselinux -L$(LIBDIR)
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
-sefcontext_compile: LDLIBS += -lpcre ../src/libselinux.a -lsepol
+sefcontext_compile: LDLIBS += -lpcre -lcrypto ../src/libselinux.a -lsepol
 
 ifeq ($(DISABLE_AVC),y)
 	UNUSED_TARGETS+=compute_av compute_create compute_member compute_relabel
diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
new file mode 100644
index 0000000..16706b5
--- /dev/null
+++ b/libselinux/utils/selabel_digest.c
@@ -0,0 +1,183 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+
+static size_t digest_len;
+
+static void usage(const char *progname)
+{
+	fprintf(stderr,
+		"usage: %s -b backend [-d] [-v] [-B] [-f file]\n\n"
+		"Where:\n\t"
+		"-b  The backend - \"file\", \"media\", \"x\", \"db\" or "
+			"\"prop\"\n\t"
+		"-v  Run \"cat <specfile_list> | openssl dgst -sha1 -hex\"\n\t"
+		"    on the list of specfiles to compare the SHA1 digests.\n\t"
+		"-B  Use base specfiles only (valid for \"-b file\" only).\n\t"
+		"-f  Optional file containing the specs (defaults to\n\t"
+		"    those used by loaded policy).\n\n",
+		progname);
+	exit(1);
+}
+
+static int run_check_digest(char *cmd, char *selabel_digest)
+{
+	FILE *fp;
+	char files_digest[128];
+	char *files_ptr;
+	int rc = 0;
+
+	fp = popen(cmd, "r");
+	if (!fp) {
+		printf("Failed to run command line\n");
+		return -1;
+	}
+
+	/* Only expect one line "(stdin)= x.." so read and find first space */
+	while (fgets(files_digest, sizeof(files_digest) - 1, fp) != NULL)
+		;
+
+	files_ptr = strstr(files_digest, " ");
+
+	rc = strncmp(selabel_digest, files_ptr + 1, digest_len * 2);
+	if (rc) {
+		printf("Failed validation:\n\tselabel_digest: %s\n\t"
+				    "files_digest:   %s\n",
+				    selabel_digest, files_ptr + 1);
+	} else {
+		printf("Passed validation - digest: %s\n", selabel_digest);
+	}
+
+	pclose(fp);
+	return rc;
+}
+
+int main(int argc, char **argv)
+{
+	int backend = 0, rc, opt, i, validate = 0;
+	char *baseonly = NULL, *file = NULL;
+	char **specfiles = NULL;
+	unsigned char *sha1_digest = NULL;
+	size_t num_specfiles;
+
+	char cmd_buf[4096];
+	char *cmd_ptr;
+	char *sha1_buf;
+
+	struct selabel_handle *hnd;
+	struct selinux_opt selabel_option[] = {
+		{ SELABEL_OPT_PATH, file },
+		{ SELABEL_OPT_BASEONLY, baseonly },
+		{ SELABEL_OPT_DIGEST, (char *)1 }
+	};
+
+	if (argc < 3)
+		usage(argv[0]);
+
+	while ((opt = getopt(argc, argv, "b:Bvf:")) > 0) {
+		switch (opt) {
+		case 'b':
+			if (!strcasecmp(optarg, "file")) {
+				backend = SELABEL_CTX_FILE;
+			} else if (!strcmp(optarg, "media")) {
+				backend = SELABEL_CTX_MEDIA;
+			} else if (!strcmp(optarg, "x")) {
+				backend = SELABEL_CTX_X;
+			} else if (!strcmp(optarg, "db")) {
+				backend = SELABEL_CTX_DB;
+			} else if (!strcmp(optarg, "prop")) {
+				backend = SELABEL_CTX_ANDROID_PROP;
+			} else {
+				fprintf(stderr, "Unknown backend: %s\n",
+								    optarg);
+				usage(argv[0]);
+			}
+			break;
+		case 'B':
+			baseonly = (char *)1;
+			break;
+		case 'v':
+			validate = 1;
+			break;
+		case 'f':
+			file = optarg;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	memset(cmd_buf, 0, sizeof(cmd_buf));
+
+	selabel_option[0].value = file;
+	selabel_option[1].value = baseonly;
+
+	hnd = selabel_open(backend, selabel_option, 3);
+	if (!hnd) {
+		switch (errno) {
+		case EOVERFLOW:
+			fprintf(stderr, "ERROR Number of specfiles or specfile"
+					" buffer caused an overflow.\n");
+			break;
+		default:
+			fprintf(stderr, "ERROR: selabel_open: %s\n",
+						    strerror(errno));
+		}
+		return -1;
+	}
+
+	rc = selabel_digest(hnd, &sha1_digest, &digest_len, &specfiles,
+							    &num_specfiles);
+
+	if (rc) {
+		switch (errno) {
+		case EINVAL:
+			fprintf(stderr, "No digest available.\n");
+			break;
+		default:
+			fprintf(stderr, "selabel_digest ERROR: %s\n",
+						    strerror(errno));
+		}
+		goto err;
+	}
+
+	sha1_buf = malloc(digest_len * 2 + 1);
+	if (!sha1_buf) {
+		fprintf(stderr, "Could not malloc buffer ERROR: %s\n",
+						    strerror(errno));
+		rc = -1;
+		goto err;
+	}
+
+	printf("SHA1 digest: ");
+	for (i = 0; i < digest_len; i++)
+		sprintf(&(sha1_buf[i * 2]), "%02x", sha1_digest[i]);
+
+	printf("%s\n", sha1_buf);
+	printf("calculated using the following specfile(s):\n");
+
+	if (specfiles) {
+		cmd_ptr = &cmd_buf[0];
+		sprintf(cmd_ptr, "/usr/bin/cat ");
+		cmd_ptr = &cmd_buf[0] + strlen(cmd_buf);
+
+		for (i = 0; i < num_specfiles; i++) {
+			sprintf(cmd_ptr, "%s ", specfiles[i]);
+			cmd_ptr += strlen(specfiles[i]) + 1;
+			printf("%s\n", specfiles[i]);
+		}
+		sprintf(cmd_ptr, "| /usr/bin/openssl dgst -sha1 -hex");
+
+		if (validate)
+			rc = run_check_digest(cmd_buf, sha1_buf);
+	}
+
+	free(sha1_buf);
+err:
+	selabel_close(hnd);
+	return rc;
+}
-- 
2.4.3
