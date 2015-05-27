Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4RGFAJA014178
 for <selinux@tycho.nsa.gov>; Wed, 27 May 2015 12:15:10 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH V2] libselinux: Support consistent mode size for bin files
Date: Wed, 27 May 2015 17:14:59 +0100
Message-Id: <1432743299-30028-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently sefcontext_compile defines the mode field as mode_t whose
size will vary depending on the architecture (e.g. 32 bit / 64 bit).
This patch sets the size when writing/reading binary files to
uint32_t. The file version is set to SELINUX_COMPILED_FCONTEXT_MODE

V2 fixes those listed in http://marc.info/?l=selinux&m=143273965514292&w=2


Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label_file.c           | 8 +++++++-
 libselinux/src/label_file.h           | 6 +++++-
 libselinux/utils/sefcontext_compile.c | 6 ++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 7da79b4..bfb64af 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -404,6 +404,7 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 	for (i = 0; i < regex_array_len; i++) {
 		struct spec *spec;
 		int32_t stem_id, meta_chars;
+		uint32_t mode = 0;
 
 		rc = grow_specs(data);
 		if (rc < 0)
@@ -454,10 +455,15 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 		}
 
 		/* Process mode */
-		rc = next_entry(&spec->mode, mmap_area, sizeof(mode_t));
+		if (version >= SELINUX_COMPILED_FCONTEXT_MODE)
+			rc = next_entry(&mode, mmap_area, sizeof(uint32_t));
+		else
+			rc = next_entry(&mode, mmap_area, sizeof(mode_t));
 		if (rc < 0)
 			goto err;
 
+		spec->mode = mode;
+
 		/* map the stem id from the mmap file to the data->stem_arr */
 		rc = next_entry(&stem_id, mmap_area, sizeof(int32_t));
 		if (rc < 0)
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 3d963b4..a8d1e51 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -6,9 +6,13 @@
 #include "label_internal.h"
 
 #define SELINUX_MAGIC_COMPILED_FCONTEXT	0xf97cff8a
+
+/* Version specific changes */
 #define SELINUX_COMPILED_FCONTEXT_NOPCRE_VERS	1
 #define SELINUX_COMPILED_FCONTEXT_PCRE_VERS	2
-#define SELINUX_COMPILED_FCONTEXT_MAX_VERS	2
+#define SELINUX_COMPILED_FCONTEXT_MODE		3
+
+#define SELINUX_COMPILED_FCONTEXT_MAX_VERS	SELINUX_COMPILED_FCONTEXT_MODE
 
 /* Prior to verison 8.20, libpcre did not have pcre_free_study() */
 #if (PCRE_MAJOR < 8 || (PCRE_MAJOR == 8 && PCRE_MINOR < 20))
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index e6d93d4..33a4a42 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -142,7 +142,8 @@ static int process_file(struct saved_data *data, const char *filename)
  * 	char - char array of the raw context
  *	u32  - length of the upcoming regex_str
  *	char - char array of the original regex string including the stem.
- *	mode_t - mode bits
+ *	u32  - mode bits for >= SELINUX_COMPILED_FCONTEXT_MODE
+ *	       mode_t for <= SELINUX_COMPILED_FCONTEXT_PCRE_VERS
  *	s32  - stemid associated with the regex
  *	u32  - spec has meta characters
  *	u32  - data length of the pcre regex
@@ -247,7 +248,8 @@ static int write_binary_file(struct saved_data *data, int fd)
 			goto err;
 
 		/* binary F_MODE bits */
-		len = fwrite(&mode, sizeof(mode), 1, bin_file);
+		to_write = mode;
+		len = fwrite(&to_write, sizeof(uint32_t), 1, bin_file);
 		if (len != 1)
 			goto err;
 
-- 
2.1.0
