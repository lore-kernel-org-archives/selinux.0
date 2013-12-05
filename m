Message-ID: <1386279472.2469.51.camel@d30>
Subject: Re: avtab dense hash table
From: Dominick Grift <dominick.grift@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Pavel Roschin <roshin@scriptumplus.ru>, selinux@tycho.nsa.gov
Date: Thu, 05 Dec 2013 22:37:52 +0100
In-Reply-To: <52A0ED28.6050804@tycho.nsa.gov>
References: <20131205130431.7fe3c727.roshin@scriptumplus.ru>
		 <52A08A87.2030009@tycho.nsa.gov> <1386258595.2469.18.camel@d30>
	 <52A0ED28.6050804@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2013-12-05 at 16:16 -0500, Stephen Smalley wrote:
> On 12/05/2013 10:49 AM, Dominick Grift wrote:
> > On Thu, 2013-12-05 at 09:15 -0500, Stephen Smalley wrote:
> > 
> >> So, first, originally the policy was much smaller.  I'm personally of
> >> the view that people need to take a chainsaw to the refpolicy and look
> >> to greatly coalesce domains/types
> > 
> > Could you please give some examples of existing types that you would
> > merge or even remove and why. I might be able to find patterns in how
> > you decide when its worth to merge types and when not in your opinion. I
> > generally like the idea but i could use some inspiration. Where would
> > you draw the line and why?
> 
> I have a tool for SE for Android (under external/sepolicy/tools -
> sepolicy-analyze.c) that analyzes that policy for identical types and
> reports them.  Also looks for redundant allow rules (allowed by
> attribute and individually).  Unfortunately the type equivalence
> analysis seems to take forever on Fedora policy since it does it by
> first expanding the attributes; I have a patch to do it without
> requiring full attribute expansion but that fails to identify some
> cases.  apol also has a types relationship analysis facility that will
> let you examine how two types compare, but only a pairwise basis.
> 
> We're also planning to extend sepolicy-analyze to not only report
> equivalent types but also look for isomorphic types, as we otherwise
> never see identical domains due to the unique entrypoint, tmpfs, and
> similar relationships.
> 

Thanks, But if i understand it correctly then types that have (roughly)
the same properties would be candidates for merger.

That could be processes (or files) with different properties ( but same
rules associated with them )

That would mean that a system could end up with various different
processes running in the same domain (thus they can in theory affect
each other)

The way i am approaching it is besides requiring types to have similar
properties that also the processes have similar properties

So for example merge all web servers if the policy is roughly the same.

My reasoning for this is that only one kind of web server runs on a
system at any given time (usually).

Another example all: all irc clients in the same domain because often
one kind of irc client is used on a system at any given time

I see that you are willing to take this further. If for example (stupid
example) a mail server would have the same properties (rules) as a web
server that would be a candidate for a merger. Even though the mail
server and the web server could run on a system at any given time. Thus
they could affect each other

For android that approach would work since seandroid also associates
unique categories to uids but this does not apply to regular Linux

Would you agree that a system like Fedora has different properties than
a system like seandroid?

It occurs to me that Fedora is much more general purpose whereas android
is a phone operating system.

I believe that there is a lot of room for improvement in reference
policy and i am willing to do the leg work to bring some change in this
regard. Consensus is not easy to achieve though. I could not even make
the case for getting nginx in the apache domain.

I hope that this thread can get a discussion going with regard to
simplifying the policy without compromising too much

Thank you for you reply


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
