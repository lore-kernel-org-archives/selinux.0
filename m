Subject: Re: SELinux security and passed file descriptors
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: viro@ftp.linux.org.uk, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <8927.1188570735@redhat.com>
References: <1188487195.26572.351.camel@moss-spartans.epoch.ncsc.mil>
	 <10698.1188486734@redhat.com>  <8927.1188570735@redhat.com>
Content-Type: text/plain
Date: Fri, 31 Aug 2007 11:01:44 -0400
Message-Id: <1188572504.26572.459.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-08-31 at 15:32 +0100, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > That's how mandatory access control is supposed to work; otherwise, a
> > flaw in A can leak the descriptor to B at will in violation of security
> > policy.
> 
> Yeah, but by making it impossible to have the flaw, you've also made it
> impossible for A to validly pass to B a file descriptor B wouldn't otherwise
> be able to access directly, but should be able to access on behalf of A.

Let me say it again:  that's how mandatory access control is supposed to
work.  A program (or user) isn't supposed to be able to delegate access
under a mandatory policy.

> To put it another way, how does A now legitimately pass on to B the grant of
> rights A had on that specific file descriptor?

That would be discretionary, and therefore vulnerable to flawed and
malicious code.  That's the point.

> I don't think you can practically change the security attached to the file
> struct,

SELinux already ensures that a process cannot inherit or receive a
descriptor to which it isn't authorized access.  What isn't practical
about that?

> With respect to execve(), imagine that program A (a shell, say) opens a file
> to use as a stdout for program B, which it then proceeds to exec.  Imagine,
> however, the process's security label is changed during the exec of B and this
> disallows B from writing to its stdout.  Is this correct behaviour since it is
> differs depending on whether SELinux is in enforcing mode or not?  Or is there
> some way around this in SELinux?  (I presume this is what
> flush_unauthorized_files() does).

It is correct behavior to close the descriptor in that case, yes, and
that is what flush_unauthorized_files does.

> > And it has caught any number of bugs in applications as well as the kernel
> > where a descriptor is unwittingly leaked across exec.
> 
> Whilst that may make it a useful debugging tool, it doesn't necessarily make
> it a good policy.

It prevents unauthorized propagation of access rights in the system,
which is required to enforce a mandatory policy.

Suppose that we have two processes A and B, and A is allowed to send to
B but not vice versa (unidirectional channel, used to upgrade
information).  If A can send a descriptor to B and B can use the
descriptor based solely on A's credentials, then that unidirectional
channel can be leveraged to create a reverse channel via a file
descriptor passed across it, and now we have no information flow
control.

Suppose that we have a protected/trusted subsystem A that is responsible
for mediating all data flow to a given file, where A performs some kind
of checking or transformation (access control, encryption, sanitization,
whatever).  We want to ensure that only A can write to the file
directly, but we are fine with a client process B sending data to A to
be checked/transformed by A and then written to the file by A.  If A
leaks a descriptor to the file to B and B can use the descriptor solely
based on A's credentials, then B can now bypass the checking or
transform and we have no integrity protection there.

> Btw, surely selinux_file_receive() is redundant because all that it checks is
> whether B can naturally access the file, which surely read and write, etc,
> will check anyway.  OTOH, although it appears to be redundant, I suppose it
> eliminates the use of the file as soon as possible.

Closing the descriptor at the point of a transition/transfer (on exec or
receive) is more reliable and seems better from an error handling point
of view.  As I said, the read/write checks are more for revalidation to
handle file relabels and policy changes, and we'd be willing to replace
those with a revoke-based mechanism if one existed and could be used to
the same effect.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
