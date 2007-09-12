Message-ID: <46E7583C.9030103@ak.jp.nec.com>
Date: Wed, 12 Sep 2007 12:08:44 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: [patch] Tuning avtab to reduce memory usage
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <200708211111.27019.paul.moore@hp.com> <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil> <200708211255.45132.paul.moore@hp.com> <46CC00F4.2090501@ak.jp.nec.com>
In-Reply-To: <46CC00F4.2090501@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------040503000308030405040605"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040503000308030405040605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch applies the standard bitmap operations
for the iteration macro of ebitmap, and enables to improve
the performance in AVC-misses case.

Real-time responsibility is a significant issue for embedded
Linux people. This patch also reduce amount of busy loop in
the kernel, so it can improve real-time responsibility.

I added ebitmap_for_each_positive_bit() macro not to walk
on any native bit within ebitmap, and applies it on
  - context_struct_compute_av()
  - security_get_user_sids()
  - mls_context_isvalid()

ebitmap_node was redefined as follows:
   #define EBITMAP_UNIT_NUMS      \
         ((32 - sizeof(void *) - sizeof(u32)) / sizeof(unsigned long))
   struct ebitmap_node {
       struct ebitmap_node *next;
       unsigned long maps[EBITMAP_UNIT_NUMS];
       u32 startbit;
   };

"u64 map" is replaced by an array of "unsigned long". It enables to
apply standard bit operations. In addition, length of the array is
determind to fit 32-bytes, the minimum size of kmalloc().

The result of benchmarks seems to me fine.

       selinux-2.6      selinux-2.6-ebitmap
AVG:   22.763 [s]          8.750 [s]
STD:    0.265              0.019
------------------------------------------
1st:   22.558 [s]          8.786 [s]
2nd:   22.458 [s]          8.750 [s]
3rd:   22.478 [s]          8.754 [s]
4th:   22.724 [s]          8.745 [s]
5th:   22.918 [s]          8.748 [s]
6th:   22.905 [s]          8.764 [s]
7th:   23.238 [s]          8.726 [s]
8th:   22.822 [s]          8.729 [s]

NOTE: We used the following operatins as a test case.
       No need to say, it is a corner case to highlight.
[root@saba ~]# id -Z
root:system_r:unconfined_t:SystemLow-SystemHigh
[root@saba ~]# cd /dev/shm
[root@saba shm]# for I in `seq 1 640`
 > do
 >     echo > file${I}
 >     chcon -l s0:c${I} file${I}
 > done
[root@saba shm]# ~kaigai/manyfiles 800 file*

I also attached "manyfiles.c" to reproduce them.

In addition, we could not make sure a statistical difference
in the AVC-hits case.

Thanks,

KaiGai Kohei wrote:
> Paul Moore wrote:
>> On Tuesday, August 21 2007 12:37:49 pm Stephen Smalley wrote:
>>> On Tue, 2007-08-21 at 11:11 -0400, Paul Moore wrote:
>>>> On Tuesday, August 21 2007 9:47:38 am Stephen Smalley wrote:
>>>>> We likely should look at optimizing the ebitmap code, or replacing it
>>>>> with the native kernel bitmaps (include/linux/bitmap.h, lib/bitmap.c).
>>>>> For example, ebitmap_next could possibly use find_next_bit().
>>>> [Removed the busybox list because I'm sure they don't care]
>>>>
>>>> Would the fact that the MLS category bitmaps grow to 1024 bits be a
>>>> concern with using a single contiguous bitmap instead of the sparse
>>>> bitmap the ebitmap currently uses?  Granted, in the worst case of
>>>> c0.c1023 the kernel bitmap would most certainly be better but I wonder
>>>> what the common case is (and if the MLS compartments even factor 
>>>> into the
>>>> discussion) and which type is better suited to handle this case.
>>> Even if we retain the ebitmap type as a sparse bitmap, I think we can do
>>> some optimization of its internals, possibly leveraging things like
>>> find_next_bit(), to speed up the loops that were introduced when we
>>> optimized the avtab memory layout by pushing attributes down into the
>>> kernel policy (policy.20).
>>>
>>> Trying Yuichi's simple instrumentation of security_compute_av, I see a
>>> huge difference in security_compute_av times between policy.19 and
>>> policy.20.  We knew it would slow security_compute_av down (standard
>>> tradeoff between runtime performance and memory use), but the thinking
>>> at the time was that it wouldn't matter because of the AVC.  But we do
>>> have to bound our worst case latency.
>>
>> I understand, I was just slightly concerned about losing the sparse 
>> bitmap feature which I have a hunch is beneficial in the MLS 
>> compartment case.  Although I will readily admit I have no data to 
>> support this claim, I just wanted to throw it out as something to 
>> consider.
> 
> I think the sparse bitmap feature is also useful to skip unnecessary scan
> on the ebitmap, so these features should be used together.
> 
> The current version of ebitmap contains a 64-bit length bitmap.
> I have a concern to apply the standard bitops, and memory usage.
> 
> The one is a difference in the type of variable.
> find_next_bit() requires the bitmap defined as unsigned long array,
> but ebitmap uses a u64 value as a bitmap, so we cannot apply it as is.
> 
> The other is memory usage. The ebitmap_node is allocated by kzalloc().
> However, sizeof(ebitmap_node) is 16-byte in 32bit arch, although
> the minimun unit of kmalloc() is 32 byte.
> 
> In 32-bit arch, map should be defined as 'unsigned long map[6]'
> to apply the standard bitops and to maximun memory usage.
> 
> Thanks,


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------040503000308030405040605
Content-Type: text/x-patch;
 name="ebitmap-bitops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ebitmap-bitops.patch"

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index ce492a6..de9ef55 100644
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
@@ -84,7 +88,8 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
 {
 	struct ebitmap_node *e_iter = ebmap->node;
 	struct netlbl_lsm_secattr_catmap *c_iter;
-	u32 cmap_idx;
+	u32 cmap_idx, cmap_sft;
+	int i;
 
 	/* This function is a much simpler because SELinux's MAPTYPE happens
 	 * to be the same as NetLabel's NETLBL_CATMAP_MAPTYPE, if MAPTYPE is
@@ -104,19 +109,20 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
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
@@ -128,7 +134,7 @@ netlbl_export_failure:
 
 /**
  * ebitmap_netlbl_import - Import a NetLabel category bitmap into an ebitmap
- * @ebmap: the ebitmap to export
+ * @ebmap: the ebitmap to import
  * @catmap: the NetLabel category bitmap
  *
  * Description:
@@ -142,7 +148,7 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
 	struct ebitmap_node *e_iter = NULL;
 	struct ebitmap_node *emap_prev = NULL;
 	struct netlbl_lsm_secattr_catmap *c_iter = catmap;
-	u32 c_idx;
+	u32 c_idx, c_pos, e_idx, e_sft;
 
 	/* This function is a much simpler because SELinux's MAPTYPE happens
 	 * to be the same as NetLabel's NETLBL_CATMAP_MAPTYPE, if MAPTYPE is
@@ -152,26 +158,34 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
 
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
 
@@ -186,6 +200,7 @@ netlbl_import_failure:
 int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2)
 {
 	struct ebitmap_node *n1, *n2;
+	int i;
 
 	if (e1->highbit < e2->highbit)
 		return 0;
@@ -197,8 +212,10 @@ int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2)
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
@@ -219,12 +236,8 @@ int ebitmap_get_bit(struct ebitmap *e, unsigned long bit)
 
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
 
@@ -238,31 +251,31 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
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
@@ -277,12 +290,12 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
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
@@ -316,11 +329,11 @@ void ebitmap_destroy(struct ebitmap *e)
 
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
 
@@ -328,85 +341,84 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	if (rc < 0)
 		goto out;
 
-	mapsize = le32_to_cpu(buf[0]);
+	mapunit = le32_to_cpu(buf[0]);
 	e->highbit = le32_to_cpu(buf[1]);
 	count = le32_to_cpu(buf[2]);
 
-	if (mapsize != MAPSIZE) {
+	/* round up e->highbit */
+	e->highbit += EBITMAP_SIZE - 1;
+	e->highbit -= (e->highbit % EBITMAP_SIZE);
+
+	if (mapunit != sizeof(u64) * 8) {
 		printk(KERN_ERR "security: ebitmap: map size %u does not "
-		       "match my size %Zd (high bit was %d)\n", mapsize,
-		       MAPSIZE, e->highbit);
+		       "match my size %Zd (high bit was %d)\n",
+		       mapunit, sizeof(u64) * 8, e->highbit);
 		goto bad;
 	}
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
 		}
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
+		}
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
index 1270e34..fc0ce05 100644
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
@@ -41,6 +42,19 @@ static inline unsigned int ebitmap_start(struct ebitmap *e,
 	return ebitmap_startbit(e);
 }
 
+static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
+						  struct ebitmap_node **n)
+{
+	unsigned int ofs;
+
+	for (*n = e->node; *n; *n = (*n)->next) {
+		ofs = find_first_bit((*n)->maps, EBITMAP_SIZE);
+		if (ofs < EBITMAP_SIZE)
+			return (*n)->startbit + ofs;
+	}
+	return ebitmap_length(e);
+}
+
 static inline void ebitmap_init(struct ebitmap *e)
 {
 	memset(e, 0, sizeof(*e));
@@ -49,7 +63,7 @@ static inline void ebitmap_init(struct ebitmap *e)
 static inline unsigned int ebitmap_next(struct ebitmap_node **n,
 					unsigned int bit)
 {
-	if ((bit == ((*n)->startbit + MAPSIZE - 1)) &&
+	if ((bit == ((*n)->startbit + EBITMAP_SIZE - 1)) &&
 	    (*n)->next) {
 		*n = (*n)->next;
 		return (*n)->startbit;
@@ -58,16 +72,64 @@ static inline unsigned int ebitmap_next(struct ebitmap_node **n,
 	return (bit+1);
 }
 
+static inline unsigned int ebitmap_next_positive(struct ebitmap *e,
+						 struct ebitmap_node **n,
+						 unsigned int bit)
+{
+	unsigned int ofs;
+
+	ofs = find_next_bit((*n)->maps, EBITMAP_SIZE, bit - (*n)->startbit + 1);
+	if (ofs < EBITMAP_SIZE)
+		return ofs + (*n)->startbit;
+
+	for (*n = (*n)->next; *n; *n = (*n)->next) {
+		ofs = find_first_bit((*n)->maps, EBITMAP_SIZE);
+		if (ofs < EBITMAP_SIZE)
+			return ofs + (*n)->startbit;
+	}
+	return ebitmap_length(e);
+}
+
 static inline int ebitmap_node_get_bit(struct ebitmap_node * n,
 				       unsigned int bit)
 {
-	if (n->map & (MAPBIT << (bit - n->startbit)))
+	unsigned int ofs =   (bit - n->startbit) % EBITMAP_UNIT_SIZE;
+	unsigned int index = (bit - n->startbit) / EBITMAP_UNIT_SIZE;
+	
+	if (index < EBITMAP_UNIT_NUMS && (n->maps[index] & (EBITMAP_BIT << ofs)))
 		return 1;
 	return 0;
 }
 
-#define ebitmap_for_each_bit(e, n, bit) \
-	for (bit = ebitmap_start(e, &n); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
+static inline void ebitmap_node_set_bit(struct ebitmap_node * n,
+					unsigned int bit)
+{
+	unsigned int index = (bit - n->startbit) / EBITMAP_UNIT_SIZE;
+	unsigned int ofs   = (bit - n->startbit) % EBITMAP_UNIT_SIZE;
+
+	if (index < EBITMAP_UNIT_NUMS)
+		n->maps[index] |= (EBITMAP_BIT << ofs);
+}
+
+static inline void ebitmap_node_clr_bit(struct ebitmap_node * n,
+					unsigned int bit)
+{
+	unsigned int index = (bit - n->startbit) / EBITMAP_UNIT_SIZE;
+	unsigned int ofs   = (bit - n->startbit) % EBITMAP_UNIT_SIZE;
+
+	if (index < EBITMAP_UNIT_NUMS)
+		n->maps[index] &= ~(EBITMAP_BIT << ofs);
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
index 4a8bab2..846314f 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -190,17 +190,17 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
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
+			// BUG_ON(!ebitmap_node_get_bit(node, i));
+
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
 
@@ -485,18 +485,17 @@ int mls_convert_context(struct policydb *oldp,
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
+			// BUG_ON(!ebitmap_node_get_bit(node, i));
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
index 40660ff..0729996 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -329,12 +329,12 @@ static int context_struct_compute_av(struct context *scontext,
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
+		// BUG_ON(!ebitmap_node_get_bit(snode, i));
+
+		ebitmap_for_each_positive_bit(tattr, tnode, j) {
+			// BUG_ON(!ebitmap_node_get_bit(tnode, j));
+
 			avkey.source_type = i + 1;
 			avkey.target_type = j + 1;
 			for (node = avtab_search_node(&policydb.te_avtab, &avkey);
@@ -1622,14 +1622,14 @@ int security_get_user_sids(u32 fromsid,
 		goto out_unlock;
 	}
 
-	ebitmap_for_each_bit(&user->roles, rnode, i) {
-		if (!ebitmap_node_get_bit(rnode, i))
-			continue;
+	ebitmap_for_each_positive_bit(&user->roles, rnode, i) {
+		// BUG_ON(!ebitmap_node_get_bit(rnode, i));
+
 		role = policydb.role_val_to_struct[i];
 		usercon.role = i+1;
-		ebitmap_for_each_bit(&role->types, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+		ebitmap_for_each_positive_bit(&role->types, tnode, j) {
+			// BUG_ON(!ebitmap_node_get_bit(tnode, j));
+
 			usercon.type = j+1;
 
 			if (mls_setup_user_range(fromcon, user, &usercon))

--------------040503000308030405040605
Content-Type: text/plain;
 name="manyfiles.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="manyfiles.c"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

static void usage(int exitcode) {
    fprintf(stderr, "usage: manyfiles <# of loop> <files ...>\n");
    exit(exitcode);
}

#define TEST_STR "abcdefghijklmnopqrstuvwxyz0123456789\n"

int main(int argc, char *argv[]) {
    char buffer[128];
    int i, j, nloops, nfiles, *fd;
    struct timeval t1, t2;
    double delta;

    if (argc < 3)
	usage(1);

    nloops = atoi(argv[1]);
    if (nloops < 1)
	nloops = 1;

    fd = malloc(sizeof(int *) * argc);
    if (!fd) {
	fprintf(stderr, "could not allocate memory (%s)\n", strerror(errno));
	return 1;
    }

    for (i=2, nfiles=0; argv[i]; i++) {
	fd[nfiles] = open(argv[i], O_RDWR | O_CREAT, 0644);
	if (fd[nfiles] < 0) {
	    fprintf(stderr, "could not open %s (%s)\n",
		    argv[i], strerror(errno));
	    continue;
	}
	nfiles++;
    }

    gettimeofday(&t1, NULL);
    for (i=0; i < nloops; i++) {
	for (j=0; j < nfiles; j++) {
	    lseek(fd[j], 0, SEEK_SET);
	    write(fd[j], TEST_STR, sizeof(TEST_STR));
	}
	for (j=0; j < nfiles; j++) {
	    lseek(fd[j], 0, SEEK_SET);
	    read(fd[j], buffer, sizeof(buffer));
	}
    }
    gettimeofday(&t2, NULL);

    delta = (((double)t2.tv_sec * 1000000.0 + (double)t2.tv_usec)
	     - ((double)t1.tv_sec * 1000000.0 + (double)t1.tv_usec)) / 1000000.0;
    printf("%d files, %d loops, %.3f [sec]\n", nfiles, nloops, delta);

    return 0;
}



--------------040503000308030405040605--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
