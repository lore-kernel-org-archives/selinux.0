Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PCvITe002312
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 08:57:18 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PCvHPm006194
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 12:57:17 GMT
Message-ID: <4E56467C.10003@manicmethod.com>
Date: Thu, 25 Aug 2011 08:56:28 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: qingtao.cao@windriver.com
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, slawrence@tresys.com,
        selinux@tycho.nsa.gov
Subject: Re: v0 Separate tunables from booleans
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <4E553731.20600@tresys.com> <4E553A4F.8000707@manicmethod.com> <4E55DE34.2000609@windriver.com>
In-Reply-To: <4E55DE34.2000609@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Harry Ciao wrote:
> Joshua Brindle 写道:
>> Christopher J. PeBenito wrote:
<snip>>
> Hi Joshua,
>
> Honestly speaking I have become kinda confused. If tunable_policy()
> remains as if-else conditionals then what Chris has wanted is to expand
> all RBAC rules into cond_rule_def aside from just AVRULE_AV and
> AVRULE_TYPE rules.
>
> However, if tunable_policy() is to be implemented as a block, then
> what's the major difference between such "tunable block " and the blocks
> already created by optional_block()? The optional_block() already
> supports the else-branch, and only one of the two branches would take
> effect, also if its external requirement won't be satisfied, the whole
> block would not be enabled and skipped over during expansion, which
> sounds to me like a tunable which just has the if-branch and defaults to
> false.
>

Yes, it is close. We thought about making a tunable symbol and putting 
it in the require section of a block. Unfortunately it doesn't give us 
the expressions that conditionals do ( foo || bar ) so it still isn't 
ideal. Additionally you can't declare things in the else branch. We 
didn't know how to deal with this case:

optional {
	requires { type a; }
	type b;
	...
} else {
	requires { type c; }
	type d;
}

optional {
	requires { type b; }
	type c;
} else {
	requires { type d; }
	type b;
}

So we just punted on allowing declarations in the else block so Chris 
uses them very rarely.
	

> Anyway, it's good to know how tunable is handled in CIL, I would have
> better understanding once I get to know more about it.
>


There was just a release of the compiler, take a look :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
