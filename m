Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5664E0v006167
 for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2017 02:04:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id x81so5067825lfb.3
 for <selinux@tycho.nsa.gov>; Mon, 05 Jun 2017 14:39:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496653814-3653-1-git-send-email-junil0814.lee@lge.com>
References: <1496653814-3653-1-git-send-email-junil0814.lee@lge.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 5 Jun 2017 17:39:46 -0400
Message-ID: <CAHC9VhSDux6oAcD1ZULOTcCp69JFY1c4Jati3odg4ROoRROp-w@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: use kmem_cache for ebitmap
To: Junil Lee <junil0814.lee@lge.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 william.c.roberts@intel.com, adobriyan@gmail.com,
 akpm@linux-foundation.org, dledford@redhat.com, danielj@mellanox.com,
 mka@chromium.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 5, 2017 at 5:10 AM, Junil Lee <junil0814.lee@lge.com> wrote:
> The allocated size for each ebitmap_node is 192byte by kzalloc().
> Then, ebitmap_node size is fixed, so it's possible to use only 144byte
> for each object by kmem_cache_zalloc().
> It can reduce some dynamic allocation size.
>
> Signed-off-by: Junil Lee <junil0814.lee@lge.com>
> ---
>  security/selinux/ss/ebitmap.c  | 24 +++++++++++++++++++-----
>  security/selinux/ss/ebitmap.h  |  3 +++
>  security/selinux/ss/services.c |  4 ++++
>  3 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 9db4709a..076c96f 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -24,6 +24,8 @@
>
>  #define BITS_PER_U64   (sizeof(u64) * 8)
>
> +static struct kmem_cache *ebitmap_node_cachep;
> +
>  int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2)
>  {
>         struct ebitmap_node *n1, *n2;
> @@ -54,7 +56,7 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
>         n = src->node;
>         prev = NULL;
>         while (n) {
> -               new = kzalloc(sizeof(*new), GFP_ATOMIC);
> +               new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>                 if (!new) {
>                         ebitmap_destroy(dst);
>                         return -ENOMEM;
> @@ -162,7 +164,7 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
>                 if (e_iter == NULL ||
>                     offset >= e_iter->startbit + EBITMAP_SIZE) {
>                         e_prev = e_iter;
> -                       e_iter = kzalloc(sizeof(*e_iter), GFP_ATOMIC);
> +                       e_iter = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>                         if (e_iter == NULL)
>                                 goto netlbl_import_failure;
>                         e_iter->startbit = offset - (offset % EBITMAP_SIZE);
> @@ -299,7 +301,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
>         if (!value)
>                 return 0;
>
> -       new = kzalloc(sizeof(*new), GFP_ATOMIC);
> +       new = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
>         if (!new)
>                 return -ENOMEM;

I believe there is a kfree() in ebitmap_set_bit() that also needs to
be converted.

-- 
paul moore
www.paul-moore.com
