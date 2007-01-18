Subject: Re: [RFC] 0/4 - Hierarchal apache policy for reference policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45AFBF18.3080004@mentalrootkit.com>
References: <45AFA08F.9080602@tresys.com>
	 <45AFABC8.2050101@mentalrootkit.com> <45AFB433.1010309@tresys.com>
	 <45AFBF18.3080004@mentalrootkit.com>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 14:40:03 -0500
Message-Id: <1169149203.22731.358.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-18 at 13:40 -0500, Karl MacMillan wrote:
> Joshua Brindle wrote:
> > Karl MacMillan wrote:
> >> Joshua Brindle wrote:
> >>> This is an RFC for policy allowing management delegation through 
> >>> hierarchical types.
> >>>
> >>> Policy management often is handled by different administrators, based 
> >>> on the application or applications that are being governed. As a 
> >>> result, providing a means to delegate access to manage only certain 
> >>> aspects of policy is desirable, and can be accomplished using 
> >>> hierarchical types.
> >>>
> >>> The proof of concept apache policy module illustrates policy 
> >>> management delegation through hierarchical types. This example apache 
> >>> policy works together with an adds metapolicy to the apache module
> >>
> >> It's good to see progress on this and a real fleshed-out example. I 
> >> look forward to seeing the prototype policy server.
> >>
> >> I think the biggest hurdle to this gaining widespread use is the 
> >> length of the meta-policy, especially since it essentially repeats the 
> >> policy for the sub-types. Any ideas about how to shorten this policy?
> >>
> > 
> > nit: the meta-policy is short (5 lines). The policy itself is longer due 
> > to the propagation of rules to children types.
> > 
> 
> Fine - but that answer the question. Having to define container types 
> with a superset of the rules results in a much longer policy. I think 
> that it is going to be hard to convince people to add that policy.

Policy build could automatically generate the rules for the container
types from the child type rules, as long as they come from the same
source (e.g. all part of the base policy build, or all within the same
module).  Then you only need to explicitly state rules for the container
types for accesses that you wish to permit to externally defined
children.

> >> The other large issue, of course, is that this demonstrates how 
> >> invasive the policy changes are in order to support delegation. This 
> >> makes it very difficult for a policy admin to create a separate policy 
> >> module that a) places hierarchical restrictions on a set of types and 
> >> b) delegates administrative privileges to an admin type to make 
> >> changes to those types.
> >>
> > 
> > I'm not sure how desirable ad-hoc delegation is.
> 
> It is not ad-hoc, it is just not done by the distribution or upstream.
> 
>   Just like normal policy
> > meta policy needs to be well thought out in order to meet specific 
> > security goals (and do so without allowing bypass, etc).
> > 
> 
> Sure, but that doesn't mean that an administrator can't do this. The 
> upstream refpolicy and / or distributions cannot meet all of the users 
> needs - I'm just suggesting that we make it possible for people to do 
> customization. It is their responsibility to do a good job at that point.
> 
> The alternative (take what is given or leave it) is not very attractive 
> if it doesn't meet your needs.

Agreed; we need to leave the choice in the user's hands, and just
provide them with good tooling for making informed choices.  We can't
predict all the different ways in which real admins will want to
delegate.

> >> My guess is that for real administrative roles to become viable in 
> >> SELinux they are going to be largely site-defined in loadable modules 
> >> (and the work at RH along those lines is using that as a starting 
> >> assumption). So some way to support that seems necessary. At the very 
> >> least I think that decoupling the hierarchical restrictions from the 
> >> identifier names is needed. This also makes hierarchy work better with 
> >> reference policy scoping.
> >>
> > 
> > I don't know if I believe this, all of our experience with making 
> > administrative roles is that it is difficult, we know, for example, that 
> > the secadm and sysadm roles are hardly separate and there are trivial 
> > bypasses that the sysadm role can use to gain secadm type access.
> > 
> 
> I don't think that secadm and sysadm are representative because they 
> both end up touching files / processes that could potentially allow 
> bypass. Allowing an admin to only run adduser or write to web pages is 
> much simpler.
> 
> Just because it is hard doesn't mean that it shouldn't be possible to be 
> done by admins.

Agreed.

> > Decoupling the hierarchy from the identifier seems like it would make 
> > understanding the hierarchy and the resulting metapolicy very difficult.
> > 
> 
> I'm not certain that determining the hierarchy tree is the limiting 
> factor in terms of understandability.

Particularly with appropriate tooling to make the tree visible.

> Much more important to me is that it means that customization will 
> almost always require changes to the original policy. I just don't think 
> that is supportable.

Yes, that is presently a real obstacle to e.g. implementing roles at a
site.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
