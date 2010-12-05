Date: Mon, 6 Dec 2010 09:22:35 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, esandeen@redhat.com
Subject: Re: [PATCH] selinux: cache sidtab_context_to_sid results
In-Reply-To: <20101202210634.27460.81333.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1012060921230.14997@tundra.namei.org>
References: <20101202210634.27460.81333.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2 Dec 2010, Eric Paris wrote:

> sidtab_context_to_sid takes up a large share of time when creating large
> numbers of new inodes (~30-40% in oprofile runs).  This patch implements a
> cache of 3 entries which is checked before we do a full context_to_sid lookup.
> On one system this showed over a x3 improvement in the number of inodes that
> could be created per second and around a 20% improvement on another system.
> 
> Any time we look up the same context string sucessivly (imagine ls -lZ) we
> should hit this cache hot.  A cache miss should have a relatively minor affect
> on performance next to doing the full table search.
> 
> All operations on the cache are done COMPLETELY lockless.  We know that all
> struct sidtab_node objects created will never be deleted until a new policy is
> loaded thus we never have to worry about a pointer being dereferenced.  Since
> we also know that pointer assignment is atomic we know that the cache will
> always have valid pointers.  Given this information we implement a FIFO cache
> in an array of 3 pointers.  Every result (whether a cache hit or table lookup)
> will be places in the 0 spot of the cache and the rest of the entries moved
> down one spot.  The 3rd entry will be lost.

This sounds a bit like a magazine cache -- should be useful.  Have you 
thought about making it per-cpu ?

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
