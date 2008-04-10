From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 2/3] SELinux: Made netnode cache adds faster
Date: Thu, 10 Apr 2008 09:46:32 -0400
Cc: selinux@tycho.nsa.gov
References: <20080407230647.8052.79603.stgit@flek.lan> <200804091341.57537.paul.moore@hp.com> <1207830559.21223.681.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1207830559.21223.681.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804100946.32724.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 10 April 2008 8:29:19 am Stephen Smalley wrote:
> On Wed, 2008-04-09 at 13:41 -0400, Paul Moore wrote:
> > On Wednesday 09 April 2008 1:08:55 pm Stephen Smalley wrote:
> > > On Mon, 2008-04-07 at 19:11 -0400, Paul Moore wrote:
> > > > diff --git a/security/selinux/netnode.c
> > > > b/security/selinux/netnode.c index f3c526f..b3a5a65 100644
> > > > --- a/security/selinux/netnode.c
> > > > +++ b/security/selinux/netnode.c
> > > > @@ -40,11 +40,17 @@
> > > >  #include <net/ipv6.h>
> > > >  #include <asm/bug.h>
> > > >
> > > > +#include "netnode.h"
> > > >  #include "objsec.h"
> > > >
> > > >  #define SEL_NETNODE_HASH_SIZE       256
> > > >  #define SEL_NETNODE_HASH_BKT_LIMIT   16
> > > >
> > > > +struct sel_netnode_bkt {
> > > > +	u32 size;
> > >
> > > Technically this could just be an ordinary unsigned int, right?
> > > We tend to overuse fixed-size integers in our code at present.
> >
> > [Thanks for taking a look]
> >
> > Yep, we can make this anything we want.  I suppose if we are
> > adverse to fixed-size scalars (not really an issue here, but I
> > understand your point) a size_t variable might be a better pick
> > since it is a "size" even though it isn't the traditional memory
> > chunk size.  The only drawback is that it varies in size, but it
> > shouldn't messup the packing of the struct.
> >
> > I guess I still kinda like the limit imposed by the u32 (I suppose
> > I could make it smaller, u8?, but the compiler is just going to
> > waste the memory for alignment reasons anyway) but if you feel
> > strongly about this I can change it to an int or size_t type.
>
> Just pointing out that we tend to use fixed-size integers too widely,
> when an ordinary unsigned int or unsigned long would suffice.  We
> only generally need the fixed size integers for file (e.g. policy
> image) and network packet formats.  Not new to this code, but
> something to be aware of.

I switched it over to an unsigned int in the "v2" revision I posted last 
night.  You're right in that there is no _need_ for it to be a fixed 
signed integer so we might as well let it be a more "native" type.

> > > > @@ -179,35 +183,22 @@ static int sel_netnode_insert(struct
> > > > sel_netnode *node) default:
> > > >  		BUG();
> > > >  	}
> > > > -	list_add_rcu(&node->list, &sel_netnode_hash[idx]);
> > > >
> > > >  	/* we need to impose a limit on the growth of the hash table
> > > > so check * this bucket to make sure it is within the specified
> > > > bounds */ -	list_for_each_entry(iter, &sel_netnode_hash[idx],
> > > > list) -		if (++count > SEL_NETNODE_HASH_BKT_LIMIT) {
> > > > -			list_del_rcu(&iter->list);
> > > > -			call_rcu(&iter->rcu, sel_netnode_free);
> > > > -			break;
> > > > -		}
> > > > +	list_add_rcu(&node->list, &sel_netnode_hash[idx].list);
> > > > +	if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT)
> > > > { +		struct sel_netnode *tail;
> > > > +		tail = list_entry(node->list.prev, struct sel_netnode,
> > > > list); +		__list_del(node->list.prev, node->list.next);
> > >
> > > Can you clarify the change from list_del_rcu() to __list_del()
> > > here?
> >
> > Well, the main reason for the change is I want to delete the tail
> > of the list without having to traverse the entire list, there
> > doesn't appear to be a list_*_rcu() that will allow me to do this
> > so I simply used the __list_del() function to do what I needed. 
> > The only danger here is maintaining all of the right RCUisms and
> > looking at the different implementations the only real difference
> > is that the RCU version sets the removed entry's prev pointer to a
> > poison value.  Since I "immediately" remove the entry and don't
> > make use of the prev pointer in any of the list functions I decided
> > to just skip that step.
> >
> > However, I am not an RCU expert (tricky thing to master) so if this
> > sounds problematic to you let me know and I'll add the "poisoning"
> > to the code.
>
> I don't quite understand. {snip}

Yeah, now I guess I don't either.  For some reason when I wrote this 
code I thought I needed to use a __list_del() call to remove the last 
entry in the list when in reality I can do the same thing with 
list_del_rcu().  No idea what I was thinking then ... give me a few 
hours and I'll resubmit.

Thanks.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
