Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7OG2Eg6013875
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 12:02:14 -0400
Received: from mail-gy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7OG2Djv001666
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 16:02:13 GMT
Received: by gyg8 with SMTP id 8so1239660gyg.12
        for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 09:02:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
Date: Wed, 24 Aug 2011 12:02:13 -0400
Message-ID: <CACLa4pvMmx32JpX=vzOb8TvEqJ7HqTBVK=PNTFQjkiF924sMjA@mail.gmail.com>
Subject: Re: v0 Separate tunables from booleans
From: Eric Paris <eparis@parisplace.org>
To: Harry Ciao <qingtao.cao@windriver.com>
Cc: cpebenito@tresys.com, slawrence@tresys.com, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 23, 2011 at 6:08 AM, Harry Ciao <qingtao.cao@windriver.com> wrote:

> With this patchset, the size of policy.X would drop significantly from 600+k
> down to 322+k bytes(since most of tunables are default to false, and there is
> no else branch of most conditionals).

I should point out that I think you're off by one order of magnitude.
You went from a 6M policy to a 3.2M policy.  But still.

I decided to do a little playing with this yesterday in Fedora policy
(where Dan already DRASTICALLY reduced the policy size by changing
from type sets with removal to using all attributes.  My numbers
weren't quite as impressive as yours (and I'm not certain I did one
thing correctly)

Pre Patch:
        2148552 bytes    89383 allow rules    193 booleans
Post Patch (no policy changes)
        2166328 bytes    89383 allow rules    193 booleans
Post Patch WITH policy changes
        2031150 bytes    79685 allow rules    4 booleans

So our policy grows 0.8% with only the tools change.  Our policy
shrinks 5.5% with this change.  So it certainly doesn't look like bad
news.


I did have one problem with my testing however.
0002-user_ping-is-a-tunable-use-tunable_policy-for-it.patch doesn't
apply to Fedora.  I tried to fix it up by hand.  We actually have both
of the following lines inside that if (user_ping)
        netutils_domtrans_ping($1)
        allow $1 ping_t:process { signal sigkill };

I turned that into:
        tunable_policy(`user_ping',`
                netutils_domtrans_traceroute($1)
                allow $1 traceroute_t:process { signal sigkill };
        ')

But that resulted in an error which I didn't bother to figure out.
Maybe you can tell me what it is?

/usr/share/selinux/devel/include/system/modutils.if: Syntax error on
line 181095 ` [type=TICK]
/usr/share/selinux/devel/include/system/modutils.if: Syntax error on
line 181097 ' [type=SQUOTE]

It's also very possible that it comes from sepolgen-ifgen and it is
part of the fedora-ism that is setroubleshoot.....

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
