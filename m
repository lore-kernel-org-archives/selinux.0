Subject: Re: [rfc] refpolicy user based separation
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <48528E71.3000301@manicmethod.com>
References: <48528E71.3000301@manicmethod.com>
Content-Type: text/plain
Date: Tue, 17 Jun 2008 11:04:32 -0400
Message-Id: <1213715072.2875.57.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-06-13 at 11:12 -0400, Joshua Brindle wrote:
> With the role based separation work being done an alternate idea was brought up here. Rather than going through the pain required for role based separation (kernel patches, policy format changes, incompatibility with older distros, long term refpolicy branch) we could do user based separation.
> 
> The work done on refpolicy to merge derived types is still necessary, and much of that work has been done. It just means that rather than separating user home dirs and user processes based on the role field it will be done on the user field. We believe that no kernel patches or format changes are necessary to do this.
> 
> Some advantages include less work, ofcourse. No incompatibility with older distros (eg., trunk refpolicy will still be usable on RHEL4/5). Some disadvantages are less flexibility, more difficult to separate roles given to the same user (TE policy with derived types would be necessary). It would be easy to use roles and users in a 1:1 mapping and force people to log out and back in to assume a new role, or to use sudo with context setting support (although that requires the selinux user identity to be non-immutable, which some have objected to)
> 
It does seem like the user-based separation would work and be easier to
implement, but it would be really nice to have the increased flexibility
in policy writing that the role-based separation changes would bring.
The goal of the Flask architecture is to provide policy flexibility, so
these changes would help us to better meet that goal.

It could be argued that if someone wants to add role-based separation
later, then the support could be added then, but considering that
changes are needed in both the policy toolchain and kernel, and there
are only a limited number of people that could probably make the
changes, it seems likely that no one would even attempt to write a
policy using role-based separation unless it was already supported in
the toolchain and kernel.

I think that policy flexibility is important enough to pursue the
role-based separation in refpolicy not only to make the mechanisms
available, but also to provide an example of how to use them.

> Some work would still need to be done in userspace, such as user attribute support in the module format and libsemanage, to be able to exempt separation for specific users.
> 
I think that user attributes are a good idea regardless -- more
flexibility.

Wouldn't a change in module format mean incompatibilities with older
distros?  They would need the newer toochain.  Or are you just talking
about compatibility with older kernels?

> Opinions?
> 
Flexibility is good.

> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
