From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 sds@tycho.nsa.gov
Subject: [PATCH] libselinux: clean up process file
Date: Fri, 26 Aug 2016 13:14:03 -0700
Message-Id: <1472242443-14689-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

The current process_file() code will open the file
twice on the case of a binary file, correct this.

Just open the file, determine the type, mmap and
process.

The general flow through process_file() was a bit
difficult to read, streamline the routine to be
more readable.

This change results in a slight performance increase
on textual files (presumable mmap) and no noticeable
change on bin files. The object code is 39 bytes
larger and there are 29 more lines from cloc.

Detailed statistics of before and after:

Source lines of code reported by cloc on modified files:
before: 1090
after: 1119

Object size difference:
before: 195530 bytes
after:  195569 bytes

Performance:

text fc files (avg of 3 runs with selabel_open()):
before: 248 ms
after: 243 ms

bin fc files (avg of 3 runs with selabel_open()):
before: 236 ms
after:  236 ms

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/label_file.c | 606 ++++++++++++++++++++++++++------------------
 libselinux/src/label_file.h |  17 +-
 2 files changed, 359 insertions(+), 264 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index c89bb35..bd65ee7 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -97,92 +97,270 @@ static int nodups_specs(struct saved_data *data, const char *path)
 	return rc;
 }
 
-static int load_mmap(struct selabel_handle *rec, const char *path,
-				    struct stat *sb, bool isbinary,
-				    struct selabel_digest *digest)
+static int load_mmap(FILE *fp, off_t size, struct selabel_handle *rec)
 {
-	struct saved_data *data = (struct saved_data *)rec->data;
-	char mmap_path[PATH_MAX + 1];
-	int mmapfd;
-	int rc;
-	struct stat mmap_stat;
-	char *addr, *str_buf;
-	size_t len;
-	int *stem_map;
+	char *addr;
 	struct mmap_area *mmap_area;
-	uint32_t i, magic, version;
-	uint32_t entry_len, stem_map_len, regex_array_len;
 
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
+	struct saved_data *data = (struct saved_data *) rec->data;
 
-	mmapfd = open(mmap_path, O_RDONLY | O_CLOEXEC);
-	if (mmapfd < 0)
+	addr = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
+	if (addr == MAP_FAILED )
 		return -1;
 
-	rc = fstat(mmapfd, &mmap_stat);
-	if (rc < 0) {
-		close(mmapfd);
+	mmap_area = malloc(sizeof(*mmap_area));
+	if (!mmap_area) {
+		munmap(addr, size);
 		return -1;
 	}
 
-	/* if mmap is old, ignore it */
-	if (mmap_stat.st_mtime < sb->st_mtime) {
-		close(mmapfd);
-		return -1;
+	/* save where we mmap'd the file to cleanup on close() */
+	mmap_area->addr = mmap_area->next_addr = addr;
+	mmap_area->len = mmap_area->next_len = size;
+	mmap_area->next = data->mmap_areas;
+	data->mmap_areas = mmap_area;
+
+	return 0;
+}
+
+struct file_details {
+	const char *suffix;
+	struct stat sb;
+};
+
+static char *rolling_append(char *current, const char *suffix, size_t max)
+{
+	size_t size;
+
+	if (!suffix)
+		return current;
+
+	/*
+	 * Overflow check:
+	 * current contents of tmp (stack_path) + '.' + suffix  + '\0'
+	 * should never be too big.
+	 */
+	size = strlen(current) + 1 + strlen(suffix) + 1;
+	if (size > max)
+		return NULL ;
+
+	/* Append any given suffix */
+	strcat(current, ".");
+	strcat(current, suffix);
+
+	return current;
+}
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static FILE *open_file(const char *path, const char *suffix, size_t *size,
+		char**save_path)
+{
+
+	unsigned i;
+	int rc;
+	char stack_path[PATH_MAX + 1];
+
+	struct file_details *found = NULL;
+	char found_path[sizeof(stack_path)];
+
+	/*
+	 *  Rolling append of suffix, iw we try with path.suffix then the
+	 * next as path.suffix.suffix and so forth.
+	 */
+	struct file_details fdetails[2] = { { .suffix = suffix },
+			{ .suffix = "bin" }, };
+
+	rc = snprintf(stack_path, sizeof(stack_path), "%s", path);
+	if (rc >= (int) sizeof(stack_path)) {
+		errno = ENAMETOOLONG;
+		return NULL ;
 	}
 
-	/* ok, read it in... */
-	len = mmap_stat.st_size;
-	len += (sysconf(_SC_PAGE_SIZE) - 1);
-	len &= ~(sysconf(_SC_PAGE_SIZE) - 1);
+	for (i = 0; i < ARRAY_SIZE(fdetails); i++) {
 
-	mmap_area = malloc(sizeof(*mmap_area));
-	if (!mmap_area) {
-		close(mmapfd);
-		return -1;
+		path = rolling_append(stack_path, fdetails[i].suffix,
+				sizeof(stack_path));
+		if (!path)
+			return NULL ;
+
+		rc = stat(path, &fdetails[i].sb);
+		if (rc)
+			continue;
+
+		/* first file thing found, just take it */
+		if (!found) {
+			strcpy(found_path, path);
+			found = &fdetails[i];
+			continue;
+		}
+
+		/* next possible finds, keep picking the newest file */
+		if (fdetails[i].sb.st_mtime > found->sb.st_mtime) {
+			found = &fdetails[i];
+			strcpy(found_path, path);
+		}
 	}
 
-	addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, mmapfd, 0);
-	close(mmapfd);
-	if (addr == MAP_FAILED) {
-		free(mmap_area);
-		perror("mmap");
+	if (!found) {
+		errno = ENOENT;
+		return NULL ;
+	}
+
+	*save_path = strdup(found_path);
+	if (!*save_path)
+		return NULL ;
+
+	*size = found->sb.st_size;
+	return fopen(found_path, "r");
+}
+
+/* This will always check for buffer over-runs and either read the next entry
+ * if buf != NULL or skip over the entry (as these areas are mapped in the
+ * current buffer). */
+static inline int next_entry(void *buf, struct mmap_area *fp, size_t bytes)
+{
+	if (bytes > fp->next_len)
+		return -1;
+
+	if (buf)
+		memcpy(buf, fp->next_addr, bytes);
+
+	fp->next_addr = (char *) fp->next_addr + bytes;
+	fp->next_len -= bytes;
+	return 0;
+}
+
+static inline int mmap_area_rewind(struct mmap_area *area, size_t bytes)
+{
+	if (area->next_len + bytes > area->len)
 		return -1;
+
+	area->next_addr = (char *) area->next_addr - bytes;
+	area->next_len += bytes;
+	return 0;
+}
+
+static bool fcontext_is_binary(struct mmap_area *area)
+{
+	uint32_t magic;
+	bool is_binary = false;
+
+	int rc = next_entry(&magic, area, sizeof(magic));
+
+	is_binary = (!rc && (magic == SELINUX_MAGIC_COMPILED_FCONTEXT));
+	if (!is_binary)
+		mmap_area_rewind(area, sizeof(magic));
+
+	return is_binary;
+}
+
+/*
+ * Similair to getline() but not quite the same.
+ * It returns the length of the string in the size paramter,
+ * not the buffer size.
+ *
+ * Returns:
+ * 1 - EOF
+ * 0 - Success
+ * -1 - Error
+ */
+static int get_next_newline(struct mmap_area *fp, char **line, size_t *size)
+{
+	size_t offset = 0;
+	char *p = fp->next_addr;
+
+	/* normal end of file condition */
+	if (!fp->next_len)
+		return 1;
+
+	while (*p != '\n') {
+
+		if (offset > fp->next_len)
+			return -1;
+
+		p++;
+		offset++;
 	}
 
-	/* save where we mmap'd the file to cleanup on close() */
-	mmap_area->addr = mmap_area->next_addr = addr;
-	mmap_area->len = mmap_area->next_len = len;
-	mmap_area->next = data->mmap_areas;
-	data->mmap_areas = mmap_area;
+	/* capture the newline */
+	offset++;
+
+	/* ensure no overflows on below arithmatic */
+	if (offset == (size_t) -1)
+		return -1;
 
-	/* check if this looks like an fcontext file */
-	rc = next_entry(&magic, mmap_area, sizeof(uint32_t));
-	if (rc < 0 || magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
+	*line = malloc(offset + 1);
+	if (!*line)
 		return -1;
 
+	strncpy(*line, fp->next_addr, offset);
+
+	(*line)[offset] = '\0';
+
+	fp->next_addr = (char *) fp->next_addr + offset;
+	fp->next_len -= offset;
+	*size = offset;
+	return 0;
+}
+
+static int read_text_file(struct selabel_handle *rec, const char *prefix)
+{
+	int rc;
+	char *line;
+	size_t size;
+	unsigned lineno = 0;
+
+	struct saved_data *saved_data = (struct saved_data *) rec->data;
+	struct mmap_area *area = saved_data->mmap_areas;
+
+	while (get_next_newline(area, &line, &size) == 0) {
+		rc = process_line(rec, saved_data->path, prefix, line, ++lineno);
+		free(line);
+		if (rc)
+			return -1;
+	}
+
+	return 0;
+}
+
+static int read_binary_file(struct selabel_handle *rec)
+{
+
+	int err;
+	size_t len;
+	int *stem_map;
+	char *str_buf;
+	uint32_t entry_len;
+
+	int rc = -1;
+
+	struct saved_data *data = (struct saved_data *) rec->data;
+	struct mmap_area *map_area = data->mmap_areas;
+
+	/*
+	 * We assume entry from is_binary() puts us past the uint32_t
+	 * magic header
+	 */
+
 	/* check if this version is higher than we understand */
-	rc = next_entry(&version, mmap_area, sizeof(uint32_t));
-	if (rc < 0 || version > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
+	uint32_t version;
+	err = next_entry(&version, map_area, sizeof(version));
+	if (err < 0 || version > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
 		return -1;
 
 	if (version >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
 		len = strlen(pcre_version());
 
-		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
-		if (rc < 0)
+		err = next_entry(&entry_len, map_area, sizeof(entry_len));
+		if (err < 0)
 			return -1;
 
-		/* Check version lengths */
+		/*
+		 * We assume that len < (~0 -1) returned from pcre_version()
+		 * thus the below check is sufficient to detect overflow
+		 * on the malloc below.
+		 */
 		if (len != entry_len)
 			return -1;
 
@@ -191,8 +369,8 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 		if (!str_buf)
 			return -1;
 
-		rc = next_entry(str_buf, mmap_area, entry_len);
-		if (rc < 0) {
+		err = next_entry(str_buf, map_area, entry_len);
+		if (err < 0) {
 			free(str_buf);
 			return -1;
 		}
@@ -205,9 +383,10 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 		free(str_buf);
 	}
 
+	uint32_t stem_map_len;
 	/* allocate the stems_data array */
-	rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
-	if (rc < 0 || !stem_map_len)
+	err = next_entry(&stem_map_len, map_area, sizeof(stem_map_len));
+	if (err < 0 || !stem_map_len)
 		return -1;
 
 	/*
@@ -218,295 +397,223 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 	if (!stem_map)
 		return -1;
 
+	uint32_t i;
 	for (i = 0; i < stem_map_len; i++) {
 		char *buf;
 		uint32_t stem_len;
 		int newid;
 
 		/* the length does not inlude the nul */
-		rc = next_entry(&stem_len, mmap_area, sizeof(uint32_t));
-		if (rc < 0 || !stem_len) {
-			rc = -1;
-			goto err;
-		}
+		err = next_entry(&stem_len, map_area, sizeof(stem_len));
+		if (err < 0 || !stem_len)
+			goto out;
 
 		/* Check for stem_len wrap around. */
 		if (stem_len < UINT32_MAX) {
-			buf = (char *)mmap_area->next_addr;
+			buf = (char *) map_area->next_addr;
 			/* Check if over-run before null check. */
-			rc = next_entry(NULL, mmap_area, (stem_len + 1));
-			if (rc < 0)
-				goto err;
+			err = next_entry(NULL, map_area, (stem_len + 1));
+			if (err < 0)
+				goto out;
 
 			if (buf[stem_len] != '\0') {
-				rc = -1;
-				goto err;
+				err = -1;
+				goto out;
 			}
 		} else {
-			rc = -1;
-			goto err;
+			goto out;
 		}
 
 		/* store the mapping between old and new */
 		newid = find_stem(data, buf, stem_len);
 		if (newid < 0) {
 			newid = store_stem(data, buf, stem_len);
-			if (newid < 0) {
-				rc = newid;
-				goto err;
-			}
+			if (newid < 0)
+				goto out;
+
 			data->stem_arr[newid].from_mmap = 1;
 		}
 		stem_map[i] = newid;
 	}
 
 	/* allocate the regex array */
-	rc = next_entry(&regex_array_len, mmap_area, sizeof(uint32_t));
-	if (rc < 0 || !regex_array_len) {
-		rc = -1;
-		goto err;
-	}
+	uint32_t regex_array_len;
+	err = next_entry(&regex_array_len, map_area, sizeof(regex_array_len));
+	if (err < 0 || !regex_array_len)
+		goto out;
 
 	for (i = 0; i < regex_array_len; i++) {
 		struct spec *spec;
 		int32_t stem_id, meta_chars;
-		uint32_t mode = 0, prefix_len = 0;
+		uint32_t mode = 0;
 
-		rc = grow_specs(data);
-		if (rc < 0)
-			goto err;
+		err = grow_specs(data);
+		if (err < 0)
+			goto out;
 
 		spec = &data->spec_arr[data->nspec];
 		spec->from_mmap = 1;
 		spec->regcomp = 1;
 
 		/* Process context */
-		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
-		if (rc < 0 || !entry_len) {
-			rc = -1;
-			goto err;
-		}
+		err = next_entry(&entry_len, map_area, sizeof(entry_len));
+		if (err < 0 || !entry_len)
+			goto out;
 
 		str_buf = malloc(entry_len);
-		if (!str_buf) {
-			rc = -1;
-			goto err;
-		}
-		rc = next_entry(str_buf, mmap_area, entry_len);
-		if (rc < 0)
-			goto err;
+		if (!str_buf)
+			goto out;
+
+		err = next_entry(str_buf, map_area, entry_len);
+		if (err < 0)
+			goto out;
 
 		if (str_buf[entry_len - 1] != '\0') {
 			free(str_buf);
-			rc = -1;
-			goto err;
+			goto out;
 		}
+
 		spec->lr.ctx_raw = str_buf;
 
 		if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->validating) {
 			if (selabel_validate(rec, &spec->lr) < 0) {
-				selinux_log(SELINUX_ERROR,
-					    "%s: context %s is invalid\n", mmap_path, spec->lr.ctx_raw);
-				goto err;
+				selinux_log(SELINUX_ERROR, "%s: context %s is invalid\n",
+						data->path, spec->lr.ctx_raw);
+				errno = EINVAL;
+				free(str_buf);
+				goto out;
 			}
 		}
 
 		/* Process regex string */
-		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
-		if (rc < 0 || !entry_len) {
-			rc = -1;
-			goto err;
-		}
+		err = next_entry(&entry_len, map_area, sizeof(entry_len));
+		if (err < 0 || !entry_len)
+			goto out;
 
-		spec->regex_str = (char *)mmap_area->next_addr;
-		rc = next_entry(NULL, mmap_area, entry_len);
-		if (rc < 0)
-			goto err;
+		spec->regex_str = (char *) map_area->next_addr;
+		err = next_entry(NULL, map_area, entry_len);
+		if (err < 0)
+			goto out;
 
-		if (spec->regex_str[entry_len - 1] != '\0') {
-			rc = -1;
-			goto err;
-		}
+		if (spec->regex_str[entry_len - 1] != '\0')
+			goto out;
 
 		/* Process mode */
 		if (version >= SELINUX_COMPILED_FCONTEXT_MODE)
-			rc = next_entry(&mode, mmap_area, sizeof(uint32_t));
+			err = next_entry(&mode, map_area, sizeof(mode));
 		else
-			rc = next_entry(&mode, mmap_area, sizeof(mode_t));
-		if (rc < 0)
-			goto err;
+			err = next_entry(&mode, map_area, sizeof(mode_t));
+
+		if (err < 0)
+			goto out;
 
 		spec->mode = mode;
 
 		/* map the stem id from the mmap file to the data->stem_arr */
-		rc = next_entry(&stem_id, mmap_area, sizeof(int32_t));
-		if (rc < 0)
-			goto err;
+		err = next_entry(&stem_id, map_area, sizeof(stem_id));
+		if (err < 0)
+			goto out;
 
-		if (stem_id < 0 || stem_id >= (int32_t)stem_map_len)
+		if (stem_id < 0 || stem_id >= (int32_t) stem_map_len)
 			spec->stem_id = -1;
-		 else
+		else
 			spec->stem_id = stem_map[stem_id];
 
 		/* retrieve the hasMetaChars bit */
-		rc = next_entry(&meta_chars, mmap_area, sizeof(uint32_t));
-		if (rc < 0)
-			goto err;
+		err = next_entry(&meta_chars, map_area, sizeof(meta_chars));
+		if (err < 0)
+			goto out;
 
 		spec->hasMetaChars = meta_chars;
 		/* and prefix length for use by selabel_lookup_best_match */
 		if (version >= SELINUX_COMPILED_FCONTEXT_PREFIX_LEN) {
-			rc = next_entry(&prefix_len, mmap_area,
-					    sizeof(uint32_t));
-			if (rc < 0)
-				goto err;
+			uint32_t prefix_len;
+			err = next_entry(&prefix_len, map_area, sizeof(prefix_len));
+			if (err < 0)
+				goto out;
 
 			spec->prefix_len = prefix_len;
 		}
 
 		/* Process regex and study_data entries */
-		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
-		if (rc < 0 || !entry_len) {
-			rc = -1;
-			goto err;
-		}
-		spec->regex = (pcre *)mmap_area->next_addr;
-		rc = next_entry(NULL, mmap_area, entry_len);
-		if (rc < 0)
-			goto err;
+		err = next_entry(&entry_len, map_area, sizeof(entry_len));
+		if (err < 0 || !entry_len)
+			goto out;
+
+		spec->regex = (pcre *) map_area->next_addr;
+		err = next_entry(NULL, map_area, entry_len);
+		if (err < 0)
+			goto out;
 
 		/* Check that regex lengths match. pcre_fullinfo()
 		 * also validates its magic number. */
-		rc = pcre_fullinfo(spec->regex, NULL, PCRE_INFO_SIZE, &len);
-		if (rc < 0 || len != entry_len) {
-			rc = -1;
-			goto err;
-		}
+		err = pcre_fullinfo(spec->regex, NULL, PCRE_INFO_SIZE, &len);
+		if (err < 0 || len != entry_len)
+			goto out;
 
-		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
-		if (rc < 0 || !entry_len) {
-			rc = -1;
-			goto err;
-		}
+		err = next_entry(&entry_len, map_area, sizeof(entry_len));
+		if (err < 0 || !entry_len)
+			goto out;
 
 		if (entry_len) {
-			spec->lsd.study_data = (void *)mmap_area->next_addr;
+			spec->lsd.study_data = (void *) map_area->next_addr;
 			spec->lsd.flags |= PCRE_EXTRA_STUDY_DATA;
-			rc = next_entry(NULL, mmap_area, entry_len);
-			if (rc < 0)
-				goto err;
+			err = next_entry(NULL, map_area, entry_len);
+			if (err < 0)
+				goto out;
 
 			/* Check that study data lengths match. */
-			rc = pcre_fullinfo(spec->regex, &spec->lsd,
-					   PCRE_INFO_STUDYSIZE, &len);
-			if (rc < 0 || len != entry_len) {
-				rc = -1;
-				goto err;
-			}
+			err = pcre_fullinfo(spec->regex, &spec->lsd, PCRE_INFO_STUDYSIZE,
+					&len);
+			if (err < 0 || len != entry_len)
+				goto out;
 		}
 
 		data->nspec++;
 	}
 
-	rc = digest_add_specfile(digest, NULL, addr, mmap_stat.st_size,
-								    mmap_path);
-	if (rc)
-		goto err;
-
-err:
-	free(stem_map);
+	rc = 0;
 
+	out: free(stem_map);
 	return rc;
 }
 
 static int process_file(const char *path, const char *suffix,
-			  struct selabel_handle *rec,
-			  const char *prefix, struct selabel_digest *digest)
+		struct selabel_handle *rec, const char *prefix,
+		struct selabel_digest *digest)
 {
+
 	FILE *fp;
-	struct stat sb;
-	unsigned int lineno;
-	size_t line_len = 0;
-	char *line_buf = NULL;
 	int rc;
-	char stack_path[PATH_MAX + 1];
-	bool isbinary = false;
-	uint32_t magic;
-
-	/* append the path suffix if we have one */
-	if (suffix) {
-		rc = snprintf(stack_path, sizeof(stack_path),
-					    "%s.%s", path, suffix);
-		if (rc >= (int)sizeof(stack_path)) {
-			errno = ENAMETOOLONG;
-			return -1;
-		}
-		path = stack_path;
-	}
+	size_t size;
+	bool is_binary;
+	struct mmap_area *area;
 
-	/* Open the specification file. */
-	fp = fopen(path, "r");
-	if (fp) {
-		__fsetlocking(fp, FSETLOCKING_BYCALLER);
+	struct saved_data *saved_data = (struct saved_data *) rec->data;
 
-		if (fstat(fileno(fp), &sb) < 0)
-			return -1;
-		if (!S_ISREG(sb.st_mode)) {
-			errno = EINVAL;
-			return -1;
-		}
-
-		magic = 0;
-		if (fread(&magic, sizeof magic, 1, fp) != 1) {
-			if (ferror(fp)) {
-				errno = EINVAL;
-				fclose(fp);
-				return -1;
-			}
-			clearerr(fp);
-		}
-
-		if (magic == SELINUX_MAGIC_COMPILED_FCONTEXT) {
-			/* file_contexts.bin format */
-			fclose(fp);
-			fp = NULL;
-			isbinary = true;
-		} else {
-			rewind(fp);
-		}
-	} else {
-		/*
-		 * Text file does not exist, so clear the timestamp
-		 * so that we will always pass the timestamp comparison
-		 * with the bin file in load_mmap().
-		 */
-		sb.st_mtime = 0;
-	}
+	fp = open_file(path, suffix, &size, &saved_data->path);
+	if (!fp)
+		return -1;
 
-	rc = load_mmap(rec, path, &sb, isbinary, digest);
-	if (rc == 0)
+	rc = load_mmap(fp, size, rec);
+	if (rc != 0)
 		goto out;
 
-	if (!fp)
-		return -1; /* no text or bin file */
+	area = saved_data->mmap_areas;
 
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
+	is_binary = fcontext_is_binary(area);
+	if (is_binary)
+		rc = read_binary_file(rec);
+	else
+		rc = read_text_file(rec, prefix);
 
-	rc = digest_add_specfile(digest, fp, NULL, sb.st_size, path);
+	if (rc < 0)
+		goto out;
 
-out:
-	free(line_buf);
-	if (fp)
-		fclose(fp);
+	rc = digest_add_specfile(digest, fp, NULL, size, path);
+	out:
+	/* closef() deals with mmapings */
+	fclose(fp);
 	return rc;
 }
 
@@ -634,6 +741,10 @@ static void closef(struct selabel_handle *rec)
 		area = area->next;
 		free(last_area);
 	}
+
+    if (data->path)
+        free(data->path);
+
 	free(data);
 }
 
@@ -927,10 +1038,9 @@ int selabel_file_init(struct selabel_handle *rec,
 {
 	struct saved_data *data;
 
-	data = (struct saved_data *)malloc(sizeof(*data));
+	data = (struct saved_data *)calloc(1, sizeof(*data));
 	if (!data)
 		return -1;
-	memset(data, 0, sizeof(*data));
 
 	rec->data = data;
 	rec->func_close = &closef;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 6d1e890..da06164 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -76,6 +76,7 @@ struct saved_data {
 	int num_stems;
 	int alloc_stems;
 	struct mmap_area *mmap_areas;
+	char *path;
 };
 
 static inline pcre_extra *get_pcre_extra(struct spec *spec)
@@ -314,22 +315,6 @@ static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
 	return store_stem(data, stem, stem_len);
 }
 
-/* This will always check for buffer over-runs and either read the next entry
- * if buf != NULL or skip over the entry (as these areas are mapped in the
- * current buffer). */
-static inline int next_entry(void *buf, struct mmap_area *fp, size_t bytes)
-{
-	if (bytes > fp->next_len)
-		return -1;
-
-	if (buf)
-		memcpy(buf, fp->next_addr, bytes);
-
-	fp->next_addr = (char *)fp->next_addr + bytes;
-	fp->next_len -= bytes;
-	return 0;
-}
-
 static inline int compile_regex(struct saved_data *data, struct spec *spec,
 					    const char **errbuf)
 {
-- 
1.9.1
