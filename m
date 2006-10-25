Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <james.antill@redhat.com>
Cc: redhat-lspp@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        "GeorgeC.Wilson" <ltcgcw@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <1161803724.29689.57.camel@code.and.org>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
	 <1161722236.667.20.camel@code.and.org>
	 <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
	 <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1161784251.667.28.camel@code.and.org>
	 <1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>
	 <1161803724.29689.57.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 15:24:50 -0400
Message-Id: <1161804290.3987.388.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-25 at 15:15 -0400, James Antill wrote:
> On Wed, 2006-10-25 at 09:59 -0400, Stephen Smalley wrote:
> > On Wed, 2006-10-25 at 09:50 -0400, James Antill wrote:
> > >  My understanding is that while security_check_context() allows it, the
> > > setexeccon() will fail. Which seemed to be good enough.
> > 
> > No, it won't.  Suppose that I have two Linux users A and B, with A
> > authorized for category c0 and B authorized for category c2 in seusers,
> > but both A and B are mapped to SELinux user U who is authorized for all
> > categories in the kernel policy.  The login-style programs are naturally
> > going to be authorized to transition to any of those contexts since they
> > have to deal with user logins at any level, so the setexeccon() will
> > succeed.  The SELinux security context will have U as the user identity,
> > so it will always be valid.  You need an explicit check.
> 
>  Ok, I had assumed that "U" would always be different in this case. I
> think this update to the patch solves the problem ... it gets the list
> of valid roles/levels from get_ordered_context_list() (which I think is
> complete, but I'm not 100%) and compares what is entered against that.
>  I'm not 100% sure this is right (it means there would be huge lists
> returned for MCS, no?), but I don't see what else I can call that would
> validate the role/level-range for a specific login.

Sorry, no (at least based on that description - didn't receive the patch
itself).  get_ordered_context_list() et al are still interfaces based on
SELinux user identity.  What you need to do is to validate the
user-supplied level against the range returned by getseuserbyname(), and
the particular check needs to see whether the level is within the user's
authorized range.  Which gets into policy specifics, which is why I
suggested using a permission check via avc_has_perm or
security_compute_av, and letting policy define a mlsconstrain on it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
