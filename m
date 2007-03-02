Message-ID: <45E84046.5030901@trustedcs.com>
Date: Fri, 02 Mar 2007 09:18:30 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Klaus Weidner <klaus@atsec.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] policy diffing of MLS levels/ranges
References: <1172774544.19169.61.camel@sgc.columbia.tresys.com>
In-Reply-To: <1172774544.19169.61.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> For the next release of SETools, we are working on diffing MLS
> components of the policy in the sediff/sediffx tools.  We're looking for
> some feedback on how a diff for a range should be done.
> 
> Say for example we have the range: s0:c1,c2 - s2:c0.c10
> 
> The policy has:
> * sensitivities s0 to s2, dominance in increasing numerical order
> * categories c0 to c10
> * each level allowed all categories
> 
> Then the policy is changed:
> * remove category c5
> * add sensitivity s1a between s1 and s2
> * level s1a allowed category set is c1,c2
> 
> How should the difference in the above range be represented?
> 
> Our current idea is to present a diff of each level in the range.  The
> diff for a level would show a level addition/removal if a sensitivity is
> added/removed (dominance changes would be shown in a difference
> section).  The level would be considered modified if categories are
> added/removed by changing the category set allowed for the level (via
> changing the level statement and/or adding/removing categories).  So the
> first question would be, what should the category set be for each level
> of a range?
> 
> We think it basically takes the top level's category set and uses it for
> each level, dropping categories if they're not allowed for a particular
> level.  However this doesn't really show that the minimal category set
> is c1 and c2.  One way might be to specially mark the minimal category
> set.  Another way might be to change setools' view of levels to instead
> be the sensitivity and all combinations of categories.  However this
> would quickly become overwhelming in a diff.  Other options would be to
> report a level diff if the endpoints in a grouping change (s0:c0.c10 in
> both the original and modified policy would not be reported as a change
> since c5 is inside c0.c10).  Taking that further we could not report the
> above as a diff since the endpoints of the range aren't different.
> 
> To make the above options clearer, here's how the outputs might look
> like:
> 
> 1) independent categories:
> 
> s0:c1,c2 - s2:c0.c10
> added levels:
>  + s1a: c1,c2
> modified levels:
>  * s0: c0,c1,c2,c3,c4,c6,c7,c8,c9,c10, -c5
>  * s1: c0,c1,c2,c3,c4,c6,c7,c8,c9,c10, -c5
>  * s2: c0,c1,c2,c3,c4,c6,c7,c8,c9,c10, -c5

This seems to show everything that is relevant in the most concise way.
>From this info, one can see the new category sets for each sensitivity and
it is up to the interpreter to figure out that s0:c0 is not valid due to
the original definition of the range - that seems within reason.

> 1a) independent categories with min category set indicated
> 
> s0:c1,c2 - s2:c0.c10
> added levels:
>  + s1a: (c1,c2)
> modified levels:
>  * s0: (c1,c2) c0,c3,c4,c6,c7,c8,c9,c10,-c5
>  * s1: (c1,c2) c0,c3,c4,c6,c7,c8,c9,c10,-c5
>  * s2: (c1,c2) c0,c3,c4,c6,c7,c8,c9,c10,-c5

I think the min category set can be inferred as stated above.

> 2) category combinations:
> 
> s0:c1,c2 - s2:c0.c10
> added levels:
>  + s1a: {c1,c2}
> modified levels:
>  * s0: -{c1,c2,c5}, -{c1,c2,c3,c5}, -{c1,c2,c3,c4,c5}, ....
>  * s1: -{c1,c2,c5}, -{c1,c2,c3,c5}, -{c1,c2,c3,c4,c5}, ....
>  * s2: -{c1,c2,c5}, -{c1,c2,c3,c5}, -{c1,c2,c3,c4,c5}, ....

This spells everything out, but the output may become so verbose that
it loses usefulness for visual inspection.

> 3) diff only for changes in each level's category endpoints, and
> added/removed levels:
> 
> s0:c1,c2 - s2:c0.c10
> added levels:
>  + s1a: c1,c2
> 
> 4) diff only for changes in the range's endpoints
> [no diff]
> 
> Suggestions?

So far, I like #1.  A modification of #4 could be to just note that the
levels included in the range have changed and refer them to the diff of
the mls definitions (sens, cats, levels) to determine the changes on their
own.  Maybe two levels of verbosity (#1 and the modified #4) would be most
helpful.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
