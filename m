Subject: Re: [RFC PATCH] newrole suid breakdown
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
In-Reply-To: <200610070337.40031.russell@coker.com.au>
References: <452432FA.1060009@us.ibm.com>
	 <200610060915.15441.russell@coker.com.au> <45268BD9.9050809@redhat.com>
	 <200610070337.40031.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 14:54:39 -0400
Message-Id: <1160160879.20202.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-10-07 at 03:37 +1000, Russell Coker wrote:
> On Saturday 07 October 2006 03:01, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > Russell Coker wrote:
> > > On Thursday 05 October 2006 23:57, Daniel J Walsh <dwalsh@redhat.com> 
> wrote:
> > >> Does the code continue to work correctly if I compile in AUDIT_LOG_PRIV
> > >> and NAMESPACE_PRIV but run it without the setuid bit and as a normal
> > >> user.  IE, We want the option to only set this setuid when in an MLS
> > >> environment.  This is not required for targeted or strict policy
> > >> machines.
> > >
> > > Who does "we" mean in this context?
> > >
> > > I would like to have newrole work with namespaces in a strict policy
> > > environment!
> >
> > I am not denying you that right.  I am asking for the tool to continue
> > working with or without setuid.
> 
> Without setuid means without poly-instantiation based on SE Linux context, 
> which means that probably most strict policy systems won't be able to 
> effectively use poly-instantiation.

Not sure I follow.  Dan just wants to be able to build a single newrole
binary that correctly handles both cases, and the default install to
leave newrole non-setuid.  That doesn't prevent another package or a
user from making newrole setuid and adjusting the libaudit.conf and/or
newrole pam config to enable/disable the desired auditing and namespace
behavior.  To use polyinstantiation at all, it is already the case that
you need to put pam_namespace into the pam configs of various programs
(not just newrole but login et al),
configure /etc/security/namespace.conf, and set
up /etc/security/namespace.init if necessary.

> Without even trying I've found six setuid-root programs that are included in a 
> fairly default install of Fedora and which are never needed by the vast 
> majority of users.  I doubt that all six are as well audited as newrole.

Keep in mind that newrole didn't start life as a setuid program, so it
wasn't written specifically from that perspective.   It was even fairly
limited wrt SELinux - it couldn't transition you to an arbitrary role
and domain, only one that you were already authorized for in the kernel
policy (vs. su, which can serve as the gateway from any uid to any uid).
The only real power it had was access to the tty/ptys.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
