Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8EHeVwu027778
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2012 13:40:31 -0400
Received: by wibhn17 with SMTP id hn17so87438wib.12
        for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2012 10:40:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50536933.8030009@tresys.com>
References: <50535A56.2010209@tresys.com>
	<1347641987.11029.65.camel@moss-pluto.epoch.ncsc.mil>
	<50536933.8030009@tresys.com>
Date: Fri, 14 Sep 2012 13:40:29 -0400
Message-ID: <CACLa4pvWVLfK=nqL4vsDHB1Mw8k=qbgXKZneyBXrsrpPens9mw@mail.gmail.com>
Subject: Re: policycoreutils build failure
From: Eric Paris <eparis@parisplace.org>
To: Pat McClory <pmcclory@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, eparis@redhat.com,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

9f78846a5f7a567e1c2277c7cd05558cd625a868 Seems to be the problem.  I
added the Fedora po Makefile, but forgot to remove the one part I
refuse to add upstream.  I will not commit selinux.tbl upstream (and
have to fight^Wwork with Dan to figure out a good way to handle it)

I'll remove the bad line from the makefile right now.

-Eric

On Fri, Sep 14, 2012 at 1:28 PM, Pat McClory <pmcclory@tresys.com> wrote:
> yes, that works for me.  however just running 'make' (no install) doesn't,
> for the same reason.
>
> looking at the policycoreutils/po/Makefile I see that the 'all' target has
> 'update-po' as a dependency, while 'install' does not.  When I try to run
> 'make update-po' in policycoreutils/po I see the same issue.
>
> pat mcclory
>
> On 09/14/2012 12:59 PM, Stephen Smalley wrote:
>>
>> On Fri, 2012-09-14 at 12:24 -0400, Pat McClory wrote:
>>>
>>> Hi Eric,
>>>
>>> I tried to build your latest upstream push, and I'm having trouble
>>> building policycoreutils:
>>>
>>> make[1]: Entering directory `/home/pmcclory/selinux/policycoreutils/po'
>>> make[1]: *** No rule to make target `../gui/selinux.tbl', needed by
>>> `policycoreutils.pot'.  Stop.
>>> make[1]: Leaving directory `/home/pmcclory/selinux/policycoreutils/po'
>>> make: *** [all] Error 1
>>>
>>> it looks like policycoreutils/gui/selinux.tbl is added in commit
>>> f237aac4506e398367575319e7c0e7741ff7bce0 in the queue branch, but isn't
>>> in master.
>>
>>
>> Did you clean your tree first?  Try a git clean -fdx and then building.
>> Works for me.
>>
>> cd selinux
>> git clean -fdx
>> make DESTDIR=~/obj install
>>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
