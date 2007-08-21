Subject: Re: [patch] Tuning avtab to reduce memory usage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Kaigai Kohei <kaigai@ak.jp.nec.com>
In-Reply-To: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
Content-Type: text/plain
Date: Tue, 21 Aug 2007 09:47:38 -0400
Message-Id: <1187704058.1451.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-21 at 13:29 +0900, Yuichi Nakamura wrote:
> Hi.
> 
> I would like to propose patch that reduce memory usage of avtab again.
> It reduces number of hash slots of avtab.
> Previous patch was discussed in past threads.
> http://marc.info/?t=118517459600001&r=1&w=2
> http://marc.info/?t=118526972800008&r=1&w=2
> http://marc.info/?t=118647810000001&r=1&w=2
> 
> 0. Background 
> * In avtab_init:
>  h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
> Number of hash table size is AVTAB_SIZE.
> 
> * In avtab.h
> #define AVTAB_HASH_BITS 15
> #define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
> #define AVTAB_SIZE AVTAB_HASH_BUCKETS
> 
> AVTAB_SIZE is 2^15 = 32768
> 
> So 32768 entries are allocated for avtab, 
> and 2 avtabs are used in policydb:
> struct avtab te_avtab;
> struct avtab te_cond_avtab;
> 
> If te rules are fewer than 32768,
> unused entries are using memory.
> 
> In embedded devices, the rules tend to be fewer.
> In my test system(SH architecture board), it is less than 10000 rules.
> We want to save memory for embedded devices.
> 
> 1. Explanation of patch
> It decides number of hash slots dynamically based on number of rules.
> There was 3 points I had to consider, according to previous discussion.
> 1) Tuning hash function
> I tried to tune hash function(AVTAB_HASH) for avtab.
> But I found it is better not to change hash function.
> 
> I compared 3 hash functions, default, jhash, hash_long.
> default is default AVTAB_HASH.
> jhash is function defined in linux/jhash.h.
> hash_long is defined in linux/hash.h, I used it like following.
> 	(int)(hash_long(((unsigned long)keyp->target_class)+
>     (((unsigned long)keyp->target_type)<<2)+
>     (((unsigned long)keyp->source_type)<<9)  , bits))
> According to benchmark result in 3.2(1)(2),
> chain length of jhash/hash_long are better.
> However, performance is worse.
> So, I think it is better not to change hash function for avtab.
> 
> 2) Number of dynamically allocated hash slots
> I decided to allocate <number of rules>/4 hash slots.
> Because performance remains almost the same, 
> see benchmark result in 3.2(2).
> 
> 3) Max number of hash slots
> There is max number of hash slots.
> It was 32768 in previous patch.
> I found we can reduce it to 8192.
> Performance had not got worse, see benchmark result in 3.1(1).
> I also replaced vmalloc with kmalloc to allocate hash slots.
> 
> 
> 2. Memory usage
> I measured memory usage by /proc/memstat before/after tuning.
> 
> * Memory usage: SELinux before loading policy.
> 2720k is used.
> 
> * Memory usage: SELinux after loading policy(about 8000 rules) before patch
> +1116k increase
> 
> * Memory usage: SELinux after loading poilcy(about 8000 rules) after patch.
>   configured AVTAB_HASH_BITS as "13" 
> +780k increase
> -> improved 336k
> 
> 
> 3. Benchmark 
> 3.1 Explanation of benchmark
> To measure performance, 
> I measured time to call security_compute_av varying number of hash slots 
> and hash functions.
> I measured time 10000 security_compute_av call from system boot, 
> using below code.
> 
> int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>                          u16 tclass, u32 requested,
>                          struct av_decision *avd)
> {
> 	struct avc_node *node;
> 	struct avc_entry entry, *p_ae;
> 	int rc = 0;
> 	u32 denied;
> +	unsigned long long t0,t1;
> +	unsigned long long t2=0;
> +	static unsigned long long t3=0;
> +	static int count = 0;
> +	static int flag = 1;
> +	static int max = 10000;
> +	int i = 0;
> 
> 
> 	rcu_read_lock();
> +	if (flag && ss_initialized) {
> +		t0 = sched_clock();
> +		security_compute_av(ssid,tsid,tclass, requested, &entry.avd);
> +		t1 = sched_clock();
> +		t2 = t1 - t0;
> +		t3 += t2;
> +		count ++;
> +	} 
> +	if (flag && (count == max)) {
> +		flag = 0;
> +		printk("SELinux:security_compute_av execution time:%Lu\n", t3);
> +
> +	}
> 
> security_compute_av is located at the entry of avc_has_perm_no_audit.
> And nano second to call 10000 security_compute_av function is printed out.
> 
> 
> 3.2 Benchmark Result
> 1) Benchmark for full strict policy, x86 system
> This benchmark is to see performance for PC system with full SELinux feature.
> ** Environment
>   * Policy: selinux-policy-strict-2.4.6-80.fc6
>           166741 unconditional rules
>   * Kernel: linux-2.6.22
>   * CPU: Pentium 4 2.26 GHz
>   * RAM: 1GB
>   In this environment, max number of hash slot is allocated.
> 
> ** Result
>  * number of hash slots: 32768
>                longest chain length  time to call security compute_av
>  Default hash  34                    0.87(s)
>  jhash         21                    1.10(s)
>  hash_long     17                    0.99(s)
> 
> * hash slot: 8192
>               longest chain length   time to call security compute_av
>  Default hash  97                    1.00(s)
>  jhash         41                    1.92(s)
>  hash_long     43                    1.42(s)
> 
> * hash slot: 4096
>                longest chain length  time to call security compute_av
>  Default hash  182                   1.14(s)
>  jhash         41                    3.33(s)
>  hash_long     43                    2.19(s)
> 
> 
> 2) Benchmark for small policy, embedded system
> This benchmark is to see performance for small system.
> I made small refpolicy, and run on embedded CPU.
> 
> ** Environment
>   * Policy: serefpolicy-2.4.6, build with targeted
>             8188 unconditional rules
>   * Kernel: linux-2.6.22
>   * CPU: SH-4(SH 7751R) 240Mhz
>   * RAM: 64M
> 
> ** Result
> * Number of slot(8192) = num of rules 
>                longest chain length  time to call security compute_av
>  Default hash  13                   9.67(s)
>  hash_long     8                    9.78(s)
> 
> * Number of slot(4096) = num of rules/2
>                longest chain length  time to call security compute_av
>  Default hash  21                   9.65(s)
>  hash_long     10                   9.85(s)
> 
> * Number of slot(2048) = num of rules/4
>               longest chain length  time to call security compute_av
>  Default hash  35                   9.68(s)
>  hash_long     13                   9.99(s)
> 
> *  Number of slot(1024) = num of rules/8
>               longest chain length  time to call security compute_av
>  Default hash  64                   9.78(s)
>  hash_long     19                   10.25(s)

The divergence in times between strict/large policy vs. targeted/small
policy seems curious.

Is it because targeted/small policy makes more use of type attributes,
making the nested ebitmap_for_each_bit loops much longer?

We likely should look at optimizing the ebitmap code, or replacing it
with the native kernel bitmaps (include/linux/bitmap.h, lib/bitmap.c).
For example, ebitmap_next could possibly use find_next_bit().

> 
> Next is a patch.
> Signed-Off-By: Yuichi Nakamura <ynakam@hitachisoft.jp>

Looks ok, but a few coding style issues.  Run ./scripts/checkpatch.pl on
it and fix all issues please.  And make it apply with patch -p1 (and use
diffstat -p1 to generate the diffstat).

> ----
>  avtab.c       |   61 ++++++++++++++++++++++++++++++++++++++++++++--------------
>  avtab.h       |   13 +++++++-----
>  conditional.c |    6 +++++
>  policydb.c    |    9 ++------
>  4 files changed, 64 insertions(+), 25 deletions(-)

> diff -ur security/selinux.notuning/ss/avtab.c security/selinux/ss/avtab.c
> --- security/selinux.notuning/ss/avtab.c	2007-08-05 14:30:24.000000000 +0900
> +++ security/selinux/ss/avtab.c	2007-08-21 10:15:09.000000000 +0900
> @@ -16,17 +16,16 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> -#include <linux/vmalloc.h>
>  #include <linux/errno.h>
>  
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
>  
>  static struct kmem_cache *avtab_node_cachep;
>  
> @@ -62,7 +61,7 @@
>  	if (!h)
>  		return -EINVAL;
>  
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = AVTAB_HASH(key,h->mask);
>  	for (prev = NULL, cur = h->htable[hvalue];
>  	     cur;
>  	     prev = cur, cur = cur->next) {
> @@ -102,7 +101,7 @@
>  
>  	if (!h)
>  		return NULL;
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = AVTAB_HASH(key, h->mask);
>  	for (prev = NULL, cur = h->htable[hvalue];
>  	     cur;
>  	     prev = cur, cur = cur->next) {
> @@ -135,7 +134,7 @@
>  	if (!h)
>  		return NULL;
>  
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = AVTAB_HASH(key, h->mask);
>  	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
>  		if (key->source_type == cur->key.source_type &&
>  		    key->target_type == cur->key.target_type &&
> @@ -170,7 +169,7 @@
>  	if (!h)
>  		return NULL;
>  
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = AVTAB_HASH(key, h->mask);
>  	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
>  		if (key->source_type == cur->key.source_type &&
>  		    key->target_type == cur->key.target_type &&
> @@ -228,7 +227,7 @@
>  	if (!h || !h->htable)
>  		return;
>  
> -	for (i = 0; i < AVTAB_SIZE; i++) {
> +	for (i = 0; i < h->nslot; i++) {
>  		cur = h->htable[i];
>  		while (cur != NULL) {
>  			temp = cur;
> @@ -237,21 +236,48 @@
>  		}
>  		h->htable[i] = NULL;
>  	}
> -	vfree(h->htable);
> +	kfree(h->htable);
>  	h->htable = NULL;
> +	h->nslot = 0;
> +	h->mask = 0;
>  }
>  
> -
>  int avtab_init(struct avtab *h)
>  {
> +	h->htable = NULL;
> +	h->nel = 0;
> +	return 0;
> +}
> +
> +int avtab_alloc(struct avtab *h, int nrules) {
>  	int i;
> +	u16 mask;
> +	u32 shift = 0;
> +	u32 work = nrules;
> +	u32 nslot;
> +	
> +	while(work) {
> +		work  = work>>1;
> +		shift++;
> +	}	
> +	if (shift > 2) {
> +		shift = shift - 2;
> +	}
> +	nslot = 1 << shift;
> +	if (nslot > MAX_AVTAB_SIZE) {
> +		nslot = MAX_AVTAB_SIZE;
> +	}
> +	mask = nslot - 1;
>  
> -	h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
> +	h->htable = kmalloc(sizeof(*(h->htable)) * nslot, GFP_KERNEL);
>  	if (!h->htable)
>  		return -ENOMEM;
> -	for (i = 0; i < AVTAB_SIZE; i++)
> +	for (i = 0; i < nslot; i++)
>  		h->htable[i] = NULL;
>  	h->nel = 0;
> +	h->nslot = nslot;
> +	h->mask = mask;	
> +	printk(KERN_DEBUG "SELinux:%d avtab hash slots allocated. Num of rules:%d\n", h->nslot, nrules);
>  	return 0;
>  }
>  
> @@ -262,7 +288,7 @@
>  
>  	slots_used = 0;
>  	max_chain_len = 0;
> -	for (i = 0; i < AVTAB_SIZE; i++) {
> +	for (i = 0; i < h->nslot; i++) {
>  		cur = h->htable[i];
>  		if (cur) {
>  			slots_used++;
> @@ -278,7 +304,7 @@
>  	}
>  
>  	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
> -	       "chain length %d\n", tag, h->nel, slots_used, AVTAB_SIZE,
> +	       "chain length %d\n", tag, h->nel, slots_used, h->nslot,
>  	       max_chain_len);
>  }
>  
> @@ -419,6 +445,13 @@
>  		rc = -EINVAL;
>  		goto bad;
>  	}
> +
> +	rc = avtab_alloc(a, nel);
> +	if (rc) {
> +		rc = -ENOMEM;
> +		goto bad;
> +	}
> +
>  	for (i = 0; i < nel; i++) {
>  		rc = avtab_read_item(fp,vers, a, avtab_insertf, NULL);
>  		if (rc) {
> diff -ur security/selinux.notuning/ss/avtab.h security/selinux/ss/avtab.h
> --- security/selinux.notuning/ss/avtab.h	2007-08-05 14:30:24.000000000 +0900
> +++ security/selinux/ss/avtab.h	2007-08-21 09:56:51.000000000 +0900
> @@ -50,9 +50,13 @@
>  struct avtab {
>  	struct avtab_node **htable;
>  	u32 nel;	/* number of elements */
> +	u32 nslot;      /* number of hash slots */
> +	u16 mask;       /* mask to compute hash func */
> +
>  };
>  
>  int avtab_init(struct avtab *);
> +int avtab_alloc(struct avtab *, int);
>  struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
>  void avtab_destroy(struct avtab *h);
>  void avtab_hash_eval(struct avtab *h, char *tag);
> @@ -74,11 +78,10 @@
>  void avtab_cache_init(void);
>  void avtab_cache_destroy(void);
>  
> -#define AVTAB_HASH_BITS 15
> -#define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
> -#define AVTAB_HASH_MASK (AVTAB_HASH_BUCKETS-1)
> -
> -#define AVTAB_SIZE AVTAB_HASH_BUCKETS
> +#define MAX_AVTAB_HASH_BITS 13
> +#define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
> +#define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
> +#define MAX_AVTAB_SIZE MAX_AVTAB_HASH_BUCKETS
>  
>  #endif	/* _SS_AVTAB_H_ */
>  
> diff -ur security/selinux.notuning/ss/conditional.c security/selinux/ss/conditional.c
> --- security/selinux.notuning/ss/conditional.c	2007-08-05 14:30:24.000000000 +0900
> +++ security/selinux/ss/conditional.c	2007-08-21 09:56:26.000000000 +0900
> @@ -455,6 +455,12 @@
>  		return -1;
>  
>  	len = le32_to_cpu(buf[0]);
> +	
> +	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
> +	if (rc) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
>  
>  	for (i = 0; i < len; i++) {
>  		node = kzalloc(sizeof(struct cond_node), GFP_KERNEL);
> diff -ur security/selinux.notuning/ss/policydb.c security/selinux/ss/policydb.c
> --- security/selinux.notuning/ss/policydb.c	2007-08-05 14:30:24.000000000 +0900
> +++ security/selinux/ss/policydb.c	2007-08-21 11:50:38.000000000 +0900
> @@ -172,22 +172,19 @@
>  
>  	rc = avtab_init(&p->te_avtab);
>  	if (rc)
> -		goto out_free_symtab;
> +		goto out_free_symtab;	
>  
>  	rc = roles_init(p);
>  	if (rc)
> -		goto out_free_avtab;
> +		goto out_free_symtab;
>  
>  	rc = cond_policydb_init(p);
>  	if (rc)
> -		goto out_free_avtab;
> +		goto out_free_symtab;
>  
>  out:
>  	return rc;
>  
> -out_free_avtab:
> -	avtab_destroy(&p->te_avtab);
> -
>  out_free_symtab:
>  	for (i = 0; i < SYM_NUM; i++)
>  		hashtab_destroy(p->symtab[i].table);
> 
> 
> Regards,
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
