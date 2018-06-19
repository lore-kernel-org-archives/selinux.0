Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JFncxN031600
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 11:49:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id a13-v6so199161lfk.12
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 08:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-3-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-3-peter.enderborg@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jun 2018 11:49:10 -0400
Message-ID: <CAHC9VhQezCR-P_5-RV1dGYcoP40k-eCC4GYqUOANvfggzRmV+A@mail.gmail.com>
To: peter.enderborg@sony.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, danielj@mellanox.com,
 dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 02/13] selinux: Cleanup printk logging in ebitmap
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/ss/ebitmap.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 5ae8c61b75bf..8f624f80055b 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -362,7 +362,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>         count = le32_to_cpu(buf[2]);
>
>         if (mapunit != BITS_PER_U64) {
> -               printk(KERN_ERR "SELinux: ebitmap: map size %u does not "
> +               pr_err("SELinux: ebitmap: map size %u does not "
>                        "match my size %zd (high bit was %d)\n",
>                        mapunit, BITS_PER_U64, e->highbit);
>                 goto bad;
> @@ -383,19 +383,19 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>         for (i = 0; i < count; i++) {
>                 rc = next_entry(&startbit, fp, sizeof(u32));
>                 if (rc < 0) {
> -                       printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
> +                       pr_err("SELinux: ebitmap: truncated map\n");
>                         goto bad;
>                 }
>                 startbit = le32_to_cpu(startbit);
>
>                 if (startbit & (mapunit - 1)) {
> -                       printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
> +                       pr_err("SELinux: ebitmap start bit (%d) is "
>                                "not a multiple of the map unit size (%u)\n",
>                                startbit, mapunit);
>                         goto bad;
>                 }
>                 if (startbit > e->highbit - mapunit) {
> -                       printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
> +                       pr_err("SELinux: ebitmap start bit (%d) is "
>                                "beyond the end of the bitmap (%u)\n",
>                                startbit, (e->highbit - mapunit));
>                         goto bad;
> @@ -405,8 +405,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>                         struct ebitmap_node *tmp;
>                         tmp = kmem_cache_zalloc(ebitmap_node_cachep, GFP_KERNEL);
>                         if (!tmp) {
> -                               printk(KERN_ERR
> -                                      "SELinux: ebitmap: out of memory\n");
> +                               pr_err("SELinux: ebitmap: out of memory\n");
>                                 rc = -ENOMEM;
>                                 goto bad;
>                         }
> @@ -418,7 +417,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>                                 e->node = tmp;
>                         n = tmp;
>                 } else if (startbit <= n->startbit) {
> -                       printk(KERN_ERR "SELinux: ebitmap: start bit %d"
> +                       pr_err("SELinux: ebitmap: start bit %d"
>                                " comes after start bit %d\n",
>                                startbit, n->startbit);
>                         goto bad;
> @@ -426,7 +425,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>
>                 rc = next_entry(&map, fp, sizeof(u64));
>                 if (rc < 0) {
> -                       printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
> +                       pr_err("SELinux: ebitmap: truncated map\n");
>                         goto bad;
>                 }
>                 map = le64_to_cpu(map);
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
