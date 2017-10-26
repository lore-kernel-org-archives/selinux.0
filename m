From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 26 Oct 2017 11:05:07 -0400
Message-Id: <20171026150507.5406-1-sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: nnp_nosuid: tidy perl style
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Trivial reformatting via tools/check-syntax -f.
Noticed it when I ran it to fix up the inet_socket/test script
after the changes in the preceding commit and it also fixed this one.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/nnp_nosuid/test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nnp_nosuid/test b/tests/nnp_nosuid/test
index accb3f2..4e13927 100755
--- a/tests/nnp_nosuid/test
+++ b/tests/nnp_nosuid/test
@@ -173,7 +173,7 @@ if ($test_nnp_nosuid_transition) {
       );
     ok( $result, 0 );    #this should succeed
 
-    # Automatic transition under NNP+nosuid to nnpnosuidtransition domain via exec.
+ # Automatic transition under NNP+nosuid to nnpnosuidtransition domain via exec.
     $result =
       system(
 "$basedir/execnnp -n -- $basedir/testdir/checkcon test_nnpnosuidtransition_t 2>&1"
-- 
2.9.5
