Message-ID: <46F22BEF.9050208@ak.jp.nec.com>
Date: Thu, 20 Sep 2007 17:14:39 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: [patch] Tuning avtab to reduce memory usage
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>	 <200708211111.27019.paul.moore@hp.com>	 <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>	 <200708211255.45132.paul.moore@hp.com> <46CC00F4.2090501@ak.jp.nec.com>	 <46E7583C.9030103@ak.jp.nec.com> <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------070501070901050005060905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070501070901050005060905
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Wed, 2007-09-12 at 12:08 +0900, KaiGai Kohei wrote:
>> The attached patch applies the standard bitmap operations
>> for the iteration macro of ebitmap, and enables to improve
>> the performance in AVC-misses case.
>>
>> Real-time responsibility is a significant issue for embedded
>> Linux people. This patch also reduce amount of busy loop in
>> the kernel, so it can improve real-time responsibility.
>>
>> I added ebitmap_for_each_positive_bit() macro not to walk
>> on any native bit within ebitmap, and applies it on
>>   - context_struct_compute_av()
>>   - security_get_user_sids()
>>   - mls_context_isvalid()
>>
>> ebitmap_node was redefined as follows:
>>    #define EBITMAP_UNIT_NUMS      \
>>          ((32 - sizeof(void *) - sizeof(u32)) / sizeof(unsigned long))
>>    struct ebitmap_node {
>>        struct ebitmap_node *next;
>>        unsigned long maps[EBITMAP_UNIT_NUMS];
>>        u32 startbit;
>>    };
>>
>> "u64 map" is replaced by an array of "unsigned long". It enables to
>> apply standard bit operations. In addition, length of the array is
>> determind to fit 32-bytes, the minimum size of kmalloc().
>>
>> The result of benchmarks seems to me fine.
>>
>>        selinux-2.6      selinux-2.6-ebitmap
>> AVG:   22.763 [s]          8.750 [s]
>> STD:    0.265              0.019
>> ------------------------------------------
>> 1st:   22.558 [s]          8.786 [s]
>> 2nd:   22.458 [s]          8.750 [s]
>> 3rd:   22.478 [s]          8.754 [s]
>> 4th:   22.724 [s]          8.745 [s]
>> 5th:   22.918 [s]          8.748 [s]
>> 6th:   22.905 [s]          8.764 [s]
>> 7th:   23.238 [s]          8.726 [s]
>> 8th:   22.822 [s]          8.729 [s]
>>
>> NOTE: We used the following operatins as a test case.
>>        No need to say, it is a corner case to highlight.
>> [root@saba ~]# id -Z
>> root:system_r:unconfined_t:SystemLow-SystemHigh
>> [root@saba ~]# cd /dev/shm
>> [root@saba shm]# for I in `seq 1 640`
>>  > do
>>  >     echo > file${I}
>>  >     chcon -l s0:c${I} file${I}
>>  > done
>> [root@saba shm]# ~kaigai/manyfiles 800 file*
>>
>> I also attached "manyfiles.c" to reproduce them.
>>
>> In addition, we could not make sure a statistical difference
>> in the AVC-hits case.
>>
>> Thanks,

Stephen, Thanks for your comments.

The attached second patch is revised in several points.
 - comment blocks in ebitmap_netlbl_(inport|export) are rewritten
   as I mentioned before.
 - rest of codes using ebitmap_for_each_bit() were replaced by
   _positive_ version. I had to modify logic in ss/mls.c a bit.
 - applied your comment as follows:

> The patch looks good overall - a couple minor comments below.
> Paul, can you test the netlabel import/export functionality?
> 
> I was wondering whether it might be useful to also introduce a new
> policy version with an updated ebitmap representation in the policy
> format that would be closer to the kernel native representation,
> although we'd still need to be able to read the old formats for backward
> compatibility.

I don't think a new policy format is necessary, because the width of
unsigned long depends on its architecture, although selinux-policy
is a "noarch" package.
The kernel should translate it into another format easier to handle
on run-time, if necessary.

> If/when we introduce support for reading back the currently loaded
> policy image from the kernel via a selinuxfs node for use by tools,
> we'll need conversion code to map the kernel representation back to the
> policy format.  libsepol has an ebitmap_write() function to generate a
> linear policy format representation from an in-memory policydb, which
> could be ported to the kernel (it used to be there too, actually, but
> was expunged because we didn't need it in the kernel code at the time),
> but naturally it only deals with the current representation.
>
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index ce492a6..de9ef55 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -328,85 +341,84 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  	if (rc < 0)
>  		goto out;
>  
> -	mapsize = le32_to_cpu(buf[0]);
> +	mapunit = le32_to_cpu(buf[0]);
>  	e->highbit = le32_to_cpu(buf[1]);
>  	count = le32_to_cpu(buf[2]);
>  
> -	if (mapsize != MAPSIZE) {
> +	/* round up e->highbit */
> +	e->highbit += EBITMAP_SIZE - 1;
> +	e->highbit -= (e->highbit % EBITMAP_SIZE);
> +
> +	if (mapunit != sizeof(u64) * 8) {
>  		printk(KERN_ERR "security: ebitmap: map size %u does not "
> -		       "match my size %Zd (high bit was %d)\n", mapsize,
> -		       MAPSIZE, e->highbit);
> +		       "match my size %Zd (high bit was %d)\n",
> +		       mapunit, sizeof(u64) * 8, e->highbit);
> 
> Here you will display the modified highbit value rather than the one
> that was actually in the policy image.  I think you can just move the
> check before mutating the highbit.

I moved it in front of rounding up e->highbit.

>  		goto bad;
>  	}
>  	if (!e->highbit) {
>  		e->node = NULL;
>  		goto ok;
>  	}
> -	if (e->highbit & (MAPSIZE - 1)) {
> -		printk(KERN_ERR "security: ebitmap: high bit (%d) is not a "
> -		       "multiple of the map size (%Zd)\n", e->highbit, MAPSIZE);
> -		goto bad;
> -	}
> 
> Not sure why you'd drop this sanity check.  As before, it would need to happen before mutating the highbit.

The reason why I dropped this sanity check is to avoid redundant one,
because e->highbit is already rounded up to the align of EBITMAP_SIZE.
The above condition is not always false.

> +		} else if (startbit <= n->startbit) {
> +			printk(KERN_ERR "security: ebitmap: start bit %d"
> +			       " comes after start bit %d\n",
> +			       startbit, n->startbit);
> 
> Need to bail out here with an appropriate rc value.

I added "goto bad;" at the point. It returns -EINVAL.

> diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
> index 1270e34..fc0ce05 100644
> --- a/security/selinux/ss/ebitmap.h
> +++ b/security/selinux/ss/ebitmap.h
> @@ -41,6 +42,19 @@ static inline unsigned int ebitmap_start(struct ebitmap *e,
>  	return ebitmap_startbit(e);
>  }
>  
> +static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
> +						  struct ebitmap_node **n)
> 
> I suspect we could just make these all "static" (not explicitly inline)
> and let the compiler do the right thing.  That seemed to be the trend
> upstream and guidance from arjan.

How should we do the explicitly inlined static functions used as stubs?

For example, ebitmap_netlbl_export() when NetLabel is not enabled is
defined as explicitly inlined function which always returns -ENOMEM,
however, these are also declarations of function when NetLabel is enabled.

> <snip>
>  static inline int ebitmap_node_get_bit(struct ebitmap_node * n,
>  				       unsigned int bit)
>  {
> -	if (n->map & (MAPBIT << (bit - n->startbit)))
> +	unsigned int ofs =   (bit - n->startbit) % EBITMAP_UNIT_SIZE;
> +	unsigned int index = (bit - n->startbit) / EBITMAP_UNIT_SIZE;
> 
> Possibly the computation of (ofs,index) should be a common macro since it is done in several of these
> functions.

I added EBITMAP_NODE_INDEX(node,bit) and EBITMAP_NODE_OFFSET(node,bit) to compute them.

> +	
> +	if (index < EBITMAP_UNIT_NUMS && (n->maps[index] & (EBITMAP_BIT << ofs)))
> 
> Possibly BUG_ON(index >= EBITMAP_UNIT_NUMS) instead of silently returning 0 in that case?

It is good idea indeed.
All caller of ebitmap_node_get_bit() always confirms 'bit' is in the range of
ebitmap_node. If the index overs EBITMAP_UNIT_NUMS, it is a bug surely.

> +#define ebitmap_for_each_bit(e, n, bit)			\
> +	for (bit = ebitmap_start(e, &n);		\
> +	     bit < ebitmap_length(e);			\
> +	     bit = ebitmap_next(&n, bit))		\
> 
> Ideally we'd kill off all uses of ebitmap_for_each_bit and use the _positive_ form in all cases,
> although I see that would require some changes to the mls logic.

ebitmap_start, ebitmap_next and ebitmap_for_each_bit are dropped.
The rest of codes using ebitmap_for_each_bit(), in ss/mls.c, are
also replaced with _positive_ version.

> +#define ebitmap_for_each_positive_bit(e, n, bit)	\
> +	for (bit = ebitmap_start_positive(e, &n);	\
> +	     bit < ebitmap_length(e);			\
> +	     bit = ebitmap_next_positive(e, &n, bit))	\
>  
>  int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
>  int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 4a8bab2..846314f 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -190,17 +190,17 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
>  		if (!levdatum)
>  			return 0;
>  
> -		ebitmap_for_each_bit(&c->range.level[l].cat, node, i) {
> -			if (ebitmap_node_get_bit(node, i)) {
> -				if (i > p->p_cats.nprim)
> -					return 0;
> -				if (!ebitmap_get_bit(&levdatum->level->cat, i))
> -					/*
> -					 * Category may not be associated with
> -					 * sensitivity in low level.
> -					 */
> -					return 0;
> -			}
> +		ebitmap_for_each_positive_bit(&c->range.level[l].cat, node, i) {
> +			// BUG_ON(!ebitmap_node_get_bit(node, i));
> 
> Drop these BUG_ON's out, or uncomment them if you want to keep them for now for testing purposes.

I dropped the BUG_ON() to confirm each bit is actually positive.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------070501070901050005060905
Content-Type: text/x-patch;
 name="ebitmap-bitops.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ebitmap-bitops.2.patch"

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index ce492a6..f03a347 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -10,6 +10,10 @@
  *
  * (c) Copyright Hewlett-Packard Development Company, L.P., 2006
  */
+/*
+ * Updated: KaiGai Kohei <kaigai@ak.jp.nec.com>
+ *      Applied standard bit operations to improve bitmap scanning.
+ */
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -29,7 +33,7 @@ int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
 	n2 = e2->node;
 	while (n1 && n2 &&
 	       (n1->startbit == n2->startbit) &&
-	       (n1->map == n2->map)) {
+	       !memcmp(n1->maps, n2->maps, EBITMAP_SIZE / 8)) {
 		n1 = n1->next;
 		n2 = n2->next;
 	}
@@ -54,7 +58,7 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
 			return -ENOMEM;
 		}
 		new->startbit = n->startbit;
-		new->map = n->map;
+		memcpy(new->maps, n->maps, EBITMAP_SIZE / 8);
 		new->next = NULL;
 		if (prev)
 			prev->next = new;
@@ -84,13 +88,15 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
 {
 	struct ebitmap_node *e_iter = ebmap->node;
 	struct netlbl_lsm_secattr_catmap *c_iter;
-	u32 cmap_idx;
+	u32 cmap_idx, cmap_sft;
+	int i;
 
-	/* This function is a much simpler because SELinux's MAPTYPE happens
-	 * to be the same as NetLabel's NETLBL_CATMAP_MAPTYPE, if MAPTYPE is
-	 * changed from a u64 this function will most likely need to be changed
-	 * as well.  It's not ideal but I think the tradeoff in terms of
-	 * neatness and speed is worth it. */
+	/* NetLabel's NETLBL_CATMAP_MAPTYPE is defined as an array of u64,
+	 * however, it is not always compatible with an array of unsigned long
+	 * in ebitmap_node.
+	 * In addition, you should pay attention the following implementation
+	 * assumes unsigned long has a width equal with or less than 64-bit.
+	 */ 
 
 	if (e_iter == NULL) {
 		*catmap = NULL;
@@ -104,19 +110,20 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
 	c_iter->startbit = e_iter->startbit & ~(NETLBL_CATMAP_SIZE - 1);
 
 	while (e_iter != NULL) {
-		if (e_iter->startbit >=
-		    (c_iter->startbit + NETLBL_CATMAP_SIZE)) {
-			c_iter->next = netlbl_secattr_catmap_alloc(GFP_ATOMIC);
-			if (c_iter->next == NULL)
-				goto netlbl_export_failure;
-			c_iter = c_iter->next;
-			c_iter->startbit = e_iter->startbit &
-				           ~(NETLBL_CATMAP_SIZE - 1);
+		for (i=0; i < EBITMAP_UNIT_NUMS; i++) {
+			unsigned int e_startbit = e_iter->startbit + i * EBITMAP_UNIT_SIZE;
+			if (e_startbit >= c_iter->startbit + NETLBL_CATMAP_SIZE) {
+				c_iter->next = netlbl_secattr_catmap_alloc(GFP_ATOMIC);
+				if (c_iter->next == NULL)
+					goto netlbl_export_failure;
+				c_iter = c_iter->next;
+				c_iter->startbit = e_startbit & ~(NETLBL_CATMAP_SIZE - 1);
+			}
+			cmap_idx = (e_startbit - c_iter->startbit) / NETLBL_CATMAP_MAPSIZE;
+			cmap_sft = (e_startbit - c_iter->startbit) % NETLBL_CATMAP_MAPSIZE;
+			c_iter->bitmap[cmap_idx] |= e_iter->maps[cmap_idx] << cmap_sft;
+			e_iter = e_iter->next;
 		}
-		cmap_idx = (e_iter->startbit - c_iter->startbit) /
-			   NETLBL_CATMAP_MAPSIZE;
-		c_iter->bitmap[cmap_idx] = e_iter->map;
-		e_iter = e_iter->next;
 	}
 
 	return 0;
@@ -128,7 +135,7 @@ netlbl_export_failure:
 
 /**
  * ebitmap_netlbl_import - Import a NetLabel category bitmap into an ebitmap
- * @ebmap: the ebitmap to export
+ * @ebmap: the ebitmap to import
  * @catmap: the NetLabel category bitmap
  *
  * Description:
@@ -142,36 +149,45 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
 	struct ebitmap_node *e_iter = NULL;
 	struct ebitmap_node *emap_prev = NULL;
 	struct netlbl_lsm_secattr_catmap *c_iter = catmap;
-	u32 c_idx;
+	u32 c_idx, c_pos, e_idx, e_sft;
 
-	/* This function is a much simpler because SELinux's MAPTYPE happens
-	 * to be the same as NetLabel's NETLBL_CATMAP_MAPTYPE, if MAPTYPE is
-	 * changed from a u64 this function will most likely need to be changed
-	 * as well.  It's not ideal but I think the tradeoff in terms of
-	 * neatness and speed is worth it. */
+	/* NetLabel's NETLBL_CATMAP_MAPTYPE is defined as an array of u64,
+	 * however, it is not always compatible with an array of unsigned long
+	 * in ebitmap_node.
+	 * In addition, you should pay attention the following implementation
+	 * assumes unsigned long has a width equal with or less than 64-bit.
+	 */ 
 
 	do {
 		for (c_idx = 0; c_idx < NETLBL_CATMAP_MAPCNT; c_idx++) {
-			if (c_iter->bitmap[c_idx] == 0)
+			u64 map = c_iter->bitmap[c_idx];
+
+			if (!map)
 				continue;
 
-			e_iter = kzalloc(sizeof(*e_iter), GFP_ATOMIC);
-			if (e_iter == NULL)
-				goto netlbl_import_failure;
-			if (emap_prev == NULL)
-				ebmap->node = e_iter;
-			else
-				emap_prev->next = e_iter;
-			emap_prev = e_iter;
-
-			e_iter->startbit = c_iter->startbit +
-				           NETLBL_CATMAP_MAPSIZE * c_idx;
-			e_iter->map = c_iter->bitmap[c_idx];
+			c_pos = c_iter->startbit + c_idx * NETLBL_CATMAP_MAPSIZE;
+			if (!e_iter || c_pos >= e_iter->startbit + EBITMAP_SIZE) {
+				e_iter = kzalloc(sizeof(*e_iter), GFP_ATOMIC);
+				if (!e_iter)
+					goto netlbl_import_failure;
+				e_iter->startbit = c_pos - (c_pos % EBITMAP_SIZE);
+				if (emap_prev == NULL)
+					ebmap->node = e_iter;
+				else
+					emap_prev->next = e_iter;
+				emap_prev = e_iter;
+			}
+			e_idx = (c_pos - e_iter->startbit) / EBITMAP_UNIT_SIZE;
+			e_sft = (c_pos - e_iter->startbit) % EBITMAP_UNIT_SIZE;
+			while (map) {
+				e_iter->maps[e_idx++] |= map & (-1UL);
+				map >>= EBITMAP_UNIT_SIZE;
+			}
 		}
 		c_iter = c_iter->next;
 	} while (c_iter != NULL);
 	if (e_iter != NULL)
-		ebmap->highbit = e_iter->startbit + MAPSIZE;
+		ebmap->highbit = e_iter->startbit + EBITMAP_SIZE;
 	else
 		ebitmap_destroy(ebmap);
 
@@ -186,6 +202,7 @@ netlbl_import_failure:
 int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2)
 {
 	struct ebitmap_node *n1, *n2;
+	int i;
 
 	if (e1->highbit < e2->highbit)
 		return 0;
@@ -197,8 +214,10 @@ int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2)
 			n1 = n1->next;
 			continue;
 		}
-		if ((n1->map & n2->map) != n2->map)
-			return 0;
+		for (i=0; i < EBITMAP_UNIT_NUMS; i++) {
+			if ((n1->maps[i] & n2->maps[i]) != n2->maps[i])
+				return 0;
+		}
 
 		n1 = n1->next;
 		n2 = n2->next;
@@ -219,12 +238,8 @@ int ebitmap_get_bit(struct ebitmap *e, unsigned long bit)
 
 	n = e->node;
 	while (n && (n->startbit <= bit)) {
-		if ((n->startbit + MAPSIZE) > bit) {
-			if (n->map & (MAPBIT << (bit - n->startbit)))
-				return 1;
-			else
-				return 0;
-		}
+		if ((n->startbit + EBITMAP_SIZE) > bit)
+			return ebitmap_node_get_bit(n, bit);
 		n = n->next;
 	}
 
@@ -238,31 +253,31 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
 	prev = NULL;
 	n = e->node;
 	while (n && n->startbit <= bit) {
-		if ((n->startbit + MAPSIZE) > bit) {
+		if ((n->startbit + EBITMAP_SIZE) > bit) {
 			if (value) {
-				n->map |= (MAPBIT << (bit - n->startbit));
+				ebitmap_node_set_bit(n, bit);
 			} else {
-				n->map &= ~(MAPBIT << (bit - n->startbit));
-				if (!n->map) {
-					/* drop this node from the bitmap */
-
-					if (!n->next) {
-						/*
-						 * this was the highest map
-						 * within the bitmap
-						 */
-						if (prev)
-							e->highbit = prev->startbit + MAPSIZE;
-						else
-							e->highbit = 0;
-					}
+				ebitmap_node_clr_bit(n, bit);
+
+				if (find_first_bit(n->maps, EBITMAP_SIZE) < EBITMAP_SIZE)
+					return 0;
+
+				/* drop this node from the bitmap */
+				if (!n->next) {
+					/*
+					 * this was the highest map
+					 * within the bitmap
+					 */
 					if (prev)
-						prev->next = n->next;
+						e->highbit = prev->startbit + EBITMAP_SIZE;
 					else
-						e->node = n->next;
-
-					kfree(n);
+						e->highbit = 0;
 				}
+				if (prev)
+					prev->next = n->next;
+				else
+					e->node = n->next;
+				kfree(n);
 			}
 			return 0;
 		}
@@ -277,12 +292,12 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
 	if (!new)
 		return -ENOMEM;
 
-	new->startbit = bit & ~(MAPSIZE - 1);
-	new->map = (MAPBIT << (bit - new->startbit));
+	new->startbit = bit - (bit % EBITMAP_SIZE);
+	ebitmap_node_set_bit(new, bit);
 
 	if (!n)
 		/* this node will be the highest map within the bitmap */
-		e->highbit = new->startbit + MAPSIZE;
+		e->highbit = new->startbit + EBITMAP_SIZE;
 
 	if (prev) {
 		new->next = prev->next;
@@ -316,11 +331,11 @@ void ebitmap_destroy(struct ebitmap *e)
 
 int ebitmap_read(struct ebitmap *e, void *fp)
 {
-	int rc;
-	struct ebitmap_node *n, *l;
+	struct ebitmap_node *n = NULL;
+	u32 mapunit, count, startbit, index;
+	u64 map;
 	__le32 buf[3];
-	u32 mapsize, count, i;
-	__le64 map;
+	int rc, i;
 
 	ebitmap_init(e);
 
@@ -328,85 +343,86 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	if (rc < 0)
 		goto out;
 
-	mapsize = le32_to_cpu(buf[0]);
+	mapunit = le32_to_cpu(buf[0]);
 	e->highbit = le32_to_cpu(buf[1]);
 	count = le32_to_cpu(buf[2]);
 
-	if (mapsize != MAPSIZE) {
+	if (mapunit != sizeof(u64) * 8) {
 		printk(KERN_ERR "security: ebitmap: map size %u does not "
-		       "match my size %Zd (high bit was %d)\n", mapsize,
-		       MAPSIZE, e->highbit);
+		       "match my size %Zd (high bit was %d)\n",
+		       mapunit, sizeof(u64) * 8, e->highbit);
 		goto bad;
 	}
+
+	/* round up e->highbit */
+	e->highbit += EBITMAP_SIZE - 1;
+	e->highbit -= (e->highbit % EBITMAP_SIZE);
+
 	if (!e->highbit) {
 		e->node = NULL;
 		goto ok;
 	}
-	if (e->highbit & (MAPSIZE - 1)) {
-		printk(KERN_ERR "security: ebitmap: high bit (%d) is not a "
-		       "multiple of the map size (%Zd)\n", e->highbit, MAPSIZE);
-		goto bad;
-	}
-	l = NULL;
+
 	for (i = 0; i < count; i++) {
-		rc = next_entry(buf, fp, sizeof(u32));
+		rc = next_entry(&startbit, fp, sizeof(u32));
 		if (rc < 0) {
 			printk(KERN_ERR "security: ebitmap: truncated map\n");
 			goto bad;
 		}
-		n = kzalloc(sizeof(*n), GFP_KERNEL);
-		if (!n) {
-			printk(KERN_ERR "security: ebitmap: out of memory\n");
-			rc = -ENOMEM;
-			goto bad;
-		}
-
-		n->startbit = le32_to_cpu(buf[0]);
+		startbit = le32_to_cpu(startbit);
 
-		if (n->startbit & (MAPSIZE - 1)) {
+		if (startbit & (mapunit - 1)) {
 			printk(KERN_ERR "security: ebitmap start bit (%d) is "
-			       "not a multiple of the map size (%Zd)\n",
-			       n->startbit, MAPSIZE);
-			goto bad_free;
+			       "not a multiple of the map unit size (%Zd)\n",
+			       startbit, mapunit);
+			goto bad;
 		}
-		if (n->startbit > (e->highbit - MAPSIZE)) {
+		if (startbit > e->highbit - mapunit) {
 			printk(KERN_ERR "security: ebitmap start bit (%d) is "
 			       "beyond the end of the bitmap (%Zd)\n",
-			       n->startbit, (e->highbit - MAPSIZE));
-			goto bad_free;
+			       startbit, (e->highbit - mapunit));
+			goto bad;
+		}
+
+		if (!n || startbit >= n->startbit + EBITMAP_SIZE) {
+			struct ebitmap_node *_n = kzalloc(sizeof(*_n), GFP_KERNEL);
+			if (!_n) {
+				printk(KERN_ERR "security: ebitmap: out of memory\n");
+				rc = -ENOMEM;
+				goto bad;
+			}
+			_n->startbit = startbit - (startbit % EBITMAP_SIZE); /* round down */
+			if (n) {
+				n->next = _n;
+			} else {
+				e->node = _n;
+			}
+			n = _n;
+		} else if (startbit <= n->startbit) {
+			printk(KERN_ERR "security: ebitmap: start bit %d"
+			       " comes after start bit %d\n",
+			       startbit, n->startbit);
+			goto bad;
 		}
+
 		rc = next_entry(&map, fp, sizeof(u64));
 		if (rc < 0) {
 			printk(KERN_ERR "security: ebitmap: truncated map\n");
-			goto bad_free;
+			goto bad;
 		}
-		n->map = le64_to_cpu(map);
+		map = le64_to_cpu(map);
 
-		if (!n->map) {
-			printk(KERN_ERR "security: ebitmap: null map in "
-			       "ebitmap (startbit %d)\n", n->startbit);
-			goto bad_free;
+		index = (startbit - n->startbit) / EBITMAP_UNIT_SIZE;
+		while (map) {
+			n->maps[index] = map & (-1UL);
+			map = map >> EBITMAP_UNIT_SIZE;
+			index++;
 		}
-		if (l) {
-			if (n->startbit <= l->startbit) {
-				printk(KERN_ERR "security: ebitmap: start "
-				       "bit %d comes after start bit %d\n",
-				       n->startbit, l->startbit);
-				goto bad_free;
-			}
-			l->next = n;
-		} else
-			e->node = n;
-
-		l = n;
 	}
-
 ok:
 	rc = 0;
 out:
 	return rc;
-bad_free:
-	kfree(n);
 bad:
 	if (!rc)
 		rc = -EINVAL;
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 1270e34..a07e8d9 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -16,14 +16,15 @@
 
 #include <net/netlabel.h>
 
-#define MAPTYPE u64			/* portion of bitmap in each node */
-#define MAPSIZE (sizeof(MAPTYPE) * 8)	/* number of bits in node bitmap */
-#define MAPBIT  1ULL			/* a bit in the node bitmap */
+#define EBITMAP_UNIT_NUMS	((32 - sizeof(void *) - sizeof(u32)) / sizeof(unsigned long))
+#define EBITMAP_UNIT_SIZE	BITS_PER_LONG
+#define EBITMAP_SIZE		(EBITMAP_UNIT_NUMS * EBITMAP_UNIT_SIZE)
+#define EBITMAP_BIT		1ULL
 
 struct ebitmap_node {
-	u32 startbit;		/* starting position in the total bitmap */
-	MAPTYPE map;		/* this node's portion of the bitmap */
 	struct ebitmap_node *next;
+	unsigned long maps[EBITMAP_UNIT_NUMS];
+	u32 startbit;
 };
 
 struct ebitmap {
@@ -34,11 +35,17 @@ struct ebitmap {
 #define ebitmap_length(e) ((e)->highbit)
 #define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
 
-static inline unsigned int ebitmap_start(struct ebitmap *e,
-					 struct ebitmap_node **n)
+static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
+						  struct ebitmap_node **n)
 {
-	*n = e->node;
-	return ebitmap_startbit(e);
+	unsigned int ofs;
+
+	for (*n = e->node; *n; *n = (*n)->next) {
+		ofs = find_first_bit((*n)->maps, EBITMAP_SIZE);
+		if (ofs < EBITMAP_SIZE)
+			return (*n)->startbit + ofs;
+	}
+	return ebitmap_length(e);
 }
 
 static inline void ebitmap_init(struct ebitmap *e)
@@ -46,28 +53,68 @@ static inline void ebitmap_init(struct ebitmap *e)
 	memset(e, 0, sizeof(*e));
 }
 
-static inline unsigned int ebitmap_next(struct ebitmap_node **n,
-					unsigned int bit)
+static inline unsigned int ebitmap_next_positive(struct ebitmap *e,
+						 struct ebitmap_node **n,
+						 unsigned int bit)
 {
-	if ((bit == ((*n)->startbit + MAPSIZE - 1)) &&
-	    (*n)->next) {
-		*n = (*n)->next;
-		return (*n)->startbit;
-	}
+	unsigned int ofs;
+
+	ofs = find_next_bit((*n)->maps, EBITMAP_SIZE, bit - (*n)->startbit + 1);
+	if (ofs < EBITMAP_SIZE)
+		return ofs + (*n)->startbit;
 
-	return (bit+1);
+	for (*n = (*n)->next; *n; *n = (*n)->next) {
+		ofs = find_first_bit((*n)->maps, EBITMAP_SIZE);
+		if (ofs < EBITMAP_SIZE)
+			return ofs + (*n)->startbit;
+	}
+	return ebitmap_length(e);
 }
 
+#define EBITMAP_NODE_INDEX(node, bit)	(((bit) - (node)->startbit) / EBITMAP_UNIT_SIZE)
+#define EBITMAP_NODE_OFFSET(node, bit)	(((bit) - (node)->startbit) % EBITMAP_UNIT_SIZE)
+
 static inline int ebitmap_node_get_bit(struct ebitmap_node * n,
 				       unsigned int bit)
 {
-	if (n->map & (MAPBIT << (bit - n->startbit)))
+	unsigned int index = EBITMAP_NODE_INDEX(n,bit);
+	unsigned int ofs = EBITMAP_NODE_OFFSET(n,bit);
+
+	BUG_ON(index >= EBITMAP_UNIT_NUMS);
+	if ((n->maps[index] & (EBITMAP_BIT << ofs)))
 		return 1;
 	return 0;
 }
 
-#define ebitmap_for_each_bit(e, n, bit) \
-	for (bit = ebitmap_start(e, &n); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
+static inline void ebitmap_node_set_bit(struct ebitmap_node * n,
+					unsigned int bit)
+{
+	unsigned int index = EBITMAP_NODE_INDEX(n,bit);
+	unsigned int ofs = EBITMAP_NODE_OFFSET(n,bit);
+
+	BUG_ON(index >= EBITMAP_UNIT_NUMS);
+	n->maps[index] |= (EBITMAP_BIT << ofs);
+}
+
+static inline void ebitmap_node_clr_bit(struct ebitmap_node * n,
+					unsigned int bit)
+{
+	unsigned int index = EBITMAP_NODE_INDEX(n,bit);
+	unsigned int ofs = EBITMAP_NODE_OFFSET(n,bit);
+
+	BUG_ON(index >= EBITMAP_UNIT_NUMS);
+	n->maps[index] &= ~(EBITMAP_BIT << ofs);
+}
+
+#define ebitmap_for_each_bit(e, n, bit)			\
+	for (bit = ebitmap_start(e, &n);		\
+	     bit < ebitmap_length(e);			\
+	     bit = ebitmap_next(&n, bit))		\
+
+#define ebitmap_for_each_positive_bit(e, n, bit)	\
+	for (bit = ebitmap_start_positive(e, &n);	\
+	     bit < ebitmap_length(e);			\
+	     bit = ebitmap_next_positive(e, &n, bit))	\
 
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 4a8bab2..98f4c12 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -34,7 +34,7 @@
  */
 int mls_compute_context_len(struct context * context)
 {
-	int i, l, len, range;
+	int i, l, len, head, prev;
 	struct ebitmap_node *node;
 
 	if (!selinux_mls_enabled)
@@ -42,31 +42,25 @@ int mls_compute_context_len(struct context * context)
 
 	len = 1; /* for the beginning ":" */
 	for (l = 0; l < 2; l++) {
-		range = 0;
 		len += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
 
-		ebitmap_for_each_bit(&context->range.level[l].cat, node, i) {
-			if (ebitmap_node_get_bit(node, i)) {
-				if (range) {
-					range++;
-					continue;
-				}
-
+		/* categories */
+		head = prev = -2;
+		ebitmap_for_each_positive_bit(&context->range.level[l].cat, node, i) {
+			if (i - prev > 1) {
+				/* one or more negative bits are skipped, at least. */
+				if (head != prev)
+					len += strlen(policydb.p_cat_val_to_name[prev]) + 1;
 				len += strlen(policydb.p_cat_val_to_name[i]) + 1;
-				range++;
-			} else {
-				if (range > 1)
-					len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
-				range = 0;
+				head = i;
 			}
+			prev = i;
 		}
-		/* Handle case where last category is the end of range */
-		if (range > 1)
-			len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
-
+		if (prev != head)
+			len += strlen(policydb.p_cat_val_to_name[prev]) + 1;
 		if (l == 0) {
 			if (mls_level_eq(&context->range.level[0],
-			                 &context->range.level[1]))
+					 &context->range.level[1]))
 				break;
 			else
 				len++;
@@ -85,7 +79,7 @@ void mls_sid_to_context(struct context *context,
                         char **scontext)
 {
 	char *scontextp;
-	int i, l, range, wrote_sep;
+	int i, l, head, prev;
 	struct ebitmap_node *node;
 
 	if (!selinux_mls_enabled)
@@ -97,61 +91,49 @@ void mls_sid_to_context(struct context *context,
 	scontextp++;
 
 	for (l = 0; l < 2; l++) {
-		range = 0;
-		wrote_sep = 0;
 		strcpy(scontextp,
 		       policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
-		scontextp += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
+		scontextp += strlen(scontextp);
 
 		/* categories */
-		ebitmap_for_each_bit(&context->range.level[l].cat, node, i) {
-			if (ebitmap_node_get_bit(node, i)) {
-				if (range) {
-					range++;
-					continue;
-				}
-
-				if (!wrote_sep) {
-					*scontextp++ = ':';
-					wrote_sep = 1;
-				} else
-					*scontextp++ = ',';
-				strcpy(scontextp, policydb.p_cat_val_to_name[i]);
-				scontextp += strlen(policydb.p_cat_val_to_name[i]);
-				range++;
-			} else {
-				if (range > 1) {
-					if (range > 2)
+		head = prev = -2;
+		ebitmap_for_each_positive_bit(&context->range.level[l].cat, node, i) {
+			if (i - prev > 1) {
+				/* one or more negative bits are skipped, at least. */
+				if (prev != head) {
+					if (prev - head > 1)
 						*scontextp++ = '.';
 					else
 						*scontextp++ = ',';
-
-					strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
-					scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
+					strcpy(scontextp, policydb.p_cat_val_to_name[prev]);
+					scontextp += strlen(scontextp);
 				}
-				range = 0;
+				if (prev < 0)
+					*scontextp++ = ':';
+				else
+					*scontextp++ = ',';
+				strcpy(scontextp, policydb.p_cat_val_to_name[i]);
+				scontextp += strlen(scontextp);
+				head = i;
 			}
+			prev = i;
 		}
 
-		/* Handle case where last category is the end of range */
-		if (range > 1) {
-			if (range > 2)
+		if (prev != head) {
+			if (prev - head > 1)
 				*scontextp++ = '.';
 			else
 				*scontextp++ = ',';
-
-			strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
-			scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
+			strcpy(scontextp, policydb.p_cat_val_to_name[prev]);
+			scontextp += strlen(scontextp);
 		}
 
 		if (l == 0) {
 			if (mls_level_eq(&context->range.level[0],
 			                 &context->range.level[1]))
 				break;
-			else {
-				*scontextp = '-';
-				scontextp++;
-			}
+			else
+				*scontextp++ = '-';
 		}
 	}
 
@@ -190,17 +172,15 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
 		if (!levdatum)
 			return 0;
 
-		ebitmap_for_each_bit(&c->range.level[l].cat, node, i) {
-			if (ebitmap_node_get_bit(node, i)) {
-				if (i > p->p_cats.nprim)
-					return 0;
-				if (!ebitmap_get_bit(&levdatum->level->cat, i))
-					/*
-					 * Category may not be associated with
-					 * sensitivity in low level.
-					 */
-					return 0;
-			}
+		ebitmap_for_each_positive_bit(&c->range.level[l].cat, node, i) {
+			if (i > p->p_cats.nprim)
+				return 0;
+			if (!ebitmap_get_bit(&levdatum->level->cat, i))
+				/*
+				 * Category may not be associated with
+				 * sensitivity in low level.
+				 */
+				return 0;
 		}
 	}
 
@@ -485,18 +465,16 @@ int mls_convert_context(struct policydb *oldp,
 		c->range.level[l].sens = levdatum->level->sens;
 
 		ebitmap_init(&bitmap);
-		ebitmap_for_each_bit(&c->range.level[l].cat, node, i) {
-			if (ebitmap_node_get_bit(node, i)) {
-				int rc;
-
-				catdatum = hashtab_search(newp->p_cats.table,
-				         	oldp->p_cat_val_to_name[i]);
-				if (!catdatum)
-					return -EINVAL;
-				rc = ebitmap_set_bit(&bitmap, catdatum->value - 1, 1);
-				if (rc)
-					return rc;
-			}
+		ebitmap_for_each_positive_bit(&c->range.level[l].cat, node, i) {
+			int rc;
+
+			catdatum = hashtab_search(newp->p_cats.table,
+						  oldp->p_cat_val_to_name[i]);
+			if (!catdatum)
+				return -EINVAL;
+			rc = ebitmap_set_bit(&bitmap, catdatum->value - 1, 1);
+			if (rc)
+				return rc;
 		}
 		ebitmap_destroy(&c->range.level[l].cat);
 		c->range.level[l].cat = bitmap;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 6100fc0..19be935 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -329,12 +329,8 @@ static int context_struct_compute_av(struct context *scontext,
 	avkey.specified = AVTAB_AV;
 	sattr = &policydb.type_attr_map[scontext->type - 1];
 	tattr = &policydb.type_attr_map[tcontext->type - 1];
-	ebitmap_for_each_bit(sattr, snode, i) {
-		if (!ebitmap_node_get_bit(snode, i))
-			continue;
-		ebitmap_for_each_bit(tattr, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+	ebitmap_for_each_positive_bit(sattr, snode, i) {
+		ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			avkey.source_type = i + 1;
 			avkey.target_type = j + 1;
 			for (node = avtab_search_node(&policydb.te_avtab, &avkey);
@@ -1621,14 +1617,10 @@ int security_get_user_sids(u32 fromsid,
 		goto out_unlock;
 	}
 
-	ebitmap_for_each_bit(&user->roles, rnode, i) {
-		if (!ebitmap_node_get_bit(rnode, i))
-			continue;
+	ebitmap_for_each_positive_bit(&user->roles, rnode, i) {
 		role = policydb.role_val_to_struct[i];
 		usercon.role = i+1;
-		ebitmap_for_each_bit(&role->types, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+		ebitmap_for_each_positive_bit(&role->types, tnode, j) {
 			usercon.type = j+1;
 
 			if (mls_setup_user_range(fromcon, user, &usercon))

--------------070501070901050005060905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
