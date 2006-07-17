Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6H2gPQZ011408
	for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2006 22:42:25 -0400
Received: from ccerelrim01.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6H2gOS9017422
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 02:42:24 GMT
From: Paul Moore <paul.moore@hp.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
Date: Sun, 16 Jul 2006 22:42:07 -0400
Cc: jmorris@namei.org, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        sds@epoch.ncsc.mil, pratt@argus-systems.com
References: <20060714185915.270209000@flek.zko.hp.com> <200607161210.44873.paul.moore@hp.com> <20060716.181230.59471240.davem@davemloft.net>
In-Reply-To: <20060716.181230.59471240.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607162242.08622.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 16 July 2006 9:12 pm, David Miller wrote:
> From: Paul Moore <paul.moore@hp.com>
> Date: Sun, 16 Jul 2006 12:10:44 -0400
>
> > On Friday 14 July 2006 10:03 pm, James Morris wrote:
> > > On Fri, 14 Jul 2006, paul.moore@hp.com wrote:
> > > > +/**
> > > > + * cipso_v4_bitmap_walk - Walk a bitmap looking for a bit
> > > >
> > > > + * cipso_v4_bitmap_setbit - Sets a single bit in a bitmap
> > >
> > > Can you use lib/bitmap.c instead?
> >
> > Looking again at include/asm/bitops.h I think I now remember why I
> > decided not to use them in the first place.
>
> lib/bitmap.c and the asm/bitops.h operations are two entirely
> different animals.

I probably should have been more clear - I didn't see anything in lib/bitmap.c 
(or include/linux/bitmap.h) that I think would have been useful.  However, 
include/linux/bitmap.h makes reference to asm/bitops.h which does have some 
function which may have been useful if they didn't have the length 
restrictions.

> Wrt. your asm/bitops.h concerns, is there any reason you cannot pad
> out your bitmaps to be a modulo of "long" which is required for
> those routines?

Right now I use both the bitmap_walk() and bitmap_setbit() routines to deal 
with both CIPSO tags straight from the sk_buff as well as the internal bitmap 
representation.  Padding out the internal bitmaps would require some code 
changes but there isn't much I can do about the packet I don't believe.  True 
it would probably be okay for most packets to assume you could access an 
entire "long"s worth of memory but then again it would only take one evil 
packet to start causing problems ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
