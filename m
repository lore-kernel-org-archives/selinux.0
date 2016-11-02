From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: bill.c.roberts@gmail.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsemanage: fix kernel pathname in semanage_verify_kernel()
Date: Wed,  2 Nov 2016 09:00:27 -0400
Message-Id: <1478091627-8111-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Building with CC=clang, we get the following errors:

semanage_store.c:2177:20: error: implicit conversion from enumeration type 'enum semanage_final_defs' to different enumeration type 'enum semanage_store_defs' [-Werror,-Wenum-conversion]
            semanage_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL);
            ~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~
semanage_store.c:2177:40: error: implicit conversion from enumeration type 'enum semanage_final_path_defs' to different enumeration type 'enum semanage_sandbox_defs' [-Werror,-Wenum-conversion]
            semanage_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL);
            ~~~~~~~~~~~~~                     ^~~~~~~~~~~~~~~

This is an actual bug; semanage_verify_kernel() was never updated to
use semanage_final_path() when the rest were converted.  Fix it.
This pathname is only used if a kernel policy verifier is specified
in semanage.conf, so this is not used by default.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/semanage_store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index ca29257..58a58ef 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -2174,7 +2174,7 @@ int semanage_verify_kernel(semanage_handle_t * sh)
 {
 	int retval = -1;
 	const char *kernel_filename =
-	    semanage_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL);
+	    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL);
 	semanage_conf_t *conf = sh->conf;
 	external_prog_t *e;
 	if (conf->kernel_prog == NULL) {
-- 
2.7.4
