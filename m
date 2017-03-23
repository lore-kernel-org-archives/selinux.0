Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NLKGN4026595
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 17:20:16 -0400
Received: by mail-vk0-f65.google.com with SMTP id d188so21659653vka.3
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 14:20:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <247c0e27-c442-3408-4f92-492629d61fbf@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <247c0e27-c442-3408-4f92-492629d61fbf@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 17:20:14 -0400
Message-ID: <CAHC9VhRHEDCRNVfOqw4mwJQD9PmESEcgyZ7xCEwHZKpiDSjnYw@mail.gmail.com>
Subject: Re: [PATCH 07/46] selinux: Delete unnecessary variable assignments in
 policydb_index()
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

On Sun, Jan 15, 2017 at 10:04 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 13:40:25 +0100
>
> The local variable "rc" was reset with an error code up to five times
> before a memory allocation failure was detected.
>
> Add a jump target so that this assignment will only be performed after
> a concrete software failure.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)

Like you, I generally despise the notion of unconditionally setting
return codes to an error value *before* the faulting call; see Eric's
response on patch 0/46, my preferred style is different from Eric.
However, I agree with Casey that this patch is mostly just code churn
so I'm going to drop this from your series.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 21869b622c0c..4d4ba1ad910d 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -539,34 +539,30 @@ static int policydb_index(struct policydb *p)
>         symtab_hash_eval(p->symtab);
>  #endif
>
> -       rc = -ENOMEM;
>         p->class_val_to_struct = kcalloc(p->p_classes.nprim,
>                                          sizeof(*p->class_val_to_struct),
>                                          GFP_KERNEL);
>         if (!p->class_val_to_struct)
> -               goto out;
> +               goto failure_indication;
>
> -       rc = -ENOMEM;
>         p->role_val_to_struct = kcalloc(p->p_roles.nprim,
>                                         sizeof(*p->role_val_to_struct),
>                                         GFP_KERNEL);
>         if (!p->role_val_to_struct)
> -               goto out;
> +               goto failure_indication;
>
> -       rc = -ENOMEM;
>         p->user_val_to_struct = kcalloc(p->p_users.nprim,
>                                         sizeof(*p->user_val_to_struct),
>                                         GFP_KERNEL);
>         if (!p->user_val_to_struct)
> -               goto out;
> +               goto failure_indication;
>
>         /* Yes, I want the sizeof the pointer, not the structure */
> -       rc = -ENOMEM;
>         p->type_val_to_struct_array = flex_array_alloc(sizeof(struct type_datum *),
>                                                        p->p_types.nprim,
>                                                        GFP_KERNEL | __GFP_ZERO);
>         if (!p->type_val_to_struct_array)
> -               goto out;
> +               goto failure_indication;
>
>         rc = flex_array_prealloc(p->type_val_to_struct_array, 0,
>                                  p->p_types.nprim, GFP_KERNEL | __GFP_ZERO);
> @@ -578,12 +574,11 @@ static int policydb_index(struct policydb *p)
>                 goto out;
>
>         for (i = 0; i < SYM_NUM; i++) {
> -               rc = -ENOMEM;
>                 p->sym_val_to_name[i] = flex_array_alloc(sizeof(char *),
>                                                          p->symtab[i].nprim,
>                                                          GFP_KERNEL | __GFP_ZERO);
>                 if (!p->sym_val_to_name[i])
> -                       goto out;
> +                       goto failure_indication;
>
>                 rc = flex_array_prealloc(p->sym_val_to_name[i],
>                                          0, p->symtab[i].nprim,
> @@ -598,6 +593,9 @@ static int policydb_index(struct policydb *p)
>         rc = 0;
>  out:
>         return rc;
> +failure_indication:
> +       rc = -ENOMEM;
> +       goto out;
>  }
>
>  /*
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
