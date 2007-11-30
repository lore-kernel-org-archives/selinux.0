Subject: Re: PATCH: peersid capability support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: tmiller@tresys.com, selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>
In-Reply-To: <1196439171.10720.70.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <200711291927.lATJRixF021978@rawhidevm-targeted.columbia.tresys.com>
	 <1196371475.24040.74.camel@moss-spartans.epoch.ncsc.mil>
	 <474F4A43.3050106@manicmethod.com>
	 <1196429668.10720.1.camel@moss-spartans.epoch.ncsc.mil>
	 <47502066.5090106@manicmethod.com>
	 <1196434083.10720.10.camel@moss-spartans.epoch.ncsc.mil>
	 <47502CED.2030607@manicmethod.com>
	 <1196439171.10720.70.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 11:41:25 -0500
Message-Id: <1196440885.10720.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-30 at 11:12 -0500, Stephen Smalley wrote:
> On Fri, 2007-11-30 at 10:31 -0500, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > On Fri, 2007-11-30 at 09:38 -0500, Joshua Brindle wrote:
> > >   
> > >> Stephen Smalley wrote:
> > >>     
> > >>> On Thu, 2007-11-29 at 18:24 -0500, Joshua Brindle wrote:
> > >>>   
> > >>>       
> > >>>> Stephen Smalley wrote:
> > >>>>     
> > >>>>         
> > >>>>> On Thu, 2007-11-29 at 14:27 -0500, tmiller@tresys.com wrote:
> > >>>>>   
> > >>>>>       
> > >>>>>           
> > >>>>>> This is a reworking of the peersid capability patch Joshua sent out
> > >>>>>> a few weeks ago.  This version requires added explicit declaration of
> > >>>>>> capabilities in the policy.
> > >>>>>>
> > >>>>>> I've used the same strings that Paul's kernel diff used (there is
> > >>>>>> currently just a single capability).
> > >>>>>>
> > >>>>>> Note that capability declarations are not limited to base.conf /
> > >>>>>> policy.conf as we would like to eventually get rid of the base vs. module
> > >>>>>> distinction.
> > >>>>>>     
> > >>>>>>         
> > >>>>>>             
> > >>>>> Taking the union of the capabilities at link time seems worrisome to me.
> > >>>>> I'd be more inclined to require equivalence or take the intersection.
> > >>>>>
> > >>>>>   
> > >>>>>       
> > >>>>>           
> > >>>> I strongly disagree. My vision was to be able to add a capability to the 
> > >>>> policy by inserting a policy module that enables the capability (and has 
> > >>>> associated policy). Making them an intersection or equivalence would 
> > >>>> require one to update every single module just to add a capability (or 
> > >>>> at least update the base if it is considered authoritative, which I was 
> > >>>> also trying to avoid).
> > >>>>     
> > >>>>         
> > >>> Joshua - think about it.  Let's say I write a policy module based on the
> > >>> new peer checks, and my base module was written in terms of the old
> > >>> network checks.  Now I link them together and get a policy that tells
> > >>> the kernel to use the new peer checks.  Voila!  My base policy breaks
> > >>> horrendously.
> > >>>   
> > >>>       
> > >> That is why I said the module being inserted would have the associated 
> > >> policy.
> > >>     
> > >
> > > That seems to violate modularity/encapsulation.
> > >
> > >   
> > >>  I don't believe policyrep is going to have a concept of base so 
> > >> we'd just be delaying the inevitable by restricting it to base now.
> > >>     
> > >
> > > It isn't a base vs. non-base issue.  You can certainly have every module
> > > declare the capabilities it requires/expects.  But taking the union is
> > > unsafe.  Module foo doesn't know what the rest of the modules on the
> > > system expect or what rules they contain.
> > >
> > > Requiring equivalence is the safest approach.
> > >   
> > 
> > Equivalence between every module? I don't see how this would possibly 
> > work in practice, how would audit2allow know what caps to include when 
> > it creates a new module? How would support for new caps come from a 
> > policy upgrade when there are local modules present that don't have them?
> 
> audit2allow would want to preserve the status quo - use the same set of
> capabilities as the existing policy.  Which could come by inspection of
> the existing policy or from some file in selinux-policy-devel.
> 
> policy upgrade with inconsistent caps has to either fail and require
> manual intervention or evict the obsolete modules.
> 
> Unioning helps with these situations how?

Let's see:
1) audit2allow wouldn't specify any caps or the null set, and just union
with the existing policy.  But that's no different than status quo
extraction of the existing set.
2) policy upgrade would take the union of the new policy caps and the
local modules caps, likely yielding a broken policy as far as local
modules are concerned.  Without a warning to the user.  Possibly as
severe as breaking all networking for some existing domains defined by
local or third party modules.  Meanwhile, the new policy can't know what
is in those local or third paty modules and thus can't automatically
include rules to enable them to work.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
