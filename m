Message-ID: <54007C2A.1040504@tycho.nsa.gov>
Date: Fri, 29 Aug 2014 09:12:10 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v2] selinux: Permit bounded transitions under NO_NEW_PRIVS
 or NOSUID.
References: <1407173809-3477-1-git-send-email-sds@tycho.nsa.gov>
 <1781230.AAtiyApM3R@sifl> <53EA692A.1030705@tycho.nsa.gov>
 <35237187.pLesj1POuT@sifl>
In-Reply-To: <35237187.pLesj1POuT@sifl>
Content-Type: multipart/mixed; boundary="------------060006000008070202010405"
Cc: SELinux-NSA <selinux@tycho.nsa.gov>, Andy Lutomirski <luto@amacapital.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------060006000008070202010405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 08/28/2014 05:36 PM, Paul Moore wrote:
> On Tuesday, August 12, 2014 03:21:14 PM Stephen Smalley wrote:
>> Attached is the patch for the selinux-testsuite,
>> against git://git.selinuxproject.org/~serge/selinux-testsuite.
>> Once it goes into a kernel I can make the test kernel version-specific
>> and thus ensure it passes on old and new kernels.
> 
> I just applied the kernel patch to the SELinux next branch and ran the 
> testsuite against it to ensure everything was okay and ran into the problems 
> below:
> 
> <<<<
> Running as user root with context unconfined_u:unconfined_r:unconfined_t
> 
> domain_trans/test ....... ok   
> entrypoint/test ......... ok   
> execshare/test .......... ok   
> exectrace/test .......... ok   
> execute_no_trans/test ... ok   
> fdreceive/test .......... ok   
> inherit/test ............ ok   
> link/test ............... ok   
> mkdir/test .............. ok   
> msg/test ................ ok     
> nnp/test ................ 1/4 # Test 1 got: "32256" (nnp/test at line 19)
> #   Expected: "0"
> #  nnp/test line 19 is: ok($result,0); #this should pass
> # Test 2 got: "256" (nnp/test at line 23)
> #   Expected: "0"
> #  nnp/test line 23 is: ok($result,0); #this should pass
> nnp/test ................ Failed 2/4 subtests 

This is the output I get on an unpatched kernel.
On the patched kernel, all tests pass.

> open/test ............... ok   
> ptrace/test ............. ok   
> readlink/test ........... ok   
> relabel/test ............ ok   
> rename/test ............. ok   
> rxdir/test .............. ok   
> sem/test ................ ok     
> setattr/test ............ ok   
> setnice/test ............ ok   
> shm/test ................ ok     
> sigkill/test ............ ok     
> stat/test ............... ok   
> sysctl/test ............. ok   
> task_create/test ........ ok   
> task_setnice/test ....... ok   
> task_setscheduler/test .. ok   
> task_getscheduler/test .. ok   
> task_getsid/test ........ ok   
> task_getpgid/test ....... ok   
> task_setpgid/test ....... ok   
> wait/test ............... ok   
> file/test ............... ok     
> ioctl/test .............. ok   
> capable_file/test ....... ok     
> capable_net/test ........ ok   
> capable_sys/test ........ ok   
> dyntrans/test ........... ok   
> dyntrace/test ........... ok   
> bounds/test ............. ok
> <<<<
> 
> When I run the test by hand using the command line below, the following 
> appears in the audit log:

Just FYI, you can more easily re-run the failed test just by running its
test script, e.g. ./nnp/test, rather than manually running individual
commands from it.

> 
>  # ls -Z checkcon
>  unconfined_u:object_r:test_nnp_bounded_exec_t:s0 checkcon
>  # ./execnnp runcon -t test_nnp_bounded_t ./checkcon test_nnp_bounded_t
>  runcon: ./checkcon: Permission denied
> 
> <<<<
> type=SELINUX_ERR msg=audit(1409261360.961:1953): op=security_compute_av 
> reason=bounds scontext=unconfined_u:unconfined_r:test_nnp_bounded_t:s0-
> s0:c0.c1023 tcontext=unconfined_u:object_r:test_nnp_bounded_exec_t:s0 
> tclass=file perms=entrypoint

Ok, so since your base policy does not allow unconfined_t entrypoint to
all file types, it was denied to test_nnp_bounded_t since it is bounded
by unconfined_t.

> type=AVC msg=audit(1409261360.961:1953): avc:  denied  { entrypoint } for  
> pid=15556 comm="runcon" path="/root/sources/selinux_testsuite-
> upstream/tests/nnp/checkcon" dev="vda3" ino=423593 
> scontext=unconfined_u:unconfined_r:test_nnp_bounded_t:s0-s0:c0.c1023 
> tcontext=unconfined_u:object_r:test_nnp_bounded_exec_t:s0 tclass=file 
> permissive=0
> type=SYSCALL msg=audit(1409261360.961:1953): arch=c000003e syscall=59 
> success=no exit=-13 a0=7fffd720e76c a1=7fffd720df50 a2=7fffd720df68 
> a3=6e5f747365743a72 items=0 ppid=4569 pid=15556 auid=0 uid=0 gid=0 euid=0 
> suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=4 comm="runcon" 
> exe="/usr/bin/runcon" subj=unconfined_u:unconfined_r:unconfined_t:s0-
> s0:c0.c1023 key=(null)
> <<<<
> 
> Unfortunately that is about as far as I'm going to be able to get today on 
> this, so I'm tossing this out hoping you'll have an answer before I can touch 
> this next.

It runs fine on Fedora 20.  I am guessing you are running on rawhide /
Fedora 21, and that this is a difference in your base policy.  Try this
patch for selinux-testsuite on top of the current one.




--------------060006000008070202010405
Content-Type: text/x-patch;
 name="0001-Explicitly-allow-unconfined_t-entrypoint-to-test_nnp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Explicitly-allow-unconfined_t-entrypoint-to-test_nnp.pa";
 filename*1="tch"

>From fb7a3f11041213e3babba1b7b65d8aff014799bc Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 29 Aug 2014 08:50:20 -0400
Subject: [PATCH] Explicitly allow unconfined_t entrypoint to
 test_nnp_bounded_exec_t.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_nnp.te | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policy/test_nnp.te b/policy/test_nnp.te
index 55eccd8..206882d 100644
--- a/policy/test_nnp.te
+++ b/policy/test_nnp.te
@@ -13,6 +13,7 @@ typebounds unconfined_t test_nnp_bounded_t;
 type test_nnp_bounded_exec_t;
 files_type(test_nnp_bounded_exec_t)
 domain_entry_file(test_nnp_bounded_t, test_nnp_bounded_exec_t)
+domain_entry_file(unconfined_t, test_nnp_bounded_exec_t)
 
 # Run it!  This should succeed on patched kernels, fail on old ones.
 unconfined_runs_test(test_nnp_bounded_t)
-- 
1.9.3


--------------060006000008070202010405--
