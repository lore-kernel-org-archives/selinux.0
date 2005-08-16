Subject: Re: pty / idr_remove problem persists
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1124134054.6379.53.camel@sgc>
References: <1124134054.6379.53.camel@sgc>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 08:49:56 -0400
Message-Id: <1124196596.29692.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-15 at 15:27 -0400, Christopher J. PeBenito wrote:
> Is anyone currently working on the pty/idr_remove problem?  The problem
> been around for a while, and it seems that more people may be hitting it
> lately, from what I've seen in the IRC channels.  Steve, you said here
> 
> http://marc.theaimsgroup.com/?l=selinux&m=111589787131836&w=2
> 
> that you weren't yet convinced that it was SELinux's fault.  Is this
> still the case?  From my experience, it seems to only be hit in
> enforcing, which really makes it sound like a SELinux problem.

Hi,

I recently spent some time looking into this bug, as the bug report
submitted by Russell Coker on linux-kernel back in February was
forwarded by Andrew Morton to me recently for resolution.

At least in the specific case reported by Russell, the issue was that
the policy allowed a process to access a devpts node (and thus inherit
the devpts node as its controlling tty) but did not allow the process to
search the devpts root directory.  This led to breakage when the process
attempted to re-open its controlling tty via /dev/tty, where
drivers/char/tty_io.c:tty_open calls init_dev calls
fs/devpts/inode.c:devpts_get_tty calls get_node calls lookup_one_len
which fails upon the search denial.  This leads to devpts_get_tty
returning NULL, which init_dev incorrectly interprets as meaning that
the tty is not already opened.  Thus, init_dev falls through to the
first time open code, creating an aliased object for the tty, which
leads to later problems.

I originally had thought that this was a non-SELinux bug; in particular,
that it just reflected a bug in the existing tty error handling code
that was simply being revealed by the SELinux denial.  That is a common
situation, where the introduction of MAC checks leads to exercising
error paths that are not normally encountered (but are still possible
even prior to the MAC checks) and thus reveals longstanding bugs in
those paths.  However, after tracing through the details, I am more
inclined to think that this particular case is a SELinux policy bug,
i.e. SELinux policy should always allow access to the devpts root
directory whenever it allows access to a devpts node.  The benefit of
allowing a process to inherit a controlling tty while preventing it from
opening another tty with the same type from the filesystem (by denying
search access to the containing directory) is small and doesn't
generalize to regular ttys (as you need at least search access to /dev
to open /dev/tty).  

Hence, my recommendation is that we classify this as a policy bug and
amend our policies accordingly, ensuring that access to devpts nodes is
always granted via macros that also allow search access to the devpts
root directory.

The alternative is to modify the kernel code to handle this situation
differently, but I don't think that is justified, and it isn't clear how
we should change the handling in the kernel.  If we altered
devpts_get_tty to propagate errors to the caller and altered init_dev to
bail upon errors, then the attempt to re-open the controlling tty would
still fail, so we would only avoid the idr_remove bug and not change the
fact that one needs search access to the devpts root to re-open the
controlling tty.  If we altered devpts_get_tty to somehow turn off LSM
checking for the devpts root for internal lookups by it, then that would
allow one to re-open the controlling tty without having search access to
the devpts root, but as noted above, that has little benefit and doesn't
generalize to regular ttys.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
