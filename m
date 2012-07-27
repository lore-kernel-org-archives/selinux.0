Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6RJMIsV014885
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 15:22:18 -0400
Received: by pbbrr13 with SMTP id rr13so5319168pbb.12
        for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2012 12:22:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343416759-32071-2-git-send-email-w.roberts@sta.samsung.com>
References: <1343416759-32071-2-git-send-email-w.roberts@sta.samsung.com>
Date: Fri, 27 Jul 2012 12:22:17 -0700
Message-ID: <CAFftDdpC8bBM69ioTDAA0NAdybK19ukp74HxbkFyoey2UY61zA@mail.gmail.com>
Subject: Re: [PATCH] You can now specify a sebool= flag in seapp_contexts
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is part of a patch series, but for some reason the operator of
git send-email is messing it up (me)

On Fri, Jul 27, 2012 at 12:19 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> and that rule will ONLY be applied on a match to that
> boolean, and only if the boolean is set to true.
>
> Change-Id: Ifdba35cd3a78ce1c8173786514db649203018e28
> Signed-off-by: William Roberts <w.roberts@sta.samsung.com>
> ---
>  src/android.c |   41 ++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/src/android.c b/src/android.c
> index 83ba7b7..8415742 100644
> --- a/src/android.c
> +++ b/src/android.c
> @@ -45,6 +45,7 @@ struct seapp_context {
>         char *domain;
>         char *type;
>         char *level;
> +       char *sebool;
>         char levelFromUid;
>  };
>
> @@ -85,6 +86,12 @@ static int seapp_context_cmp(const void *A, const void *B)
>         if (!s1->name && s2->name)
>                 return 1;
>
> +        /* Give precedence to a specified sebool= over an unspecified sebool=. */
> +        if (s1->sebool && !s2->sebool)
> +                return -1;
> +        if (!s1->sebool && s2->sebool)
> +                return 1;
> +
>         /* Anything else has equal precedence. */
>         return 0;
>  }
> @@ -196,6 +203,10 @@ int selinux_android_seapp_context_reload(void)
>                                 cur->level = strdup(value);
>                                 if (!cur->level)
>                                         goto oom;
> +                       } else if (!strcasecmp(name, "sebool")) {
> +                               cur->sebool = strdup(value);
> +                               if (!cur->sebool)
> +                                       goto oom;
>                         } else
>                                 goto err;
>
> @@ -217,12 +228,13 @@ int selinux_android_seapp_context_reload(void)
>                 int i;
>                 for (i = 0; i < nspec; i++) {
>                         cur = seapp_contexts[i];
> -                       selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s user=%s seinfo=%s name=%s -> domain=%s type=%s level=%s levelFromUid=%s",
> +                       selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s user=%s seinfo=%s name=%s -> domain=%s type=%s level=%s levelFromUid=%s sebool=%s",
>                                     __FUNCTION__,
>                                     cur->isSystemServer ? "true" : "false",
>                                     cur->user, cur->seinfo, cur->name,
>                                     cur->domain, cur->type, cur->level,
> -                                   cur->levelFromUid ? "true" : "false");
> +                                   cur->levelFromUid ? "true" : "false",
> +                                   cur->sebool);
>                 }
>         }
>  #endif
> @@ -348,7 +360,18 @@ int selinux_android_setfilecon2(const char *pkgdir,
>                         if (context_range_set(ctx, cur->level))
>                                 goto oom;
>                 }
> -
> +
> +                if (cur->sebool) {
> +                        int value = security_get_boolean_active(cur->sebool);
> +                        if (value == 0)
> +                                continue;
> +                        else if (value == -1) {
> +                                selinux_log(SELINUX_ERROR, \
> +                                "Could not find boolean: %s ", cur->sebool);
> +                                goto err;
> +                        }
> +                }
> +
>                 break;
>         }
>
> @@ -443,6 +466,7 @@ int selinux_android_setcontext(uid_t uid,
>
>         for (i = 0; i < nspec; i++) {
>                 cur = seapp_contexts[i];
> +
>                 if (cur->isSystemServer != isSystemServer)
>                         continue;
>                 if (cur->user) {
> @@ -466,6 +490,17 @@ int selinux_android_setcontext(uid_t uid,
>                 if (!cur->domain)
>                         continue;
>
> +               if (cur->sebool) {
> +                       int value = security_get_boolean_active(cur->sebool);
> +                       if (value == 0)
> +                               continue;
> +                       else if (value == -1) {
> +                               selinux_log(SELINUX_ERROR, \
> +                               "Could not find boolean: %s ", cur->sebool);
> +                                goto err;
> +                        }
> +                }
> +
>                 if (context_type_set(ctx, cur->domain))
>                         goto oom;
>
> --
> 1.7.0.4
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
