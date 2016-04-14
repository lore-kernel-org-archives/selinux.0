Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3E1Koud019710
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 21:20:50 -0400
From: Paul Moore <pmoore@redhat.com>
To: Daniel Jurgens <danielj@mellanox.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [RFC PATCH] selinux: always return a value from the
 netport/netnode/netif caches
Date: Wed, 13 Apr 2016 21:20:46 -0400
Message-ID: <1959697.69VcgtjyaY@sifl>
In-Reply-To: <AM2PR05MB11056C527FE5F93ECA9D332AC4960@AM2PR05MB1105.eurprd05.prod.outlook.com>
References: <146058346288.11989.9543589385643222847.stgit@localhost>
 <AM2PR05MB11056C527FE5F93ECA9D332AC4960@AM2PR05MB1105.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, April 13, 2016 10:30:26 PM Daniel Jurgens wrote:
> On 4/13/2016 4:43 PM, Paul Moore wrote:
> > From: Paul Moore <paul@paul-moore.com>
> > 
> > Even if we are under memory pressure and can't allocate a new cache
> > node we can still return the port/node/iface value we looked up from
> > the policy.
> > 
> > Reported-by: Greg <gkubok@gmail.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> > 
> >  security/selinux/netif.c   |   35 +++++++++++++----------------------
> >  security/selinux/netnode.c |   31 +++++++++++++++++--------------
> >  security/selinux/netport.c |   19 ++++++++-----------
> >  3 files changed, 38 insertions(+), 47 deletions(-)
> > 
> > diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> > index e607b44..5c3bfa4 100644
> > --- a/security/selinux/netif.c
> > +++ b/security/selinux/netif.c
> > @@ -91,18 +91,16 @@ static inline struct sel_netif *sel_netif_find(const
> > struct net *ns,> 
> >   * zero on success, negative values on failure.
> >   *
> >   */
> > 
> > -static int sel_netif_insert(struct sel_netif *netif)
> > +static void sel_netif_insert(struct sel_netif *netif)
> > 
> >  {
> >  
> >  	int idx;
> >  	
> >  	if (sel_netif_total >= SEL_NETIF_HASH_MAX)
> > 
> > -		return -ENOSPC;
> > +		return;
> > 
> >  	idx = sel_netif_hashfn(netif->nsec.ns, netif->nsec.ifindex);
> >  	list_add_rcu(&netif->list, &sel_netif_hash[idx]);
> >  	sel_netif_total++;
> > 
> > -
> > -	return 0;
> > 
> >  }
> >  
> >  /**
> > 
> > @@ -135,7 +133,7 @@ static void sel_netif_destroy(struct sel_netif *netif)
> > 
> >   */
> >  
> >  static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
> >  {
> > 
> > -	int ret;
> > +	int ret = 0;
> > 
> >  	struct sel_netif *netif;
> >  	struct sel_netif *new = NULL;
> >  	struct net_device *dev;
> > 
> > @@ -155,34 +153,27 @@ static int sel_netif_sid_slow(struct net *ns, int
> > ifindex, u32 *sid)> 
> >  	netif = sel_netif_find(ns, ifindex);
> 
> I know this is out of context for this patch, but isn't this find
> redundant?  It was already checked in sel_netif_sid.

The first time we do the cache lookup it is only with the RCU read lock held, 
we need to do another lookup once we are holding the spinlock.

-- 
paul moore
security @ redhat
