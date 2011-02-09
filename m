Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p19E6X3c001506
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2011 09:06:34 -0500
Received: from cluster-a.mailcontrol.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p19E6VgP010551
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2011 14:06:32 GMT
Received: from rly06a.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly06a.srv.mailcontrol.com (MailControl) with ESMTP id p19E6SQn019648
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2011 14:06:29 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly06a.srv.mailcontrol.com (MailControl) id p19E5TIK010009
	for <selinux@tycho.nsa.gov>; Wed, 9 Feb 2011 14:05:29 GMT
From: Kohei Kaigai <Kohei.Kaigai@EU.NEC.COM>
To: SELinux-NSA <selinux@tycho.nsa.gov>
CC: Kohei KaiGai <kaigai@kaigai.gr.jp>
Date: Wed, 9 Feb 2011 14:05:22 +0000
Subject: RE: libselinux: add selinux_status_* interfaces for /selinux/status
Message-ID: <A9F5079BABDEE646AEBDB6831725762C4205A2356A@EUEXCLU01.EU.NEC.COM>
References: <AANLkTi=WqUp8FFkqo7eooUUP7qLju=WQQyf6qWsd1+4E@mail.gmail.com>
 <4D40C42A.2080903@ak.jp.nec.com>
In-Reply-To: <4D40C42A.2080903@ak.jp.nec.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How about getting inclusion of these patches that I submitted before?

Thanks,

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On Behalf Of KaiGai Kohei
> Sent: 27 January 2011 01:03
> To: SELinux-NSA
> Cc: Kohei KaiGai
> Subject: Re: libselinux: add selinux_status_* interfaces for
> /selinux/status
> 
> I updated my patch to reference /selinux/status entry.
> 
> The interface of selinux_status_open() and selinux_status_updated() was
> revised to eliminate an argument of 'last_seqlock' that holds a
> sequence value when we call this function last time.
> At first, I tried to give this storage externally for thread-safing,
> but fallback routine was not thread-safe anyway, so it became nonsense.
> 
> The attached status.c is an example program to call these APIs.
> 
> Any comments please. Thanks,
> 
> (2011/01/22 22:42), Kohei KaiGai wrote:
> > The attached patch adds several interfaces to reference
> > /selinux/status according to sequential-lock logic.
> >
> > selinux_status_open() open the kernel status page and mmap it with
> > read-only mode, or open netlink socket as a fallback in older kernels.
> >
> > Then, we can obtain status information from the mmap'ed page using
> > selinux_status_updated(), selinux_status_getenfoce(),
> > selinux_status_policyload() or selinux_status_deny_unknown().
> >
> > It enables to help to implement userspace avc with heavy access
> > control decision; that we cannot ignore the cost to communicate with
> > kernel for validation of userspace caches.
> >
> > Thanks,
> --
> KaiGai Kohei <kaigai@ak.jp.nec.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
