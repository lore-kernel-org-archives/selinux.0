Subject: Re: [RFC] Dynamically deciding number of hash slots for avtab
	(Was:Re: [patch] customizable AVTAB_HASH_BITS for embedded devices
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com, method@manicmethod.com
In-Reply-To: <20070724181924.41F6.YNAKAM@hitachisoft.jp>
References: <20070723124502.17C7.YNAKAM@hitachisoft.jp>
	 <1185220711.4177.30.camel@moss-spartans.epoch.ncsc.mil>
	 <20070724181924.41F6.YNAKAM@hitachisoft.jp>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 08:52:03 -0400
Message-Id: <1185281523.16598.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-24 at 18:32 +0900, Yuichi Nakamura wrote:
> On Mon, 23 Jul 2007 15:58:31 -0400
> Stephen Smalley  wrote:
> > I'm open to making this configurable, although I'm not sure whether it
> > should be a Kconfig setting or selinuxfs (or sysctl) setting.  Ideally,
> > of course, it would be runtime computed based on the actual policy size.
> > Rewriting the avtab and other security server data structures to more
> > kernel native would be fine with me too - they don't need to match the
> > userland ones.
> > 
> > (please cc James, Eric, and me on selinux kernel patches)
> OK, I made patch about that. 
> Please look at patch at the end of this e-mail.
> 
> It decides number of hash slots based on number of unconditional TE rules.
> I looked at avtab_read, and found number of unconditional TE rules are 
> described in binary policy, 
> so it can be used.
> Number of hash slot is 2^n. n is decided based on number of unconditional TE rules.
> If number of unconditional TE rules is 4000, n is 12, so 2^12 = 4096 slots 
> are allocated for te_avtab and te_cond_avtab.

That seems too high; we don't need one slot per rule, especially given
the AVC, as noted by KaiGai.  I'd tune it down further.  And make the
max lower, such that we can always use kmalloc instead of vmalloc.

> I tested the patch against my test policy.
> It contains 8486 unconditional TE rules, 3464 conditional TE rules.
> So number of hash slots for te_avtab is 16384.
> te_cond_avtab is also 16384.
> Before tuning, it was 32768 for both, 
> so saved 32768 hash slots(about 32768*4 = 131k byte).
> 
> I could not find the way to obtain number of "conditinal" TE rules 
> before avtab_init(in cond_read_list).
> If I could obtain number of conditional TE rules before avtab_init,
> number of allocated hash slots for te_cond_avtab would be 4096, can save memory more...
> Does anyone know how to obtain number of conditional TE rules?
> Should policy format be changed for that?

There doesn't appear to be a good way to determine that number presently
(you'd have to make two passes over the conditional lists).  So until we
make another format change (which should bundle up more than just this
one change), I'd say just reuse the number of slots of the unconditional
avtab for the conditional one.

> diff -r -pu security/selinux.orig/ss/avtab.c security/selinux/ss/avtab.c
> --- security/selinux.orig/ss/avtab.c	2007-07-20 17:29:30.000000000 +0900
> +++ security/selinux/ss/avtab.c	2007-07-24 15:11:43.000000000 +0900
> @@ -22,11 +22,11 @@
>  #include "avtab.h"
>  #include "policydb.h"
>  
> -#define AVTAB_HASH(keyp) \
> +#define AVTAB_HASH(keyp,mask)			\
>  ((keyp->target_class + \
>   (keyp->target_type << 2) + \
>   (keyp->source_type << 9)) & \
> - AVTAB_HASH_MASK)
> + mask)

The hash function likely needs to be completely replaced to work well
with smaller number of slots.  Maybe we can leverage
include/linux/hash.h or include/linux/jhash.h?

> @@ -239,19 +239,38 @@ void avtab_destroy(struct avtab *h)
>  	}
>  	vfree(h->htable);
>  	h->htable = NULL;
> +	h->nslot = 0;
> +	h->mask = 0;
>  }
>  
> -
> -int avtab_init(struct avtab *h)
> -{
> +int avtab_init(struct avtab *h, int nrules) {
>  	int i;
> +	u16 mask;
> +	int shift = 0;
> +	int work = nrules;
> +	int nslot;

int?  Or u32?

> +	
> +	if (nrules > MAX_AVTAB_SIZE) {
> +		nslot = MAX_AVTAB_SIZE;
> +		mask =  MAX_AVTAB_HASH_MASK ;
> +	} else {
> +		while(work) {
> +			work  = work>>1;
> +			shift++;
> +		}
> +		mask =(1 << shift) - 1;	
> +		nslot = 1 << shift;

I'd tune this down.  And you only need to compute 1 << shift once.

Not sure if this should still be called avtab_init() as it no longer
happens at policydb_init().  Versus keeping a simple avtab_init() that
just clears the avtab fields and introducing a new avtab_alloc()
function or similar.

> @@ -262,7 +281,7 @@ void avtab_hash_eval(struct avtab *h, ch
>  
>  	slots_used = 0;
>  	max_chain_len = 0;
> -	for (i = 0; i < AVTAB_SIZE; i++) {
> +	for (i = 0; i < h->nslot; i++) {
>  		cur = h->htable[i];
>  		if (cur) {
>  			slots_used++;
> @@ -278,7 +297,7 @@ void avtab_hash_eval(struct avtab *h, ch
>  	}
>  
>  	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
> -	       "chain length %d\n", tag, h->nel, slots_used, AVTAB_SIZE,
> +	       "chain length %d\n", tag, h->nel, slots_used, h->nslot,
>  	       max_chain_len);
>  }

Enable the call to this function by #define'ing DEBUG_HASHES in
policydb.c, and then look at the output not only for your policy but for
a full one.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
