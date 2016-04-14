From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH] selinux: always return a value from the
 netport/netnode/netif caches
Date: Thu, 14 Apr 2016 14:49:30 -0400
Message-ID: <1577626.0S0ufBum6K@sifl>
In-Reply-To: <570FA495.8040401@tycho.nsa.gov>
References: <146058346288.11989.9543589385643222847.stgit@localhost>
 <570FA495.8040401@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, April 14, 2016 10:09:25 AM Stephen Smalley wrote:
> On 04/13/2016 05:37 PM, Paul Moore wrote:
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
> 
> This will leak netif (new in the caller).  Looks like the other
> sel_*_insert() functions handle freeing of the entry if we hit the limit.

Yes, good catch.

For a while now I thought we would be better off if we consolidated the 
different network object caches into one small cache implementation with 
object specific callouts (hash, match, etc.) and cache instances.  There is so 
much duplicated code between these three and there really is no need for it.  
Perhaps I'll play with that this weekend if I get some time.

-- 
paul moore
security @ redhat
