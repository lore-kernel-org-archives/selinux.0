From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: support context validation on file_contexts.bin
Date: Thu,  6 Aug 2015 14:12:58 -0400
Message-Id: <1438884778-15634-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If file_contexts.bin was opened with SELABEL_OPT_VALIDATE set, then
we should validate contexts in the same manner as with file_contexts.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 04b3826..b91e1e6 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -302,6 +302,14 @@ static int load_mmap(struct selabel_handle *rec, const char *path,
 		}
 		spec->lr.ctx_raw = str_buf;
 
+		if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->validating) {
+			if (selabel_validate(rec, &spec->lr) < 0) {
+				selinux_log(SELINUX_ERROR,
+					    "%s: context %s is invalid\n", mmap_path, spec->lr.ctx_raw);
+				goto err;
+			}
+		}
+
 		/* Process regex string */
 		rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
 		if (rc < 0 || !entry_len) {
-- 
2.1.0
