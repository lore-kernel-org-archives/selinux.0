Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8QENCOe024768
 for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2016 10:23:12 -0400
Received: by mail-wm0-f43.google.com with SMTP id l132so155150416wmf.0
 for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2016 07:22:55 -0700 (PDT)
From: Janis Danisevskis <jdanis@android.com>
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov, jdanis@google.com
Cc: Janis Danisevskis <jdanis@android.com>
Subject: [PATCH 1/3] libselinux: Add architecture string to file_context.bin
Date: Mon, 26 Sep 2016 15:22:34 +0100
Message-Id: <1474899756-93610-1-git-send-email-jdanis@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Serialized precompiled regular expressins are architecture
dependent when using PCRE2. This patch
- bumps the SELINUX_COMPILED_FCONTEXT version to 5 and
- adds a field to the output indicating the architecture
  compatibility.

libselinux can cope with an architecture mismatch by
ignoring the precompiled data in the input file and recompiling
the regular expressions at runtime. It can also load older
versions of file_contexts.bin if they where built with
sefcontext_compile using the exact same version of the
pcre1/2 as selinux.

Signed-off-by: Janis Danisevskis <jdanis@android.com>
---
 libselinux/src/label_file.c           | 44 +++++++++++++++++++++++++++++-
 libselinux/src/label_file.h           |  4 ++-
 libselinux/src/regex.c                | 50 ++++++++++++++++++++++++++++++++---
 libselinux/src/regex.h                | 15 ++++++++++-
 libselinux/utils/sefcontext_compile.c | 13 +++++++++
 5 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 7156825..9abc1d6 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -126,6 +126,8 @@ static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec,
 	uint32_t i, magic, version;
 	uint32_t entry_len, stem_map_len, regex_array_len;
 	const char *reg_version;
+	const char *reg_arch;
+	char reg_arch_matches = 1;
 
 	mmap_area = malloc(sizeof(*mmap_area));
 	if (!mmap_area) {
@@ -159,6 +161,10 @@ static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec,
 	if (!reg_version)
 		return -1;
 
+	reg_arch = regex_arch_string();
+	if (!reg_arch)
+		return -1;
+
 	if (version >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
 
 		len = strlen(reg_version);
@@ -188,7 +194,43 @@ static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec,
 			return -1;
 		}
 		free(str_buf);
+
+		if (version >= SELINUX_COMPILED_FCONTEXT_REGEX_ARCH) {
+			len = strlen(reg_arch);
+
+			rc = next_entry(&entry_len, mmap_area,
+					sizeof(uint32_t));
+			if (rc < 0)
+				return -1;
+
+			/* Check arch string lengths */
+			if (len != entry_len) {
+				/*
+				 * Skip the entry and conclude that we have
+				 * a mismatch, which is not fatal.
+				 */
+				next_entry(NULL, mmap_area, entry_len);
+				reg_arch_matches = 0;
+				goto end_arch_check;
+			}
+
+			/* Check if arch string mismatch */
+			str_buf = malloc(entry_len + 1);
+			if (!str_buf)
+				return -1;
+
+			rc = next_entry(str_buf, mmap_area, entry_len);
+			if (rc < 0) {
+				free(str_buf);
+				return -1;
+			}
+
+			str_buf[entry_len] = '\0';
+			reg_arch_matches = strcmp(str_buf, reg_arch) == 0;
+			free(str_buf);
+		}
 	}
+end_arch_check:
 
 	/* allocate the stems_data array */
 	rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
@@ -349,7 +391,7 @@ static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec,
 			spec->prefix_len = prefix_len;
 		}
 
-		rc = regex_load_mmap(mmap_area, &spec->regex);
+		rc = regex_load_mmap(mmap_area, &spec->regex, reg_arch_matches);
 		if (rc < 0)
 			goto out;
 
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 88f4294..00c0a5c 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -24,8 +24,10 @@
 #define SELINUX_COMPILED_FCONTEXT_PCRE_VERS	2
 #define SELINUX_COMPILED_FCONTEXT_MODE		3
 #define SELINUX_COMPILED_FCONTEXT_PREFIX_LEN	4
+#define SELINUX_COMPILED_FCONTEXT_REGEX_ARCH	5
 
-#define SELINUX_COMPILED_FCONTEXT_MAX_VERS	SELINUX_COMPILED_FCONTEXT_PREFIX_LEN
+#define SELINUX_COMPILED_FCONTEXT_MAX_VERS \
+	SELINUX_COMPILED_FCONTEXT_REGEX_ARCH
 
 /* A file security context specification. */
 struct spec {
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 750088e..a3b427b 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -7,6 +7,44 @@
 #include "label_file.h"
 
 #ifdef USE_PCRE2
+#define REGEX_ARCH_SIZE_T PCRE2_SIZE
+#else
+#define REGEX_ARCH_SIZE_T size_t
+#endif
+
+#ifndef __BYTE_ORDER__
+#error __BYTE_ORDER__ not defined. Unable to determine endianness.
+#endif
+
+#ifdef USE_PCRE2
+char const *regex_arch_string(void)
+{
+	static char arch_string_buffer[32];
+	static char const *arch_string = "";
+	char const *endianness = NULL;
+	int rc;
+
+	if (arch_string[0] == '\0') {
+		if (__BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__)
+			endianness = "el";
+		else if (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
+			endianness = "eb";
+
+		if (!endianness)
+			return NULL;
+
+		rc = snprintf(arch_string_buffer, sizeof(arch_string_buffer),
+				"%zu-%zu-%s", sizeof(void *),
+				sizeof(REGEX_ARCH_SIZE_T),
+				endianness);
+		if (rc < 0)
+			abort();
+
+		arch_string = &arch_string_buffer[0];
+	}
+	return arch_string;
+}
+
 struct regex_data {
 	pcre2_code *regex; /* compiled regular expression */
 	/*
@@ -56,7 +94,8 @@ char const *regex_version(void)
 	return version_buf;
 }
 
-int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex)
+int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
+		    int do_load_precompregex)
 {
 	int rc;
 	uint32_t entry_len;
@@ -65,7 +104,7 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex)
 	if (rc < 0)
 		return -1;
 
-	if (entry_len) {
+	if (entry_len && do_load_precompregex) {
 		/*
 		 * this should yield exactly one because we store one pattern at
 		 * a time
@@ -195,6 +234,10 @@ int regex_cmp(struct regex_data *regex1, struct regex_data *regex2)
 }
 
 #else // !USE_PCRE2
+char const *regex_arch_string(void)
+{
+	return "N/A";
+}
 
 /* Prior to version 8.20, libpcre did not have pcre_free_study() */
 #if (PCRE_MAJOR < 8 || (PCRE_MAJOR == 8 && PCRE_MINOR < 20))
@@ -247,7 +290,8 @@ char const *regex_version(void)
 	return pcre_version();
 }
 
-int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex)
+int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
+		    int unused __attribute__((unused)))
 {
 	int rc;
 	uint32_t entry_len;
diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
index 810b3c5..186c5ec 100644
--- a/libselinux/src/regex.h
+++ b/libselinux/src/regex.h
@@ -34,6 +34,16 @@ struct regex_error_data {
 struct mmap_area;
 
 /**
+ * regex_arch_string return a string that represents the pointer width, the
+ * width of what the backend considers a size type, and the endianness of the
+ * system that this library was build for. (e.g. for x86_64: "8-8-el").
+ * This is required when loading stored regular espressions. PCRE2 regular
+ * expressions are not portable across architectures that do not have a
+ * matching arch-string.
+ */
+char const *regex_arch_string(void) hidden;
+
+/**
  * regex_verison returns the version string of the underlying regular
  * regular expressions library. In the case of PCRE it just returns the
  * result of pcre_version(). In the case of PCRE2, the very first time this
@@ -86,12 +96,15 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
  *               representation of the precompiled pattern.
  * @arg regex If successful, the structure returned through *regex was allocated
  *            with regex_data_create and must be freed with regex_data_free.
+ * @arg do_load_precompregex If non-zero precompiled patterns get loaded from
+ *			     the mmap region (ignored by PCRE1 back-end).
  *
  * @retval 0 on success
  * @retval -1 on error
  */
 int regex_load_mmap(struct mmap_area *map_area,
-		    struct regex_data **regex) hidden;
+		    struct regex_data **regex,
+		    int do_load_precompregex) hidden;
 /**
  * This function stores a precompiled regular expression to a file.
  * In the case of PCRE, it just dumps the binary representation of the
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 70853e7..d91db9a 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -103,6 +103,7 @@ static int write_binary_file(struct saved_data *data, int fd,
 	uint32_t i;
 	int rc;
 	const char *reg_version;
+	const char *reg_arch;
 
 	bin_file = fdopen(fd, "w");
 	if (!bin_file) {
@@ -133,6 +134,18 @@ static int write_binary_file(struct saved_data *data, int fd,
 	if (len != section_len)
 		goto err;
 
+	/* write regex arch string */
+	reg_arch = regex_arch_string();
+	if (!reg_arch)
+		goto err;
+	section_len = strlen(reg_arch);
+	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		goto err;
+	len = fwrite(reg_arch, sizeof(char), section_len, bin_file);
+	if (len != section_len)
+		goto err;
+
 	/* write the number of stems coming */
 	section_len = data->num_stems;
 	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
-- 
2.8.0.rc3.226.g39d4020
