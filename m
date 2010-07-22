Subject: Re: [PATCH] Improve loading performance by 80% using dynamic
 resizing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kyle Moffett <kyle@moffetthome.net>
Cc: Matthew Robertson <Matthew.L.Robertson@boeing.com>, selinux@tycho.nsa.gov,
        John Livingston <John.A.Livingston@boeing.com>,
        Kyle Moffett <Kyle.D.Moffett@boeing.com>
In-Reply-To: <AANLkTimxfftX2x0P7o5N5rWQyJIt0MRStwmBk1U9kdUF@mail.gmail.com>
References: <1279319518.464844.26726.nullmailer@UDistro.exmeritus.com.>
	 <AANLkTimxfftX2x0P7o5N5rWQyJIt0MRStwmBk1U9kdUF@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Jul 2010 10:30:17 -0400
Message-ID: <1279809017.11197.35.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-07-18 at 17:11 -0400, Kyle Moffett wrote:
> Hmm, it looks like this email never made it to the list (spamfilter
> maybe?)  I'm re-forwarding it here:

He doesn't appear to be subscribed to the list, and I don't see the
original posting even on the approval list.  Can he or you re-post it in
an appliable form (looks like the original patch wasn't generated
against the top-level selinux git repo and re-forwarding further mangled
it)?  Thanks.

> Cheers,
> Kyle Moffett
> 
> On Fri, Jul 16, 2010 at 17:50, Matthew Robertson
> <Matthew.L.Robertson@boeing.com> wrote:
> > After spending a lot of developer time recently doing repeated relinks of
> > policies after making minor changes we put some time into tracking down avenues
> > for improving performance in the SELinux libraries. On a reasonably modern HP
> > server a 'make load' of a precompiled SELinux Reference Policy takes roughly 96
> > seconds. The 'perf' tool pointed us to some undersized and overpopulated hash
> > tables in libsepol's hashtab.c and avtab.c. By implementing dynamic resizing for
> > those structures we were able to bring that down to a 19 second runtime (80%
> > performance improvement) at the cost of ~6% more memory overhead.
> >
> > After applying this fix, bzip2 takes up a disproportionate percentage of the
> > time for a policy load. By effectively disabling bzip2 (changing bzip_blocksize
> > in libsemanage to 0) we reduced load time to about 11 seconds--disabling
> > compression might not be a tenable solution but supporting a faster compression
> > option like gzip could be worth the trouble if the other fixes check out.
> >
> > For reference, here are the numbers and perf reports we're looking at for the
> > policy loading step after a compile/install:
> >
> > SELinux Reference Policy        v2.20091117
> > libsepol                        v2.0.41
> > libsemanage                     v2.0.45
> > libselinux                      v2.0.94
> > libbz2                          v1.0.5-4
> >
> > ORIGINAL LIBRARIES: 96.0s
> > [full compile + load: 142s]
> >
> >    54.34%  semodule  /lib/libc-2.11.2.so            [.] __strcmp_sse42
> >    16.08%  semodule  /lib/libsepol.so.1             [.] hashtab_search
> >     4.74%  semodule  /lib/libsepol.so.1             [.] symcmp
> >     3.98%  semodule  /lib/libsepol.so.1             [.] strcmp@plt
> >     3.76%  semodule  /lib/libbz2.so.1.0.4           [.] 0x0000000000b0bc
> >     2.80%  semodule  /lib/libsepol.so.1             [.] avtab_search_node
> >     2.72%  semodule  /lib/libbz2.so.1.0.4           [.] 0x000000000022d0
> >     1.51%  semodule  /lib/libsepol.so.1             [.] ebitmap_set_bit
> >     1.12%  semodule  /lib/libsepol.so.1             [.] hashtab_map
> >     1.00%  semodule  /lib/libsepol.so.1             [.] symhash
> >     0.95%  semodule  /lib/libbz2.so.1.0.4           [.] BZ2_decompress
> >     0.90%  semodule  /lib/libbz2.so.1.0.4           [.] BZ2_compressBlock
> >     0.68%  semodule  /lib/libc-2.11.2.so            [.] __strlen_sse42
> >     0.57%  semodule  /lib/libbz2.so.1.0.4           [.] BZ2_bzDecompress
> >
> > DYNAMIC HASHING ENABLED, BZIP2 LEFT ENABLED: 19s, 80% improvement
> > [full compile + load: 70.5s, ~50% improvement]
> >
> >    28.57%  semodule  /lib/libbz2.so.1.0.4           [.] 0x0000000000b539
> >     7.53%  semodule  /lib/libsepol.so.1             [.] ebitmap_set_bit
> >     7.24%  semodule  /lib/libc-2.11.2.so            [.] __strcmp_sse42
> >     5.91%  semodule  /lib/libsepol.so.1             [.] hashtab_map
> >     4.91%  semodule  /lib/libsepol.so.1             [.] symhash
> >     4.66%  semodule  /lib/libsepol.so.1             [.] hashtab_search
> >     4.58%  semodule  /lib/libbz2.so.1.0.4           [.] BZ2_decompress
> >     4.46%  semodule  /lib/libbz2.so.1.0.4           [.] BZ2_compressBlock
> >     4.38%  semodule  /lib/libsepol.so.1             [.] avtab_search_node
> >     3.40%  semodule  /lib/libbz2.so.1.0.4           [.] 0x0000000000d1f9
> >     2.29%  semodule  /lib/libbz2.so.1.0.4           [.] BZ2_bzDecompress
> >
> > DYNAMIC HASHING ENABLED, BZIP2 DISABLED: 11 seconds, 88% improvement
> > [full compile + load: 62s, ~55% improvement]
> >
> >    13.39%  semodule  /lib/libsepol.so.1             [.] ebitmap_set_bit
> >    12.77%  semodule  /lib/libc-2.11.2.so            [.] __strcmp_sse42
> >    10.44%  semodule  /lib/libsepol.so.1             [.] hashtab_map
> >     8.91%  semodule  /lib/libsepol.so.1             [.] symhash
> >     8.28%  semodule  /lib/libsepol.so.1             [.] hashtab_search
> >     7.74%  semodule  /lib/libsepol.so.1             [.] avtab_search_node
> >
> > Signed-off-by:  Matthew Robertson <Matthew.L.Robertson@boeing.com>
> > ---
> >  src/avtab.c   |   52 +++++++++++++++++++++++++++-----
> >  src/hashtab.c |   91 +++++++++++++++++++++++++++++++++++++++-----------------
> >  2 files changed, 106 insertions(+), 37 deletions(-)
> >
> > diff --git a/src/avtab.c b/src/avtab.c
> > index ea947cb..2db931e 100644
> > --- a/src/avtab.c
> > +++ b/src/avtab.c
> > @@ -78,17 +78,13 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t prev, avtab_key_t * key,
> >        return newnode;
> >  }
> >
> > -int avtab_insert(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
> > +int avtab_insert__(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
> >  {
> > -       int hvalue;
> > -       avtab_ptr_t prev, cur, newnode;
> > +       avtab_ptr_t prev, cur;
> > +       int hvalue = avtab_hash(key, h->mask);
> >        uint16_t specified =
> >            key->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
> > -
> > -       if (!h || !h->htable)
> > -               return SEPOL_ENOMEM;
> > -
> > -       hvalue = avtab_hash(key, h->mask);
> > +
> >        for (prev = NULL, cur = h->htable[hvalue];
> >             cur; prev = cur, cur = cur->next) {
> >                if (key->source_type == cur->key.source_type &&
> > @@ -110,8 +106,46 @@ int avtab_insert(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
> >        newnode = avtab_insert_node(h, hvalue, prev, key, datum);
> >        if (!newnode)
> >                return SEPOL_ENOMEM;
> > +       return SEPOL_OK;
> > +}
> >
> > -       return 0;
> > +int avtab_insert(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
> > +{
> > +        int oldsize, i;
> > +       avtab_ptr_t prev, cur, newnode, *oldtbl, *newtbl;
> > +
> > +       if (!h || !h->htable)
> > +               return SEPOL_ENOMEM;
> > +
> > +       /* If we don't need to resize, just insert the new entry */
> > +       if (h->nslot * 3/4 > h->nel)
> > +               return avtab_insert__(h, key, datum);
> > +
> > +       /* Attempt to allocate a bigger table */
> > +       newtbl = (avtab_ptr_t*) calloc(sizeof(avtab_ptr_t), h->nslot * 2);
> > +       if (newtbl == NULL)
> > +               return avtab_insert__(h, key, datum);
> > +
> > +       /* Reinsert all elements into the new table */
> > +       h->nel = 0;
> > +       oldsize = h->nslot;
> > +       h->nslot *= 2;
> > +       h->mask = h->nslot - 1;
> > +       oldtbl = h->htable;
> > +       h->htable = newtbl;
> > +
> > +       for (i = 0; i < oldsize; i++) {
> > +               cur = oldtbl[i];
> > +               while (cur != NULL) {
> > +                       avtab_insert(h, &(cur->key), &(cur->datum));
> > +                       prev = cur;
> > +                       cur = cur->next;
> > +                       free (prev);
> > +               }
> > +       }
> > +       free (oldtbl);
> > +
> > +       return avtab_insert__(h, key, datum);
> >  }
> >
> >  /* Unlike avtab_insert(), this function allow multiple insertions of the same
> > diff --git a/src/hashtab.c b/src/hashtab.c
> > index c4be72c..e06d808 100644
> > --- a/src/hashtab.c
> > +++ b/src/hashtab.c
> > @@ -63,41 +63,76 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
> >        return p;
> >  }
> >
> > -int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
> > +int hashtab_insert__(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
> >  {
> > -       int hvalue;
> > -       hashtab_ptr_t prev, cur, newnode;
> > +        int hvalue = h->hash_value(h, key);
> > +        hashtab_ptr_t prev = NULL;
> > +        hashtab_ptr_t cur = h->htable[hvalue];
> > +        hashtab_ptr_t newnode;
> > +
> > +        while (cur && h->keycmp(h, key, cur->key) > 0) {
> > +                prev = cur;
> > +                cur = cur->next;
> > +        }
> > +
> > +        if (cur && (h->keycmp(h, key, cur->key) == 0))
> > +                return SEPOL_EEXIST;
> > +
> > +        newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
> > +        if (newnode == NULL)
> > +                return SEPOL_ENOMEM;
> > +        memset(newnode, 0, sizeof(struct hashtab_node));
> > +        newnode->key = key;
> > +        newnode->datum = datum;
> > +        if (prev) {
> > +                newnode->next = prev->next;
> > +                prev->next = newnode;
> > +        } else {
> > +                newnode->next = h->htable[hvalue];
> > +                h->htable[hvalue] = newnode;
> > +        }
> > +
> > +        h->nel++;
> > +        return SEPOL_OK;
> > +}
> >
> > +int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
> > +{
> > +       hashtab_ptr_t *oldtbl, *newtbl;
> > +       int oldsize, i;
> > +
> >        if (!h)
> >                return SEPOL_ENOMEM;
> >
> > -       hvalue = h->hash_value(h, key);
> > -       prev = NULL;
> > -       cur = h->htable[hvalue];
> > -       while (cur && h->keycmp(h, key, cur->key) > 0) {
> > -               prev = cur;
> > -               cur = cur->next;
> > -       }
> > -
> > -       if (cur && (h->keycmp(h, key, cur->key) == 0))
> > -               return SEPOL_EEXIST;
> > -
> > -       newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
> > -       if (newnode == NULL)
> > -               return SEPOL_ENOMEM;
> > -       memset(newnode, 0, sizeof(struct hashtab_node));
> > -       newnode->key = key;
> > -       newnode->datum = datum;
> > -       if (prev) {
> > -               newnode->next = prev->next;
> > -               prev->next = newnode;
> > -       } else {
> > -               newnode->next = h->htable[hvalue];
> > -               h->htable[hvalue] = newnode;
> > +       /* If we don't need to resize, just insert the new entry */
> > +       if (h->size > h->nel)
> > +               return hashtab_insert__(h, key, datum);
> > +
> > +       /* Attempt to allocate a bigger table */
> > +       newtbl = (hashtab_ptr_t*) calloc(sizeof(hashtab_ptr_t), h->size * 8);
> > +       if (newtbl == NULL)
> > +               return hashtab_insert__(h, key, datum);
> > +
> > +       /* Reinsert all elements into the new table */
> > +       oldtbl = h->htable;
> > +       oldsize = h->size;
> > +       h->nel = 0;
> > +       h->size *= 8;
> > +       h->htable = newtbl;
> > +
> > +       for (i = 0; i < oldsize; i++) {
> > +               hashtab_ptr_t prev = NULL;
> > +               hashtab_ptr_t cur = oldtbl[i];
> > +               while (cur != NULL) {
> > +                       hashtab_insert__(h, cur->key, cur->datum);
> > +                       prev = cur;
> > +                       cur = cur->next;
> > +                       free(prev);
> > +               }
> >        }
> > +       free(oldtbl);
> >
> > -       h->nel++;
> > -       return SEPOL_OK;
> > +       return hashtab_insert__(h, key, datum);
> >  }
> >
> >  int hashtab_remove(hashtab_t h, hashtab_key_t key,
> > --
> > 1.7.0
> >
> >
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
