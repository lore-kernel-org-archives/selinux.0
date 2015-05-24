Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4OHZeLl001584
 for <selinux@tycho.nsa.gov>; Sun, 24 May 2015 13:35:40 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH V4] Fix more bin file processing core dumps
Date: Sun, 24 May 2015 18:35:18 +0100
Message-Id: <1432488918-18430-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The reading of bin files has been changed to follow that of loading
policy to catch over-runs. Entries that should be NUL terminated are
also checked. If any error, then process the text file. This should
fix all problems highlighted in [1] with V2 fixing those in [2].
V3 corrects int32_t/uint32_t for *_len entries and V4 fixes [3]
and adds pcre_fullinfo checks to validate regex and study data
sizes. pcre_fullinfo also validates its magic number.

Tested with bin files built using sefcontext_compile PCRE_VERS 1 and 2.

The following is a rough guide to the difference in processing a bin
file against a text file:
   6K entries - x5
   4K entries - x4
   1K entries - x3
   500 entries - x2

[1] http://marc.info/?l=selinux&m=143101983922281&w=2
[2] http://marc.info/?l=selinux&m=143161763905159&w=2
[3] http://marc.info/?l=selinux&m=143204170705586&w=2

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label_file.c | 226 ++++++++++++++++++++++++++++++--------------
 libselinux/src/label_file.h |  20 +++-
 2 files changed, 171 insertions(+), 75 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index c722f29..7da79b4 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -8,7 +8,6 @@
  * developed by Secure Computing Corporation.
  */
 
-#include <assert.h>
 #include <fcntl.h>
 #include <stdarg.h>
 #include <string.h>
@@ -242,15 +241,12 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 	int mmapfd;
 	int rc;
 	struct stat mmap_stat;
-	char *addr;
+	char *addr, *str_buf;
 	size_t len;
-	int stem_map_len, *stem_map;
+	int *stem_map;
 	struct mmap_area *mmap_area;
-
-	uint32_t i;
-	uint32_t *magic;
-	uint32_t *section_len;
-	uint32_t *plen;
+	uint32_t i, magic, version;
+	uint32_t entry_len, stem_map_len, regex_array_len;
 
 	rc = snprintf(mmap_path, sizeof(mmap_path), "%s.bin", path);
 	if (rc >= (int)sizeof(mmap_path))
@@ -304,57 +300,86 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 	data->mmap_areas = mmap_area;
 
 	/* check if this looks like an fcontext file */
-	magic = (uint32_t *)addr;
-	if (*magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
+	rc = next_entry(&magic, mmap_area, sizeof(uint32_t));
+	if (rc < 0 || magic != SELINUX_MAGIC_COMPILED_FCONTEXT)
 		return -1;
-	addr += sizeof(uint32_t);
 
 	/* check if this version is higher than we understand */
-	section_len = (uint32_t *)addr;
-	if (*section_len > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
+	rc = next_entry(&version, mmap_area, sizeof(uint32_t));
+	if (rc < 0 || version > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
 		return -1;
-	addr += sizeof(uint32_t);
 
-	if (*section_len >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
+	if (version >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
 		len = strlen(pcre_version());
-		plen = (uint32_t *)addr;
-		if (*plen > mmap_area->len)
-			return -1; /* runs off the end of the map */
-		if (len != *plen)
-			return -1; /* pcre version length mismatch */
-		addr += sizeof(uint32_t);
-		if (memcmp((char *)addr, pcre_version(), len))
-			return -1; /* pcre version content mismatch */
-		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
-			return -1; /* Buffer over-run */
-		addr += *plen;
+
+		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
+		if (rc < 0)
+			return -1;
+
+		/* Check version lengths */
+		if (len != entry_len)
+			return -1;
+
+		/* Check if pcre version mismatch */
+		str_buf = malloc(entry_len + 1);
+		if (!str_buf)
+			return -1;
+
+		rc = next_entry(str_buf, mmap_area, entry_len);
+		if (rc < 0) {
+			free(str_buf);
+			return -1;
+		}
+
+		str_buf[entry_len] = '\0';
+		if ((strcmp(str_buf, pcre_version()) != 0)) {
+			free(str_buf);
+			return -1;
+		}
+		free(str_buf);
 	}
 
 	/* allocate the stems_data array */
-	section_len = (uint32_t *)addr;
-	addr += sizeof(uint32_t);
+	rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
+	if (rc < 0 || !stem_map_len)
+		return -1;
 
 	/*
 	 * map indexed by the stem # in the mmap file and contains the stem
 	 * number in the data stem_arr
 	 */
-	stem_map_len = *section_len;
 	stem_map = calloc(stem_map_len, sizeof(*stem_map));
 	if (!stem_map)
 		return -1;
 
-	for (i = 0; i < *section_len; i++) {
+	for (i = 0; i < stem_map_len; i++) {
 		char *buf;
 		uint32_t stem_len;
 		int newid;
 
 		/* the length does not inlude the nul */
-		plen = (uint32_t *)addr;
-		addr += sizeof(uint32_t);
+		rc = next_entry(&stem_len, mmap_area, sizeof(uint32_t));
+		if (rc < 0 || !stem_len) {
+			rc = -1;
+			goto err;
+		}
 
-		stem_len = *plen;
-		buf = (char *)addr;
-		addr += (stem_len + 1); // +1 is the nul
+		/* Check for stem_len wrap around. */
+		if (stem_len < UINT32_MAX) {
+			buf = (char *)mmap_area->addr;
+			/* Check if over-run before null check. */
+			rc = next_entry(NULL, mmap_area, (stem_len + 1));
+			if (rc < 0)
+				goto err;
+
+			if (buf[stem_len] != '\0') {
+				rc = -1;
+				goto err;
+			}
+		} else {
+			rc = -1;
+			goto err;
+		}
 
 		/* store the mapping between old and new */
 		newid = find_stem(data, buf, stem_len);
@@ -370,12 +395,15 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 	}
 
 	/* allocate the regex array */
-	section_len = (uint32_t *)addr;
-	addr += sizeof(*section_len);
+	rc = next_entry(&regex_array_len, mmap_area, sizeof(uint32_t));
+	if (rc < 0 || !regex_array_len) {
+		rc = -1;
+		goto err;
+	}
 
-	for (i = 0; i < *section_len; i++) {
+	for (i = 0; i < regex_array_len; i++) {
 		struct spec *spec;
-		int32_t stem_id;
+		int32_t stem_id, meta_chars;
 
 		rc = grow_specs(data);
 		if (rc < 0)
@@ -385,53 +413,105 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 		spec->from_mmap = 1;
 		spec->regcomp = 1;
 
-		plen = (uint32_t *)addr;
-		addr += sizeof(uint32_t);
-		rc = -1;
-		spec->lr.ctx_raw = strdup((char *)addr);
-		if (!spec->lr.ctx_raw)
+		/* Process context */
+		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
+		if (rc < 0 || !entry_len) {
+			rc = -1;
 			goto err;
+		}
 
-		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
-			return -1;
-		addr += *plen;
+		str_buf = malloc(entry_len);
+		if (!str_buf) {
+			rc = -1;
+			goto err;
+		}
+		rc = next_entry(str_buf, mmap_area, entry_len);
+		if (rc < 0)
+			goto err;
 
-		plen = (uint32_t *)addr;
-		addr += sizeof(uint32_t);
-		spec->regex_str = (char *)addr;
-		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
-			return -1;
-		addr += *plen;
+		if (str_buf[entry_len - 1] != '\0') {
+			free(str_buf);
+			rc = -1;
+			goto err;
+		}
+		spec->lr.ctx_raw = str_buf;
 
-		spec->mode = *(mode_t *)addr;
-		addr += sizeof(mode_t);
+		/* Process regex string */
+		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
+		if (rc < 0 || !entry_len) {
+			rc = -1;
+			goto err;
+		}
+
+		spec->regex_str = (char *)mmap_area->addr;
+		rc = next_entry(NULL, mmap_area, entry_len);
+		if (rc < 0)
+			goto err;
+
+		if (spec->regex_str[entry_len - 1] != '\0') {
+			rc = -1;
+			goto err;
+		}
+
+		/* Process mode */
+		rc = next_entry(&spec->mode, mmap_area, sizeof(mode_t));
+		if (rc < 0)
+			goto err;
 
 		/* map the stem id from the mmap file to the data->stem_arr */
-		stem_id = *(int32_t *)addr;
-		if (stem_id == -1 || stem_id >= stem_map_len)
+		rc = next_entry(&stem_id, mmap_area, sizeof(int32_t));
+		if (rc < 0)
+			goto err;
+
+		if (stem_id < 0 || stem_id >= stem_map_len)
 			spec->stem_id = -1;
-		else
+		 else
 			spec->stem_id = stem_map[stem_id];
-		addr += sizeof(int32_t);
 
 		/* retrieve the hasMetaChars bit */
-		spec->hasMetaChars = *(uint32_t *)addr;
-		addr += sizeof(uint32_t);
+		rc = next_entry(&meta_chars, mmap_area, sizeof(uint32_t));
+		if (rc < 0)
+			goto err;
 
-		plen = (uint32_t *)addr;
-		addr += sizeof(uint32_t);
-		spec->regex = (pcre *)addr;
-		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
-			return -1;
-		addr += *plen;
+		spec->hasMetaChars = meta_chars;
+
+		/* Process regex and study_data entries */
+		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
+		if (rc < 0 || !entry_len) {
+			rc = -1;
+			goto err;
+		}
+		spec->regex = (pcre *)mmap_area->addr;
+		rc = next_entry(NULL, mmap_area, entry_len);
+		if (rc < 0)
+			goto err;
+
+		/* Check that regex lengths match. pcre_fullinfo()
+		 * also validates its magic number. */
+		rc = pcre_fullinfo(spec->regex, NULL, PCRE_INFO_SIZE, &len);
+		if (rc < 0 || len != entry_len) {
+			rc = -1;
+			goto err;
+		}
 
-		plen = (uint32_t *)addr;
-		addr += sizeof(uint32_t);
-		spec->lsd.study_data = (void *)addr;
+		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
+		if (rc < 0 || !entry_len) {
+			rc = -1;
+			goto err;
+		}
+		spec->lsd.study_data = (void *)mmap_area->addr;
 		spec->lsd.flags |= PCRE_EXTRA_STUDY_DATA;
-		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
-			return -1;
-		addr += *plen;
+		rc = next_entry(NULL, mmap_area, entry_len);
+		if (rc < 0)
+			goto err;
+
+		/* Check that study data lengths match. */
+		rc = pcre_fullinfo(spec->regex, &spec->lsd,
+				    PCRE_INFO_STUDYSIZE, &len);
+		if (rc < 0 || len != entry_len) {
+			rc = -1;
+			goto err;
+		}
 
 		data->nspec++;
 	}
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index d37008f..3d963b4 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -43,8 +43,8 @@ struct stem {
 
 /* Where we map the file in during selabel_open() */
 struct mmap_area {
-	void *addr;
-	size_t len;
+	void *addr;	/* Start of area - gets incremented by next_entry() */
+	size_t len;	/* Length - gets decremented by next_entry() */
 	struct mmap_area *next;
 };
 
@@ -297,4 +297,20 @@ static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
 	return store_stem(data, stem, stem_len);
 }
 
+/* This will always check for buffer over-runs and either read the next entry
+ * if buf != NULL or skip over the entry (as these areas are mapped in the
+ * current buffer). */
+static inline int next_entry(void *buf, struct mmap_area *fp, size_t bytes)
+{
+	if (bytes > fp->len)
+		return -1;
+
+	if (buf)
+		memcpy(buf, fp->addr, bytes);
+
+	fp->addr = (char *)fp->addr + bytes;
+	fp->len -= bytes;
+	return 0;
+}
+
 #endif /* _SELABEL_FILE_H_ */
-- 
2.1.0
