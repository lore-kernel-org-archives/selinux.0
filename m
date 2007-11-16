Date: Sat, 17 Nov 2007 08:55:37 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        alan@redhat.com, chrisw@redhat.com, hpa@zytor.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] mmap: round mmap hint address above mmap_min_addr
In-Reply-To: <1195249793.2924.99.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0711170852170.22208@us.intercode.com.au>
References: <1195246486.2924.87.camel@localhost.localdomain>
 <Xine.LNX.4.64.0711170841200.22208@us.intercode.com.au>
 <1195249793.2924.99.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Nov 2007, Eric Paris wrote:

> On Sat, 2007-11-17 at 08:42 +1100, James Morris wrote:
> > On Fri, 16 Nov 2007, Eric Paris wrote:
> > 
> > > +#ifdef CONFIG_SECURITY
> > > +	/*
> > > +	 * If a hint addr is less than mmap_min_addr change addr to be as
> > > +	 * low as possible but still greater than mmap_min_addr
> > > +	 */
> > > +	if (!(flags & MAP_FIXED) && ((void *)addr != NULL) &&
> > > +	    (addr < mmap_min_addr))
> > > +		addr = PAGE_ALIGN(mmap_min_addr);
> > > +#endif
> > 
> > Please make this a static inline which is optimized away with 
> > !CONFIG_SECURITY.
> 
> Where do you think these should go?  You think I should instead have a
> static inline function in both mmap.c and nommu.c so the CONFIG check
> isn't scattered in this code but still in this file?  Or did you
> actually want something in security.h so I only have the code once?

Both: not having #ifdefs in the core kernel code (we had pushback on this 
when LSM was being developed), and consolidating the code.  It doesn't 
actually call into LSM modules, so may be better to put it in 
include/linux/mm.h.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
