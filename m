Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0VAbIJT020323
 for <selinux@tycho.nsa.gov>; Sun, 31 Jan 2016 05:37:18 -0500
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D27635648D1
 for <selinux@tycho.nsa.gov>; Sun, 31 Jan 2016 11:37:13 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsemanage: move modinfo_tmp definition before goto
 cleanup
Date: Sun, 31 Jan 2016 11:36:38 +0100
Message-Id: <1454236598-1829-3-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1454236598-1829-1-git-send-email-nicolas.iooss@m4x.org>
References: <1454236598-1829-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In semanage_direct_set_module_info() and semanage_direct_list_all()
functions, when modinfo_tmp variable gets initialized, a branch to
"cleanup" label may have already been taken.  This leads to this
variable being possibly used uninitialized in these functions.

This is reported by clang:

    direct_api.c:2491:41: error: variable 'modinfo_tmp' may be
    uninitialized when used here [-Werror,-Wconditional-uninitialized]
            ret = semanage_module_info_destroy(sh, modinfo_tmp);
                                                   ^~~~~~~~~~~
    direct_api.c:2334:2: note: variable 'modinfo_tmp' is declared here
            semanage_module_info_t *modinfo_tmp = NULL;
            ^

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/direct_api.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index dd621d99295e..7c84bcea629b 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2136,6 +2136,7 @@ static int semanage_direct_set_module_info(semanage_handle_t *sh,
 	char fn[PATH_MAX];
 	const char *path = NULL;
 	int enabled = 0;
+	semanage_module_info_t *modinfo_tmp = NULL;
 
 	semanage_module_key_t modkey;
 	ret = semanage_module_key_init(sh, &modkey);
@@ -2144,8 +2145,6 @@ static int semanage_direct_set_module_info(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	semanage_module_info_t *modinfo_tmp = NULL;
-
 	/* check transaction */
 	if (!sh->is_in_transaction) {
 		if (semanage_begin_transaction(sh) < 0) {
@@ -2316,6 +2315,8 @@ static int semanage_direct_list_all(semanage_handle_t *sh,
 
 	uint16_t priority = 0;
 
+	semanage_module_info_t *modinfo_tmp = NULL;
+
 	semanage_module_info_t modinfo;
 	ret = semanage_module_info_init(sh, &modinfo);
 	if (ret != 0) {
@@ -2323,8 +2324,6 @@ static int semanage_direct_list_all(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	semanage_module_info_t *modinfo_tmp = NULL;
-
 	if (sh->is_in_transaction) {
 		toplevel = semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES);
 	} else {
-- 
2.7.0
