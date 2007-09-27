Message-ID: <46FB18D1.6080608@ak.jp.nec.com>
Date: Thu, 27 Sep 2007 11:43:29 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov,
        Paul Moore <paul.moore@hp.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] Improve SELinux performance when AVC misses.
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>	 <200708211111.27019.paul.moore@hp.com>	 <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>	 <200708211255.45132.paul.moore@hp.com> <46CC00F4.2090501@ak.jp.nec.com>	 <46E7583C.9030103@ak.jp.nec.com>	 <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>	 <46F22BEF.9050208@ak.jp.nec.com>	 <1190402479.17518.130.camel@moss-spartans.epoch.ncsc.mil>	 <46F89767.2090203@ak.jp.nec.com> <1190728430.24726.13.camel@moss-spartans.epoch.ncsc.mil> <46F9F2E2.4060406@ak.jp.nec.com> <46FB13EE.3040907@ak.jp.nec.com>
In-Reply-To: <46FB13EE.3040907@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
>>> I think we have to conform to it, and if it makes it harder to read,
>>> possibly that suggests that we need to rework the code in some way.
>> I'm preparing another version of patch which does not contain any
>> "line over 80 characters" warning. Please wait for a while.
> 
> The following part is the patch which does not contain any "line
> over 80 characters" warnings.

The following part is a result of diff between the previous patch
which contains 80-char warnings and the latest one without them.

I think it is better than I expected.
However, there are several ugly manner like as:

-+				c_iter->startbit = e_startbit & ~(NETLBL_CATMAP_SIZE - 1);
++				c_iter->startbit
++				  = e_startbit & ~(NETLBL_CATMAP_SIZE - 1);
If both side of the formula is in a same line, the width of the line get overs
the 80-char limitation.


++	char *nm;
           :
++				if (head != prev) {
++					nm = policydb.p_cat_val_to_name[prev];
++					len += strlen(nm) + 1;
++				}

If the temporary char * variable is named as "cat_name", the above longest
line overs 80-char limitation, so I named it as "nm".
This naming may be unclear for its purpose.

Thanks,

[kaigai@saba ~]$ diff -NU3 ebitmap-bitops.patch ebitmap-bitops.less-than-80char.patch
 diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
-index ce492a6..3a60186 100644
+index ce492a6..5643bdd 100644
 --- a/security/selinux/ss/ebitmap.c
 +++ b/security/selinux/ss/ebitmap.c
 @@ -10,6 +10,10 @@
@@ -53,7 +59,7 @@

  	if (e_iter == NULL) {
  		*catmap = NULL;
-@@ -104,19 +110,21 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
+@@ -104,19 +110,27 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
  	c_iter->startbit = e_iter->startbit & ~(NETLBL_CATMAP_SIZE - 1);

  	while (e_iter != NULL) {
@@ -66,18 +72,24 @@
 -			c_iter->startbit = e_iter->startbit &
 -				           ~(NETLBL_CATMAP_SIZE - 1);
 +		for (i = 0; i < EBITMAP_UNIT_NUMS; i++) {
-+			unsigned int e_startbit = e_iter->startbit + i * EBITMAP_UNIT_SIZE;
++			unsigned int delta, e_startbit, c_endbit;
 +
-+			if (e_startbit >= c_iter->startbit + NETLBL_CATMAP_SIZE) {
-+				c_iter->next = netlbl_secattr_catmap_alloc(GFP_ATOMIC);
++			e_startbit = e_iter->startbit + i * EBITMAP_UNIT_SIZE;
++			c_endbit = c_iter->startbit + NETLBL_CATMAP_SIZE;
++			if (e_startbit >= c_endbit) {
++				c_iter->next
++				  = netlbl_secattr_catmap_alloc(GFP_ATOMIC);
 +				if (c_iter->next == NULL)
 +					goto netlbl_export_failure;
 +				c_iter = c_iter->next;
-+				c_iter->startbit = e_startbit & ~(NETLBL_CATMAP_SIZE - 1);
++				c_iter->startbit
++				  = e_startbit & ~(NETLBL_CATMAP_SIZE - 1);
 +			}
-+			cmap_idx = (e_startbit - c_iter->startbit) / NETLBL_CATMAP_MAPSIZE;
-+			cmap_sft = (e_startbit - c_iter->startbit) % NETLBL_CATMAP_MAPSIZE;
-+			c_iter->bitmap[cmap_idx] |= e_iter->maps[cmap_idx] << cmap_sft;
++			delta = e_startbit - c_iter->startbit;
++			cmap_idx = delta / NETLBL_CATMAP_MAPSIZE;
++			cmap_sft = delta % NETLBL_CATMAP_MAPSIZE;
++			c_iter->bitmap[cmap_idx]
++				|= e_iter->maps[cmap_idx] << cmap_sft;
 +			e_iter = e_iter->next;
  		}
 -		cmap_idx = (e_iter->startbit - c_iter->startbit) /
@@ -87,7 +99,7 @@
  	}

  	return 0;
-@@ -128,7 +136,7 @@ netlbl_export_failure:
+@@ -128,7 +142,7 @@ netlbl_export_failure:

  /**
   * ebitmap_netlbl_import - Import a NetLabel category bitmap into an ebitmap
@@ -96,7 +108,7 @@
   * @catmap: the NetLabel category bitmap
   *
   * Description:
-@@ -142,36 +150,45 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
+@@ -142,36 +156,50 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
  	struct ebitmap_node *e_iter = NULL;
  	struct ebitmap_node *emap_prev = NULL;
  	struct netlbl_lsm_secattr_catmap *c_iter = catmap;
@@ -118,6 +130,7 @@
  	do {
  		for (c_idx = 0; c_idx < NETLBL_CATMAP_MAPCNT; c_idx++) {
 -			if (c_iter->bitmap[c_idx] == 0)
++			unsigned int delta;
 +			u64 map = c_iter->bitmap[c_idx];
 +
 +			if (!map)
@@ -135,20 +148,24 @@
 -			e_iter->startbit = c_iter->startbit +
 -				           NETLBL_CATMAP_MAPSIZE * c_idx;
 -			e_iter->map = c_iter->bitmap[c_idx];
-+			c_pos = c_iter->startbit + c_idx * NETLBL_CATMAP_MAPSIZE;
-+			if (!e_iter || c_pos >= e_iter->startbit + EBITMAP_SIZE) {
++			c_pos = c_iter->startbit
++				+ c_idx * NETLBL_CATMAP_MAPSIZE;
++			if (!e_iter
++			    || c_pos >= e_iter->startbit + EBITMAP_SIZE) {
 +				e_iter = kzalloc(sizeof(*e_iter), GFP_ATOMIC);
 +				if (!e_iter)
 +					goto netlbl_import_failure;
-+				e_iter->startbit = c_pos - (c_pos % EBITMAP_SIZE);
++				e_iter->startbit
++					= c_pos - (c_pos % EBITMAP_SIZE);
 +				if (emap_prev == NULL)
 +					ebmap->node = e_iter;
 +				else
 +					emap_prev->next = e_iter;
 +				emap_prev = e_iter;
 +			}
-+			e_idx = (c_pos - e_iter->startbit) / EBITMAP_UNIT_SIZE;
-+			e_sft = (c_pos - e_iter->startbit) % EBITMAP_UNIT_SIZE;
++			delta = c_pos - e_iter->startbit;
++			e_idx = delta / EBITMAP_UNIT_SIZE;
++			e_sft = delta % EBITMAP_UNIT_SIZE;
 +			while (map) {
 +				e_iter->maps[e_idx++] |= map & (-1UL);
 +				map >>= EBITMAP_UNIT_SIZE;
@@ -162,7 +179,7 @@
  	else
  		ebitmap_destroy(ebmap);

-@@ -186,6 +203,7 @@ netlbl_import_failure:
+@@ -186,6 +214,7 @@ netlbl_import_failure:
  int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2)
  {
  	struct ebitmap_node *n1, *n2;
@@ -170,7 +187,7 @@

  	if (e1->highbit < e2->highbit)
  		return 0;
-@@ -197,8 +215,10 @@ int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2)
+@@ -197,8 +226,10 @@ int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2)
  			n1 = n1->next;
  			continue;
  		}
@@ -183,7 +200,7 @@

  		n1 = n1->next;
  		n2 = n2->next;
-@@ -219,12 +239,8 @@ int ebitmap_get_bit(struct ebitmap *e, unsigned long bit)
+@@ -219,12 +250,8 @@ int ebitmap_get_bit(struct ebitmap *e, unsigned long bit)

  	n = e->node;
  	while (n && (n->startbit <= bit)) {
@@ -198,7 +215,7 @@
  		n = n->next;
  	}

-@@ -238,31 +254,31 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
+@@ -238,31 +265,35 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
  	prev = NULL;
  	n = e->node;
  	while (n && n->startbit <= bit) {
@@ -222,9 +239,12 @@
 -						else
 -							e->highbit = 0;
 -					}
++				unsigned int s;
++
 +				ebitmap_node_clr_bit(n, bit);
 +
-+				if (find_first_bit(n->maps, EBITMAP_SIZE) < EBITMAP_SIZE)
++				s = find_first_bit(n->maps, EBITMAP_SIZE);
++				if (s < EBITMAP_SIZE)
 +					return 0;
 +
 +				/* drop this node from the bitmap */
@@ -235,7 +255,8 @@
 +					 */
  					if (prev)
 -						prev->next = n->next;
-+						e->highbit = prev->startbit + EBITMAP_SIZE;
++						e->highbit = prev->startbit
++							     + EBITMAP_SIZE;
  					else
 -						e->node = n->next;
 -
@@ -250,7 +271,7 @@
  			}
  			return 0;
  		}
-@@ -277,12 +293,12 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
+@@ -277,12 +308,12 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
  	if (!new)
  		return -ENOMEM;

@@ -266,7 +287,7 @@

  	if (prev) {
  		new->next = prev->next;
-@@ -316,11 +332,11 @@ void ebitmap_destroy(struct ebitmap *e)
+@@ -316,11 +347,11 @@ void ebitmap_destroy(struct ebitmap *e)

  int ebitmap_read(struct ebitmap *e, void *fp)
  {
@@ -282,7 +303,7 @@

  	ebitmap_init(e);

-@@ -328,85 +344,86 @@ int ebitmap_read(struct ebitmap *e, void *fp)
+@@ -328,85 +359,89 @@ int ebitmap_read(struct ebitmap *e, void *fp)
  	if (rc < 0)
  		goto out;

@@ -354,13 +375,16 @@
 +		}
 +
 +		if (!n || startbit >= n->startbit + EBITMAP_SIZE) {
-+			struct ebitmap_node *_n = kzalloc(sizeof(*_n), GFP_KERNEL);
++			struct ebitmap_node *_n;
++			_n = kzalloc(sizeof(*_n), GFP_KERNEL);
 +			if (!_n) {
-+				printk(KERN_ERR "security: ebitmap: out of memory\n");
++				printk(KERN_ERR
++				       "security: ebitmap: out of memory\n");
 +				rc = -ENOMEM;
 +				goto bad;
 +			}
-+			_n->startbit = startbit - (startbit % EBITMAP_SIZE); /* round down */
++			/* round down */
++			_n->startbit = startbit - (startbit % EBITMAP_SIZE);
 +			if (n) {
 +				n->next = _n;
 +			} else {
@@ -417,17 +441,18 @@
  	if (!rc)
  		rc = -EINVAL;
 diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
-index 1270e34..417053e 100644
+index 1270e34..e38a327 100644
 --- a/security/selinux/ss/ebitmap.h
 +++ b/security/selinux/ss/ebitmap.h
-@@ -16,14 +16,15 @@
+@@ -16,14 +16,16 @@

  #include <net/netlabel.h>

 -#define MAPTYPE u64			/* portion of bitmap in each node */
 -#define MAPSIZE (sizeof(MAPTYPE) * 8)	/* number of bits in node bitmap */
 -#define MAPBIT  1ULL			/* a bit in the node bitmap */
-+#define EBITMAP_UNIT_NUMS	((32 - sizeof(void *) - sizeof(u32)) / sizeof(unsigned long))
++#define EBITMAP_UNIT_NUMS	((32 - sizeof(void *) - sizeof(u32))	\
++					/ sizeof(unsigned long))
 +#define EBITMAP_UNIT_SIZE	BITS_PER_LONG
 +#define EBITMAP_SIZE		(EBITMAP_UNIT_NUMS * EBITMAP_UNIT_SIZE)
 +#define EBITMAP_BIT		1ULL
@@ -441,7 +466,7 @@
  };

  struct ebitmap {
-@@ -34,11 +35,17 @@ struct ebitmap {
+@@ -34,11 +36,17 @@ struct ebitmap {
  #define ebitmap_length(e) ((e)->highbit)
  #define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)

@@ -463,7 +488,7 @@
  }

  static inline void ebitmap_init(struct ebitmap *e)
-@@ -46,28 +53,65 @@ static inline void ebitmap_init(struct ebitmap *e)
+@@ -46,28 +54,65 @@ static inline void ebitmap_init(struct ebitmap *e)
  	memset(e, 0, sizeof(*e));
  }

@@ -542,56 +567,67 @@
  int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
  int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
 diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
-index 4a8bab2..27ef5eb 100644
+index 4a8bab2..9a11dea 100644
 --- a/security/selinux/ss/mls.c
 +++ b/security/selinux/ss/mls.c
-@@ -34,7 +34,7 @@
+@@ -34,7 +34,9 @@
   */
  int mls_compute_context_len(struct context * context)
  {
 -	int i, l, len, range;
 +	int i, l, len, head, prev;
++	char *nm;
++	struct ebitmap *e;
  	struct ebitmap_node *node;

  	if (!selinux_mls_enabled)
-@@ -42,31 +42,26 @@ int mls_compute_context_len(struct context * context)
+@@ -42,31 +44,33 @@ int mls_compute_context_len(struct context * context)

  	len = 1; /* for the beginning ":" */
  	for (l = 0; l < 2; l++) {
 -		range = 0;
- 		len += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
-
+-		len += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
+-
 -		ebitmap_for_each_bit(&context->range.level[l].cat, node, i) {
 -			if (ebitmap_node_get_bit(node, i)) {
 -				if (range) {
 -					range++;
 -					continue;
 -				}
--
-+		/* categories */
-+		head = -2;
-+		prev = -2;
-+		ebitmap_for_each_positive_bit(&context->range.level[l].cat, node, i) {
-+			if (i - prev > 1) {
-+				/* one or more negative bits are skipped, at least. */
-+				if (head != prev)
-+					len += strlen(policydb.p_cat_val_to_name[prev]) + 1;
- 				len += strlen(policydb.p_cat_val_to_name[i]) + 1;
++		int index_sens = context->range.level[l].sens;
++		len += strlen(policydb.p_sens_val_to_name[index_sens - 1]);
+
+-				len += strlen(policydb.p_cat_val_to_name[i]) + 1;
 -				range++;
 -			} else {
 -				if (range > 1)
 -					len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
 -				range = 0;
++		/* categories */
++		head = -2;
++		prev = -2;
++		e = &context->range.level[l].cat;
++		ebitmap_for_each_positive_bit(e, node, i) {
++			if (i - prev > 1) {
++				/* one or more negative bits are skipped */
++				if (head != prev) {
++					nm = policydb.p_cat_val_to_name[prev];
++					len += strlen(nm) + 1;
++				}
++				nm = policydb.p_cat_val_to_name[i];
++				len += strlen(nm) + 1;
 +				head = i;
  			}
 +			prev = i;
++		}
++		if (prev != head) {
++			nm = policydb.p_cat_val_to_name[prev];
++			len += strlen(nm) + 1;
  		}
 -		/* Handle case where last category is the end of range */
 -		if (range > 1)
 -			len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
 -
-+		if (prev != head)
-+			len += strlen(policydb.p_cat_val_to_name[prev]) + 1;
  		if (l == 0) {
  			if (mls_level_eq(&context->range.level[0],
 -			                 &context->range.level[1]))
@@ -599,16 +635,19 @@
  				break;
  			else
  				len++;
-@@ -85,7 +80,7 @@ void mls_sid_to_context(struct context *context,
+@@ -84,8 +88,9 @@ int mls_compute_context_len(struct context * context)
+ void mls_sid_to_context(struct context *context,
                          char **scontext)
  {
- 	char *scontextp;
+-	char *scontextp;
 -	int i, l, range, wrote_sep;
++	char *scontextp, *nm;
 +	int i, l, head, prev;
++	struct ebitmap *e;
  	struct ebitmap_node *node;

  	if (!selinux_mls_enabled)
-@@ -97,61 +92,50 @@ void mls_sid_to_context(struct context *context,
+@@ -97,61 +102,54 @@ void mls_sid_to_context(struct context *context,
  	scontextp++;

  	for (l = 0; l < 2; l++) {
@@ -640,9 +679,10 @@
 -					if (range > 2)
 +		head = -2;
 +		prev = -2;
-+		ebitmap_for_each_positive_bit(&context->range.level[l].cat, node, i) {
++		e = &context->range.level[l].cat;
++		ebitmap_for_each_positive_bit(e, node, i) {
 +			if (i - prev > 1) {
-+				/* one or more negative bits are skipped, at least. */
++				/* one or more negative bits are skipped */
 +				if (prev != head) {
 +					if (prev - head > 1)
  						*scontextp++ = '.';
@@ -651,16 +691,18 @@
 -
 -					strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
 -					scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
-+					strcpy(scontextp, policydb.p_cat_val_to_name[prev]);
-+					scontextp += strlen(scontextp);
++					nm = policydb.p_cat_val_to_name[prev];
++					strcpy(scontextp, nm);
++					scontextp += strlen(nm);
  				}
 -				range = 0;
 +				if (prev < 0)
 +					*scontextp++ = ':';
 +				else
 +					*scontextp++ = ',';
-+				strcpy(scontextp, policydb.p_cat_val_to_name[i]);
-+				scontextp += strlen(scontextp);
++				nm = policydb.p_cat_val_to_name[i];
++				strcpy(scontextp, nm);
++				scontextp += strlen(nm);
 +				head = i;
  			}
 +			prev = i;
@@ -677,8 +719,9 @@
 -
 -			strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
 -			scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
-+			strcpy(scontextp, policydb.p_cat_val_to_name[prev]);
-+			scontextp += strlen(scontextp);
++			nm = policydb.p_cat_val_to_name[prev];
++			strcpy(scontextp, nm);
++			scontextp += strlen(nm);
  		}

  		if (l == 0) {
@@ -694,7 +737,7 @@
  		}
  	}

-@@ -190,17 +174,15 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
+@@ -190,17 +188,15 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
  		if (!levdatum)
  			return 0;

@@ -721,7 +764,7 @@
  		}
  	}

-@@ -485,18 +467,16 @@ int mls_convert_context(struct policydb *oldp,
+@@ -485,18 +481,16 @@ int mls_convert_context(struct policydb *oldp,
  		c->range.level[l].sens = levdatum->level->sens;

  		ebitmap_init(&bitmap);

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
