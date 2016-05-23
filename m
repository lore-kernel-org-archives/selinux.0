Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4NL4ah3016843
 for <selinux@tycho.nsa.gov>; Mon, 23 May 2016 17:04:37 -0400
Received: by mail-oi0-f65.google.com with SMTP id j202so3854179oih.2
 for <selinux@tycho.nsa.gov>; Mon, 23 May 2016 14:04:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1464015251-9425-1-git-send-email-sds@tycho.nsa.gov>
References: <1464015251-9425-1-git-send-email-sds@tycho.nsa.gov>
Date: Mon, 23 May 2016 17:04:32 -0400
Message-ID: <CAHC9VhSPy9O3OZpapUE9pyQDXFP82P4CJ3KgC5OyhZmJgWi72A@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: Only apply bounds checking to source types
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, May 23, 2016 at 10:54 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> The current bounds checking of both source and target types
> requires allowing any domain that has access to the child
> domain to also have the same permissions to the parent, which
> is undesirable.  Drop the target bounds checking.

...

> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v4 simplifies the logic as per the review comments, moving common
> code outside of the if statement and dropping unnecessary conditionals.

Thanks for the updated patch, it looks good to me.  I've merged it to
my next-queue and I'll apply it to selinux#next once the merge window
closes (should be next week).

>  security/selinux/ss/services.c | 70 +++++++++++++-----------------------------
>  1 file changed, 22 insertions(+), 48 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 89df646..082b20c 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -543,7 +543,7 @@ static void type_attribute_bounds_av(struct context *scontext,
>                                      struct av_decision *avd)
>  {
>         struct context lo_scontext;
> -       struct context lo_tcontext;
> +       struct context lo_tcontext, *tcontextp = tcontext;
>         struct av_decision lo_avd;
>         struct type_datum *source;
>         struct type_datum *target;
> @@ -553,67 +553,41 @@ static void type_attribute_bounds_av(struct context *scontext,
>                                     scontext->type - 1);
>         BUG_ON(!source);
>
> +       if (!source->bounds)
> +               return;
> +
>         target = flex_array_get_ptr(policydb.type_val_to_struct_array,
>                                     tcontext->type - 1);
>         BUG_ON(!target);
>
> -       if (source->bounds) {
> -               memset(&lo_avd, 0, sizeof(lo_avd));
> -
> -               memcpy(&lo_scontext, scontext, sizeof(lo_scontext));
> -               lo_scontext.type = source->bounds;
> +       memset(&lo_avd, 0, sizeof(lo_avd));
>
> -               context_struct_compute_av(&lo_scontext,
> -                                         tcontext,
> -                                         tclass,
> -                                         &lo_avd,
> -                                         NULL);
> -               if ((lo_avd.allowed & avd->allowed) == avd->allowed)
> -                       return;         /* no masked permission */
> -               masked = ~lo_avd.allowed & avd->allowed;
> -       }
> +       memcpy(&lo_scontext, scontext, sizeof(lo_scontext));
> +       lo_scontext.type = source->bounds;
>
>         if (target->bounds) {
> -               memset(&lo_avd, 0, sizeof(lo_avd));
> -
>                 memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
>                 lo_tcontext.type = target->bounds;
> -
> -               context_struct_compute_av(scontext,
> -                                         &lo_tcontext,
> -                                         tclass,
> -                                         &lo_avd,
> -                                         NULL);
> -               if ((lo_avd.allowed & avd->allowed) == avd->allowed)
> -                       return;         /* no masked permission */
> -               masked = ~lo_avd.allowed & avd->allowed;
> +               tcontextp = &lo_tcontext;
>         }
>
> -       if (source->bounds && target->bounds) {
> -               memset(&lo_avd, 0, sizeof(lo_avd));
> -               /*
> -                * lo_scontext and lo_tcontext are already
> -                * set up.
> -                */
> +       context_struct_compute_av(&lo_scontext,
> +                                 tcontextp,
> +                                 tclass,
> +                                 &lo_avd,
> +                                 NULL);
>
> -               context_struct_compute_av(&lo_scontext,
> -                                         &lo_tcontext,
> -                                         tclass,
> -                                         &lo_avd,
> -                                         NULL);
> -               if ((lo_avd.allowed & avd->allowed) == avd->allowed)
> -                       return;         /* no masked permission */
> -               masked = ~lo_avd.allowed & avd->allowed;
> -       }
> +       masked = ~lo_avd.allowed & avd->allowed;
>
> -       if (masked) {
> -               /* mask violated permissions */
> -               avd->allowed &= ~masked;
> +       if (likely(!masked))
> +               return;         /* no masked permission */
>
> -               /* audit masked permissions */
> -               security_dump_masked_av(scontext, tcontext,
> -                                       tclass, masked, "bounds");
> -       }
> +       /* mask violated permissions */
> +       avd->allowed &= ~masked;
> +
> +       /* audit masked permissions */
> +       security_dump_masked_av(scontext, tcontext,
> +                               tclass, masked, "bounds");
>  }
>
>  /*
> --
> 2.5.5
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
paul moore
www.paul-moore.com
