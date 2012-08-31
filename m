From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 18/18] libselinux: label_file: use precompiled filecontext when possible
Date: Fri, 31 Aug 2012 10:49:54 -0700
Message-Id: <1346435394-1954-18-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When loading the filecontext database, check to see if there is a newer
binary version.  If so, mmap that file, is used to populate the regex db
instead of reading from the text representation and compiling regex's as
needed.  If the text file is newer it will use the text version and
ignore the binary version.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 169 ++++++++++++++++++++++++++++++++++++++++++++
 libselinux/src/label_file.h |  12 +++-
 2 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 0815d12..2421186 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -8,6 +8,7 @@
  * developed by Secure Computing Corporation.
  */
 
+#include <assert.h>
 #include <fcntl.h>
 #include <stdarg.h>
 #include <string.h>
@@ -16,7 +17,12 @@
 #include <ctype.h>
 #include <errno.h>
 #include <limits.h>
+#include <stdint.h>
 #include <pcre.h>
+
+#include <linux/limits.h>
+
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -243,6 +249,160 @@ static int process_line(struct selabel_handle *rec,
 	return 0;
 }
 
+static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *stat)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	char mmap_path[PATH_MAX + 1];
+	int mmapfd;
+	int rc, i;
+	struct stat mmap_stat;
+	char *addr;
+	size_t len;
+	int stem_map_len, *stem_map;
+
+	uint32_t *magic;
+	uint32_t *section_len;
+	uint32_t *plen;
+
+	rc = snprintf(mmap_path, sizeof(mmap_path), "%s.bin", path);
+	if (rc >= sizeof(mmap_path))
+		return -1;
+
+	mmapfd = open(mmap_path, O_RDONLY);
+	if (!mmapfd)
+		return -1;
+
+	rc = fstat(mmapfd, &mmap_stat);
+	if (rc < 0)
+		return -1;
+
+	/* if mmap is old, ignore it */
+	if (mmap_stat.st_mtime < stat->st_mtime)
+		return -1;
+
+	if (mmap_stat.st_mtime == stat->st_mtime &&
+	    mmap_stat.st_mtim.tv_nsec < stat->st_mtim.tv_nsec)
+		return -1;
+	
+	/* ok, read it in... */
+	len = mmap_stat.st_size;
+	len += (sysconf(_SC_PAGE_SIZE) - 1);
+	len &= ~(sysconf(_SC_PAGE_SIZE) - 1);
+
+	addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, mmapfd, 0);
+	close(mmapfd);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		return -1;
+	}
+
+	magic = (uint32_t *)addr;
+	if (*magic != 0xdeadbeef)
+		return -1;
+	addr += sizeof(uint32_t);
+
+	/* allocate the stems_data array */
+	section_len = (uint32_t *)addr;
+	addr += sizeof(uint32_t);
+
+	/*
+	 * map indexed by the stem # in the mmap file and contains the stem
+	 * number in the data stem_arr
+	 */
+	stem_map_len = *section_len;
+	stem_map = calloc(stem_map_len, sizeof(*stem_map));
+	if (!stem_map)
+		return -1;
+
+	for (i = 0; i < *section_len; i++) {
+		char *buf;
+		uint32_t stem_len;
+		int newid;
+
+		/* the length does not inlude the nul */
+		plen = (uint32_t *)addr;
+		addr += sizeof(uint32_t);
+
+		stem_len = *plen;
+		buf = (char *)addr;
+		addr += (stem_len + 1); // +1 is the nul
+
+		/* store the mapping between old and new */
+		newid = find_stem(data, buf, stem_len);
+		if (newid < 0) {
+			newid = store_stem(data, buf, stem_len);
+			if (newid < 0)
+				return newid;
+			data->stem_arr[newid].from_mmap = 1;
+		}
+		stem_map[i] = newid;
+	}
+
+	/* allocate the regex array */
+	section_len = (uint32_t *)addr;
+	addr += sizeof(*section_len);
+
+	for (i = 0; i < *section_len; i++) {
+		struct spec *spec;
+		int32_t stem_id;
+
+		rc = grow_specs(data);
+		if (rc < 0)
+			return rc;
+
+		spec = &data->spec_arr[data->nspec];
+		spec->from_mmap = 1;
+		spec->regcomp = 1;
+
+		plen = (uint32_t *)addr;
+		addr += sizeof(uint32_t);
+		spec->lr.ctx_raw = strdup((char *)addr);
+		if (!spec->lr.ctx_raw)
+			return -1;
+		addr += *plen;
+
+		plen = (uint32_t *)addr;
+		addr += sizeof(uint32_t);
+		spec->regex_str = (char *)addr;
+		addr += *plen;
+
+		spec->mode = *(mode_t *)addr;
+		addr += sizeof(mode_t);
+
+		/* map the stem id from the mmap file to the data->stem_arr */
+		stem_id = *(int32_t *)addr;
+		if (stem_id == -1) {
+			spec->stem_id = -1;
+		} else {
+			assert(stem_id <= stem_map_len);
+			spec->stem_id = stem_map[stem_id];
+		}
+		addr += sizeof(int32_t);
+
+		/* retrieve the hasMetaChars bit */
+		spec->hasMetaChars = *(uint32_t *)addr;
+		addr += sizeof(uint32_t);
+
+		plen = (uint32_t *)addr;
+		addr += sizeof(uint32_t);
+		spec->regex = (pcre *)addr;
+		addr += *plen;
+
+		plen = (uint32_t *)addr;
+		addr += sizeof(uint32_t);
+		spec->lsd.study_data = (void *)addr;
+		spec->lsd.flags |= PCRE_EXTRA_STUDY_DATA;
+		addr += *plen;
+
+		data->nspec++;
+	}
+
+	free(stem_map);
+
+	/* win */
+	return 0;
+}
+
 static int process_file(const char *path, const char *suffix, struct selabel_handle *rec, const char **prefix_array)
 {
 	FILE *fp;
@@ -275,6 +435,10 @@ static int process_file(const char *path, const char *suffix, struct selabel_han
 		return -1;
 	}
 
+	rc = load_mmap(rec, path, &sb);
+	if (rc == 0)
+		goto out;
+
 	/* 
 	 * The do detailed validation of the input and fill the spec array
 	 */
@@ -284,6 +448,7 @@ static int process_file(const char *path, const char *suffix, struct selabel_han
 		if (rc)
 			return rc;
 	}
+out:
 	free(line_buf);
 	fclose(fp);
 
@@ -375,6 +540,8 @@ static void closef(struct selabel_handle *rec)
 
 	for (i = 0; i < data->nspec; i++) {
 		spec = &data->spec_arr[i];
+		if (spec->from_mmap)
+			continue;
 		free(spec->regex_str);
 		free(spec->type_str);
 		free(spec->lr.ctx_raw);
@@ -387,6 +554,8 @@ static void closef(struct selabel_handle *rec)
 
 	for (i = 0; i < (unsigned int)data->num_stems; i++) {
 		stem = &data->stem_arr[i];
+		if (stem->from_mmap)
+			continue;
 		free(stem->buf);
 	}
 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 8e6f550..5765fd4 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -11,18 +11,23 @@ struct spec {
 	char *regex_str;	/* regular expession string for diagnostics */
 	char *type_str;		/* type string for diagnostic messages */
 	pcre *regex;		/* compiled regular expression */
-	pcre_extra *sd;		/* extra compiled stuff */
+	union {
+		pcre_extra *sd;	/* pointer to extra compiled stuff */
+		pcre_extra lsd;	/* used to hold the mmap'd version */
+	};
 	mode_t mode;		/* mode format value */
 	int matches;		/* number of matching pathnames */
 	int stem_id;		/* indicates which stem-compression item */
 	char hasMetaChars;	/* regular expression has meta-chars */
 	char regcomp;		/* regex_str has been compiled to regex */
+	char from_mmap;		/* this spec is from an mmap of the data */
 };
 
 /* A regular expression stem */
 struct stem {
 	char *buf;
 	int len;
+	char from_mmap;
 };
 
 /* Our stored configuration */
@@ -45,7 +50,10 @@ struct saved_data {
 
 static inline pcre_extra *get_pcre_extra(struct spec *spec)
 {
-	return spec->sd;
+	if (spec->from_mmap)
+		return &spec->lsd;
+	else
+		return spec->sd;
 }
 
 static inline mode_t string_to_mode(char *mode)
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
