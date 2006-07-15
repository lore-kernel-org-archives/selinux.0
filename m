Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6F2IcqL010297
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 22:18:38 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6F2Ibe9010299
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 02:18:37 GMT
Date: Fri, 14 Jul 2006 22:18:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
In-Reply-To: <20060714185915.270209000@flek.zko.hp.com>
Message-ID: <Pine.LNX.4.64.0607142209180.19821@d.namei>
References: <20060714185739.780700000@flek.zko.hp.com>
 <20060714185915.270209000@flek.zko.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Jul 2006, paul.moore@hp.com wrote:


> +
> +/* Label mapping cache */
> +int cipso_v4_cache_enabled = 1;
> +int cipso_v4_cache_bucketsize = 10;

> +static struct cipso_v4_map_cache_bkt *cipso_v4_cache = NULL;
> +#define CIPSO_V4_CACHE_ENABLED (cipso_v4_cache_enabled &&		\
> +				cipso_v4_cache_bucketsize > 0 &&	\
> +				cipso_v4_cache_size > 0)

This macro seems kind of odd.  Why not just check for 
cipso_v4_cache_enabled ?


> +static int cipso_v4_cache_init(const u32 bkt_size)
> +{
> +	struct cipso_v4_map_cache_bkt *cache;

Why have this temporary local variable,

> +	cipso_v4_cache = cache;

then assign its value to a global?

This function is only ever called once, right?


> + * Description:
> + * Clears the CIPSO cache and frees all the memory.  This function does not
> + * hold any locks and should only be called when the module is being unloaded.
> + *
> + */
> +static int cipso_v4_cache_destroy(void)
> +{
> +	struct cipso_v4_map_cache_bkt *cache;
> +	struct cipso_v4_map_cache_entry *entry;
> +	u32 cache_size;
> +	u32 iter;
> +
> +	cache = cipso_v4_cache;
> +	cache_size = cipso_v4_cache_size;
> +	cipso_v4_cache_size = 0;
> +	cipso_v4_cache = NULL;
> +
> +	for (iter = 0; iter < cache_size; iter++)
> +		list_for_each_entry(entry, &cache[iter].list, list) {
> +			list_del(&entry->list);
> +			cipso_v4_cache_entry_free(entry);
> +		}
> +
> +	return 0;
> +}
> +

If you're in a permanent cleanup phase, why bother clearing all of these 
global variables and using temporary pointers?

Why not just simply free each entry?  The way this is coded makes it seem 
like you're unsure about the safety of the code.

e.g. what could it possibly matter at this stage whether cipso_v4_cache is 
NULL or not?

I think I asked this some time ago: what are the lifetime rules for this 
code as a loadable module?  What if you arbitrarily rmmod it?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
