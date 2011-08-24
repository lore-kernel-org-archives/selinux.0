Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7OHsTLi012987
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 13:54:30 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7OHsTCT000017
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 17:54:29 GMT
Message-ID: <4E553A4F.8000707@manicmethod.com>
Date: Wed, 24 Aug 2011 13:52:15 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Harry Ciao <qingtao.cao@windriver.com>, slawrence@tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: v0 Separate tunables from booleans
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <4E553731.20600@tresys.com>
In-Reply-To: <4E553731.20600@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On 08/23/11 06:08, Harry Ciao wrote:
>> Comments
>> ---------
>> Separate tunables from booleans.
>>
>> The effective branch of an if-else conditional that controlled by a tunable
>> should be expanded and registered to te_avtab hashtab permanently; while the
>> whole if-else conditional that controlled by a boolean should be expaned and
>> registered to te_cond_avtab hashtab as normal.
>>
>> Also nearly all tunables(exceptions see below) would be discarded from
>> policy.X.
>>
>> With this patchset, the size of policy.X would drop significantly from 600+k
>> down to 322+k bytes(since most of tunables are default to false, and there is
>> no else branch of most conditionals).
>>
>> Note, so far some tunable would be used along with some boolean in the
>> tunable_policy() macro(say pppd_can_insmod), this is not recommended and such
>> tunable would have to be transformed as boolean.
>
> I'd say that this is a good first step, but I think it has a problem.
> It has the same limitations as conditional policy, since you're reusing
> those data structures.  I'd like to be able to put more in tunables than
> can be put in conditional policy blocks, such as rbac (role, role allow,
> role_transition) statements and typeattributes statements.
>

I'm with Chris on this one. CIL implements tunables as switchable blocks where 
you can have anything in them you could have in a regular block (declarations, 
modifiers, rules, etc). This isn't a big deal because CIL tunables will never 
make it into the policy.XX either.

However, it does mean that tunables will be different things within not very 
much time (hopefully anyway) and it doesn't address the major thing we wanted 
tunables to do, which was allow declarations.

IMHO if the above numbers are correct and there is really a 50% reduction in 
size this is certainly worth doing now, just for that, with the understanding 
that CIL tunables are going to be the desired solution. How confusing this will 
be to uses remains to be seen.

It would be much more work to do this with the current toolchain but it isn't 
hard to conceptualize. Basically add a tunable table to the required index in 
avrule_block_t and start a new block when you encounter an if(). I don't think 
the amount of work it would require is justified given that we are actively 
trying to deprecate the module format.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
