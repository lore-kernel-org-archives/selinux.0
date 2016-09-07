Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u878A1rw023167
 for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2016 04:10:07 -0400
Received: by mail-wm0-f47.google.com with SMTP id w12so17120424wmf.0
 for <selinux@tycho.nsa.gov>; Wed, 07 Sep 2016 01:10:06 -0700 (PDT)
From: Janis Danisevskis <jdanis@android.com>
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov
Subject: [PATCH 2/2] libselinux: fix memory leak on pcre2
Date: Wed,  7 Sep 2016 09:08:46 +0100
Message-Id: <1473235726-62661-2-git-send-email-jdanis@android.com>
In-Reply-To: <1473235726-62661-1-git-send-email-jdanis@android.com>
References: <1473235726-62661-1-git-send-email-jdanis@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Introduced a malloc on pcre_version(). Libselinux
expected this to be static, just use a static
internal buffer.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/label_file.c           | 13 ++++++++-----
 libselinux/src/regex.c                | 20 +++++++-------------
 libselinux/utils/sefcontext_compile.c |  8 +++++---
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 6698624..110db11 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -111,6 +111,7 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 	struct mmap_area *mmap_area;
 	uint32_t i, magic, version;
 	uint32_t entry_len, stem_map_len, regex_array_len;
+	const char *reg_version;
 
 	if (isbinary) {
 		len = strlen(path);
@@ -174,11 +175,13 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 	if (rc < 0 || version > SELINUX_COMPILED_FCONTEXT_MAX_VERS)
 		return -1;
 
+	reg_version = regex_version();
+	if (!reg_version)
+		return -1;
+
 	if (version >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
-		if (!regex_version()) {
-			return -1;
-		}
-		len = strlen(regex_version());
+
+		len = strlen(reg_version);
 
 		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
 		if (rc < 0)
@@ -200,7 +203,7 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 		}
 
 		str_buf[entry_len] = '\0';
-		if ((strcmp(str_buf, regex_version()) != 0)) {
+		if ((strcmp(str_buf, reg_version) != 0)) {
 			free(str_buf);
 			return -1;
 		}
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 6b92b04..c880bfa 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -49,19 +49,13 @@ err:	regex_data_free(*regex);
 
 char const * regex_version(void) {
 #ifdef USE_PCRE2
-	static int initialized = 0;
-	static char * version_string = NULL;
-	size_t version_string_len;
-	if (!initialized) {
-		version_string_len = pcre2_config(PCRE2_CONFIG_VERSION, NULL);
-		version_string = (char*) malloc(version_string_len);
-		if (!version_string) {
-			return NULL;
-		}
-		pcre2_config(PCRE2_CONFIG_VERSION, version_string);
-		initialized = 1;
-	}
-	return version_string;
+	static char version_buf[256];
+	size_t len = pcre2_config(PCRE2_CONFIG_VERSION, NULL);
+	if (len <= 0 || len > sizeof(version_buf))
+		return NULL;
+
+	pcre2_config(PCRE2_CONFIG_VERSION, version_buf);
+	return version_buf;
 #else
 	return pcre_version();
 #endif
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 8ff73f4..b6b8d92 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -101,6 +101,7 @@ static int write_binary_file(struct saved_data *data, int fd)
 	uint32_t section_len;
 	uint32_t i;
 	int rc;
+	const char *reg_version;
 
 	bin_file = fdopen(fd, "w");
 	if (!bin_file) {
@@ -120,13 +121,14 @@ static int write_binary_file(struct saved_data *data, int fd)
 		goto err;
 
 	/* write version of the regex back-end */
-	if (!regex_version())
+	reg_version = regex_version();
+	if (!reg_version)
 		goto err;
-	section_len = strlen(regex_version());
+	section_len = strlen(reg_version);
 	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
 	if (len != 1)
 		goto err;
-	len = fwrite(regex_version(), sizeof(char), section_len, bin_file);
+	len = fwrite(reg_version, sizeof(char), section_len, bin_file);
 	if (len != section_len)
 		goto err;
 
-- 
2.8.0.rc3.226.g39d4020
