From: Jim Meyering <jim@meyering.net>
To: russell@coker.com.au
Cc: Valdis.Kletnieks@vt.edu, SELinux@tycho.nsa.gov
Subject: Re: infelicity in context_user_set; new syscalls: setfileconat, etc.?
In-Reply-To: <200607312235.24871.russell@coker.com.au> (Russell Coker's
	message of "Mon, 31 Jul 2006 22:35:20 +1000")
References: <87zmeslb2v.fsf@rho.meyering.net>
	<200607310458.k6V4wScX009997@turing-police.cc.vt.edu>
	<87odv6kw1v.fsf@rho.meyering.net>
	<200607312235.24871.russell@coker.com.au>
Date: Mon, 31 Jul 2006 15:27:08 +0200
Message-ID: <871ws1lxar.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au> wrote:

> On Monday 31 July 2006 18:39, Jim Meyering <jim@meyering.net> wrote:
>> > And I suspect that nobody's running an SELinux system with no /proc
>> > mounted (except on some *really* Martian-logic design for a Really Secure
>> > embedded system or something...)
>>
>> Let's assume that all properly-configured environments do mount /proc.
>
> Let's not, think of chroot environments.

These days, chroot environments seem more and more likely to require /proc.
That said, allowing openat et al to work even in a chroot without /proc
was one of the arguments for adding those functions to the kernel.

>> Are the required features[*] of /proc usable even in the most restrictive
>> environments?
>
> I doubt it at the moment.  But it wouldn't be difficult to enable these things
> for the rare cases where they are needed.

Is needing /proc so unusual, these days?  Even with glibc-2.4?
Quite a few glibc primitives are implemented to rely on those same
/proc features.

>> If so, then the only remaining argument for adding syscalls
>> is one of efficiency -- not very compelling.
>>
>> [*] The ability to access any FILE via /proc/self/fd/N/FILE,
>> where the directory containing FILE is open on file descriptor N.
>
> I believe that the real question is whether processes in restrictive
> environments such as chroot's need to do chcon -R operations anyway, and if
> they do whether they need to go to great depth.

In general, operating on deep hierarchies is only one benefit of using
the *at functions.  That paradigm also permits efficient (no O(N^2)
perf. hit) file system traversal (a la fts(1)) that is also thread safe.
Though of course, chcon doesn't care about thread safety.

> I have set up many chroot environments, many of which were so restrictive that
> they would not permit what you desire.  But I can't think of any of them
> having a need for deep chcon -R operations.
>
> Would it be possible to use the current functionality and only skip to the
> other type when the path depth is exceeded?

My working implementation degrades gracefully in all but some unusually
pathological cases.  I.e., when emulating a FOO*at function via /proc
fails, the implementation resorts to simulating it via
save_cwd/fchdir/FOO/restore_cwd, where save_cwd and restore_cwd are
in gnulib/coreutils' lib/save-cwd.c.  That emulation fails only when
save_cwd or restore_cwd fails, neither of which is likely in practice.
The classic failure case is when "." cannot be opened and getcwd fails.
As I said, unlikely.

If you want to see actual code before I check things in,
there are very similar bits in upstream CVS coreutils/lib/openat.c.
E.g., the fstatat function in that file:

  http://cvs.savannah.gnu.org/viewcvs/coreutils/lib/openat.c?root=coreutils&view=markup

In the upcoming coreutils-6.0, so far, the following tools already
use this sort of infrastructure: rm, du, chown, chmod, chgrp.
It makes them robust and bulletproof on systems with /proc or syscall
support for openat-style functions.  On deficient systems, the only
penalty is failure in unusual cases, as mentioned above.
So if you see a problem, please let me know.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
