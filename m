Subject: Re: [patch] Tuning avtab to reduce memory usage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <46F22BEF.9050208@ak.jp.nec.com>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
	 <200708211111.27019.paul.moore@hp.com>
	 <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>
	 <200708211255.45132.paul.moore@hp.com> <46CC00F4.2090501@ak.jp.nec.com>
	 <46E7583C.9030103@ak.jp.nec.com>
	 <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>
	 <46F22BEF.9050208@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 21 Sep 2007 15:21:19 -0400
Message-Id: <1190402479.17518.130.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-20 at 17:14 +0900, KaiGai Kohei wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-09-12 at 12:08 +0900, KaiGai Kohei wrote:
> >> The attached patch applies the standard bitmap operations
> >> for the iteration macro of ebitmap, and enables to improve
> >> the performance in AVC-misses case.
> >>
> >> Real-time responsibility is a significant issue for embedded
> >> Linux people. This patch also reduce amount of busy loop in
> >> the kernel, so it can improve real-time responsibility.
> >>
> >> I added ebitmap_for_each_positive_bit() macro not to walk
> >> on any native bit within ebitmap, and applies it on
> >>   - context_struct_compute_av()
> >>   - security_get_user_sids()
> >>   - mls_context_isvalid()
> >>
> >> ebitmap_node was redefined as follows:
> >>    #define EBITMAP_UNIT_NUMS      \
> >>          ((32 - sizeof(void *) - sizeof(u32)) / sizeof(unsigned long))
> >>    struct ebitmap_node {
> >>        struct ebitmap_node *next;
> >>        unsigned long maps[EBITMAP_UNIT_NUMS];
> >>        u32 startbit;
> >>    };
> >>
> >> "u64 map" is replaced by an array of "unsigned long". It enables to
> >> apply standard bit operations. In addition, length of the array is
> >> determind to fit 32-bytes, the minimum size of kmalloc().
> >>
> >> The result of benchmarks seems to me fine.
> >>
> >>        selinux-2.6      selinux-2.6-ebitmap
> >> AVG:   22.763 [s]          8.750 [s]
> >> STD:    0.265              0.019
> >> ------------------------------------------
> >> 1st:   22.558 [s]          8.786 [s]
> >> 2nd:   22.458 [s]          8.750 [s]
> >> 3rd:   22.478 [s]          8.754 [s]
> >> 4th:   22.724 [s]          8.745 [s]
> >> 5th:   22.918 [s]          8.748 [s]
> >> 6th:   22.905 [s]          8.764 [s]
> >> 7th:   23.238 [s]          8.726 [s]
> >> 8th:   22.822 [s]          8.729 [s]
> >>
> >> NOTE: We used the following operatins as a test case.
> >>        No need to say, it is a corner case to highlight.
> >> [root@saba ~]# id -Z
> >> root:system_r:unconfined_t:SystemLow-SystemHigh
> >> [root@saba ~]# cd /dev/shm
> >> [root@saba shm]# for I in `seq 1 640`
> >>  > do
> >>  >     echo > file${I}
> >>  >     chcon -l s0:c${I} file${I}
> >>  > done
> >> [root@saba shm]# ~kaigai/manyfiles 800 file*
> >>
> >> I also attached "manyfiles.c" to reproduce them.
> >>
> >> In addition, we could not make sure a statistical difference
> >> in the AVC-hits case.
> >>
> >> Thanks,
> 
> Stephen, Thanks for your comments.
> 
> The attached second patch is revised in several points.
>  - comment blocks in ebitmap_netlbl_(inport|export) are rewritten
>    as I mentioned before.
>  - rest of codes using ebitmap_for_each_bit() were replaced by
>    _positive_ version. I had to modify logic in ss/mls.c a bit.
>  - applied your comment as follows:
> 
> > The patch looks good overall - a couple minor comments below.
> > Paul, can you test the netlabel import/export functionality?
> > 
> > I was wondering whether it might be useful to also introduce a new
> > policy version with an updated ebitmap representation in the policy
> > format that would be closer to the kernel native representation,
> > although we'd still need to be able to read the old formats for backward
> > compatibility.
> 
> I don't think a new policy format is necessary, because the width of
> unsigned long depends on its architecture, although selinux-policy
> is a "noarch" package.
> The kernel should translate it into another format easier to handle
> on run-time, if necessary.
> 
> > If/when we introduce support for reading back the currently loaded
> > policy image from the kernel via a selinuxfs node for use by tools,
> > we'll need conversion code to map the kernel representation back to the
> > policy format.  libsepol has an ebitmap_write() function to generate a
> > linear policy format representation from an in-memory policydb, which
> > could be ported to the kernel (it used to be there too, actually, but
> > was expunged because we didn't need it in the kernel code at the time),
> > but naturally it only deals with the current representation.
> >
> > diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> > index ce492a6..de9ef55 100644
> > --- a/security/selinux/ss/ebitmap.c
> > +++ b/security/selinux/ss/ebitmap.c
> > @@ -328,85 +341,84 @@ int ebitmap_read(struct ebitmap *e, void *fp)
> >  	if (rc < 0)
> >  		goto out;
> >  
> > -	mapsize = le32_to_cpu(buf[0]);
> > +	mapunit = le32_to_cpu(buf[0]);
> >  	e->highbit = le32_to_cpu(buf[1]);
> >  	count = le32_to_cpu(buf[2]);
> >  
> > -	if (mapsize != MAPSIZE) {
> > +	/* round up e->highbit */
> > +	e->highbit += EBITMAP_SIZE - 1;
> > +	e->highbit -= (e->highbit % EBITMAP_SIZE);
> > +
> > +	if (mapunit != sizeof(u64) * 8) {
> >  		printk(KERN_ERR "security: ebitmap: map size %u does not "
> > -		       "match my size %Zd (high bit was %d)\n", mapsize,
> > -		       MAPSIZE, e->highbit);
> > +		       "match my size %Zd (high bit was %d)\n",
> > +		       mapunit, sizeof(u64) * 8, e->highbit);
> > 
> > Here you will display the modified highbit value rather than the one
> > that was actually in the policy image.  I think you can just move the
> > check before mutating the highbit.
> 
> I moved it in front of rounding up e->highbit.
> 
> >  		goto bad;
> >  	}
> >  	if (!e->highbit) {
> >  		e->node = NULL;
> >  		goto ok;
> >  	}
> > -	if (e->highbit & (MAPSIZE - 1)) {
> > -		printk(KERN_ERR "security: ebitmap: high bit (%d) is not a "
> > -		       "multiple of the map size (%Zd)\n", e->highbit, MAPSIZE);
> > -		goto bad;
> > -	}
> > 
> > Not sure why you'd drop this sanity check.  As before, it would need to happen before mutating the highbit.
> 
> The reason why I dropped this sanity check is to avoid redundant one,
> because e->highbit is already rounded up to the align of EBITMAP_SIZE.
> The above condition is not always false.
> 
> > +		} else if (startbit <= n->startbit) {
> > +			printk(KERN_ERR "security: ebitmap: start bit %d"
> > +			       " comes after start bit %d\n",
> > +			       startbit, n->startbit);
> > 
> > Need to bail out here with an appropriate rc value.
> 
> I added "goto bad;" at the point. It returns -EINVAL.
> 
> > diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
> > index 1270e34..fc0ce05 100644
> > --- a/security/selinux/ss/ebitmap.h
> > +++ b/security/selinux/ss/ebitmap.h
> > @@ -41,6 +42,19 @@ static inline unsigned int ebitmap_start(struct ebitmap *e,
> >  	return ebitmap_startbit(e);
> >  }
> >  
> > +static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
> > +						  struct ebitmap_node **n)
> > 
> > I suspect we could just make these all "static" (not explicitly inline)
> > and let the compiler do the right thing.  That seemed to be the trend
> > upstream and guidance from arjan.
> 
> How should we do the explicitly inlined static functions used as stubs?
> 
> For example, ebitmap_netlbl_export() when NetLabel is not enabled is
> defined as explicitly inlined function which always returns -ENOMEM,
> however, these are also declarations of function when NetLabel is enabled.

Ah, never mind - as these are defined in the header file, they can stay
static inline.

> > <snip>
> >  static inline int ebitmap_node_get_bit(struct ebitmap_node * n,
> >  				       unsigned int bit)
> >  {
> > -	if (n->map & (MAPBIT << (bit - n->startbit)))
> > +	unsigned int ofs =   (bit - n->startbit) % EBITMAP_UNIT_SIZE;
> > +	unsigned int index = (bit - n->startbit) / EBITMAP_UNIT_SIZE;
> > 
> > Possibly the computation of (ofs,index) should be a common macro since it is done in several of these
> > functions.
> 
> I added EBITMAP_NODE_INDEX(node,bit) and EBITMAP_NODE_OFFSET(node,bit) to compute them.
> 
> > +	
> > +	if (index < EBITMAP_UNIT_NUMS && (n->maps[index] & (EBITMAP_BIT << ofs)))
> > 
> > Possibly BUG_ON(index >= EBITMAP_UNIT_NUMS) instead of silently returning 0 in that case?
> 
> It is good idea indeed.
> All caller of ebitmap_node_get_bit() always confirms 'bit' is in the range of
> ebitmap_node. If the index overs EBITMAP_UNIT_NUMS, it is a bug surely.
> 
> > +#define ebitmap_for_each_bit(e, n, bit)			\
> > +	for (bit = ebitmap_start(e, &n);		\
> > +	     bit < ebitmap_length(e);			\
> > +	     bit = ebitmap_next(&n, bit))		\
> > 
> > Ideally we'd kill off all uses of ebitmap_for_each_bit and use the _positive_ form in all cases,
> > although I see that would require some changes to the mls logic.
> 
> ebitmap_start, ebitmap_next and ebitmap_for_each_bit are dropped.
> The rest of codes using ebitmap_for_each_bit(), in ss/mls.c, are
> also replaced with _positive_ version.

Looks like you've left ebitmap_for_each_bit defined even though no
longer used in ebitmap.h.

> > +#define ebitmap_for_each_positive_bit(e, n, bit)	\
> > +	for (bit = ebitmap_start_positive(e, &n);	\
> > +	     bit < ebitmap_length(e);			\
> > +	     bit = ebitmap_next_positive(e, &n, bit))	\
> >  
> >  int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
> >  int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
> > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > index 4a8bab2..846314f 100644
> > --- a/security/selinux/ss/mls.c
> > +++ b/security/selinux/ss/mls.c
> > @@ -190,17 +190,17 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
> >  		if (!levdatum)
> >  			return 0;
> >  
> > -		ebitmap_for_each_bit(&c->range.level[l].cat, node, i) {
> > -			if (ebitmap_node_get_bit(node, i)) {
> > -				if (i > p->p_cats.nprim)
> > -					return 0;
> > -				if (!ebitmap_get_bit(&levdatum->level->cat, i))
> > -					/*
> > -					 * Category may not be associated with
> > -					 * sensitivity in low level.
> > -					 */
> > -					return 0;
> > -			}
> > +		ebitmap_for_each_positive_bit(&c->range.level[l].cat, node, i) {
> > +			// BUG_ON(!ebitmap_node_get_bit(node, i));
> > 
> > Drop these BUG_ON's out, or uncomment them if you want to keep them for now for testing purposes.
> 
> I dropped the BUG_ON() to confirm each bit is actually positive.

Ok, looks reasonable.  Please run it through ./scripts/checkpatch.pl and
fix up the minor issues it reports, then post a clean message with a
suitable description and the patch inline.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
