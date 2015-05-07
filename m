Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t47Ef1Ko021923
 for <selinux@tycho.nsa.gov>; Thu, 7 May 2015 10:41:04 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Fix core dumps with corrupt *.bin files
Date: Thu,  7 May 2015 15:40:53 +0100
Message-Id: <1431009653-7230-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Check buffer address limits when processing *.bin files
to catch any over-runs. On failure process text file instead.

To test, the bin files were corrupted by adding and removing
various bits of data. Various file sizes were also checked and
all were caught by the patch.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label_file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b3e5671..c722f29 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -325,6 +325,8 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 		addr += sizeof(uint32_t);
 		if (memcmp((char *)addr, pcre_version(), len))
 			return -1; /* pcre version content mismatch */
+		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
+			return -1; /* Buffer over-run */
 		addr += *plen;
 	}
 
@@ -390,11 +392,15 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 		if (!spec->lr.ctx_raw)
 			goto err;
 
+		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
+			return -1;
 		addr += *plen;
 
 		plen = (uint32_t *)addr;
 		addr += sizeof(uint32_t);
 		spec->regex_str = (char *)addr;
+		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
+			return -1;
 		addr += *plen;
 
 		spec->mode = *(mode_t *)addr;
@@ -415,12 +421,16 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 		plen = (uint32_t *)addr;
 		addr += sizeof(uint32_t);
 		spec->regex = (pcre *)addr;
+		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
+			return -1;
 		addr += *plen;
 
 		plen = (uint32_t *)addr;
 		addr += sizeof(uint32_t);
 		spec->lsd.study_data = (void *)addr;
 		spec->lsd.flags |= PCRE_EXTRA_STUDY_DATA;
+		if (addr + *plen >= (char *)mmap_area->addr + mmap_area->len)
+			return -1;
 		addr += *plen;
 
 		data->nspec++;
-- 
2.1.0
