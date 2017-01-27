From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: richard_c_haines@btinternet.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] policycoreutils: remove deprecated -o option from fixfiles
 verify
Date: Fri, 27 Jan 2017 09:54:48 -0500
Message-Id: <1485528888-18328-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/scripts/fixfiles | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index df6f766..3896d19 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -310,7 +310,7 @@ process() {
 case "$1" in
     restore) restore Relabel;;
     check) VERBOSE="-v"; restore Check -n;;
-    verify) restore Verify -n -o -;;
+    verify) restore Verify -n;;
     relabel) relabel;;
     onboot)
 	> /.autorelabel
-- 
2.7.4
