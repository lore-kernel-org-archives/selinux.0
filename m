Subject: Re: logging question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Eric Moore <eemoore@fyndo.com>, SELinux@tycho.nsa.gov
In-Reply-To: <200510180752.34963.russell@coker.com.au>
References: <m33bn0az4a.fsf@eemoore.bcluster.njit.edu>
	 <1129567150.26309.154.camel@moss-spartans.epoch.ncsc.mil>
	 <200510180752.34963.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 07:56:06 -0400
Message-Id: <1129636566.2375.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-18 at 07:52 +1000, Russell Coker wrote:
> On Tuesday 18 October 2005 02:39, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > (In or out of enforcing mode).  What's the best way for me to get
> > > the kernel to log the appropriate messages somewhere?
> >
> > In 2.6, SELinux was converted over to using the native kernel audit
> > subsystem for logging its denials.  So:
> > - Does your kernel have auditing enabled (CONFIG_AUDIT=y)?  If not, time
> > to rebuild your kernel.
> 
> The Debian kernel binary packages are built with SE Linux enabled but auditing 
> disabled.  I have sent several messages to the relevant people about this 
> matter and had no positive response.  Several 2.6.x kernels have been 
> released in this state.

They may be concerned about the performance overhead of the audit
infrastructure, but most of that is from CONFIG_AUDIT_SYSCALL=y, not
just CONFIG_AUDIT=y, and SELinux only requires the latter to perform
basic auditing of permission denials (the former can be useful in
getting more information about the syscalls and is needed by auditd, but
not strictly by SELinux).

Other option is to make the #undef CONFIG_AUDIT case revert to using
printks like the original SELinux code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
