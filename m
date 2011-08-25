Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7P6H1pk014591
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 02:17:01 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7P6H0cB028865
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 06:17:00 GMT
Message-ID: <4E55E8E7.1050804@windriver.com>
Date: Thu, 25 Aug 2011 14:17:11 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: <cpebenito@tresys.com>, <slawrence@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: v0 Separate tunables from booleans
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <CACLa4pvMmx32JpX=vzOb8TvEqJ7HqTBVK=PNTFQjkiF924sMjA@mail.gmail.com>
In-Reply-To: <CACLa4pvMmx32JpX=vzOb8TvEqJ7HqTBVK=PNTFQjkiF924sMjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Eric,

Eric Paris 写道:
> On Tue, Aug 23, 2011 at 6:08 AM, Harry Ciao <qingtao.cao@windriver.com> wrote:
>
>   
>> With this patchset, the size of policy.X would drop significantly from 600+k
>> down to 322+k bytes(since most of tunables are default to false, and there is
>> no else branch of most conditionals).
>>     
>
> I should point out that I think you're off by one order of magnitude.
> You went from a 6M policy to a 3.2M policy.  But still.
>
> I decided to do a little playing with this yesterday in Fedora policy
> (where Dan already DRASTICALLY reduced the policy size by changing
> from type sets with removal to using all attributes.  My numbers
> weren't quite as impressive as yours (and I'm not certain I did one
> thing correctly)
>
> Pre Patch:
>         2148552 bytes    89383 allow rules    193 booleans
> Post Patch (no policy changes)
>         2166328 bytes    89383 allow rules    193 booleans
> Post Patch WITH policy changes
>         2031150 bytes    79685 allow rules    4 booleans
>
> So our policy grows 0.8% with only the tools change.  Our policy
> shrinks 5.5% with this change.  So it certainly doesn't look like bad
> news.
>
>
>   
No problem. I am using refpolicy from tresys tree and I have applied my
test patch to introduce a new keyword of "tunable" and change
tunable_policy() to use this tunable keyword rather than the current
"bool" keyword. Since your number of booleans has jumped from 193 down
to 4, you must have applied this patch correctly :-)

Since most tunables declared by tunable_policy() would default to false
and most of these tunable_policy() just has one if branch, then in
practice none rules would ever be expanded and written to raw policy for
them, that's why I have witnessed a significant drop from 6M to 3.22M.

So I could only guess in Fedora policy perhaps most tunables default to
true, or many tunable conditionals have two branches, then the logically
true branch would be expanded as normal. By whatever, the size of
policy.X would decrease when all disabled branch of rules are discarded.

> I did have one problem with my testing however.
> 0002-user_ping-is-a-tunable-use-tunable_policy-for-it.patch doesn't
> apply to Fedora.  I tried to fix it up by hand.  We actually have both
> of the following lines inside that if (user_ping)
>         netutils_domtrans_ping($1)
>         allow $1 ping_t:process { signal sigkill };
>
> I turned that into:
>         tunable_policy(`user_ping',`
>                 netutils_domtrans_traceroute($1)
>                 allow $1 traceroute_t:process { signal sigkill };
>         ')
>
> But that resulted in an error which I didn't bother to figure out.
> Maybe you can tell me what it is?
>
>   
Sorry I have no idea what this error is. There is no "allow $1
ping_t/traceroute_t:process ..." rules in these two interface in tresys
refpolicy, but after added them exactly as yours above still no error
happens on my side.

Or could you pass me your patch to netutils.if after you've adopted my
original patch manually?

Thanks,
Harry


> /usr/share/selinux/devel/include/system/modutils.if: Syntax error on
> line 181095 ` [type=TICK]
> /usr/share/selinux/devel/include/system/modutils.if: Syntax error on
> line 181097 ' [type=SQUOTE]
>
> It's also very possible that it comes from sepolgen-ifgen and it is
> part of the fedora-ism that is setroubleshoot.....
>
> -Eric
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
