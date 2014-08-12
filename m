Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7CCwbGK021705
 for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2014 08:58:41 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsemanage: Check files exist before sefcontext_compile
Date: Tue, 12 Aug 2014 13:58:35 +0100
Message-Id: <1407848315-23739-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The file_contexts.local and file_contexts.homedirs are optional,
therefore check they exist before calling sefcontext_compile otherwise
the Reference Policy (or any custom policy) will not build.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsemanage/src/semanage_store.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 4b040c3..de89c61 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1095,7 +1095,7 @@ static int semanage_install_active(semanage_handle_t * sh)
 {
 	int retval = -3, r, len;
 	char *storepath = NULL;
-	struct stat astore, istore;
+	struct stat astore, istore, fc;
 	const char *active_kernel = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_KERNEL);
 	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
 	const char *active_fc_loc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC_LOCAL);
@@ -1225,11 +1225,17 @@ static int semanage_install_active(semanage_handle_t * sh)
 	if (sefcontext_compile(sh, store_fc) != 0) {
 		goto cleanup;
 	}
-	if (sefcontext_compile(sh, store_fc_loc) != 0) {
-		goto cleanup;
+
+	if (stat(store_fc_loc, &fc) == 0) {
+		if (sefcontext_compile(sh, store_fc_loc) != 0) {
+			goto cleanup;
+		}
 	}
-	if (sefcontext_compile(sh, store_fc_hd) != 0) {
-		goto cleanup;
+
+	if (stat(store_fc_hd, &fc) == 0) {
+		if (sefcontext_compile(sh, store_fc_hd) != 0) {
+			goto cleanup;
+		}
 	}
 
 	retval = 0;
-- 
1.9.3
