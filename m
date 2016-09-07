From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov
Subject: [PATCH v2] libselinux: clean up process file
Date: Tue,  6 Sep 2016 17:07:01 -0700
Message-Id: <1473206821-30222-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

The current process_file() code will open the file
twice on the case of a binary file, correct this.

The general flow through process_file() was a bit
difficult to read, streamline the routine to be
more readable.

Detailed statistics of before and after:

Source lines of code reported by cloc on modified files:
before: 735
after: 740

Object size difference:
before: 195530 bytes
after:  195529 bytes

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/label_file.c | 263 ++++++++++++++++++++++++--------------------
 1 file changed, 145 insertions(+), 118 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index c89bb35..6839a77 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -97,62 +97,43 @@ static int nodups_specs(struct saved_data *data, const char *path)
 	return rc;
 }
 
-static int load_mmap(struct selabel_handle *rec, const char *path,
-				    struct stat *sb, bool isbinary,
-				    struct selabel_digest *digest)
+static int process_text_file(FILE *fp, const char *prefix, struct selabel_handle *rec, const char *path)
+{
+	/*
+	 * Then do detailed validation of the input and fill the spec array
+	 */
+	int rc;
+	size_t line_len;
+	unsigned lineno = 0;
+	char *line_buf = NULL;
+
+	while (getline(&line_buf, &line_len, fp) > 0) {
+		rc = process_line(rec, path, prefix, line_buf, ++lineno);
+		if (rc)
+			goto out;
+	}
+	rc = 0;
+out:
+	free(line_buf);
+	return rc;
+}
+
+static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec, const char *path)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
-	char mmap_path[PATH_MAX + 1];
-	int mmapfd;
 	int rc;
-	struct stat mmap_stat;
 	char *addr, *str_buf;
-	size_t len;
 	int *stem_map;
 	struct mmap_area *mmap_area;
 	uint32_t i, magic, version;
 	uint32_t entry_len, stem_map_len, regex_array_len;
 
-	if (isbinary) {
-		len = strlen(path);
-		if (len >= sizeof(mmap_path))
-			return -1;
-		strcpy(mmap_path, path);
-	} else {
-		rc = snprintf(mmap_path, sizeof(mmap_path), "%s.bin", path);
-		if (rc >= (int)sizeof(mmap_path))
-			return -1;
-	}
-
-	mmapfd = open(mmap_path, O_RDONLY | O_CLOEXEC);
-	if (mmapfd < 0)
-		return -1;
-
-	rc = fstat(mmapfd, &mmap_stat);
-	if (rc < 0) {
-		close(mmapfd);
-		return -1;
-	}
-
-	/* if mmap is old, ignore it */
-	if (mmap_stat.st_mtime < sb->st_mtime) {
-		close(mmapfd);
-		return -1;
-	}
-
-	/* ok, read it in... */
-	len = mmap_stat.st_size;
-	len += (sysconf(_SC_PAGE_SIZE) - 1);
-	len &= ~(sysconf(_SC_PAGE_SIZE) - 1);
-
 	mmap_area = malloc(sizeof(*mmap_area));
 	if (!mmap_area) {
-		close(mmapfd);
 		return -1;
 	}
 
-	addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, mmapfd, 0);
-	close(mmapfd);
+	addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
 	if (addr == MAP_FAILED) {
 		free(mmap_area);
 		perror("mmap");
@@ -306,7 +287,7 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 		if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->validating) {
 			if (selabel_validate(rec, &spec->lr) < 0) {
 				selinux_log(SELINUX_ERROR,
-					    "%s: context %s is invalid\n", mmap_path, spec->lr.ctx_raw);
+					    "%s: context %s is invalid\n", path, spec->lr.ctx_raw);
 				goto err;
 			}
 		}
@@ -408,105 +389,151 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 		data->nspec++;
 	}
 
-	rc = digest_add_specfile(digest, NULL, addr, mmap_stat.st_size,
-								    mmap_path);
-	if (rc)
-		goto err;
-
 err:
 	free(stem_map);
 
 	return rc;
 }
 
-static int process_file(const char *path, const char *suffix,
-			  struct selabel_handle *rec,
-			  const char *prefix, struct selabel_digest *digest)
-{
-	FILE *fp;
+struct file_details {
+	const char *suffix;
 	struct stat sb;
-	unsigned int lineno;
-	size_t line_len = 0;
-	char *line_buf = NULL;
-	int rc;
-	char stack_path[PATH_MAX + 1];
-	bool isbinary = false;
+};
+
+static char *rolling_append(char *current, const char *suffix, size_t max)
+{
+	size_t size;
+	size_t suffix_size;
+	size_t current_size;
+
+	if (!suffix)
+		return current;
+
+	/*
+	 * Overflow check that the following
+	 * arithmatec will not overflow or
+	 */
+	current_size = strlen(current);
+	suffix_size = strlen(suffix);
+
+	size = current_size + suffix_size;
+	if (size < current_size || size < suffix_size)
+		return NULL;
+
+	/* ensure space for the '.' and the '\0' characters. */
+	if (size >= (SIZE_MAX - 2))
+		return NULL;
+
+	size += 2;
+
+	if (size > max)
+		return NULL;
+
+	/* Append any given suffix */
+	char *to = stpcpy(&current[current_size], ".");
+	strcat(to, suffix);
+
+	return current;
+}
+
+static bool fcontext_is_binary(FILE *fp)
+{
 	uint32_t magic;
 
-	/* append the path suffix if we have one */
-	if (suffix) {
-		rc = snprintf(stack_path, sizeof(stack_path),
-					    "%s.%s", path, suffix);
-		if (rc >= (int)sizeof(stack_path)) {
-			errno = ENAMETOOLONG;
-			return -1;
-		}
-		path = stack_path;
+	size_t len = fread(&magic, sizeof(magic), 1, fp);
+	rewind(fp);
+
+	return (len && (magic == SELINUX_MAGIC_COMPILED_FCONTEXT));
+}
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static FILE *open_file(const char *path, const char *suffix,
+        char *save_path, size_t len, struct stat *sb)
+{
+	unsigned i;
+	int rc;
+	char stack_path[len];
+	struct file_details *found = NULL;
+
+	/*
+	 * Rolling append of suffix. Try to open with path.suffix then the
+	 * next as path.suffix.suffix and so forth.
+	 */
+	struct file_details fdetails[2] = {
+			{ .suffix = suffix },
+			{ .suffix = "bin" }
+	};
+
+	rc = snprintf(stack_path, sizeof(stack_path), "%s", path);
+	if (rc >= (int) sizeof(stack_path)) {
+		errno = ENAMETOOLONG;
+		return NULL;
 	}
 
-	/* Open the specification file. */
-	fp = fopen(path, "r");
-	if (fp) {
-		__fsetlocking(fp, FSETLOCKING_BYCALLER);
+	for (i = 0; i < ARRAY_SIZE(fdetails); i++) {
 
-		if (fstat(fileno(fp), &sb) < 0)
-			return -1;
-		if (!S_ISREG(sb.st_mode)) {
-			errno = EINVAL;
-			return -1;
-		}
+		/* This handles the case if suffix is null */
+		path = rolling_append(stack_path, fdetails[i].suffix,
+		        sizeof(stack_path));
+		if (!path)
+			return NULL;
 
-		magic = 0;
-		if (fread(&magic, sizeof magic, 1, fp) != 1) {
-			if (ferror(fp)) {
-				errno = EINVAL;
-				fclose(fp);
-				return -1;
-			}
-			clearerr(fp);
-		}
+		rc = stat(path, &fdetails[i].sb);
+		if (rc)
+			continue;
 
-		if (magic == SELINUX_MAGIC_COMPILED_FCONTEXT) {
-			/* file_contexts.bin format */
-			fclose(fp);
-			fp = NULL;
-			isbinary = true;
-		} else {
-			rewind(fp);
+		/* first file thing found, just take it */
+		if (!found) {
+			strcpy(save_path, path);
+			found = &fdetails[i];
+			continue;
 		}
-	} else {
+
 		/*
-		 * Text file does not exist, so clear the timestamp
-		 * so that we will always pass the timestamp comparison
-		 * with the bin file in load_mmap().
+		 * Keep picking the newest file found. Where "newest"
+		 * includes equality. This provides a precedence on
+		 * secondary suffixes even when the timestamp is the
+		 * same. Ie choose file_contexts.bin over file_contexts
+		 * even if the time stamp is the same.
 		 */
-		sb.st_mtime = 0;
+		if (fdetails[i].sb.st_mtime >= found->sb.st_mtime) {
+			found = &fdetails[i];
+			strcpy(save_path, path);
+		}
 	}
 
-	rc = load_mmap(rec, path, &sb, isbinary, digest);
-	if (rc == 0)
-		goto out;
+	if (!found) {
+		errno = ENOENT;
+		return NULL;
+	}
 
-	if (!fp)
-		return -1; /* no text or bin file */
+	memcpy(sb, &found->sb, sizeof(*sb));
+	return fopen(save_path, "r");
+}
 
-	/*
-	 * Then do detailed validation of the input and fill the spec array
-	 */
-	lineno = 0;
-	rc = 0;
-	while (getline(&line_buf, &line_len, fp) > 0) {
-		rc = process_line(rec, path, prefix, line_buf, ++lineno);
-		if (rc)
-			goto out;
-	}
+static int process_file(const char *path, const char *suffix,
+			  struct selabel_handle *rec,
+			  const char *prefix, struct selabel_digest *digest)
+{
+	int rc;
+	struct stat sb;
+	FILE *fp = NULL;
+	char found_path[PATH_MAX + 1];
+
+	fp = open_file(path, suffix, found_path, sizeof(found_path), &sb);
+	if (fp == NULL)
+		return -1;
 
-	rc = digest_add_specfile(digest, fp, NULL, sb.st_size, path);
+	rc = fcontext_is_binary(fp) ?
+			load_mmap(fp, sb.st_size, rec, found_path) :
+			process_text_file(fp, prefix, rec, found_path);
+	if (rc < 0)
+		goto out;
 
+	rc = digest_add_specfile(digest, fp, NULL, sb.st_size, found_path);
 out:
-	free(line_buf);
-	if (fp)
-		fclose(fp);
+	fclose(fp);
 	return rc;
 }
 
-- 
1.9.1
