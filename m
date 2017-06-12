Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5C2GVGj030905
 for <selinux@tycho.nsa.gov>; Sun, 11 Jun 2017 22:16:33 -0400
From: "Junil Lee" <junil0814.lee@lge.com>
To: "'Paul Moore'" <paul@paul-moore.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
 "'Eric Paris'" <eparis@parisplace.org>,
 "'James Morris'" <james.l.morris@oracle.com>, <serge@hallyn.com>,
 <william.c.roberts@intel.com>, <adobriyan@gmail.com>,
 <akpm@linux-foundation.org>, <dledford@redhat.com>,
 <danielj@mellanox.com>, <mka@chromium.org>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1496895489-180660-1-git-send-email-junil0814.lee@lge.com>
 <CAHC9VhQ54WqLpBqHQm3F2=wEQq6p7xWCEyEubyrTr6kLDE7wgw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ54WqLpBqHQm3F2=wEQq6p7xWCEyEubyrTr6kLDE7wgw@mail.gmail.com>
Subject: RE: [PATCH] security: selinux: use kmem_cache for ebitmap
Date: Mon, 12 Jun 2017 11:16:18 +0900
Message-ID: <002901d2e321$e0f0d070$a2d27150$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dear Paul.
Thank you for your support.
I hope you'll be always happy.

Thanks,
Junil Lee.

> -----Original Message-----
> From: Paul Moore [mailto:paul@paul-moore.com]
> Sent: Saturday, June 10, 2017 5:17 AM
> To: Junil Lee <junil0814.lee@lge.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>; Eric Paris <eparis@parisplace.org>;
> James Morris <james.l.morris@oracle.com>; serge@hallyn.com;
> william.c.roberts@intel.com; adobriyan@gmail.com; akpm@linux-foundation.org;
> dledford@redhat.com; danielj@mellanox.com; mka@chromium.org;
> selinux@tycho.nsa.gov; linux-security-module@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] security: selinux: use kmem_cache for ebitmap
> 
> On Thu, Jun 8, 2017 at 12:18 AM, Junil Lee <junil0814.lee@lge.com> wrote:
> > The allocated size for each ebitmap_node is 192byte by kzalloc().
> > Then, ebitmap_node size is fixed, so it's possible to use only 144byte
> > for each object by kmem_cache_zalloc().
> > It can reduce some dynamic allocation size.
> >
> > Signed-off-by: Junil Lee <junil0814.lee@lge.com>
> > ---
> >  security/selinux/ss/ebitmap.c  | 26 ++++++++++++++++++++------
> > security/selinux/ss/ebitmap.h  |  3 +++
> > security/selinux/ss/services.c |  4 ++++
> >  3 files changed, 27 insertions(+), 6 deletions(-)
> 
> I just applied this to selinux/next, thank you.
> 
> > diff --git a/security/selinux/ss/ebitmap.c
> > b/security/selinux/ss/ebitmap.c index 9db4709a..ad38299 100644
> > --- a/security/selinux/ss/ebitmap.c
> > +++ b/security/selinux/ss/ebitmap.c
> > @@ -24,6 +24,8 @@
> >
> >  #define BITS_PER_U64   (sizeof(u64) * 8)
> >
> > +static struct kmem_cache *ebitmap_node_cachep;
> > +
> >  int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)  {
> >         struct ebitmap_node *n1, *n2;
> > @@ -54,7 +56,7 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap
> *src)
> >         n = src->node;
> >         prev = NULL;
> >         while (n) {
> > -               new = kzalloc(sizeof(*new), GFP_ATOMIC);
> > +               new = kmem_cache_zalloc(ebitmap_node_cachep,
> > + GFP_ATOMIC);
> >                 if (!new) {
> >                         ebitmap_destroy(dst);
> >                         return -ENOMEM; @@ -162,7 +164,7 @@ int
> > ebitmap_netlbl_import(struct ebitmap *ebmap,
> >                 if (e_iter == NULL ||
> >                     offset >= e_iter->startbit + EBITMAP_SIZE) {
> >                         e_prev = e_iter;
> > -                       e_iter = kzalloc(sizeof(*e_iter), GFP_ATOMIC);
> > +                       e_iter =
> > + kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
> >                         if (e_iter == NULL)
> >                                 goto netlbl_import_failure;
> >                         e_iter->startbit = offset - (offset %
> > EBITMAP_SIZE); @@ -288,7 +290,7 @@ int ebitmap_set_bit(struct ebitmap *e,
> unsigned long bit, int value)
> >                                         prev->next = n->next;
> >                                 else
> >                                         e->node = n->next;
> > -                               kfree(n);
> > +                               kmem_cache_free(ebitmap_node_cachep,
> > + n);
> >                         }
> >                         return 0;
> >                 }
> > @@ -299,7 +301,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long
> bit, int value)
> >         if (!value)
> >                 return 0;
> >
> > -       new = kzalloc(sizeof(*new), GFP_ATOMIC);
> > +       new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
> >         if (!new)
> >                 return -ENOMEM;
> >
> > @@ -332,7 +334,7 @@ void ebitmap_destroy(struct ebitmap *e)
> >         while (n) {
> >                 temp = n;
> >                 n = n->next;
> > -               kfree(temp);
> > +               kmem_cache_free(ebitmap_node_cachep, temp);
> >         }
> >
> >         e->highbit = 0;
> > @@ -400,7 +402,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
> >
> >                 if (!n || startbit >= n->startbit + EBITMAP_SIZE) {
> >                         struct ebitmap_node *tmp;
> > -                       tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
> > +                       tmp = kmem_cache_zalloc(ebitmap_node_cachep,
> > + GFP_KERNEL);
> >                         if (!tmp) {
> >                                 printk(KERN_ERR
> >                                        "SELinux: ebitmap: out of
> > memory\n"); @@ -519,3 +521,15 @@ int ebitmap_write(struct ebitmap *e,
> void *fp)
> >         }
> >         return 0;
> >  }
> > +
> > +void ebitmap_cache_init(void)
> > +{
> > +       ebitmap_node_cachep = kmem_cache_create("ebitmap_node",
> > +                                                       sizeof(struct
> ebitmap_node),
> > +                                                       0, SLAB_PANIC,
> > +NULL); }
> > +
> > +void ebitmap_cache_destroy(void)
> > +{
> > +       kmem_cache_destroy(ebitmap_node_cachep);
> > +}
> > diff --git a/security/selinux/ss/ebitmap.h
> > b/security/selinux/ss/ebitmap.h index 9637b8c..6d5a9ac 100644
> > --- a/security/selinux/ss/ebitmap.h
> > +++ b/security/selinux/ss/ebitmap.h
> > @@ -130,6 +130,9 @@ void ebitmap_destroy(struct ebitmap *e);  int
> > ebitmap_read(struct ebitmap *e, void *fp);  int ebitmap_write(struct
> > ebitmap *e, void *fp);
> >
> > +void ebitmap_cache_init(void);
> > +void ebitmap_cache_destroy(void);
> > +
> >  #ifdef CONFIG_NETLABEL
> >  int ebitmap_netlbl_export(struct ebitmap *ebmap,
> >                           struct netlbl_lsm_catmap **catmap); diff
> > --git a/security/selinux/ss/services.c
> > b/security/selinux/ss/services.c index 2021666..2f02fa6 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -2054,9 +2054,11 @@ int security_load_policy(void *data, size_t
> > len)
> >
> >         if (!ss_initialized) {
> >                 avtab_cache_init();
> > +               ebitmap_cache_init();
> >                 rc = policydb_read(&policydb, fp);
> >                 if (rc) {
> >                         avtab_cache_destroy();
> > +                       ebitmap_cache_destroy();
> >                         goto out;
> >                 }
> >
> > @@ -2067,6 +2069,7 @@ int security_load_policy(void *data, size_t len)
> >                 if (rc) {
> >                         policydb_destroy(&policydb);
> >                         avtab_cache_destroy();
> > +                       ebitmap_cache_destroy();
> >                         goto out;
> >                 }
> >
> > @@ -2074,6 +2077,7 @@ int security_load_policy(void *data, size_t len)
> >                 if (rc) {
> >                         policydb_destroy(&policydb);
> >                         avtab_cache_destroy();
> > +                       ebitmap_cache_destroy();
> >                         goto out;
> >                 }
> >
> > --
> > 2.6.2
> >
> 
> 
> 
> --
> paul moore
> www.paul-moore.com
