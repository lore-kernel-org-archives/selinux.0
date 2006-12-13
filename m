Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBDLeFaD025195
	for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2006 16:40:15 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBDLekEY017781
	for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2006 21:40:47 GMT
Date: Wed, 13 Dec 2006 15:40:48 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH RFC 0/2] stricter MLS policy constraints
Message-ID: <20061213214047.GC3362@w-m-p.com>
References: <20061212072825.GA3362@w-m-p.com> <458067B3.20107@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <458067B3.20107@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 13, 2006 at 03:50:59PM -0500, Paul Moore wrote:
> I did a quick test using the refpolicy from SVN and your patches; the good news
> is that simple tests using netcat worked as expected and there did not appear to
> be any regressions.

Glad to hear that, thanks for testing!

> The bad news is that I realized we never added NetLabel receive permissions to
> any of the application domains (try to telnet into a machine with NetLabel);
> only the user domains have the NetLabel receive permissions.  As a result I
> wasn't able to try any more elaborate tests without fixing the policy.  It will
> probably take a little while to get a patch out to address this as there are a
> lot of domains which need to be changed; that said I'm probably about a third of
> the way through at this point.
> 
> In case anyone is interested, the policy changes boil down to the following:
> 
>  ifdef(`enable_mls',`
>         corenet_tcp_recv_netlabel(app_domain_t)
>         corenet_udp_recv_netlabel(app_domain_t)
>  ')

Have you considered adding those lines to the existing interfaces in
policy/modules/kernel/corenetwork.if.in instead? For example, telnetd
currently uses corenet_tcp_sendrecv_all_if(telnetd_t), and you could make
that interface provide the needed netlabel rights also.

Do we need something equivalent for labeled IPSEC?

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
