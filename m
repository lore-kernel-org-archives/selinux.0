Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6GGAuc6005141
	for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2006 12:10:56 -0400
Received: from mailhub.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6GGAtS9015809
	for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2006 16:10:55 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
Date: Sun, 16 Jul 2006 12:10:44 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        "David S. Miller" <davem@davemloft.net>, sds@epoch.ncsc.mil,
        pratt@argus-systems.com
References: <20060714185739.780700000@flek.zko.hp.com> <20060714185915.270209000@flek.zko.hp.com> <Pine.LNX.4.64.0607142202380.19821@d.namei>
In-Reply-To: <Pine.LNX.4.64.0607142202380.19821@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607161210.44873.paul.moore@hp.com>
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

Looking again at include/asm/bitops.h I think I now remember why I decided not 
to use them in the first place.  At least on the x86 side it looks like the 
underlying btsl instruction may access an entire word when the bitmap may 
only by a byte long.  I imagine in the practical sense it probably wouldn't 
be too serious of an issue, but there are too many corner cases here for me 
to be able to say for certain so I'll defer to the experts here.

If it is safe it shouldn't be too difficult to use the set/clear_bit() 
functions in cipso_v4_bitmap_setbit() and the find_*_bit() functions in 
cipso_v4_bitmap_walk().

As an aside, I've made the other changes you suggested but I won't have a 
chance to test them until Monday morning.  Assuming all goes well during some 
quick testing I'll post a new patchset around mid-day on Monday.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
