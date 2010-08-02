Subject: Re: [PATCH] Improve loading performance by 80% using dynamic
 resizing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Matthew Robertson <Matthew.L.Robertson@boeing.com>
Cc: SELinux@tycho.nsa.gov, Kyle Moffett <Kyle.D.Moffett@boeing.com>
In-Reply-To: <1280434836.813159.22406.nullmailer@UDistro.exmeritus.com.>
References: <1280434836.813159.22406.nullmailer@UDistro.exmeritus.com.>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 08:40:04 -0400
Message-ID: <1280752804.8704.33.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-07-29 at 17:30 -0400, Matthew Robertson wrote:
> After spending a lot of developer time recently doing repeated relinks of
> policies after making minor changes we put some time into tracking down avenues
> for improving performance in the SELinux libraries. On a reasonably modern HP
> server a 'make load' of a precompiled SELinux Reference Policy takes roughly 96
> seconds. The 'perf' tool pointed us to some undersized and overpopulated hash
> tables in libsepol's hashtab.c and avtab.c. By implementing dynamic resizing for
> those structures we were able to bring that down to a 19 second runtime (80%
> performance improvement) at the cost of ~6% more memory overhead.
> 
> Signed-off-by: Matthew Robertson <Matthew.L.Robertson@boeing.com>

Thanks for the patch.  Some comments below will need to be addressed for
merging.

> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index ea947cb..51abd04 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -78,17 +78,13 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t prev, avtab_key_t * key,
>  	return newnode;
>  }
>  
> -int avtab_insert(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
> +int avtab_insert__(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)

This should be made a static function, and I think the convention is to
use leading underscores rather than trailing ones for internal
functions.  Or use a unique suffix that has an actual meaning, e.g.
avtab_insert_helper().

> +int avtab_insert(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
> +{
> +        int oldsize, i;
> +	avtab_ptr_t prev, cur, *oldtbl, *newtbl;
> +
> +	if (!h || !h->htable)
> +		return SEPOL_ENOMEM;
> +
> +	/* If we don't need to resize, just insert the new entry */
> +	if (h->nslot * 3/4 > h->nel)

The resizing threshold can be precomputed by avtab_alloc() and stored in
the avtab as a field (e.g. h->threshold), so you can just compare
without recomputing here.  Why 3/4?  That should likely be a #define or
otherwise settable.

> +		return avtab_insert__(h, key, datum);
> +
> +	/* Attempt to allocate a bigger table */
> +	newtbl = (avtab_ptr_t*) calloc(sizeof(avtab_ptr_t), h->nslot * 2);

Order of arguments to calloc() is reversed - this is an array with
h->nslot*2 members of size sizeof(avtab_ptr_t) bytes each, not the other
way around.  Yields the same effect but should be fixed.

> +	if (newtbl == NULL)
> +		return avtab_insert__(h, key, datum);
> +
> +	/* Reinsert all elements into the new table */
> +	h->nel = 0;
> +	oldsize = h->nslot;
> +	h->nslot *= 2;
> +	h->mask = h->nslot - 1;
> +	oldtbl = h->htable;
> +	h->htable = newtbl;
> +
> +	for (i = 0; i < oldsize; i++) {
> +		cur = oldtbl[i];
> +		while (cur != NULL) {
> +			avtab_insert(h, &(cur->key), &(cur->datum));

avtab_insert() can fail, so at the least, you need to check and handle
errors, particularly ENOMEM, or you can lose data here.
Also, I think you want to call __avtab_insert() rather than recursively
calling avtab_insert() here, as you shouldn't need to check for resizing
the table here.
Last, we could avoid both the possibility of memory allocation failure
and be more efficient by reusing the already existing avtab nodes and
merely re-chaining them into the new hash table.  This would however
require writing a bit of custom code for doing that (or factoring out a
common helper) rather than just reusing __avtab_insert().

> diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> index c4be72c..943a2cd 100644
> --- a/libsepol/src/hashtab.c
> +++ b/libsepol/src/hashtab.c
> @@ -63,41 +63,76 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
>  	return p;
>  }
>  
> +int hashtab_insert__(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)

As above, this should be made static, and either use leading underscores
or a meaningful suffix.

> +	/* If we don't need to resize, just insert the new entry */
> +	if (h->size > h->nel)

resize threshold should be adjustable, at least via a #define, and can
be precomputed during hashtab_create().

> +		return hashtab_insert__(h, key, datum);
> +
> +	/* Attempt to allocate a bigger table */
> +	newtbl = (hashtab_ptr_t*) calloc(sizeof(hashtab_ptr_t), h->size * 8);

calloc order of arguments is wrong again.

> +	if (newtbl == NULL)
> +		return hashtab_insert__(h, key, datum);
> +
> +	/* Reinsert all elements into the new table */
> +	oldtbl = h->htable;
> +	oldsize = h->size;
> +	h->nel = 0;
> +	h->size *= 8;

The factor should likely be definable.  Why 8 here vs 2 in the avtab
case?

> +	h->htable = newtbl;
> +
> +	for (i = 0; i < oldsize; i++) {
> +		hashtab_ptr_t prev = NULL;
> +		hashtab_ptr_t cur = oldtbl[i];
> +		while (cur != NULL) {
> +			hashtab_insert__(h, cur->key, cur->datum);

This can fail.  Same as in the avtab case.  Optimal situation would be
to re-chain the existing nodes into the new hashtab rather than
allocating new nodes, copying the contents, and freeing the old ones.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
