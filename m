Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8L2D4Ww020885
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2011 22:13:04 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8L2D2Hl029209
	for <selinux@tycho.nsa.gov>; Wed, 21 Sep 2011 02:13:03 GMT
Message-ID: <4E7947B2.6040602@windriver.com>
Date: Wed, 21 Sep 2011 10:10:58 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Eric Paris <eparis@redhat.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>
Subject: Re: Role attribute status
References: <4E78ABC7.1090306@tresys.com> <1316547014.6710.5.camel@localhost>
In-Reply-To: <1316547014.6710.5.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yep, as far as I know all implementations of role attribute support have
been checked in this Monday, including the one to remove role attributes
from downgraded modules or raw policy.

Any further problem just let me know, thanks!

Cheers,
Harry

Eric Paris 写道:
> On Tue, 2011-09-20 at 11:05 -0400, Christopher J. PeBenito wrote:
>   
>> What is the status of the role attribute support?  I've got an
>> implementation for Refpolicy, but I don't want to merge it until we're
>> fairly sure the bugs have been squashed.
>>     
>
> But we won't know about the bugs until you commit it!  Wee Catch-22.
>
> All of the code should be in master and should be working.  I'm making
> userspace move a lot faster than it used to, if we find something wrong,
> we'll get it fixed.
>
> -Eric
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
