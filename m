From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: richard_c_haines@btinternet.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] policycoreutils: setfiles: make -I imply -D
Date: Fri, 30 Sep 2016 12:13:35 -0400
Message-Id: <1475252015-17100-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-I only makes sense if we are also enabling digests.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/setfiles/setfiles.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 22eba0f..1a2d711 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -279,6 +279,7 @@ int main(int argc, char **argv)
 		case 'I': /* Force label check by ignoring directory digest. */
 			r_opts.ignore_digest =
 					   SELINUX_RESTORECON_IGNORE_DIGEST;
+			request_digest = 1;
 			break;
 		case 'D': /*
 			   * Request file_contexts digest in selabel_open
-- 
2.7.4
