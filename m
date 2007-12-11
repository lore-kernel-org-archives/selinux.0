Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBHdNNr020576
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 12:39:23 -0500
Received: from g1t0028.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBBHdNrO003211
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 17:39:23 GMT
From: Paul Moore <paul.moore@hp.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] XFRM: assorted IPsec fixups
Date: Tue, 11 Dec 2007 12:39:19 -0500
Cc: netdev@vger.kernel.org, linux-audit@redhat.com, selinux@tycho.nsa.gov
References: <20071211163019.15059.73746.stgit@flek.lan> <200712111215.00720.paul.moore@hp.com> <20071211.092126.151519334.davem@davemloft.net>
In-Reply-To: <20071211.092126.151519334.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712111239.19709.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 11 December 2007 12:21:26 pm David Miller wrote:
> From: Paul Moore <paul.moore@hp.com>
> Date: Tue, 11 Dec 2007 12:15:00 -0500
>
> > I still would like to see the rest of the changes make it into
> > 2.6.25 (the SPI byte order thing is particularly troublesome) so if
> > you don't mind a "v3" I'll respin this patch right now to remove the
> > "sid -> secid" bits.
>
> Technically this could break anything parsing the audit logs, but no
> matter, I'd rather fix this now while we still can.

True, this does change how userspace sees things but I think that any 
userspace code that currently uses this SPI value successfully is either 
lucky or has a workaround/hack in place.

> I would classify the spi endianness bit as a bug fix, could you please
> just split out that fix for net-2.6, then we can make a second patch
> after I rebase net-2.6.25 which can do the rest of your patch sans the
> linux/xfrm.h change?

Sure.  Although that's enough of a change that I'd want to retest the patch a 
bit first.  If I can't get it done today expect something in your inbox 
tomorrow.

Thanks for your patience.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
