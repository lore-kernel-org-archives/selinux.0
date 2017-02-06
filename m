From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: fix ptrace test script
Date: Mon,  6 Feb 2017 16:42:13 -0500
Message-Id: <1486417333-29198-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The ptrace test script was doing a chmod +x wait, which wouldn't work
when run from the top-level directory.  Use $basedir to fully qualify
the pathname.  This just happened to "work" when there was a wait
test, but it was then being applied to the wait subdirectory, not the
wait script.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/ptrace/test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ptrace/test b/tests/ptrace/test
index 711d026..dc5bf40 100755
--- a/tests/ptrace/test
+++ b/tests/ptrace/test
@@ -5,7 +5,7 @@ BEGIN { plan tests => 2}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
-system "chmod +x wait";
+system "chmod +x $basedir/wait";
 
 # Start the process to be traced.
 if(($pid=fork())==0){
-- 
2.7.4
