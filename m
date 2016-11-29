From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: avcstat: Clean up redundant condition
Date: Tue, 29 Nov 2016 11:12:39 -0500
Message-Id: <1480435959-27151-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

dcb314 reported this via https://github.com/SELinuxProject/selinux/issues/20

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/utils/avcstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
index 70b3109..5ff582b 100644
--- a/libselinux/utils/avcstat.c
+++ b/libselinux/utils/avcstat.c
@@ -203,7 +203,7 @@ int main(int argc, char **argv)
 		if (!parsed)
 			die("unable to parse \'%s\': no data", avcstatfile);
 
-		if (cumulative || (!cumulative && !i))
+		if (cumulative || !i)
 			printf("%10Lu %10Lu %10Lu %10Lu %10Lu %10Lu\n",
 			       tot.lookups, tot.hits, tot.misses,
 			       tot.allocations, tot.reclaims, tot.frees);
-- 
2.7.4
