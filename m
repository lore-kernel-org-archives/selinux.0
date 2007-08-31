From: David Howells <dhowells@redhat.com>
In-Reply-To: <1188487195.26572.351.camel@moss-spartans.epoch.ncsc.mil>
References: <1188487195.26572.351.camel@moss-spartans.epoch.ncsc.mil> <10698.1188486734@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: SELinux security and passed file descriptors
Date: Fri, 31 Aug 2007 15:32:15 +0100
Message-ID: <8927.1188570735@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> That's how mandatory access control is supposed to work; otherwise, a
> flaw in A can leak the descriptor to B at will in violation of security
> policy.

Yeah, but by making it impossible to have the flaw, you've also made it
impossible for A to validly pass to B a file descriptor B wouldn't otherwise
be able to access directly, but should be able to access on behalf of A.

To put it another way, how does A now legitimately pass on to B the grant of
rights A had on that specific file descriptor?

I don't think you can practically change the security attached to the file
struct,

With respect to execve(), imagine that program A (a shell, say) opens a file
to use as a stdout for program B, which it then proceeds to exec.  Imagine,
however, the process's security label is changed during the exec of B and this
disallows B from writing to its stdout.  Is this correct behaviour since it is
differs depending on whether SELinux is in enforcing mode or not?  Or is there
some way around this in SELinux?  (I presume this is what
flush_unauthorized_files() does).

> And it has caught any number of bugs in applications as well as the kernel
> where a descriptor is unwittingly leaked across exec.

Whilst that may make it a useful debugging tool, it doesn't necessarily make
it a good policy.


Btw, surely selinux_file_receive() is redundant because all that it checks is
whether B can naturally access the file, which surely read and write, etc,
will check anyway.  OTOH, although it appears to be redundant, I suppose it
eliminates the use of the file as soon as possible.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
