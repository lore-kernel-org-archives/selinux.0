Subject: Re: Are the reference policy abstractions the right ones?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: jwcart2@tycho.nsa.gov
Cc: Chad Sellers <csellers@tresys.com>, SELinux <selinux@tycho.nsa.gov>,
        Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <1192218818.28398.45.camel@moss-lions.epoch.ncsc.mil>
References: <C3351CCC.2EFE6%csellers@tresys.com>
	 <1192218818.28398.45.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 15:59:09 -0400
Message-Id: <1192219149.3294.54.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-12 at 15:53 -0400, James Carter wrote:
> On Fri, 2007-10-12 at 12:45 -0400, Chad Sellers wrote:

[...]

> > > 
> > > So - I'd like to hear from some other people. Are these ideas worth
> > > pursuing? The proposals:
> > > 
> > > 1) remove the distinction between attributes / types.
> > > 2) allow nested types / attributes.
> > > 3) type_class / type_group
> > > 4) exceptions
> > > 
> > I think these are all very nice features that could definitely come in
> > handy. But I'm not sure I see how they address our fundamental problems. I
> > agree with you guys that our fundamental problem is the leaky abstractions
> > in reference policy. I really don't see how these would solve that problem,
> > unless you're proposing that these would negate the need for any
> > abstractions. And I don't think that's what you're saying (or is it?).
> > 
> I am trying to argue that all resources are labeled with types, so it
> does no good to try and hide them.  While I don't want to see types used
> all over the policy like they were in the old example policy, a few here
> and there for inheritance or attribute purposes doesn't seem harmful.
> (Famous last words that will probably come back to haunt me.)
> 
> I am not arguing that we dump reference policy and get rid of
> interfaces.  I do, however, think that nested types and the ability to
> inherit with exceptions would give Chris and other policy developers the
> ability to write interfaces that fit the common case instead of having
> to target the lowest common denominator.  I just don't know how much
> they would help.
> 

That sounds about right to me - I think we should prototype the language
extensions and see what problems they solve. Then we can understand
better how they fit with the reference policy in its current form. I
thought the plan was to add language features to enable the reference
policy anyway. To me, we are just trying to take lessons learned from
the reference policy to continue to move it forward.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
