Subject: Re: [PATCH 2/3] SELinux: Made netnode cache adds faster
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200804091341.57537.paul.moore@hp.com>
References: <20080407230647.8052.79603.stgit@flek.lan>
	 <20080407231106.8052.72925.stgit@flek.lan>
	 <1207760935.21223.468.camel@moss-spartans.epoch.ncsc.mil>
	 <200804091341.57537.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 08:29:19 -0400
Message-Id: <1207830559.21223.681.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-04-09 at 13:41 -0400, Paul Moore wrote:
> On Wednesday 09 April 2008 1:08:55 pm Stephen Smalley wrote:
> > On Mon, 2008-04-07 at 19:11 -0400, Paul Moore wrote:
> > > When adding new entries to the network node cache we would walk the
> > > entire hash bucket to make sure we didn't cross a threshold (done
> > > to bound the cache size).  This isn't a very quick or elegant
> > > solution for something which is supposed to be quick-ish so add a
> > > counter to each hash bucket to track the size of the bucket and
> > > eliminate the need to walk the entire bucket list on each add.
> > >
> > > Signed-off-by: Paul Moore <paul.moore@hp.com>
> > > ---
> > >
> > >  security/selinux/netnode.c |   57
> > > +++++++++++++++++++++----------------------- 1 files changed, 27
> > > insertions(+), 30 deletions(-)
> > >
> > > diff --git a/security/selinux/netnode.c
> > > b/security/selinux/netnode.c index f3c526f..b3a5a65 100644
> > > --- a/security/selinux/netnode.c
> > > +++ b/security/selinux/netnode.c
> > > @@ -40,11 +40,17 @@
> > >  #include <net/ipv6.h>
> > >  #include <asm/bug.h>
> > >
> > > +#include "netnode.h"
> > >  #include "objsec.h"
> > >
> > >  #define SEL_NETNODE_HASH_SIZE       256
> > >  #define SEL_NETNODE_HASH_BKT_LIMIT   16
> > >
> > > +struct sel_netnode_bkt {
> > > +	u32 size;
> >
> > Technically this could just be an ordinary unsigned int, right?
> > We tend to overuse fixed-size integers in our code at present.
> 
> [Thanks for taking a look]
> 
> Yep, we can make this anything we want.  I suppose if we are adverse to 
> fixed-size scalars (not really an issue here, but I understand your 
> point) a size_t variable might be a better pick since it is a "size" 
> even though it isn't the traditional memory chunk size.  The only 
> drawback is that it varies in size, but it shouldn't messup the packing 
> of the struct.
> 
> I guess I still kinda like the limit imposed by the u32 (I suppose I 
> could make it smaller, u8?, but the compiler is just going to waste the 
> memory for alignment reasons anyway) but if you feel strongly about 
> this I can change it to an int or size_t type.

Just pointing out that we tend to use fixed-size integers too widely,
when an ordinary unsigned int or unsigned long would suffice.  We only
generally need the fixed size integers for file (e.g. policy image) and
network packet formats.  Not new to this code, but something to be aware
of.

> 
> > > +	struct list_head list;
> > > +};
> 
> ...
> 
> > > @@ -179,35 +183,22 @@ static int sel_netnode_insert(struct
> > > sel_netnode *node) default:
> > >  		BUG();
> > >  	}
> > > -	list_add_rcu(&node->list, &sel_netnode_hash[idx]);
> > >
> > >  	/* we need to impose a limit on the growth of the hash table so
> > > check * this bucket to make sure it is within the specified bounds
> > > */ -	list_for_each_entry(iter, &sel_netnode_hash[idx], list)
> > > -		if (++count > SEL_NETNODE_HASH_BKT_LIMIT) {
> > > -			list_del_rcu(&iter->list);
> > > -			call_rcu(&iter->rcu, sel_netnode_free);
> > > -			break;
> > > -		}
> > > +	list_add_rcu(&node->list, &sel_netnode_hash[idx].list);
> > > +	if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT) {
> > > +		struct sel_netnode *tail;
> > > +		tail = list_entry(node->list.prev, struct sel_netnode, list);
> > > +		__list_del(node->list.prev, node->list.next);
> >
> > Can you clarify the change from list_del_rcu() to __list_del() here?
> 
> Well, the main reason for the change is I want to delete the tail of the 
> list without having to traverse the entire list, there doesn't appear 
> to be a list_*_rcu() that will allow me to do this so I simply used the 
> __list_del() function to do what I needed.  The only danger here is 
> maintaining all of the right RCUisms and looking at the different 
> implementations the only real difference is that the RCU version sets 
> the removed entry's prev pointer to a poison value.  Since 
> I "immediately" remove the entry and don't make use of the prev pointer 
> in any of the list functions I decided to just skip that step.
> 
> However, I am not an RCU expert (tricky thing to master) so if this 
> sounds problematic to you let me know and I'll add the "poisoning" to 
> the code.

I don't quite understand.  Prior to the patch, it was a list_del_rcu().
Which is just a __list_del() followed by poisoning of the prev pointer.
In the new code, you switched to a direct call to __list_del().  So the
only difference in the final code is losing the poisoning, which seems
bad for debugging and makes the code less self-documenting wrt RCU
issues.  And usually directly calling a __function should be avoided
outside of the implementations of the interfaces except where absolutely
needed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
