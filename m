Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7P5VNX4013069
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 01:31:23 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7P5VMcB023292
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 05:31:22 GMT
Message-ID: <4E55DE34.2000609@windriver.com>
Date: Thu, 25 Aug 2011 13:31:32 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, <slawrence@tresys.com>,
        <selinux@tycho.nsa.gov>
Subject: Re: v0 Separate tunables from booleans
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <4E553731.20600@tresys.com> <4E553A4F.8000707@manicmethod.com>
In-Reply-To: <4E553A4F.8000707@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle 写道:
> Christopher J. PeBenito wrote:
>> On 08/23/11 06:08, Harry Ciao wrote:
>>> Comments
>>> ---------
>>> Separate tunables from booleans.
>>>
>>> The effective branch of an if-else conditional that controlled by a
>>> tunable
>>> should be expanded and registered to te_avtab hashtab permanently;
>>> while the
>>> whole if-else conditional that controlled by a boolean should be
>>> expaned and
>>> registered to te_cond_avtab hashtab as normal.
>>>
>>> Also nearly all tunables(exceptions see below) would be discarded from
>>> policy.X.
>>>
>>> With this patchset, the size of policy.X would drop significantly
>>> from 600+k
>>> down to 322+k bytes(since most of tunables are default to false, and
>>> there is
>>> no else branch of most conditionals).
>>>
>>> Note, so far some tunable would be used along with some boolean in the
>>> tunable_policy() macro(say pppd_can_insmod), this is not recommended
>>> and such
>>> tunable would have to be transformed as boolean.
>>
>> I'd say that this is a good first step, but I think it has a problem.
>> It has the same limitations as conditional policy, since you're reusing
>> those data structures. I'd like to be able to put more in tunables than
>> can be put in conditional policy blocks, such as rbac (role, role allow,
>> role_transition) statements and typeattributes statements.
>>
>
> I'm with Chris on this one. CIL implements tunables as switchable
> blocks where you can have anything in them you could have in a regular
> block (declarations, modifiers, rules, etc). This isn't a big deal
> because CIL tunables will never make it into the policy.XX either.
>
> However, it does mean that tunables will be different things within
> not very much time (hopefully anyway) and it doesn't address the major
> thing we wanted tunables to do, which was allow declarations.
>
> IMHO if the above numbers are correct and there is really a 50%
> reduction in size this is certainly worth doing now, just for that,
> with the understanding that CIL tunables are going to be the desired
> solution. How confusing this will be to uses remains to be seen.
>
> It would be much more work to do this with the current toolchain but
> it isn't hard to conceptualize. Basically add a tunable table to the
> required index in avrule_block_t and start a new block when you
> encounter an if(). I don't think the amount of work it would require
> is justified given that we are actively trying to deprecate the module
> format.
>
Hi Joshua,

Honestly speaking I have become kinda confused. If tunable_policy()
remains as if-else conditionals then what Chris has wanted is to expand
all RBAC rules into cond_rule_def aside from just AVRULE_AV and
AVRULE_TYPE rules.

However, if tunable_policy() is to be implemented as a block, then
what's the major difference between such "tunable block " and the blocks
already created by optional_block()? The optional_block() already
supports the else-branch, and only one of the two branches would take
effect, also if its external requirement won't be satisfied, the whole
block would not be enabled and skipped over during expansion, which
sounds to me like a tunable which just has the if-branch and defaults to
false.

Anyway, it's good to know how tunable is handled in CIL, I would have
better understanding once I get to know more about it.

Thanks,
Harry

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
