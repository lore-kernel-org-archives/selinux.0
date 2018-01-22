Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0MGcapo024000
 for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2018 11:38:37 -0500
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Mon, 22 Jan 2018 16:38:11 +0000
Message-Id: <20180122163811.16512-1-richard_c_haines@btinternet.com>
Subject: [PATCH] libsemanage: Return commit number if save-previous
 false
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stop overwriting the commit number for the default save-previous flag
setting (false) in semanage.conf.

Allows semodule -v -i <policy> to show the correct commit number.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsemanage/src/semanage_store.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 37ff5ace..936e6495 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1740,9 +1740,9 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 
 	if (!sh->conf->save_previous) {
 		int errsv = errno;
-		retval = semanage_remove_directory(backup);
-		if (retval < 0) {
+		if (semanage_remove_directory(backup) != 0) {
 			ERR(sh, "Could not delete previous directory %s.", backup);
+			retval = -1;
 			goto cleanup;
 		}
 		errno = errsv;
-- 
2.14.3
