Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sK009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:17 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so2954205wgg.21
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:24 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.22
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:23 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 09/20] libselinux: fix gcc -Wsign-compare warnings
Date: Sun, 14 Sep 2014 23:41:40 +0200
Message-Id: <1410730911-14512-10-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libselinux/src/label_file.c           | 9 +++++----
 libselinux/src/label_file.h           | 2 +-
 libselinux/utils/sefcontext_compile.c | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 7879e2f2aa1b..8e7b288997aa 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -213,7 +213,7 @@ static int process_line(struct selabel_handle *rec,
 	spec_arr[nspec].mode = 0;
 	if (type) {
 		mode_t mode = string_to_mode(type);
-		if (mode == -1) {
+		if (mode == (mode_t)-1) {
 			COMPAT_LOG(SELINUX_WARNING, "%s:  line %d has invalid file type %s\n",
 				   path, lineno, type);
 			mode = 0;
@@ -240,19 +240,20 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 	struct saved_data *data = (struct saved_data *)rec->data;
 	char mmap_path[PATH_MAX + 1];
 	int mmapfd;
-	int rc, i;
+	int rc;
 	struct stat mmap_stat;
 	char *addr;
 	size_t len;
 	int stem_map_len, *stem_map;
 	struct mmap_area *mmap_area;
 
+	uint32_t i;
 	uint32_t *magic;
 	uint32_t *section_len;
 	uint32_t *plen;
 
 	rc = snprintf(mmap_path, sizeof(mmap_path), "%s.bin", path);
-	if (rc >= sizeof(mmap_path))
+	if (rc >= (int)sizeof(mmap_path))
 		return -1;
 
 	mmapfd = open(mmap_path, O_RDONLY | O_CLOEXEC);
@@ -445,7 +446,7 @@ static int process_file(const char *path, const char *suffix, struct selabel_han
 	/* append the path suffix if we have one */
 	if (suffix) {
 		rc = snprintf(stack_path, sizeof(stack_path), "%s.%s", path, suffix);
-		if (rc >= sizeof(stack_path)) {
+		if (rc >= (int)sizeof(stack_path)) {
 			errno = ENAMETOOLONG;
 			return -1;
 		}
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 2c6b89711664..e3a0445da30a 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -176,7 +176,7 @@ static inline int sort_specs(struct saved_data *data)
 {
 	struct spec *spec_copy;
 	struct spec spec;
-	int i;
+	unsigned int i;
 	int front, back;
 	size_t len = sizeof(*spec_copy);
 
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 7b7818039dc2..504699d643fd 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -72,7 +72,7 @@ static int process_file(struct saved_data *data, const char *filename)
 
 		spec->lr.ctx_raw = context;
 		spec->mode = string_to_mode(mode);
-		if (spec->mode == -1) {
+		if (spec->mode == (mode_t)-1) {
 			fprintf(stderr, "%s: line %d has invalid file type %s\n",
 				regex, line_num + 1, mode);
 			spec->mode = 0;
@@ -362,7 +362,7 @@ int main(int argc, char *argv[])
 		return rc;
 
 	rc = snprintf(stack_path, sizeof(stack_path), "%s.bin", path);
-	if (rc < 0 || rc >= sizeof(stack_path))
+	if (rc < 0 || rc >= (int)sizeof(stack_path))
 		return rc;
 
 	if (asprintf(&tmp, "%sXXXXXX", stack_path) < 0)
-- 
2.1.0
