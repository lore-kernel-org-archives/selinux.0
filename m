Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NLiDsl000948
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 17:44:13 -0400
Received: by mail-vk0-f66.google.com with SMTP id d188so21738990vka.3
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 14:44:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7fdcfc8f-affa-fcf8-adaf-dc8fd9e1b472@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <7fdcfc8f-affa-fcf8-adaf-dc8fd9e1b472@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 17:44:07 -0400
Message-ID: <CAHC9VhSfvsoWCD1DHFPYhnmWx_cmmapo6vjboS8e=6OZ8ca9gA@mail.gmail.com>
Subject: Re: [PATCH 10/46] selinux: Move some assignments for the variable
 "rc" in policydb_read()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Jan 15, 2017 at 10:10 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 15:22:29 +0100
>
> One local variable was set to an error code in some cases before
> a concrete error situation was detected. Thus move the corresponding
> assignments into if branches to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 59 +++++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 24 deletions(-)

More code churn with no real advantage.  I agree with the style you
are using, and would support changing it if you are in the function
fixing bugs or doing other substantial changes in that code, but I
can't justify it as a standalone change, sorry.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 53e6d06e772a..506b0228d1f1 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2250,15 +2250,14 @@ int policydb_read(struct policydb *p, void *fp)
>         if (rc)
>                 goto bad;
>
> -       rc = -EINVAL;
>         if (le32_to_cpu(buf[0]) != POLICYDB_MAGIC) {
>                 printk(KERN_ERR "SELinux:  policydb magic number 0x%x does "
>                        "not match expected magic number 0x%x\n",
>                        le32_to_cpu(buf[0]), POLICYDB_MAGIC);
> +               rc = -EINVAL;
>                 goto bad;
>         }
>
> -       rc = -EINVAL;
>         len = le32_to_cpu(buf[1]);
>         if (len != strlen(POLICYDB_STRING)) {
>                 printk(KERN_ERR "SELinux:  policydb string length %d does not "
> @@ -2265,11 +2265,13 @@ int policydb_read(struct policydb *p, void *fp)
>                        len, strlen(POLICYDB_STRING));
> +               rc = -EINVAL;
>                 goto bad;
>         }
>
> -       rc = -ENOMEM;
>         policydb_str = kmalloc(len + 1, GFP_KERNEL);
> -       if (!policydb_str)
> +       if (!policydb_str) {
> +               rc = -ENOMEM;
>                 goto bad;
> +       }
>
>         rc = next_entry(policydb_str, fp, len);
>         if (rc) {
> @@ -2279,12 +2280,12 @@ int policydb_read(struct policydb *p, void *fp)
>                 goto bad;
>         }
>
> -       rc = -EINVAL;
>         policydb_str[len] = '\0';
>         if (strcmp(policydb_str, POLICYDB_STRING)) {
>                 printk(KERN_ERR "SELinux:  policydb string %s does not match "
>                        "my string %s\n", policydb_str, POLICYDB_STRING);
>                 kfree(policydb_str);
> +               rc = -EINVAL;
>                 goto bad;
>         }
>         /* Done with policydb_str. */
> @@ -2296,24 +2297,24 @@ int policydb_read(struct policydb *p, void *fp)
>         if (rc)
>                 goto bad;
>
> -       rc = -EINVAL;
>         p->policyvers = le32_to_cpu(buf[0]);
>         if (p->policyvers < POLICYDB_VERSION_MIN ||
>             p->policyvers > POLICYDB_VERSION_MAX) {
>                 printk(KERN_ERR "SELinux:  policydb version %d does not match "
>                        "my version range %d-%d\n",
>                        le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
> +               rc = -EINVAL;
>                 goto bad;
>         }
>
>         if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
>                 p->mls_enabled = 1;
>
> -               rc = -EINVAL;
>                 if (p->policyvers < POLICYDB_VERSION_MLS) {
>                         printk(KERN_ERR "SELinux: security policydb version %d "
>                                 "(MLS) not backwards compatible\n",
>                                 p->policyvers);
> +                       rc = -EINVAL;
>                         goto bad;
>                 }
>         }
> @@ -2332,21 +2333,21 @@ int policydb_read(struct policydb *p, void *fp)
>                         goto bad;
>         }
>
> -       rc = -EINVAL;
>         info = policydb_lookup_compat(p->policyvers);
>         if (!info) {
>                 printk(KERN_ERR "SELinux:  unable to find policy compat info "
>                        "for version %d\n", p->policyvers);
> +               rc = -EINVAL;
>                 goto bad;
>         }
>
> -       rc = -EINVAL;
>         if (le32_to_cpu(buf[2]) != info->sym_num ||
>                 le32_to_cpu(buf[3]) != info->ocon_num) {
>                 printk(KERN_ERR "SELinux:  policydb table sizes (%d,%d) do "
>                        "not match mine (%d,%d)\n", le32_to_cpu(buf[2]),
>                         le32_to_cpu(buf[3]),
>                        info->sym_num, info->ocon_num);
> +               rc = -EINVAL;
>                 goto bad;
>         }
>
> @@ -2365,10 +2366,11 @@ int policydb_read(struct policydb *p, void *fp)
>                 p->symtab[i].nprim = nprim;
>         }
>
> -       rc = -EINVAL;
>         p->process_class = string_to_security_class(p, "process");
> -       if (!p->process_class)
> +       if (!p->process_class) {
> +               rc = -EINVAL;
>                 goto bad;
> +       }
>
>         rc = avtab_read(&p->te_avtab, fp, p);
>         if (rc)
> @@ -2386,10 +2388,12 @@ int policydb_read(struct policydb *p, void *fp)
>         nel = le32_to_cpu(buf[0]);
>         ltr = NULL;
>         for (i = 0; i < nel; i++) {
> -               rc = -ENOMEM;
>                 tr = kzalloc(sizeof(*tr), GFP_KERNEL);
> -               if (!tr)
> +               if (!tr) {
> +                       rc = -ENOMEM;
>                         goto bad;
> +               }
> +
>                 if (ltr)
>                         ltr->next = tr;
>                 else
> @@ -2398,7 +2402,6 @@ int policydb_read(struct policydb *p, void *fp)
>                 if (rc)
>                         goto bad;
>
> -               rc = -EINVAL;
>                 tr->role = le32_to_cpu(buf[0]);
>                 tr->type = le32_to_cpu(buf[1]);
>                 tr->new_role = le32_to_cpu(buf[2]);
> @@ -2410,12 +2413,14 @@ int policydb_read(struct policydb *p, void *fp)
>                 } else
>                         tr->tclass = p->process_class;
>
> -               rc = -EINVAL;
>                 if (!policydb_role_isvalid(p, tr->role) ||
>                     !policydb_type_isvalid(p, tr->type) ||
>                     !policydb_class_isvalid(p, tr->tclass) ||
> -                   !policydb_role_isvalid(p, tr->new_role))
> +                   !policydb_role_isvalid(p, tr->new_role)) {
> +                       rc = -EINVAL;
>                         goto bad;
> +               }
> +
>                 ltr = tr;
>         }
>
> @@ -2425,10 +2430,12 @@ int policydb_read(struct policydb *p, void *fp)
>         nel = le32_to_cpu(buf[0]);
>         lra = NULL;
>         for (i = 0; i < nel; i++) {
> -               rc = -ENOMEM;
>                 ra = kzalloc(sizeof(*ra), GFP_KERNEL);
> -               if (!ra)
> +               if (!ra) {
> +                       rc = -ENOMEM;
>                         goto bad;
> +               }
> +
>                 if (lra)
>                         lra->next = ra;
>                 else
> @@ -2437,12 +2444,14 @@ int policydb_read(struct policydb *p, void *fp)
>                 if (rc)
>                         goto bad;
>
> -               rc = -EINVAL;
>                 ra->role = le32_to_cpu(buf[0]);
>                 ra->new_role = le32_to_cpu(buf[1]);
>                 if (!policydb_role_isvalid(p, ra->role) ||
> -                   !policydb_role_isvalid(p, ra->new_role))
> +                   !policydb_role_isvalid(p, ra->new_role)) {
> +                       rc = -EINVAL;
>                         goto bad;
> +               }
> +
>                 lra = ra;
>         }
>
> @@ -2454,11 +2463,12 @@ int policydb_read(struct policydb *p, void *fp)
>         if (rc)
>                 goto bad;
>
> -       rc = -EINVAL;
>         p->process_trans_perms = string_to_av_perm(p, p->process_class, "transition");
>         p->process_trans_perms |= string_to_av_perm(p, p->process_class, "dyntransition");
> -       if (!p->process_trans_perms)
> +       if (!p->process_trans_perms) {
> +               rc = -EINVAL;
>                 goto bad;
> +       }
>
>         rc = ocontext_read(p, info, fp);
>         if (rc)
> @@ -2472,12 +2482,13 @@ int policydb_read(struct policydb *p, void *fp)
>         if (rc)
>                 goto bad;
>
> -       rc = -ENOMEM;
>         p->type_attr_map_array = flex_array_alloc(sizeof(struct ebitmap),
>                                                   p->p_types.nprim,
>                                                   GFP_KERNEL | __GFP_ZERO);
> -       if (!p->type_attr_map_array)
> +       if (!p->type_attr_map_array) {
> +               rc = -ENOMEM;
>                 goto bad;
> +       }
>
>         /* preallocate so we don't have to worry about the put ever failing */
>         rc = flex_array_prealloc(p->type_attr_map_array, 0, p->p_types.nprim,
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
