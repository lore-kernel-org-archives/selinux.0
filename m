Date: Sat, 14 Feb 2009 09:45:34 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com
Subject: Re: [PATCH 4/5] SELinux: code readability with avc_cache
In-Reply-To: <20090212195059.25599.72450.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.1.10.0902140945290.32324@tundra.namei.org>
References: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com> <20090212195059.25599.72450.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Feb 2009, Eric Paris wrote:

> The code making use of struct avc_cache was not easy to read thanks to liberal
> use of &avc_cache.{slots_lock,slots}[hvalue] throughout.  This patch simply
> creates local pointers and uses those instead of the long global names.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied.

> ---
> 
>  security/selinux/avc.c |   63 ++++++++++++++++++++++++++++++++++--------------
>  1 files changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index e9ccacd..ed051d7 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -92,12 +92,12 @@ struct avc_entry {
>  
>  struct avc_node {
>  	struct avc_entry	ae;
> -	struct list_head	list;
> +	struct list_head	list; /* anchored in avc_cache->slots[i] */
>  	struct rcu_head		rhead;
>  };
>  
>  struct avc_cache {
> -	struct list_head	slots[AVC_CACHE_SLOTS];
> +	struct list_head	slots[AVC_CACHE_SLOTS]; /* head for avc_node->list */
>  	spinlock_t		slots_lock[AVC_CACHE_SLOTS]; /* lock for writes */
>  	atomic_t		lru_hint;	/* LRU hint for reclaim scan */
>  	atomic_t		active_nodes;
> @@ -254,16 +254,18 @@ int avc_get_hash_stats(char *page)
>  {
>  	int i, chain_len, max_chain_len, slots_used;
>  	struct avc_node *node;
> +	struct list_head *head;
>  
>  	rcu_read_lock();
>  
>  	slots_used = 0;
>  	max_chain_len = 0;
>  	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
> -		if (!list_empty(&avc_cache.slots[i])) {
> +		head = &avc_cache.slots[i];
> +		if (!list_empty(head)) {
>  			slots_used++;
>  			chain_len = 0;
> -			list_for_each_entry_rcu(node, &avc_cache.slots[i], list)
> +			list_for_each_entry_rcu(node, head, list)
>  				chain_len++;
>  			if (chain_len > max_chain_len)
>  				max_chain_len = chain_len;
> @@ -311,26 +313,30 @@ static inline int avc_reclaim_node(void)
>  	struct avc_node *node;
>  	int hvalue, try, ecx;
>  	unsigned long flags;
> +	struct list_head *head;
> +	spinlock_t *lock;
>  
>  	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
>  		hvalue = atomic_inc_return(&avc_cache.lru_hint) & (AVC_CACHE_SLOTS - 1);
> +		head = &avc_cache.slots[hvalue];
> +		lock = &avc_cache.slots_lock[hvalue];
>  
> -		if (!spin_trylock_irqsave(&avc_cache.slots_lock[hvalue], flags))
> +		if (!spin_trylock_irqsave(lock, flags))
>  			continue;
>  
>  		rcu_read_lock();
> -		list_for_each_entry(node, &avc_cache.slots[hvalue], list) {
> +		list_for_each_entry(node, head, list) {
>  			avc_node_delete(node);
>  			avc_cache_stats_incr(reclaims);
>  			ecx++;
>  			if (ecx >= AVC_CACHE_RECLAIM) {
>  				rcu_read_unlock();
> -				spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flags);
> +				spin_unlock_irqrestore(lock, flags);
>  				goto out;
>  			}
>  		}
>  		rcu_read_unlock();
> -		spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flags);
> +		spin_unlock_irqrestore(lock, flags);
>  	}
>  out:
>  	return ecx;
> @@ -367,9 +373,11 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
>  {
>  	struct avc_node *node, *ret = NULL;
>  	int hvalue;
> +	struct list_head *head;
>  
>  	hvalue = avc_hash(ssid, tsid, tclass);
> -	list_for_each_entry_rcu(node, &avc_cache.slots[hvalue], list) {
> +	head = &avc_cache.slots[hvalue];
> +	list_for_each_entry_rcu(node, head, list) {
>  		if (ssid == node->ae.ssid &&
>  		    tclass == node->ae.tclass &&
>  		    tsid == node->ae.tsid) {
> @@ -458,11 +466,17 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct av_dec
>  
>  	node = avc_alloc_node();
>  	if (node) {
> +		struct list_head *head;
> +		spinlock_t *lock;
> +
>  		hvalue = avc_hash(ssid, tsid, tclass);
>  		avc_node_populate(node, ssid, tsid, tclass, avd);
>  
> -		spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
> -		list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
> +		head = &avc_cache.slots[hvalue];
> +		lock = &avc_cache.slots_lock[hvalue];
> +
> +		spin_lock_irqsave(lock, flag);
> +		list_for_each_entry(pos, head, list) {
>  			if (pos->ae.ssid == ssid &&
>  			    pos->ae.tsid == tsid &&
>  			    pos->ae.tclass == tclass) {
> @@ -470,9 +484,9 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct av_dec
>  				goto found;
>  			}
>  		}
> -		list_add_rcu(&node->list, &avc_cache.slots[hvalue]);
> +		list_add_rcu(&node->list, head);
>  found:
> -		spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flag);
> +		spin_unlock_irqrestore(lock, flag);
>  	}
>  out:
>  	return node;
> @@ -741,6 +755,8 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
>  	int hvalue, rc = 0;
>  	unsigned long flag;
>  	struct avc_node *pos, *node, *orig = NULL;
> +	struct list_head *head;
> +	spinlock_t *lock;
>  
>  	node = avc_alloc_node();
>  	if (!node) {
> @@ -750,9 +766,13 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
>  
>  	/* Lock the target slot */
>  	hvalue = avc_hash(ssid, tsid, tclass);
> -	spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
>  
> -	list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
> +	head = &avc_cache.slots[hvalue];
> +	lock = &avc_cache.slots_lock[hvalue];
> +
> +	spin_lock_irqsave(lock, flag);
> +
> +	list_for_each_entry(pos, head, list) {
>  		if (ssid == pos->ae.ssid &&
>  		    tsid == pos->ae.tsid &&
>  		    tclass == pos->ae.tclass &&
> @@ -797,7 +817,7 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
>  	}
>  	avc_node_replace(node, orig);
>  out_unlock:
> -	spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flag);
> +	spin_unlock_irqrestore(lock, flag);
>  out:
>  	return rc;
>  }
> @@ -812,18 +832,23 @@ int avc_ss_reset(u32 seqno)
>  	int i, rc = 0, tmprc;
>  	unsigned long flag;
>  	struct avc_node *node;
> +	struct list_head *head;
> +	spinlock_t *lock;
>  
>  	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
> -		spin_lock_irqsave(&avc_cache.slots_lock[i], flag);
> +		head = &avc_cache.slots[i];
> +		lock = &avc_cache.slots_lock[i];
> +
> +		spin_lock_irqsave(lock, flag);
>  		/*
>  		 * With preemptable RCU, the outer spinlock does not
>  		 * prevent RCU grace periods from ending.
>  		 */
>  		rcu_read_lock();
> -		list_for_each_entry(node, &avc_cache.slots[i], list)
> +		list_for_each_entry(node, head, list)
>  			avc_node_delete(node);
>  		rcu_read_unlock();
> -		spin_unlock_irqrestore(&avc_cache.slots_lock[i], flag);
> +		spin_unlock_irqrestore(lock, flag);
>  	}
>  
>  	for (c = avc_callbacks; c; c = c->next) {
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
