Subject: Re: [PATCH 2/3] SELinux: Made netnode cache adds faster
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080407231106.8052.72925.stgit@flek.lan>
References: <20080407230647.8052.79603.stgit@flek.lan>
	 <20080407231106.8052.72925.stgit@flek.lan>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 13:08:55 -0400
Message-Id: <1207760935.21223.468.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-04-07 at 19:11 -0400, Paul Moore wrote:
> When adding new entries to the network node cache we would walk the entire
> hash bucket to make sure we didn't cross a threshold (done to bound the cache
> size).  This isn't a very quick or elegant solution for something which is
> supposed to be quick-ish so add a counter to each hash bucket to track the
> size of the bucket and eliminate the need to walk the entire bucket list on
> each add.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
> 
>  security/selinux/netnode.c |   57 +++++++++++++++++++++-----------------------
>  1 files changed, 27 insertions(+), 30 deletions(-)
> 
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index f3c526f..b3a5a65 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -40,11 +40,17 @@
>  #include <net/ipv6.h>
>  #include <asm/bug.h>
>  
> +#include "netnode.h"
>  #include "objsec.h"
>  
>  #define SEL_NETNODE_HASH_SIZE       256
>  #define SEL_NETNODE_HASH_BKT_LIMIT   16
>  
> +struct sel_netnode_bkt {
> +	u32 size;

Technically this could just be an ordinary unsigned int, right?
We tend to overuse fixed-size integers in our code at present.

> +	struct list_head list;
> +};
> +
>  struct sel_netnode {
>  	struct netnode_security_struct nsec;
>  

> @@ -179,35 +183,22 @@ static int sel_netnode_insert(struct sel_netnode *node)
>  	default:
>  		BUG();
>  	}
> -	list_add_rcu(&node->list, &sel_netnode_hash[idx]);
>  
>  	/* we need to impose a limit on the growth of the hash table so check
>  	 * this bucket to make sure it is within the specified bounds */
> -	list_for_each_entry(iter, &sel_netnode_hash[idx], list)
> -		if (++count > SEL_NETNODE_HASH_BKT_LIMIT) {
> -			list_del_rcu(&iter->list);
> -			call_rcu(&iter->rcu, sel_netnode_free);
> -			break;
> -		}
> +	list_add_rcu(&node->list, &sel_netnode_hash[idx].list);
> +	if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT) {
> +		struct sel_netnode *tail;
> +		tail = list_entry(node->list.prev, struct sel_netnode, list);
> +		__list_del(node->list.prev, node->list.next);

Can you clarify the change from list_del_rcu() to __list_del() here?

> +		call_rcu(&tail->rcu, sel_netnode_free);
> +	} else
> +		sel_netnode_hash[idx].size++;
>  
>  	return 0;
>  }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
