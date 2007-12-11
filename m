Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBE5Mq9028871
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 09:05:22 -0500
Received: from g5t0009.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBBE5Fam014758
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 14:05:16 GMT
From: Paul Moore <paul.moore@hp.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] XFRM: assorted IPsec fixups
Date: Tue, 11 Dec 2007 09:05:05 -0500
Cc: eparis@redhat.com, netdev@vger.kernel.org, linux-audit@redhat.com,
        selinux@tycho.nsa.gov
References: <20071207171116.18151.42328.stgit@flek.americas.hpqcorp.net> <1197059769.3183.16.camel@dhcp231-215.rdu.redhat.com> <20071211.022202.208850272.davem@davemloft.net>
In-Reply-To: <20071211.022202.208850272.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712110905.06312.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 11 December 2007 5:22:02 am David Miller wrote:
> From: Eric Paris <eparis@redhat.com>
> Date: Fri, 07 Dec 2007 15:36:08 -0500
>
> > On Fri, 2007-12-07 at 12:11 -0500, Paul Moore wrote:
> > > This patch fixes a number of small but potentially troublesome things
> > > in the XFRM/IPsec code:
>
> ...
>
> > > Signed-off-by: Paul Moore <paul.moore@hp.com>
> >
> > Acked-by: Eric Paris <eparis@redhat.com>
> >
> > although it does make me wonder why audit_log_start doesn't just check
> > audit_enabled itself....   Anyway, this patch looks good.
>
> I want to apply this but it doesn't apply cleanly to
> net-2.6.25 right now, could you respin this Paul?

Sure, sorry about that.  I wasn't certain who was going to pick this up so I 
just backed again Linus' tree.  I'll get a respun version out later today.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
