Subject: Re: [rfc] refpolicy user based separation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jwcart2@epoch.ncsc.mil
Cc: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1213727306.2875.133.camel@moss-lions.epoch.ncsc.mil>
References: <48528E71.3000301@manicmethod.com>
	 <1213715072.2875.57.camel@moss-lions.epoch.ncsc.mil>
	 <4857D67B.8050606@manicmethod.com>
	 <1213720834.32066.58.camel@moss-spartans.epoch.ncsc.mil>
	 <1213725519.2875.118.camel@moss-lions.epoch.ncsc.mil>
	 <1213726033.32066.69.camel@moss-spartans.epoch.ncsc.mil>
	 <1213727306.2875.133.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 17 Jun 2008 14:48:34 -0400
Message-Id: <1213728514.32066.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-06-17 at 14:28 -0400, James Carter wrote:
> On Tue, 2008-06-17 at 14:07 -0400, Stephen Smalley wrote:
> > On Tue, 2008-06-17 at 13:58 -0400, James Carter wrote:
> > > On Tue, 2008-06-17 at 12:40 -0400, Stephen Smalley wrote:
> > > > On Tue, 2008-06-17 at 11:21 -0400, Joshua Brindle wrote:
> > > > > James Carter wrote:
> > > > > > On Fri, 2008-06-13 at 11:12 -0400, Joshua Brindle wrote:
> > > > > >> With the role based separation work being done an alternate idea was brought up here. Rather than going through the pain required for role based separation (kernel patches, policy format changes, incompatibility with older distros, long term refpolicy branch) we could do user based separation.
> > > > > >>
> > > > > >> The work done on refpolicy to merge derived types is still necessary, and much of that work has been done. It just means that rather than separating user home dirs and user processes based on the role field it will be done on the user field. We believe that no kernel patches or format changes are necessary to do this.
> > > > > >>
> > > > > >> Some advantages include less work, ofcourse. No incompatibility with older distros (eg., trunk refpolicy will still be usable on RHEL4/5). Some disadvantages are less flexibility, more difficult to separate roles given to the same user (TE policy with derived types would be necessary). It would be easy to use roles and users in a 1:1 mapping and force people to log out and back in to assume a new role, or to use sudo with context setting support (although that requires the selinux user identity to be non-immutable, which some have objected to)
> > > > > >>
> > > > > > It does seem like the user-based separation would work and be easier to
> > > > > > implement, but it would be really nice to have the increased flexibility
> > > > > > in policy writing that the role-based separation changes would bring.
> > > > > > The goal of the Flask architecture is to provide policy flexibility, so
> > > > > > these changes would help us to better meet that goal.
> > > > > > 
> > > > > > It could be argued that if someone wants to add role-based separation
> > > > > > later, then the support could be added then, but considering that
> > > > > > changes are needed in both the policy toolchain and kernel, and there
> > > > > > are only a limited number of people that could probably make the
> > > > > > changes, it seems likely that no one would even attempt to write a
> > > > > > policy using role-based separation unless it was already supported in
> > > > > > the toolchain and kernel.
> > > > > > 
> > > > > > I think that policy flexibility is important enough to pursue the
> > > > > > role-based separation in refpolicy not only to make the mechanisms
> > > > > > available, but also to provide an example of how to use them.
> > > > > > 
> > > > > >> Some work would still need to be done in userspace, such as user attribute support in the module format and libsemanage, to be able to exempt separation for specific users.
> > > > > >>
> > > > > > I think that user attributes are a good idea regardless -- more
> > > > > > flexibility.
> > > > > > 
> > > > > > Wouldn't a change in module format mean incompatibilities with older
> > > > > > distros?  They would need the newer toochain.  Or are you just talking
> > > > > > about compatibility with older kernels?
> > > > > > 
> > > > > 
> > > > > The main objection to role based separation is that the kernel changes
> > > > > and policy changes which requires a long term reference policy branch
> > > > > to support the older distros. Toolchain changes are fine internally
> > > > > (eg., CLIP already has backported toolchain features), Dan has his own
> > > > > refpolicy branches for rhel4/5 so it won't matter to him.
> > > > > 
> > > > > >> Opinions?
> > > > > >>
> > > > > > Flexibility is good.
> > > > > 
> > > > > I couldn't disagree more. Flexibility for the sake of flexibility creates insane systems that noone can/wants to use (see: xml, sendmail, emacs)
> > > > > 
> > > > > One thing that occurred to me while talking about this is that neither
> > > > > 'user separation' or 'role separation' are real security goals. What
> > > > > are we _actually_ trying to accomplish here and which solution meets
> > > > > the requirements. Further, does the added flexibility of role based
> > > > > separation outweigh the its cost? These are the questions we need to
> > > > > answer I think.
> > > > 
> > > > As I understand it, we are trying to preserve the separation and
> > > > protection guarantees that we used to obtain via derived program domains
> > > > (e.g. user_crontab_t) and derived file types (e.g. user_home_t,
> > > > user_devpts_t) between different user roles in a more direct manner
> > > > based on the role or user fields themselves w/o requiring an explosion
> > > > in the type space.  Those goals were part of the original papers and
> > > > tech reports on the initial SELinux reference implementation and example
> > > > policy, particularly with regard to protecting the admin role from
> > > > interference by non-admin users.
> > > > 
> > > > In any event, I think we should be able to experiment with user based
> > > > separation in policy w/o any code changes at all initially, if I
> > > > understand correctly, since we can write constraints on user
> > > > equality/inequality already and if we need special handling for certain
> > > > user identities we can work around our current limitations by moving
> > > > those identities into the base module.  So performing some initial
> > > > experimentation in that area to better understand how well it works and
> > > > what else might be required seems reasonable and doesn't really cost us
> > > > anything.
> > > 
> > > Is there doubt whether the user-based separation would work?  I thought
> > > that the only question was if the role-based separation was too much
> > > work for what it would provide.  Which would imply that more work should
> > > be done in that direction to find out the actual cost.  If the
> > > user-based separation is pursued first, it seems likely that the
> > > role-based separation will never even be tried.
> > 
> > I don't think it requires much investment to try the user-based
> > separation -
> 
> I agree totally.  It is by far the easier solution for this problem,
> which means that role-based separation will never even be tried.
>
> >  it only involves some policy configuration work and then
> > experimentation on RHEL 5 and/or RHEL 4 to see whether it actually works
> > in practice there, 
> 
> Whether what actually works?  Removing the derived types and providing
> separation some other way?

Yes, to see whether we can achieve the desired separation using that
mechanism, and to see whether we run into other problems with using the
user field in this manner with existing kernel and userspace (where
userspace not only includes the core selinux userland but also the
support in other userland packages, whether modifications or new
components like pam_selinux).  So that we can know the real cost of that
approach.

> I would agree totally with the following:
> 1)  Remove the derived types using user-based separation
> 2)  Investigate the cost of adding role-based separation
> 3)  If not too costly, add role-based separation mechanism and convert
> the user-based separation to role-based (which shouldn't be too hard).
> 
> But I still fear that we will stop after step 1.

There are two costs to consider here:
- the cost of developing the support for the role-based separation.  We
have a sense of how much work is required to implement that support
based on Chris' earlier emails.
- the cost of maintaining a long term branch of refpolicy that uses this
role-based separation since it will never ever ever work on RHEL 4 or
RHEL 5 or Debian etch or Ubuntu 8.04 or any existing distro release as
it will require a new kernel.

The first cost is relatively minor in comparison to the second.

> > as one of the arguments for it is that it in theory
> > would allow refpolicy to continue to be used on those distros without a
> > separate long term branch.
> > 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
