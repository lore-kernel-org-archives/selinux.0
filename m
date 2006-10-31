Subject: Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1162310652.31104.46.camel@code.and.org>
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
	 <1161804290.3987.388.camel@moss-spartans.epoch.ncsc.mil>
	 <1161970810.29689.88.camel@code.and.org>
	 <1161974293.1306.167.camel@moss-spartans.epoch.ncsc.mil>
	 <1162238632.31104.11.camel@code.and.org>
	 <1162239394.31104.13.camel@code.and.org>
	 <1162304610.32614.24.camel@moss-spartans.epoch.ncsc.mil>
	 <1162304681.32614.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1162306839.31104.23.camel@code.and.org>
	 <1162307495.32614.47.camel@moss-spartans.epoch.ncsc.mil>
	 <1162310652.31104.46.camel@code.and.org>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 11:21:15 -0500
Message-Id: <1162311675.32614.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-31 at 11:04 -0500, James Antill wrote:
> On Tue, 2006-10-31 at 10:11 -0500, Stephen Smalley wrote:
> 
> > As I understood it (and the code in pam seems to match this), you were
> > going to generate two security contexts for the user session, one based
> > on seusers and one based on the provided range, otherwise identical in
> > all respects, and apply a permission check between those two contexts.
> > So for example, if my seusers-defined default context would be
> > staff_u:staff_r:staff_t:s0-s0:c0.c255 and I entered a level of s0:c3 as
> > input, there would be a permission check made by pam_selinux between
> > staff_u:staff_r:staff_t:s0-s0:c0.c255 and staff_u:staff_r:staff_t:s0:c3.
> 
>  This should all be true.
> 
> > Thus, the TE rule would have to be between staff_t and itself (i.e. the
> > user domains), not between local_login_t and anything.
> 
>  Right. Does the mlsconstrain line not do that?

The mlsconstrain line wasn't my concern - it was the TE rule.

> > We aren't checking whether login can do anything (or using its context
> > anywhere); we are checking whether the seusers-defined default context
> > for the user contains the user-supplied context.
> 
>  Right my understanding was that the policy line:
> 
> allow $1 domain:context transition
> 
> ...meant that the login program could make security call:
> 
>  security_compute_av(src, dst, SECCLASS_CONTEXT, CONTEXT__TRANSITION, &avd)

No.  The ability to make the security call is controlled by the
compute_av permission on the security class, and isn't based on the
individual contexts passed as arguments.  That would be:
	allow $1 security_t:security compute_av;
which has an interface:
	selinux_compute_access_vector($1)
which is already in authlogin.if.  No change required for allowing the
call to happen.

What you are instead trying to do is to define the _result_ of that
compute_av call based on its arguments, not whether it can be made by
login.  So the TE rule would go into userdomain.if and be of the form:
	allow $1 self:context <permissionname>;

The mlsconstrain statement is ok, as long as it is sufficient to check
the high levels and not impose any constraint on the low levels.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
