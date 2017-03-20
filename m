Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2KFEA0k026604
 for <selinux@tycho.nsa.gov>; Mon, 20 Mar 2017 11:14:10 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] checkpolicy: Fix minor memory leak in checkpolicy
Date: Mon, 20 Mar 2017 11:14:33 -0400
Message-Id: <1490022873-11869-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sepol_set_sidtab() is called without calling sepol_sidtab_destroy().
This is not a big deal, since checkpolicy does not run for long, but
it does add noise when checking for other, more important, leaks.

Call sepol_sidtab_destroy() before exiting if not in debug mode.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/checkpolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 442e7db..534fc22 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -673,6 +673,7 @@ int main(int argc, char **argv)
 
 	if (!debug) {
 		policydb_destroy(&policydb);
+		sepol_sidtab_destroy(&sidtab);
 		exit(0);
 	}
 
-- 
2.7.4
