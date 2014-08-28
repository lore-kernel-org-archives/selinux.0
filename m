Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7SLaZB9019745
 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2014 17:36:36 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so1362984qaj.35
 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2014 14:36:41 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2] selinux: Permit bounded transitions under NO_NEW_PRIVS
 or NOSUID.
Date: Thu, 28 Aug 2014 17:36:38 -0400
Message-ID: <35237187.pLesj1POuT@sifl>
In-Reply-To: <53EA692A.1030705@tycho.nsa.gov>
References: <1407173809-3477-1-git-send-email-sds@tycho.nsa.gov>
 <1781230.AAtiyApM3R@sifl> <53EA692A.1030705@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: SELinux-NSA <selinux@tycho.nsa.gov>, Andy Lutomirski <luto@amacapital.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, August 12, 2014 03:21:14 PM Stephen Smalley wrote:
> Attached is the patch for the selinux-testsuite,
> against git://git.selinuxproject.org/~serge/selinux-testsuite.
> Once it goes into a kernel I can make the test kernel version-specific
> and thus ensure it passes on old and new kernels.

I just applied the kernel patch to the SELinux next branch and ran the 
testsuite against it to ensure everything was okay and ran into the problems 
below:

<<<<
Running as user root with context unconfined_u:unconfined_r:unconfined_t

domain_trans/test ....... ok   
entrypoint/test ......... ok   
execshare/test .......... ok   
exectrace/test .......... ok   
execute_no_trans/test ... ok   
fdreceive/test .......... ok   
inherit/test ............ ok   
link/test ............... ok   
mkdir/test .............. ok   
msg/test ................ ok     
nnp/test ................ 1/4 # Test 1 got: "32256" (nnp/test at line 19)
#   Expected: "0"
#  nnp/test line 19 is: ok($result,0); #this should pass
# Test 2 got: "256" (nnp/test at line 23)
#   Expected: "0"
#  nnp/test line 23 is: ok($result,0); #this should pass
nnp/test ................ Failed 2/4 subtests 
open/test ............... ok   
ptrace/test ............. ok   
readlink/test ........... ok   
relabel/test ............ ok   
rename/test ............. ok   
rxdir/test .............. ok   
sem/test ................ ok     
setattr/test ............ ok   
setnice/test ............ ok   
shm/test ................ ok     
sigkill/test ............ ok     
stat/test ............... ok   
sysctl/test ............. ok   
task_create/test ........ ok   
task_setnice/test ....... ok   
task_setscheduler/test .. ok   
task_getscheduler/test .. ok   
task_getsid/test ........ ok   
task_getpgid/test ....... ok   
task_setpgid/test ....... ok   
wait/test ............... ok   
file/test ............... ok     
ioctl/test .............. ok   
capable_file/test ....... ok     
capable_net/test ........ ok   
capable_sys/test ........ ok   
dyntrans/test ........... ok   
dyntrace/test ........... ok   
bounds/test ............. ok
<<<<

When I run the test by hand using the command line below, the following 
appears in the audit log:

 # ls -Z checkcon
 unconfined_u:object_r:test_nnp_bounded_exec_t:s0 checkcon
 # ./execnnp runcon -t test_nnp_bounded_t ./checkcon test_nnp_bounded_t
 runcon: ./checkcon: Permission denied

<<<<
type=SELINUX_ERR msg=audit(1409261360.961:1953): op=security_compute_av 
reason=bounds scontext=unconfined_u:unconfined_r:test_nnp_bounded_t:s0-
s0:c0.c1023 tcontext=unconfined_u:object_r:test_nnp_bounded_exec_t:s0 
tclass=file perms=entrypoint
type=AVC msg=audit(1409261360.961:1953): avc:  denied  { entrypoint } for  
pid=15556 comm="runcon" path="/root/sources/selinux_testsuite-
upstream/tests/nnp/checkcon" dev="vda3" ino=423593 
scontext=unconfined_u:unconfined_r:test_nnp_bounded_t:s0-s0:c0.c1023 
tcontext=unconfined_u:object_r:test_nnp_bounded_exec_t:s0 tclass=file 
permissive=0
type=SYSCALL msg=audit(1409261360.961:1953): arch=c000003e syscall=59 
success=no exit=-13 a0=7fffd720e76c a1=7fffd720df50 a2=7fffd720df68 
a3=6e5f747365743a72 items=0 ppid=4569 pid=15556 auid=0 uid=0 gid=0 euid=0 
suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=4 comm="runcon" 
exe="/usr/bin/runcon" subj=unconfined_u:unconfined_r:unconfined_t:s0-
s0:c0.c1023 key=(null)
<<<<

Unfortunately that is about as far as I'm going to be able to get today on 
this, so I'm tossing this out hoping you'll have an answer before I can touch 
this next.

-- 
paul moore
www.paul-moore.com
