From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: fix file/test failure
Date: Tue, 13 Sep 2016 14:57:58 -0400
Message-Id: <1473793078-14237-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4.8-rc5, Paul Moore reported the following test failure:

file/test ............... 8/16 # Test 8 got: "256" (file/test at line 85)
file/test ............... Failed 1/16 subtests

... this happens to be the SIGIO/good test.  Running the test by hand
yields the following AVC:

type=AVC msg=audit(1473785577.548:448): avc:  denied  { execute } for
 pid=2336 comm="wait_io"
 path="/root/sources/selinux-testsuite/tests/file/wait_io"
 dev="sda3" ino=399656
 scontext=unconfined_u:unconfined_r:fileop_t:s0-s0:c0.c1023
 tcontext=system_u:object_r:fileop_exec_t:s0
 tclass=file permissive=0

commit 9f834ec18defc369d73ccf9e87a2790bfa05bf46 ("binfmt_elf: switch to new
creds when switching to new mm") moved the switching of credentials before
mapping the executable, and therefore triggers a file execute check between
the new domain and the executable type on domain transitions.

Switch the test policy to use domain_entry_file() rather than a
handcoded allow rule, thereby allowing both permissions.

Reported-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_file.te | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policy/test_file.te b/policy/test_file.te
index eb93a49..24c8b16 100644
--- a/policy/test_file.te
+++ b/policy/test_file.te
@@ -66,7 +66,7 @@ userdom_sysadm_entry_spec_domtrans_to(fileopdomain)
 corecmd_bin_entry_type(fileopdomain)
 sysadm_bin_spec_domtrans_to(fileopdomain)
 
-allow fileop_t fileop_exec_t:file entrypoint;
+domain_entry_file(fileop_t, fileop_exec_t)
 domain_auto_trans(test_fileop_t, fileop_exec_t, fileop_t)
 allow test_fileop_t fileop_t:fd use;
 allow fileop_t test_fileop_t:fd use;
-- 
2.7.4
