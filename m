MIME-Version: 1.0
In-Reply-To: <1276201360.25808.183.camel@moss-pluto.epoch.ncsc.mil>
References: <AANLkTimi8y2fe1Wr0MKWfnx5WxwkCe9sNRqOOyVY1Qs5@mail.gmail.com>
	<1276198808.25808.179.camel@moss-pluto.epoch.ncsc.mil>
	<1276201360.25808.183.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 11 Jun 2010 10:29:39 +0500
Message-ID: <AANLkTimfP-YJ0ZEn5dEUMUw8FbvJa_qQyZPVU-6XkoMO@mail.gmail.com>
Subject: Re: Removing TE from the policy Model
From: Shaz <shazalive@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>,
        securityengineeringresearchgroup <securityengineeringresearchgroup@googlegroups.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 11, 2010 at 1:22 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Thu, 2010-06-10 at 15:40 -0400, Stephen Smalley wrote:
> > On Thu, 2010-06-10 at 23:57 +0500, Shaz wrote:
> > > Dear all,
> > >
> > > I have a mobile use case where TE is kind of too heavy ... if you
> > > remember from earlier threads that discussed the use case. Can I
> > > somehow use the SELinux infrastructure ... kernel and userspace to
> > > only use the rbac and uid models and leave out TE?
> > >
> > > How much is it going to take as a technical effort and some fine
> > > guidelines will be appreciated.
> > >
> > > Will it be called SELinux if we get it done in the first place?
> >
> > TE (the mechanism) isn't particularly heavy, so I presume you mean the
> > policy configuration for it.  There are multiple options there:
> > - You can build a subset of refpolicy, similar to what Fedora does in
> > its selinux-policy-minimum package.  That will certainly yield a smaller
> > policy than a full refpolicy, but there are some fundamental limitations
> > on what you can achieve using that approach.

Yes after some thinking I came to the same conclusion.

>
> > - You can construct your own policy from scratch, generating an initial
> > working one via scripts/selinux/mdp in the kernel source tree and then
> > expanding upon it.  That will yield the smallest possible policy.
> >

This seems the best option as far as I can understand.

> > - You could try the older SEEdit work by Hitachi Soft, although it isn't
> > being maintained anymore AFAIK.
>
> And just to highlight the range we're talking about in policy sizes:
> 13K  /etc/selinux/dummy/policy/policy.24
> 208K /etc/selinux/seedit/policy/policy.24
> 808K /etc/selinux/minimum/policy/policy.24
> 5.5M /etc/selinux/targeted/policy/policy.24
>
> where:
> dummy = minimal policy generated from kernel source tree,
> seedit = seedit base policy,
> minimum = selinux-policy-minimum (stripped down refpolicy)
> targeted = full targeted policy
>

Thanks Stephen.

> --
> Stephen Smalley
> National Security Agency
>



--
Shaz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
