Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l08G1tR6025624
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 11:01:55 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l08G2huS017821
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 16:02:44 GMT
Subject: Re: [PATCH RFC 0/2] stricter MLS policy constraints
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Klaus Weidner <klaus@atsec.com>, selinux@tycho.nsa.gov
In-Reply-To: <458075BA.5030007@hp.com>
References: <20061212072825.GA3362@w-m-p.com> <458067B3.20107@hp.com>
	 <20061213214047.GC3362@w-m-p.com>  <458075BA.5030007@hp.com>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 11:02:43 -0500
Message-Id: <1168272163.12883.19.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-12-13 at 16:50 -0500, Paul Moore wrote:
> Klaus Weidner wrote:
> > On Wed, Dec 13, 2006 at 03:50:59PM -0500, Paul Moore wrote:
> > 
> >>The bad news is that I realized we never added NetLabel receive permissions to
> >>any of the application domains (try to telnet into a machine with NetLabel);
> >>only the user domains have the NetLabel receive permissions.  As a result I
> >>wasn't able to try any more elaborate tests without fixing the policy.  It will
> >>probably take a little while to get a patch out to address this as there are a
> >>lot of domains which need to be changed; that said I'm probably about a third of
> >>the way through at this point.
> >>
> >>In case anyone is interested, the policy changes boil down to the following:
> >>
> >> ifdef(`enable_mls',`
> >>        corenet_tcp_recv_netlabel(app_domain_t)
> >>        corenet_udp_recv_netlabel(app_domain_t)
> >> ')
> > 
> > 
> > Have you considered adding those lines to the existing interfaces in
> > policy/modules/kernel/corenetwork.if.in instead? For example, telnetd
> > currently uses corenet_tcp_sendrecv_all_if(telnetd_t), and you could make
> > that interface provide the needed netlabel rights also.
> 
> I did consider doing something similar but I figured sticking with the existing
> refpolicy convention was the going to be the path of least resistance and in the
> "userdom_basic_networking_template" code the corenet_* NetLabel permissions are
> kept separate from the rest of the corenet_* permissions.  It makes more sense
> conceptually too I think.

The thing is that we don't want to add unrelated permissions to
interfaces.  If you add extra rules, then the interface has side
effects, which is something we're trying to avoid in policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
