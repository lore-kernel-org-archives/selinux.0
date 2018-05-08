From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue,  8 May 2018 10:32:54 -0400
Message-Id: <20180508143254.28306-1-sds@tycho.nsa.gov>
Subject: [PATCH] libsemanage: prevent string overflow on final paths
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Verify that the final path does not exceed the size of the
buffer before copying.  This can only occur if an alternate
path for the policy root and/or the policy store root has been
specified and if the resulting path would exceed PATH_MAX. A
similar check is already applied by semanage_make_final().

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/semanage_store.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index bce648c4..f1984c50 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1597,7 +1597,12 @@ static int semanage_install_final_tmp(semanage_handle_t * sh)
 		/* skip genhomedircon if configured */
 		if (sh->conf->disable_genhomedircon &&
 		    i == SEMANAGE_FC_HOMEDIRS) continue;
-		
+
+		if (strlen(dst) >= sizeof(fn)) {
+			ERR(sh, "Unable to compose the final paths.");
+			status = -1;
+			goto cleanup;
+		}
 		strcpy(fn, dst);
 		ret = semanage_mkpath(sh, dirname(fn));
 		if (ret < 0) {
-- 
2.14.3
