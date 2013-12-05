Message-ID: <52A0ED28.6050804@tycho.nsa.gov>
Date: Thu, 05 Dec 2013 16:16:24 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: Pavel Roschin <roshin@scriptumplus.ru>, selinux@tycho.nsa.gov
Subject: Re: avtab dense hash table
References: <20131205130431.7fe3c727.roshin@scriptumplus.ru>	 <52A08A87.2030009@tycho.nsa.gov> <1386258595.2469.18.camel@d30>
In-Reply-To: <1386258595.2469.18.camel@d30>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/05/2013 10:49 AM, Dominick Grift wrote:
> On Thu, 2013-12-05 at 09:15 -0500, Stephen Smalley wrote:
> 
>> So, first, originally the policy was much smaller.  I'm personally of
>> the view that people need to take a chainsaw to the refpolicy and look
>> to greatly coalesce domains/types
> 
> Could you please give some examples of existing types that you would
> merge or even remove and why. I might be able to find patterns in how
> you decide when its worth to merge types and when not in your opinion. I
> generally like the idea but i could use some inspiration. Where would
> you draw the line and why?

I have a tool for SE for Android (under external/sepolicy/tools -
sepolicy-analyze.c) that analyzes that policy for identical types and
reports them.  Also looks for redundant allow rules (allowed by
attribute and individually).  Unfortunately the type equivalence
analysis seems to take forever on Fedora policy since it does it by
first expanding the attributes; I have a patch to do it without
requiring full attribute expansion but that fails to identify some
cases.  apol also has a types relationship analysis facility that will
let you examine how two types compare, but only a pairwise basis.

We're also planning to extend sepolicy-analyze to not only report
equivalent types but also look for isomorphic types, as we otherwise
never see identical domains due to the unique entrypoint, tmpfs, and
similar relationships.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
