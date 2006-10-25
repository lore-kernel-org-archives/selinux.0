Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <james.antill@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, "GeorgeC.Wilson" <ltcgcw@us.ibm.com>,
        selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <1161784251.667.28.camel@code.and.org>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
	 <1161722236.667.20.camel@code.and.org>
	 <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
	 <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1161784251.667.28.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 09:59:19 -0400
Message-Id: <1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-25 at 09:50 -0400, James Antill wrote:
> On Wed, 2006-10-25 at 08:22 -0400, Stephen Smalley wrote:
> 
> > To elaborate, as I understood it, seusers (managed via semanage login)
> > was to provide per-Linux-user authorizations for MLS/MCS ranges, while
> > multiple such Linux users might be mapped to a single SELinux user that
> > was authorized for the full system range.  The login-style programs
> > would then ensure that the range in the initial security context for the
> > Linux user's session was limited by the value defined in seusers, and
> > SELinux policy would subsequently ensure that processes in that session
> > can not escalate outside of that range via newrole -l (or other
> > mechanism).
> 
>  My understanding is that while security_check_context() allows it, the
> setexeccon() will fail. Which seemed to be good enough.

No, it won't.  Suppose that I have two Linux users A and B, with A
authorized for category c0 and B authorized for category c2 in seusers,
but both A and B are mapped to SELinux user U who is authorized for all
categories in the kernel policy.  The login-style programs are naturally
going to be authorized to transition to any of those contexts since they
have to deal with user logins at any level, so the setexeccon() will
succeed.  The SELinux security context will have U as the user identity,
so it will always be valid.  You need an explicit check.

> 
> > It isn't sufficient to check the validity of the context with the
> > user-supplied level, because from the kernel's POV, any level might be
> > authorized for the underlying SELinux user identity, whereas seusers
> > might have defined a more restricted range for the Linux user identity.
> > You need a check between the user-supplied level and the seusers-defined
> > value (more generally, this could be an avc_has_perm or
> > security_compute_av check between contexts containing those levels, and
> > the underlying policy could define a mlsconstrain on the corresponding
> > permission). 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
