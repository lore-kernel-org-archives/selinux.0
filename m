Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA4GnNJK019317
 for <selinux@tycho.nsa.gov>; Wed, 4 Nov 2015 11:49:24 -0500
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id tA4Gn6fP032475
 for <selinux@tycho.nsa.gov>; Wed, 4 Nov 2015 11:49:06 -0500
Date: Wed, 4 Nov 2015 11:49:05 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <1451625304.2912505.1446655745278.JavaMail.zimbra@redhat.com>
In-Reply-To: <1722157580.2900002.1446655193117.JavaMail.zimbra@redhat.com>
Subject: selinux-testsuite: mmap execmod test failure on RHEL6.7 s390x
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I'm seeing one of mmap tests failing on RHEL6.7. Strange is that it
fails only on s390x, all other arches are PASSing.

setsebool allow_execmod is set to "0"
Running as user root with context unconfined_u:unconfined_r:unconfined_t:

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
dyntrace/test ........... ok   
dyntrans/test ........... ok   
bounds/test ............. ok     
mmap/test ............... 1/30 # Failed test 30 in mmap/test at line 105
#  mmap/test line 105 is: ok($result);
mmap/test ............... Failed 1/30 subtests 
unix_socket/test ........ ok   
inet_socket/test ........ ok   

>From mmap/test - this test is expected to fail:
$result = system "runcon -t test_no_execmod_t $basedir/mprotect_file_private_execmod $basedir/temp_file 2>&1";
ok($result);

>From strace.log:
...
open("./temp_file", O_RDONLY)           = 3
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0x3fffd7c3000
mprotect(0x3fffd7c3000, 4096, PROT_READ|PROT_EXEC) = 0

I opened a BZ against RHEL6.7 selinux-policy:
  Bug 1278058 - s390x fails mmap execmod test
  https://bugzilla.redhat.com/show_bug.cgi?id=1278058
but I'm not sure if it's the policy or the kernel. I couldn't find any
execmod exceptions while grepping policy sources on "s390".

Does anyone have any tips/hints how to debug this further?

Thanks,
Jan
