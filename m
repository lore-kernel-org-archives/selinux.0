Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1BL98Lf017964
	for <selinux@tycho.nsa.gov>; Fri, 11 Feb 2011 16:09:08 -0500
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1BL96f3003818
	for <selinux@tycho.nsa.gov>; Fri, 11 Feb 2011 21:09:07 GMT
Received: by iyj8 with SMTP id 8so2849961iyj.12
        for <selinux@tycho.nsa.gov>; Fri, 11 Feb 2011 13:09:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D559BA6.8020506@tresys.com>
References: <AANLkTi=WqUp8FFkqo7eooUUP7qLju=WQQyf6qWsd1+4E@mail.gmail.com>
	<4D40C42A.2080903@ak.jp.nec.com>
	<4D559BA6.8020506@tresys.com>
Date: Fri, 11 Feb 2011 22:09:05 +0100
Message-ID: <AANLkTines9S4PR-G2bX00CmV=4NUW3YGs67p4hp5WUBw@mail.gmail.com>
Subject: Re: libselinux: add selinux_status_* interfaces for /selinux/status
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: Steve Lawrence <slawrence@tresys.com>
Cc: KaiGai Kohei <kohei.kaigai@EU.NEC.COM>,
        SELinux-NSA <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> The patch looks okay to me, but I'm seeing unexpected behavior with the
> selinux_status_policyload(). For example, when running your sample
> status.c code, I get the following (I'm just calling load_policy after
> each line is printed):
>
>   # ./status
>   -- selinux kernel status page --
>   policyload = 0, enforcing = 1, deny_unknown = 0
>   policyload = 2, enforcing = 1, deny_unknown = 0
>   policyload = 3, enforcing = 1, deny_unknown = 0
>   policyload = 4, enforcing = 1, deny_unknown = 0
>
> policyload jumps from 0 to 2 when reloading policy the first time, but
> all other policy loads after that are incremented by 1, as expected. And
> it doesn't matter if it's using mmap or falls back to netlink. Same
> behavior in both cases.
>
> It doesn't look like the problem is in this patch, so I'm guessing this
> is a problem in the kernel? Or am I missing something and this is the
> correct behavior?
>
It is a specification, not a problem. :-)

See the manpage part of the patch. It says ...

| +.BR selinux_status_policyload
| +returns times of policy reloaded on the running system, or -1 on error.
| +Note that it is not a reliable value on fallback-mode until it receive
| +the first event message via netlink socket.
| +Thus, don't use this value to know actual times of policy reloaded.

When we use this interface with fallback mode, it opens a netlink socket
to receive messages from the kernel space.
The message packet will deliver userspace number of policy reloaded,
so it also means application cannot know the information until it receives
the first message packet.

As the manpage says, our recommendable usage of selinux_status_policyload()
on fall-back mode is detection of the policy reloaded event, not knowing
the actual number of policy reloaded in the system.

Of course, when /selinux/status is available, this interface always returns
the correct number.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
