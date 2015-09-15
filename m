Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8FDXJk4024176
 for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2015 09:33:19 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Fix mmap memory release for file labeling
Date: Tue, 15 Sep 2015 14:33:05 +0100
Message-Id: <1442323985-4256-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ensure the mmap start address and length are not modified so the memory
used can be released when selabel_close(3) is called.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label_file.c | 12 ++++++------
 libselinux/src/label_file.h | 14 ++++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 687d0a7..bf91885 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -159,8 +159,8 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 	}
 
 	/* save where we mmap'd the file to cleanup on close() */
-	mmap_area->addr = addr;
-	mmap_area->len = len;
+	mmap_area->addr = mmap_area->next_addr = addr;
+	mmap_area->len = mmap_area->next_len = len;
 	mmap_area->next = data->mmap_areas;
 	data->mmap_areas = mmap_area;
 
@@ -231,7 +231,7 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 
 		/* Check for stem_len wrap around. */
 		if (stem_len < UINT32_MAX) {
-			buf = (char *)mmap_area->addr;
+			buf = (char *)mmap_area->next_addr;
 			/* Check if over-run before null check. */
 			rc = next_entry(NULL, mmap_area, (stem_len + 1));
 			if (rc < 0)
@@ -317,7 +317,7 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 			goto err;
 		}
 
-		spec->regex_str = (char *)mmap_area->addr;
+		spec->regex_str = (char *)mmap_area->next_addr;
 		rc = next_entry(NULL, mmap_area, entry_len);
 		if (rc < 0)
 			goto err;
@@ -369,7 +369,7 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 			rc = -1;
 			goto err;
 		}
-		spec->regex = (pcre *)mmap_area->addr;
+		spec->regex = (pcre *)mmap_area->next_addr;
 		rc = next_entry(NULL, mmap_area, entry_len);
 		if (rc < 0)
 			goto err;
@@ -387,7 +387,7 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 			rc = -1;
 			goto err;
 		}
-		spec->lsd.study_data = (void *)mmap_area->addr;
+		spec->lsd.study_data = (void *)mmap_area->next_addr;
 		spec->lsd.flags |= PCRE_EXTRA_STUDY_DATA;
 		rc = next_entry(NULL, mmap_area, entry_len);
 		if (rc < 0)
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index e6a687a..2492826 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -49,8 +49,10 @@ struct stem {
 
 /* Where we map the file in during selabel_open() */
 struct mmap_area {
-	void *addr;	/* Start of area - gets incremented by next_entry() */
-	size_t len;	/* Length - gets decremented by next_entry() */
+	void *addr;	/* Start addr + len used to release memory at close */
+	size_t len;
+	void *next_addr;	/* Incremented by next_entry() */
+	size_t next_len;	/* Decremented by next_entry() */
 	struct mmap_area *next;
 };
 
@@ -310,14 +312,14 @@ static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
  * current buffer). */
 static inline int next_entry(void *buf, struct mmap_area *fp, size_t bytes)
 {
-	if (bytes > fp->len)
+	if (bytes > fp->next_len)
 		return -1;
 
 	if (buf)
-		memcpy(buf, fp->addr, bytes);
+		memcpy(buf, fp->next_addr, bytes);
 
-	fp->addr = (char *)fp->addr + bytes;
-	fp->len -= bytes;
+	fp->next_addr = (char *)fp->next_addr + bytes;
+	fp->next_len -= bytes;
 	return 0;
 }
 
-- 
2.4.3
