Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7TNkanP012028
 for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2016 19:46:36 -0400
Received: by mail-oi0-f66.google.com with SMTP id e80so296360oig.2
 for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2016 16:46:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471985365-1197-2-git-send-email-william.c.roberts@intel.com>
References: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
 <1471985365-1197-2-git-send-email-william.c.roberts@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Aug 2016 19:46:14 -0400
Message-ID: <CAHC9VhRxPbKprG+pfxhVuD2mu278-TszR25jUP=R-ckLwxnPRg@mail.gmail.com>
Subject: Re: [PATCH 2/3] selinux: initialize structures
To: william.c.roberts@intel.com
Cc: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 23, 2016 at 4:49 PM,  <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> libsepol pointed out an issue where its possible to have
> an unitialized jmp and invalid dereference, fix this.
> While we're here, zero allocate all the *_val_to_struct
> structures.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  security/selinux/ss/policydb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 992a315..4b24385 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -541,21 +541,21 @@ static int policydb_index(struct policydb *p)
>
>         rc = -ENOMEM;
>         p->class_val_to_struct =
> -               kmalloc(p->p_classes.nprim * sizeof(*(p->class_val_to_struct)),
> +               kzalloc(p->p_classes.nprim * sizeof(*(p->class_val_to_struct)),
>                         GFP_KERNEL);
>         if (!p->class_val_to_struct)
>                 goto out;
>
>         rc = -ENOMEM;
>         p->role_val_to_struct =
> -               kmalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
> +               kzalloc(p->p_roles.nprim * sizeof(*(p->role_val_to_struct)),
>                         GFP_KERNEL);
>         if (!p->role_val_to_struct)
>                 goto out;
>
>         rc = -ENOMEM;
>         p->user_val_to_struct =
> -               kmalloc(p->p_users.nprim * sizeof(*(p->user_val_to_struct)),
> +               kzalloc(p->p_users.nprim * sizeof(*(p->user_val_to_struct)),
>                         GFP_KERNEL);
>         if (!p->user_val_to_struct)
>                 goto out;
> @@ -964,7 +964,7 @@ int policydb_context_isvalid(struct policydb *p, struct context *c)
>                  * Role must be authorized for the type.
>                  */
>                 role = p->role_val_to_struct[c->role - 1];
> -               if (!ebitmap_get_bit(&role->types, c->type - 1))
> +               if (!role || !ebitmap_get_bit(&role->types, c->type - 1))
>                         /* role may not be associated with type */
>                         return 0;
>
> --
> 1.9.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
paul moore
www.paul-moore.com
