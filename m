Date: Sat, 14 Feb 2009 09:45:47 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com
Subject: Re: [PATCH 5/5] SELinux: convert the avc cache hash list to an
 hlist
In-Reply-To: <20090212195104.25599.75942.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.1.10.0902140945420.32324@tundra.namei.org>
References: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com> <20090212195104.25599.75942.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Feb 2009, Eric Paris wrote:

> We do not need O(1) access to the tail of the avc cache lists and so we are
> wasting lots of space using struct list_head instead of struct hlist_head.
> This patch converts the avc cache to use hlists in which there is a single
> pointer from the head which saves us about 4k of global memory.
> 
> Resulted in about a 1.5% decrease in time spent in avc_has_perm_noaudit based
> on oprofile sampling of tbench.  Although likely within the noise....
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied.

> ---
> 
>  security/selinux/avc.c |   47 +++++++++++++++++++++++++++--------------------
>  1 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index ed051d7..cc83acd 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -92,12 +92,12 @@ struct avc_entry {
>  
>  struct avc_node {
>  	struct avc_entry	ae;
> -	struct list_head	list; /* anchored in avc_cache->slots[i] */
> +	struct hlist_node	list; /* anchored in avc_cache->slots[i] */
>  	struct rcu_head		rhead;
>  };
>  
>  struct avc_cache {
> -	struct list_head	slots[AVC_CACHE_SLOTS]; /* head for avc_node->list */
> +	struct hlist_head	slots[AVC_CACHE_SLOTS]; /* head for avc_node->list */
>  	spinlock_t		slots_lock[AVC_CACHE_SLOTS]; /* lock for writes */
>  	atomic_t		lru_hint;	/* LRU hint for reclaim scan */
>  	atomic_t		active_nodes;
> @@ -238,7 +238,7 @@ void __init avc_init(void)
>  	int i;
>  
>  	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
> -		INIT_LIST_HEAD(&avc_cache.slots[i]);
> +		INIT_HLIST_HEAD(&avc_cache.slots[i]);
>  		spin_lock_init(&avc_cache.slots_lock[i]);
>  	}
>  	atomic_set(&avc_cache.active_nodes, 0);
> @@ -254,7 +254,7 @@ int avc_get_hash_stats(char *page)
>  {
>  	int i, chain_len, max_chain_len, slots_used;
>  	struct avc_node *node;
> -	struct list_head *head;
> +	struct hlist_head *head;
>  
>  	rcu_read_lock();
>  
> @@ -262,10 +262,12 @@ int avc_get_hash_stats(char *page)
>  	max_chain_len = 0;
>  	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
>  		head = &avc_cache.slots[i];
> -		if (!list_empty(head)) {
> +		if (!hlist_empty(head)) {
> +			struct hlist_node *next;
> +
>  			slots_used++;
>  			chain_len = 0;
> -			list_for_each_entry_rcu(node, head, list)
> +			hlist_for_each_entry_rcu(node, next, head, list)
>  				chain_len++;
>  			if (chain_len > max_chain_len)
>  				max_chain_len = chain_len;
> @@ -289,7 +291,7 @@ static void avc_node_free(struct rcu_head *rhead)
>  
>  static void avc_node_delete(struct avc_node *node)
>  {
> -	list_del_rcu(&node->list);
> +	hlist_del_rcu(&node->list);
>  	call_rcu(&node->rhead, avc_node_free);
>  	atomic_dec(&avc_cache.active_nodes);
>  }
> @@ -303,7 +305,7 @@ static void avc_node_kill(struct avc_node *node)
>  
>  static void avc_node_replace(struct avc_node *new, struct avc_node *old)
>  {
> -	list_replace_rcu(&old->list, &new->list);
> +	hlist_replace_rcu(&old->list, &new->list);
>  	call_rcu(&old->rhead, avc_node_free);
>  	atomic_dec(&avc_cache.active_nodes);
>  }
> @@ -313,7 +315,8 @@ static inline int avc_reclaim_node(void)
>  	struct avc_node *node;
>  	int hvalue, try, ecx;
>  	unsigned long flags;
> -	struct list_head *head;
> +	struct hlist_head *head;
> +	struct hlist_node *next;
>  	spinlock_t *lock;
>  
>  	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
> @@ -325,7 +328,7 @@ static inline int avc_reclaim_node(void)
>  			continue;
>  
>  		rcu_read_lock();
> -		list_for_each_entry(node, head, list) {
> +		hlist_for_each_entry(node, next, head, list) {
>  			avc_node_delete(node);
>  			avc_cache_stats_incr(reclaims);
>  			ecx++;
> @@ -351,7 +354,7 @@ static struct avc_node *avc_alloc_node(void)
>  		goto out;
>  
>  	INIT_RCU_HEAD(&node->rhead);
> -	INIT_LIST_HEAD(&node->list);
> +	INIT_HLIST_NODE(&node->list);
>  	avc_cache_stats_incr(allocations);
>  
>  	if (atomic_inc_return(&avc_cache.active_nodes) > avc_cache_threshold)
> @@ -373,11 +376,12 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
>  {
>  	struct avc_node *node, *ret = NULL;
>  	int hvalue;
> -	struct list_head *head;
> +	struct hlist_head *head;
> +	struct hlist_node *next;
>  
>  	hvalue = avc_hash(ssid, tsid, tclass);
>  	head = &avc_cache.slots[hvalue];
> -	list_for_each_entry_rcu(node, head, list) {
> +	hlist_for_each_entry_rcu(node, next, head, list) {
>  		if (ssid == node->ae.ssid &&
>  		    tclass == node->ae.tclass &&
>  		    tsid == node->ae.tsid) {
> @@ -466,7 +470,8 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct av_dec
>  
>  	node = avc_alloc_node();
>  	if (node) {
> -		struct list_head *head;
> +		struct hlist_head *head;
> +		struct hlist_node *next;
>  		spinlock_t *lock;
>  
>  		hvalue = avc_hash(ssid, tsid, tclass);
> @@ -476,7 +481,7 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct av_dec
>  		lock = &avc_cache.slots_lock[hvalue];
>  
>  		spin_lock_irqsave(lock, flag);
> -		list_for_each_entry(pos, head, list) {
> +		hlist_for_each_entry(pos, next, head, list) {
>  			if (pos->ae.ssid == ssid &&
>  			    pos->ae.tsid == tsid &&
>  			    pos->ae.tclass == tclass) {
> @@ -484,7 +489,7 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct av_dec
>  				goto found;
>  			}
>  		}
> -		list_add_rcu(&node->list, head);
> +		hlist_add_head_rcu(&node->list, head);
>  found:
>  		spin_unlock_irqrestore(lock, flag);
>  	}
> @@ -755,7 +760,8 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
>  	int hvalue, rc = 0;
>  	unsigned long flag;
>  	struct avc_node *pos, *node, *orig = NULL;
> -	struct list_head *head;
> +	struct hlist_head *head;
> +	struct hlist_node *next;
>  	spinlock_t *lock;
>  
>  	node = avc_alloc_node();
> @@ -772,7 +778,7 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
>  
>  	spin_lock_irqsave(lock, flag);
>  
> -	list_for_each_entry(pos, head, list) {
> +	hlist_for_each_entry(pos, next, head, list) {
>  		if (ssid == pos->ae.ssid &&
>  		    tsid == pos->ae.tsid &&
>  		    tclass == pos->ae.tclass &&
> @@ -832,7 +838,8 @@ int avc_ss_reset(u32 seqno)
>  	int i, rc = 0, tmprc;
>  	unsigned long flag;
>  	struct avc_node *node;
> -	struct list_head *head;
> +	struct hlist_head *head;
> +	struct hlist_node *next;
>  	spinlock_t *lock;
>  
>  	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
> @@ -845,7 +852,7 @@ int avc_ss_reset(u32 seqno)
>  		 * prevent RCU grace periods from ending.
>  		 */
>  		rcu_read_lock();
> -		list_for_each_entry(node, head, list)
> +		hlist_for_each_entry(node, next, head, list)
>  			avc_node_delete(node);
>  		rcu_read_unlock();
>  		spin_unlock_irqrestore(lock, flag);
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
