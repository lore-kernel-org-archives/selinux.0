Subject: Re: [PATCH] selinux: cache sidtab_context_to_sid results
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, esandeen@redhat.com
In-Reply-To: <alpine.LRH.2.00.1012060921230.14997@tundra.namei.org>
References: <20101202210634.27460.81333.stgit@paris.rdu.redhat.com>
	 <alpine.LRH.2.00.1012060921230.14997@tundra.namei.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Dec 2010 16:27:34 -0500
Message-ID: <1291757254.3072.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-12-06 at 09:22 +1100, James Morris wrote:
> On Thu, 2 Dec 2010, Eric Paris wrote:
> 
> > sidtab_context_to_sid takes up a large share of time when creating large
> > numbers of new inodes (~30-40% in oprofile runs).  This patch implements a
> > cache of 3 entries which is checked before we do a full context_to_sid lookup.
> > On one system this showed over a x3 improvement in the number of inodes that
> > could be created per second and around a 20% improvement on another system.
> > 
> > Any time we look up the same context string sucessivly (imagine ls -lZ) we
> > should hit this cache hot.  A cache miss should have a relatively minor affect
> > on performance next to doing the full table search.
> > 
> > All operations on the cache are done COMPLETELY lockless.  We know that all
> > struct sidtab_node objects created will never be deleted until a new policy is
> > loaded thus we never have to worry about a pointer being dereferenced.  Since
> > we also know that pointer assignment is atomic we know that the cache will
> > always have valid pointers.  Given this information we implement a FIFO cache
> > in an array of 3 pointers.  Every result (whether a cache hit or table lookup)
> > will be places in the 0 spot of the cache and the rest of the entries moved
> > down one spot.  The 3rd entry will be lost.
> 
> This sounds a bit like a magazine cache -- should be useful.  Have you 
> thought about making it per-cpu ?

I hadn't.  I figure that as long as we've had a single hash table lookup
(the wrong direction for the hash table) for all CPUs holding a spinlock
that this is such a clear win there wasn't a need for any complexity or
space tradeoff.

If you think differently (and have a way we could benchmark the changes)
it wouldn't be hard to do, just don't know if it's worth it....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
