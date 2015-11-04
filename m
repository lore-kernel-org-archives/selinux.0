Subject: Re: selinux-testsuite: mmap execmod test failure on RHEL6.7 s390x
To: Jan Stancek <jstancek@redhat.com>, selinux@tycho.nsa.gov,
 Paul Moore <paul@paul-moore.com>
References: <1451625304.2912505.1446655745278.JavaMail.zimbra@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <563A5AAB.5000802@tycho.nsa.gov>
Date: Wed, 4 Nov 2015 14:21:15 -0500
MIME-Version: 1.0
In-Reply-To: <1451625304.2912505.1446655745278.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/04/2015 11:49 AM, Jan Stancek wrote:
> Hi,
>
> I'm seeing one of mmap tests failing on RHEL6.7. Strange is that it
> fails only on s390x, all other arches are PASSing.
>
> setsebool allow_execmod is set to "0"
> Running as user root with context unconfined_u:unconfined_r:unconfined_t:
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
> dyntrace/test ........... ok
> dyntrans/test ........... ok
> bounds/test ............. ok
> mmap/test ............... 1/30 # Failed test 30 in mmap/test at line 105
> #  mmap/test line 105 is: ok($result);
> mmap/test ............... Failed 1/30 subtests
> unix_socket/test ........ ok
> inet_socket/test ........ ok
>
>>From mmap/test - this test is expected to fail:
> $result = system "runcon -t test_no_execmod_t $basedir/mprotect_file_private_execmod $basedir/temp_file 2>&1";
> ok($result);
>
>>From strace.log:
> ...
> open("./temp_file", O_RDONLY)           = 3
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0x3fffd7c3000
> mprotect(0x3fffd7c3000, 4096, PROT_READ|PROT_EXEC) = 0
>
> I opened a BZ against RHEL6.7 selinux-policy:
>    Bug 1278058 - s390x fails mmap execmod test
>    https://bugzilla.redhat.com/show_bug.cgi?id=1278058
> but I'm not sure if it's the policy or the kernel. I couldn't find any
> execmod exceptions while grepping policy sources on "s390".
>
> Does anyone have any tips/hints how to debug this further?

selinux-testsuite exercises the individual kernel permission checks 
using its own privately defined test domains and types, so a failure 
indicates a kernel bug or a bug in the test policy or test code, not a 
bug in the distribution policy package.  It could be that a change in 
the distribution policy has a side effect (e.g. allowing some permission 
to all domains that we are trying to test such that we cannot trigger a 
failure, as in this case), but the testsuite tries to work around such 
cases by setting any necessary global booleans for the test duration 
and/or custom defining the test domain in such a way that it does not 
inherit anything from the distribution policy.

The exec* checks can be disabled on certain architectures if they 
default to executable data but that would affect more than just execmod 
(and s390 does not default to executable data).

Can you check that execmod permission is NOT granted to test_no_execmod_t:
$ sesearch -AC -s test_no_execmod_t -p execmod

Can you confirm that the test program is not marked with executable 
stack flag:
$ execstack -q tests/mmap/mprotect_file_private_execmod

Otherwise, I think you need some kernel instrumentation / tracing to see
what is happening, particularly the selinux_file_mprotect() function.
