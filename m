Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FExDEc019221
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 10:59:13 -0400
Received: from ccerelrim01.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FExCX0021306
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 14:59:12 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
Date: Sat, 15 Jul 2006 10:59:05 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        "David S. Miller" <davem@davemloft.net>, sds@epoch.ncsc.mil,
        pratt@argus-systems.com
References: <20060714185739.780700000@flek.zko.hp.com> <20060714185915.270209000@flek.zko.hp.com> <Pine.LNX.4.64.0607142202380.19821@d.namei>
In-Reply-To: <Pine.LNX.4.64.0607142202380.19821@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607151059.05396.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 14 July 2006 10:03 pm, James Morris wrote:
> On Fri, 14 Jul 2006, paul.moore@hp.com wrote:
> > +/**
> > + * cipso_v4_bitmap_walk - Walk a bitmap looking for a bit
> >
> > + * cipso_v4_bitmap_setbit - Sets a single bit in a bitmap
>
> Can you use lib/bitmap.c instead?

I looked at using the routines in asm/bitopts.h at one point but decided not 
too.  Unfortunately, this was quite some time ago and I can't remember why I 
chose not to use them right now.  I'll look again and if it makes sense I'll 
make the change.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
