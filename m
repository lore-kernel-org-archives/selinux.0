From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: vmojzis@redhat.com, richard_c_haines@btinternet.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux, sefcontext_compile: handle NULL pcre study data
Date: Wed, 17 Aug 2016 15:15:38 -0400
Message-Id: <1471461338-13426-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

pcre_study() can return a NULL result if no additional information
could be determined for the pattern.  Thus, sefcontext_compile
needs to correctly handle the case where the study data is NULL
when generating file_contexts.bin, and libselinux needs to correctly
handle it when loading file_contexts.bin.  Fix them both.

This change enables:
semanage fcontext -a -t httpd_exec_t "(/.*)?"
to succeed, since the regex itself is valid but there is no
additional information produced by pcre_study().

Reported-by: Vit Mojzis <vmojzis@redhat.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c           | 25 ++++++++++++++-----------
 libselinux/src/label_file.h           |  9 ++++++---
 libselinux/utils/sefcontext_compile.c | 21 +++++++++++++--------
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 071d902..c89bb35 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -388,18 +388,21 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 			rc = -1;
 			goto err;
 		}
-		spec->lsd.study_data = (void *)mmap_area->next_addr;
-		spec->lsd.flags |= PCRE_EXTRA_STUDY_DATA;
-		rc = next_entry(NULL, mmap_area, entry_len);
-		if (rc < 0)
-			goto err;
 
-		/* Check that study data lengths match. */
-		rc = pcre_fullinfo(spec->regex, &spec->lsd,
-				    PCRE_INFO_STUDYSIZE, &len);
-		if (rc < 0 || len != entry_len) {
-			rc = -1;
-			goto err;
+		if (entry_len) {
+			spec->lsd.study_data = (void *)mmap_area->next_addr;
+			spec->lsd.flags |= PCRE_EXTRA_STUDY_DATA;
+			rc = next_entry(NULL, mmap_area, entry_len);
+			if (rc < 0)
+				goto err;
+
+			/* Check that study data lengths match. */
+			rc = pcre_fullinfo(spec->regex, &spec->lsd,
+					   PCRE_INFO_STUDYSIZE, &len);
+			if (rc < 0 || len != entry_len) {
+				rc = -1;
+				goto err;
+			}
 		}
 
 		data->nspec++;
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 72fed1f..6d1e890 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -80,9 +80,12 @@ struct saved_data {
 
 static inline pcre_extra *get_pcre_extra(struct spec *spec)
 {
-	if (spec->from_mmap)
-		return &spec->lsd;
-	else
+	if (spec->from_mmap) {
+		if (spec->lsd.study_data)
+			return &spec->lsd;
+		else
+			return NULL;
+	} else
 		return spec->sd;
 }
 
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index d2578b6..fd6fb78 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -228,10 +228,13 @@ static int write_binary_file(struct saved_data *data, int fd)
 		if (len != to_write)
 			goto err;
 
-		/* determine the size of the pcre study info */
-		rc = pcre_fullinfo(re, sd, PCRE_INFO_STUDYSIZE, &size);
-		if (rc < 0)
-			goto err;
+		if (sd) {
+			/* determine the size of the pcre study info */
+			rc = pcre_fullinfo(re, sd, PCRE_INFO_STUDYSIZE, &size);
+			if (rc < 0)
+				goto err;
+		} else
+			size = 0;
 
 		/* write the number of bytes in the pcre study data */
 		to_write = size;
@@ -239,10 +242,12 @@ static int write_binary_file(struct saved_data *data, int fd)
 		if (len != 1)
 			goto err;
 
-		/* write the actual pcre study data as a char array */
-		len = fwrite(sd->study_data, 1, to_write, bin_file);
-		if (len != to_write)
-			goto err;
+		if (sd) {
+			/* write the actual pcre study data as a char array */
+			len = fwrite(sd->study_data, 1, to_write, bin_file);
+			if (len != to_write)
+				goto err;
+		}
 	}
 
 	rc = 0;
-- 
2.7.4
