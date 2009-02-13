Date: Sat, 14 Feb 2009 09:44:46 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com
Subject: Re: [PATCH 1/5] SELinux: remove the unused ae.used
In-Reply-To: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.1.10.0902140944410.32324@tundra.namei.org>
References: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Feb 2009, Eric Paris wrote:

> Currently SELinux code has an atomic which was intended to track how many
> times an avc entry was used and to evict entries when they haven't been
> used recently.  Instead we never let this atomic get above 1 and evict when
> it is first checked for eviction since it hits zero.  This is a total waste
> of time so I'm completely dropping ae.used.
> 
> This change resulted in about a 3% faster avc_has_perm_noaudit when running
> oprofile against a tbench benchmark.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied.

> ---
> 
>  security/selinux/avc.c |   28 +++++++---------------------
>  1 files changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 703aba1..abfe378 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -88,7 +88,6 @@ struct avc_entry {
>  	u32			tsid;
>  	u16			tclass;
>  	struct av_decision	avd;
> -	atomic_t		used;	/* used recently */
>  };
>  
>  struct avc_node {
> @@ -321,16 +320,13 @@ static inline int avc_reclaim_node(void)
>  
>  		rcu_read_lock();
>  		list_for_each_entry(node, &avc_cache.slots[hvalue], list) {
> -			if (atomic_dec_and_test(&node->ae.used)) {
> -				/* Recently Unused */
> -				avc_node_delete(node);
> -				avc_cache_stats_incr(reclaims);
> -				ecx++;
> -				if (ecx >= AVC_CACHE_RECLAIM) {
> -					rcu_read_unlock();
> -					spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flags);
> -					goto out;
> -				}
> +			avc_node_delete(node);
> +			avc_cache_stats_incr(reclaims);
> +			ecx++;
> +			if (ecx >= AVC_CACHE_RECLAIM) {
> +				rcu_read_unlock();
> +				spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flags);
> +				goto out;
>  			}
>  		}
>  		rcu_read_unlock();
> @@ -350,7 +346,6 @@ static struct avc_node *avc_alloc_node(void)
>  
>  	INIT_RCU_HEAD(&node->rhead);
>  	INIT_LIST_HEAD(&node->list);
> -	atomic_set(&node->ae.used, 1);
>  	avc_cache_stats_incr(allocations);
>  
>  	if (atomic_inc_return(&avc_cache.active_nodes) > avc_cache_threshold)
> @@ -383,15 +378,6 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
>  		}
>  	}
>  
> -	if (ret == NULL) {
> -		/* cache miss */
> -		goto out;
> -	}
> -
> -	/* cache hit */
> -	if (atomic_read(&ret->ae.used) != 1)
> -		atomic_set(&ret->ae.used, 1);
> -out:
>  	return ret;
>  }
>  
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
