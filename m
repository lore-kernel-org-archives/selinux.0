Subject: Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1162306839.31104.23.camel@code.and.org>
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
Content-Type: text/plain
Date: Tue, 31 Oct 2006 10:11:35 -0500
Message-Id: <1162307495.32614.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-31 at 10:00 -0500, James Antill wrote:
> On Tue, 2006-10-31 at 09:24 -0500, Stephen Smalley wrote:
> > On Tue, 2006-10-31 at 09:23 -0500, Stephen Smalley wrote:
> > > 
> > > In addition to the permission name, I'd have expected the rule (and the
> > > check in the code) to always use the same type in both contexts, so the
> > > rules could just be:
> > > 	allow $1 self:context <permissionname>;
> > > 
> > > Not allow $1 domain:context, which will yield many more rules without
> > > any real justification.
> 
>  Ok, I can fix that to be just self:context.
> 
> > I'm also unclear as to what you are checking - you seem to be putting
> > this in authlogin, but I had expected this to be a check between two
> > user contexts, identical in all respects except for the MLS ranges (one
> > from seusers, one from the user-supplied input).
> 
>  AIUI the code in authlogin allows all of the login type programs (like
> getty) to call the check. The check being performed is in policy/mls and
> is just:
> 
> mlsconstrain context transition
>        ( h1 dom h2 );
> 
> ...have I misunderstood this?

As I understood it (and the code in pam seems to match this), you were
going to generate two security contexts for the user session, one based
on seusers and one based on the provided range, otherwise identical in
all respects, and apply a permission check between those two contexts.
So for example, if my seusers-defined default context would be
staff_u:staff_r:staff_t:s0-s0:c0.c255 and I entered a level of s0:c3 as
input, there would be a permission check made by pam_selinux between
staff_u:staff_r:staff_t:s0-s0:c0.c255 and staff_u:staff_r:staff_t:s0:c3.
Thus, the TE rule would have to be between staff_t and itself (i.e. the
user domains), not between local_login_t and anything.

We aren't checking whether login can do anything (or using its context
anywhere); we are checking whether the seusers-defined default context
for the user contains the user-supplied context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
