Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p27H8smm031665
	for <selinux@tycho.nsa.gov>; Mon, 7 Mar 2011 12:08:55 -0500
Received: from cluster-e.mailcontrol.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p27H8pgK016671
	for <selinux@tycho.nsa.gov>; Mon, 7 Mar 2011 17:08:52 GMT
Received: from rly67e.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly67e.srv.mailcontrol.com (MailControl) with ESMTP id p27H8UUg003318
	for <selinux@tycho.nsa.gov>; Mon, 7 Mar 2011 17:08:33 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly67e.srv.mailcontrol.com (MailControl) id p27H8FoB031107
	for <selinux@tycho.nsa.gov>; Mon, 7 Mar 2011 17:08:15 GMT
From: Kohei Kaigai <Kohei.Kaigai@EU.NEC.COM>
To: Steve Lawrence <slawrence@tresys.com>, Kohei KaiGai <kaigai@kaigai.gr.jp>
CC: SELinux-NSA <selinux@tycho.nsa.gov>
Date: Mon, 7 Mar 2011 17:07:59 +0000
Subject: RE: libselinux: add selinux_status_* interfaces for /selinux/status
Message-ID: <A9F5079BABDEE646AEBDB6831725762C4205C8829C@EUEXCLU01.EU.NEC.COM>
References: <AANLkTi=WqUp8FFkqo7eooUUP7qLju=WQQyf6qWsd1+4E@mail.gmail.com>
	<4D40C42A.2080903@ak.jp.nec.com>	<4D559BA6.8020506@tresys.com>
 <AANLkTines9S4PR-G2bX00CmV=4NUW3YGs67p4hp5WUBw@mail.gmail.com>
 <4D6D32B4.9050108@tresys.com>
In-Reply-To: <4D6D32B4.9050108@tresys.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I see, looks good then.
> 
> Acked-by: Steve Lawrence <slawrence@tresys.com>
> 
> Merged as of libselinux to 2.0.99
>
Thanks for your reviewing.

I also submitted the following patch:
  http://marc.info/?l=selinux&m=129429839717037&w=2

The db_language class represents procedural languages (such as pl/pgsql, ...)
that is already got into refpolicy, so please add libselinux this support also.

Thanks,
--
NEC Europe Ltd, Global Competence Center
KaiGai Kohei <kohei.kaigai@eu.nec.com>


> -----Original Message-----
> From: Steve Lawrence [mailto:slawrence@tresys.com]
> Sent: 1. März 2011 17:54
> To: Kohei KaiGai
> Cc: Kohei Kaigai; SELinux-NSA
> Subject: Re: libselinux: add selinux_status_* interfaces for
> /selinux/status
> 
> On 02/11/2011 04:09 PM, Kohei KaiGai wrote:
> >> The patch looks okay to me, but I'm seeing unexpected behavior with the
> >> selinux_status_policyload(). For example, when running your sample
> >> status.c code, I get the following (I'm just calling load_policy after
> >> each line is printed):
> >>
> >>    # ./status
> >>    -- selinux kernel status page --
> >>    policyload = 0, enforcing = 1, deny_unknown = 0
> >>    policyload = 2, enforcing = 1, deny_unknown = 0
> >>    policyload = 3, enforcing = 1, deny_unknown = 0
> >>    policyload = 4, enforcing = 1, deny_unknown = 0
> >>
> >> policyload jumps from 0 to 2 when reloading policy the first time, but
> >> all other policy loads after that are incremented by 1, as expected.
> And
> >> it doesn't matter if it's using mmap or falls back to netlink. Same
> >> behavior in both cases.
> >>
> >> It doesn't look like the problem is in this patch, so I'm guessing this
> >> is a problem in the kernel? Or am I missing something and this is the
> >> correct behavior?
> >>
> > It is a specification, not a problem. :-)
> >
> > See the manpage part of the patch. It says ...
> >
> > | +.BR selinux_status_policyload
> > | +returns times of policy reloaded on the running system, or -1 on error.
> > | +Note that it is not a reliable value on fallback-mode until it receive
> > | +the first event message via netlink socket.
> > | +Thus, don't use this value to know actual times of policy reloaded.
> >
> > When we use this interface with fallback mode, it opens a netlink socket
> > to receive messages from the kernel space.
> > The message packet will deliver userspace number of policy reloaded,
> > so it also means application cannot know the information until it receives
> > the first message packet.
> >
> > As the manpage says, our recommendable usage of
> selinux_status_policyload()
> > on fall-back mode is detection of the policy reloaded event, not knowing
> > the actual number of policy reloaded in the system.
> >
> > Of course, when /selinux/status is available, this interface always
> returns
> > the correct number.
> >
> > Thanks,
> 
> I see, looks good then.
> 
> Acked-by: Steve Lawrence <slawrence@tresys.com>
> 
> Merged as of libselinux to 2.0.99
> 
> 
> 
> 
> 
>  Click
> https://www.mailcontrol.com/sr/GWdwHubc7EzTndxI!oX7UmPeZu4sclqX2roie2u
> XDQj5Wf!gl9SlFfzJ+GRHJbN7WZXnCqumW0JTEf5tQBqpNg==  to report this email
> as spam.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
