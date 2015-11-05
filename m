Date: Thu, 5 Nov 2015 10:45:48 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <1255732751.3581934.1446738348118.JavaMail.zimbra@redhat.com>
In-Reply-To: <563B69AD.1080708@tycho.nsa.gov>
References: <1451625304.2912505.1446655745278.JavaMail.zimbra@redhat.com>
 <563A5AAB.5000802@tycho.nsa.gov>
 <CAHC9VhTihxGX=7MPRxP+CQiOeXTqd7BGnhf+XJ10Fx4OwOiLZg@mail.gmail.com>
 <563A6F51.8090109@tycho.nsa.gov>
 <CAHC9VhQtfK2T8mnMcyd-+rwPmV6Xqw==DfWj0PJoxeecbipFHA@mail.gmail.com>
 <905415373.3482756.1446730031123.JavaMail.zimbra@redhat.com>
 <563B69AD.1080708@tycho.nsa.gov>
Subject: Re: selinux-testsuite: mmap execmod test failure on RHEL6.7 s390x
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>





----- Original Message -----
> From: "Stephen Smalley" <sds@tycho.nsa.gov>
> To: "Jan Stancek" <jstancek@redhat.com>, "Paul Moore" <paul@paul-moore.com>
> Cc: selinux@tycho.nsa.gov
> Sent: Thursday, 5 November, 2015 3:37:33 PM
> Subject: Re: selinux-testsuite: mmap execmod test failure on RHEL6.7 s390x
> 
> On 11/05/2015 08:27 AM, Jan Stancek wrote:
> >
> >
> >
> >
> > ----- Original Message -----
> >> From: "Paul Moore" <paul@paul-moore.com>
> >> To: "Stephen Smalley" <sds@tycho.nsa.gov>
> >> Cc: "Jan Stancek" <jstancek@redhat.com>, selinux@tycho.nsa.gov
> >> Sent: Wednesday, 4 November, 2015 10:51:15 PM
> >> Subject: Re: selinux-testsuite: mmap execmod test failure on RHEL6.7 s390x
> >>
> >> On Wed, Nov 4, 2015 at 3:49 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>> On 11/04/2015 03:32 PM, Paul Moore wrote:
> >>>>
> >>>> On Wed, Nov 4, 2015 at 2:21 PM, Stephen Smalley <sds@tycho.nsa.gov>
> >>>> wrote:
> >>>>>
> >>>>> selinux-testsuite exercises the individual kernel permission checks
> >>>>> using
> >>>>> its own privately defined test domains and types, so a failure
> >>>>> indicates
> >>>>> a
> >>>>> kernel bug or a bug in the test policy or test code, not a bug in the
> >>>>> distribution policy package.  It could be that a change in the
> >>>>> distribution
> >>>>> policy has a side effect (e.g. allowing some permission to all domains
> >>>>> that
> >>>>> we are trying to test such that we cannot trigger a failure, as in this
> >>>>> case), but the testsuite tries to work around such cases by setting any
> >>>>> necessary global booleans for the test duration and/or custom defining
> >>>>> the
> >>>>> test domain in such a way that it does not inherit anything from the
> >>>>> distribution policy.
> >>>>>
> >>>>> The exec* checks can be disabled on certain architectures if they
> >>>>> default
> >>>>> to
> >>>>> executable data but that would affect more than just execmod (and s390
> >>>>> does
> >>>>> not default to executable data).
> >>>>>
> >>>>> Can you check that execmod permission is NOT granted to
> >>>>> test_no_execmod_t:
> >>>>> $ sesearch -AC -s test_no_execmod_t -p execmod
> >>>>>
> >>>>> Can you confirm that the test program is not marked with executable
> >>>>> stack
> >>>>> flag:
> >>>>> $ execstack -q tests/mmap/mprotect_file_private_execmod
> >>>>>
> >>>>> Otherwise, I think you need some kernel instrumentation / tracing to
> >>>>> see
> >>>>> what is happening, particularly the selinux_file_mprotect() function.
> >>>>
> >>>>
> >>>> I have been working with Jan on this and it appears that the issue is
> >>>> due to the READ_IMPLIES_EXEC personality being set on the affected
> >>>> s390x kernels.
> >>>
> >>>
> >>> Hmmm...doesn't explain why only execmod failed - that should create
> >>> failures
> >>> for multiple tests.
> >>
> >> Yes, it turns out I spoke too soon.
> >
> > If I add a call to personality(0), the testcase can pass
> > (mprotect fails with EACCES):
> >
> > diff --git a/tests/mmap/mprotect_file_private_execmod.c
> > b/tests/mmap/mprotect_file_private_execmod.c
> > index ade1981..b2efa05 100644
> > --- a/tests/mmap/mprotect_file_private_execmod.c
> > +++ b/tests/mmap/mprotect_file_private_execmod.c
> > @@ -4,6 +4,7 @@
> >   #include <errno.h>
> >   #include <fcntl.h>
> >   #include <sys/mman.h>
> > +#include <sys/personality.h>
> >
> >   int main(int argc, char **argv)
> >   {
> > @@ -11,6 +12,9 @@ int main(int argc, char **argv)
> >          int rc;
> >          int fd;
> >
> > +
> > +       personality(0);
> > +
> >          if (argc != 2) {
> >                  fprintf(stderr, "usage: %s file\n", argv[0]);
> >                  exit(1);
> >
> > (strace log)
> > ...
> > [pid  2976] 08:21:53.928872 personality(PER_LINUX) = 4194304
> > [pid  2976] 08:21:53.936870 open("./temp_file", O_RDONLY) = 3
> > [pid  2976] 08:21:53.936898 mmap(NULL, 4096, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE, 3, 0) = 0x3fffd4fa000
> > [pid  2976] 08:21:53.936925 mprotect(0x3fffd4fa000, 4096,
> > PROT_READ|PROT_EXEC) = -1 EACCES (Permission denied)
> >
> > (strace log from original)
> > ...
> > [pid  3165] 08:24:31.480187 open("./temp_file", O_RDONLY) = 3
> > [pid  3165] 08:24:31.480294 mmap(NULL, 4096, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE, 3, 0) = 0x3fffd196000
> > [pid  3165] 08:24:31.480318 mprotect(0x3fffd196000, 4096,
> > PROT_READ|PROT_EXEC) = 0
> >
> > # uname -r
> > 2.6.32-584.el6.s390x
> >
> > # cat /etc/redhat-release
> > Red Hat Enterprise Linux Server release 6.7 (Santiago)
> 
> Hmm...you have no similar issue with mprotect_stack or mprotect_heap?  I

No, these work as expected. systemtap trace shows that
vma->vm_flags doesn't contain VM_EXEC:

mprotect_heap selinux_file_mprotect vma=0x789e7680 reqprot=0x5 prot=0x5, flags: 100073
mprotect_heap selinux_file_mprotect return=0xfffffffffffffff3

Here is a strace log of "runcon -t test_execmem_t $basedir/mprotect_heap":

[pid  4775] 10:31:59.987008 brk(0)      = 0xb824a000
[pid  4775] 10:31:59.987021 brk(0xb826d000) = 0xb826d000
[pid  4775] 10:31:59.987042 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
[pid  4775] 10:31:59.987060 rt_sigaction(SIGCHLD, NULL, {SIG_DFL, [], 0}, 8) = 0
[pid  4775] 10:31:59.987080 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid  4775] 10:31:59.987094 nanosleep({30, 0}, 0x3ffffaafed0) = 0 
  ^^ I added this sleep so I can capture /proc/pid/maps
[pid  4775] 10:32:29.987868 mprotect(0xb824b000, 4096, PROT_READ|PROT_EXEC) = -1 EACCES (Permission denied)

# cat /proc/4775/maps 
80000000-80001000 r-xp 00000000 fd:00 787427                             /root/selinux-testsuite-my/tests/mmap/mprotect_heap
80001000-80002000 rwxp 00000000 fd:00 787427                             /root/selinux-testsuite-my/tests/mmap/mprotect_heap
b824a000-b826d000 rw-p 00000000 00:00 0                                  [heap]
4a9261f000-4a92640000 r-xp 00000000 fd:00 268803                         /lib64/ld-2.12.so
4a92640000-4a92641000 r-xp 00020000 fd:00 268803                         /lib64/ld-2.12.so
4a92641000-4a92642000 rwxp 00021000 fd:00 268803                         /lib64/ld-2.12.so
4a92642000-4a92643000 rw-p 00000000 00:00 0 
4a92649000-4a927f9000 r-xp 00000000 fd:00 268804                         /lib64/libc-2.12.so
4a927f9000-4a927fd000 r-xp 001af000 fd:00 268804                         /lib64/libc-2.12.so
4a927fd000-4a927fe000 rwxp 001b3000 fd:00 268804                         /lib64/libc-2.12.so
4a927fe000-4a92803000 rwxp 00000000 00:00 0 
3fffd6b4000-3fffd6b6000 rwxp 00000000 00:00 0 
3fffd6c3000-3fffd6c6000 rwxp 00000000 00:00 0 
3fffd6c6000-3fffd6c8000 r-xp 00000000 00:00 0                            [vdso]
3ffffa9c000-3ffffab1000 rw-p 00000000 00:00 0                            [stack]

# cat /proc/4775/personality 
00400000

Regards,
Jan

> guess mprotect_file_private_rx and mprotect_file_private_rwx aren't
> affected because we always apply the file execute check even if the
> mapping is already executable, and likewise for mprotect_anon_* and
> execmem.  Only the checks directly in selinux_file_mprotect() are gated
> by a !(vma->vm_flags & VM_EXEC) test; the ones in file_map_prot_check()
> that are shared with the mmap hook are unconditional.
> 
> What does /proc/self/maps look like?
> 
> 
