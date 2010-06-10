Subject: Re: Removing TE from the policy Model
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shaz <shazalive@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>,
        securityengineeringresearchgroup <securityengineeringresearchgroup@googlegroups.com>
In-Reply-To: <1276198808.25808.179.camel@moss-pluto.epoch.ncsc.mil>
References: <AANLkTimi8y2fe1Wr0MKWfnx5WxwkCe9sNRqOOyVY1Qs5@mail.gmail.com>
	 <1276198808.25808.179.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 16:22:40 -0400
Message-ID: <1276201360.25808.183.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-06-10 at 15:40 -0400, Stephen Smalley wrote:
> On Thu, 2010-06-10 at 23:57 +0500, Shaz wrote:
> > Dear all,
> > 
> > I have a mobile use case where TE is kind of too heavy ... if you
> > remember from earlier threads that discussed the use case. Can I
> > somehow use the SELinux infrastructure ... kernel and userspace to
> > only use the rbac and uid models and leave out TE?
> > 
> > How much is it going to take as a technical effort and some fine
> > guidelines will be appreciated.
> > 
> > Will it be called SELinux if we get it done in the first place?
> 
> TE (the mechanism) isn't particularly heavy, so I presume you mean the
> policy configuration for it.  There are multiple options there:
> - You can build a subset of refpolicy, similar to what Fedora does in
> its selinux-policy-minimum package.  That will certainly yield a smaller
> policy than a full refpolicy, but there are some fundamental limitations
> on what you can achieve using that approach.
> 
> - You can construct your own policy from scratch, generating an initial
> working one via scripts/selinux/mdp in the kernel source tree and then
> expanding upon it.  That will yield the smallest possible policy.
> 
> - You could try the older SEEdit work by Hitachi Soft, although it isn't
> being maintained anymore AFAIK.

And just to highlight the range we're talking about in policy sizes:
13K  /etc/selinux/dummy/policy/policy.24
208K /etc/selinux/seedit/policy/policy.24
808K /etc/selinux/minimum/policy/policy.24
5.5M /etc/selinux/targeted/policy/policy.24

where:
dummy = minimal policy generated from kernel source tree,
seedit = seedit base policy,
minimum = selinux-policy-minimum (stripped down refpolicy)
targeted = full targeted policy

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
