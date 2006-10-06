From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC PATCH] newrole suid breakdown
Date: Sat, 7 Oct 2006 03:37:36 +1000
Cc: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, jdesai@us.ibm.com
References: <452432FA.1060009@us.ibm.com> <200610060915.15441.russell@coker.com.au> <45268BD9.9050809@redhat.com>
In-Reply-To: <45268BD9.9050809@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610070337.40031.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 07 October 2006 03:01, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> > On Thursday 05 October 2006 23:57, Daniel J Walsh <dwalsh@redhat.com> 
wrote:
> >> Does the code continue to work correctly if I compile in AUDIT_LOG_PRIV
> >> and NAMESPACE_PRIV but run it without the setuid bit and as a normal
> >> user.  IE, We want the option to only set this setuid when in an MLS
> >> environment.  This is not required for targeted or strict policy
> >> machines.
> >
> > Who does "we" mean in this context?
> >
> > I would like to have newrole work with namespaces in a strict policy
> > environment!
>
> I am not denying you that right.  I am asking for the tool to continue
> working with or without setuid.

Without setuid means without poly-instantiation based on SE Linux context, 
which means that probably most strict policy systems won't be able to 
effectively use poly-instantiation.

> IE Don't force a setuid app on the OS, if I don't do pam_namespace or
> care about role auditing.

/usr/kerberos/bin/ksu is forced on the OS even though the vast majority of 
Fedora users will never use Kerberos.

/usr/sbin/ccreds_validate seems to always get installed even on systems that 
will never use network authentication (again the majority).

/usr/libexec/openssh/ssh-keysign is always installed even though it's 
generally recommended that you don't use host based authentication (and my 
observation is that almost no-one is using it).

The rsh package has three setuid root programs and again is almost never 
needed (in fact it's recommended that you don't have it for several reasons).


Without even trying I've found six setuid-root programs that are included in a 
fairly default install of Fedora and which are never needed by the vast 
majority of users.  I doubt that all six are as well audited as newrole.

It seems that the decision to force setuid programs on the OS has already been 
made.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
