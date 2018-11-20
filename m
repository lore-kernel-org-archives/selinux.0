Return-Path: <SRS0=awya=N7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450AAC46475
	for <selinux@archiver.kernel.org>; Tue, 20 Nov 2018 21:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D472C21479
	for <selinux@archiver.kernel.org>; Tue, 20 Nov 2018 21:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VVbmgBZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D472C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbeKUHhd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:37:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39308 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeKUHhd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Nov 2018 02:37:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so2371265lfh.6
        for <selinux@vger.kernel.org>; Tue, 20 Nov 2018 13:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3f/UJvUgkrP11y7hWtx/dnqTpokRsUvDtcPo54MEvw=;
        b=VVbmgBZ109GWlFM/Y41TD819OIWCYLVFTnH01rJwF8jbOMDCOucKIj7Y/cesb8kveg
         vS9Et9K1n8blWlALg0ebf/0R2J/lSWZ+INLzqLHFViKmidGNmPERQqzBWVvVOuDEGZ0u
         esxgBoDWTTjBvUf3gs35Sg315PEMEgC7Y+6L4DUi5bzr44+sIVkMHkiH2IwOo5H39VEK
         1KT++OOsbUK/de+DDasGYflmmW4289BAetUzRNeXNUTHo8YjA7+vdDbNaJ1hnBE71pev
         J/OH4IMGpVcQYzsicBO9GSU8TzQNSZlPSWcb5+SvY+o6GEpIDvPSkygUr9QGWLrB1WtU
         e6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3f/UJvUgkrP11y7hWtx/dnqTpokRsUvDtcPo54MEvw=;
        b=Snn34kumx9iQ9KsV3ElZ8OIC07GrbprbeJIumDdm6HGRMEsy/DnpjVzR+P+IVyK8cY
         3wUZux661/AtzqzGEJElgnIjhe0pPzvwQ10rDoTw/I6N2unEfMFm06nAgkn8b/35wfKN
         UKAFobre9vk5HUwXT23NM7O23d8bwGP8Ol29dAx8R2+oUOecv0FJx+rPE6FaLT6byZTy
         HN+OPNuSw8bCVFhSXjJmSzmmoHR04abiJxcj2kkla39MzkSJkLp8TW7pTqttM/eYQ7Ns
         xE9VWVfoxowvFoFYjopwqIPkKHImE9ufzJjjx9hiH1rUdLHtIjKyczcuFmvrnSz/UI2F
         tbUA==
X-Gm-Message-State: AGRZ1gLWHT2Lxg8zRFA5vsUQM5SEGsQ5f4aZBfSGBTfFVg6S1RyXeSU4
        Qw2p382Kum3GNwdyRj+kC8FKoXSf1w892BwPoOD44I8=
X-Google-Smtp-Source: AJdET5f+9yoORu2LgU0Jbqoc0/JUuu0BWGEcAwKDsaWy4AZwupff4QCHUqQMdROIjOizRK4RsyK0vEBSMU7ptDkV/OM=
X-Received: by 2002:a19:f115:: with SMTP id p21mr1988028lfh.20.1542747984612;
 Tue, 20 Nov 2018 13:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20181112114426.20887-1-omosnace@redhat.com>
In-Reply-To: <20181112114426.20887-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Nov 2018 16:06:13 -0500
Message-ID: <CAHC9VhTwQbAKvCxFNzRYOLL=cGQoCnpoggqGHks5C7-q5gGP5w@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: simplify mls_context_to_sid()
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 12, 2018 at 6:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This function has only two callers, but only one of them actually needs
> the special logic at the beginning. Factoring this logic out into
> string_to_context_struct() allows us to drop the arguments 'oldc', 's',
> and 'def_sid'.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Changes in v3:
>  - correct the comment about policy read lock
>
> Changes in v2:
>  - also drop unneeded #include's from mls.c
>
>  security/selinux/ss/mls.c      | 49 +++++-----------------------------
>  security/selinux/ss/mls.h      |  5 +---
>  security/selinux/ss/services.c | 32 +++++++++++++++++++---
>  3 files changed, 36 insertions(+), 50 deletions(-)

What was the original motivation for this patch?  Is there a performance issue?

I'm asking because I'm not really convinced this is an improvement.
While I agree the number of function arguments is a bordering on "too
many", I think I like having the logic in mls_context_to_sid() for
right now.

> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 2fe459df3c85..d1da928a7e77 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -24,10 +24,7 @@
>  #include <linux/string.h>
>  #include <linux/errno.h>
>  #include <net/netlabel.h>
> -#include "sidtab.h"
>  #include "mls.h"
> -#include "policydb.h"
> -#include "services.h"
>
>  /*
>   * Return the length in bytes for the MLS fields of the
> @@ -223,20 +220,12 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
>   * This function modifies the string in place, inserting
>   * NULL characters to terminate the MLS fields.
>   *
> - * If a def_sid is provided and no MLS field is present,
> - * copy the MLS field of the associated default context.
> - * Used for upgraded to MLS systems where objects may lack
> - * MLS fields.
> - *
> - * Policy read-lock must be held for sidtab lookup.
> + * Policy read-lock must be held for policy data lookup.
>   *
>   */
>  int mls_context_to_sid(struct policydb *pol,
> -                      char oldc,
>                        char *scontext,
> -                      struct context *context,
> -                      struct sidtab *s,
> -                      u32 def_sid)
> +                      struct context *context)
>  {
>         char *sensitivity, *cur_cat, *next_cat, *rngptr;
>         struct level_datum *levdatum;
> @@ -244,29 +233,6 @@ int mls_context_to_sid(struct policydb *pol,
>         int l, rc, i;
>         char *rangep[2];
>
> -       if (!pol->mls_enabled) {
> -               if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
> -                       return 0;
> -               return -EINVAL;
> -       }
> -
> -       /*
> -        * No MLS component to the security context, try and map to
> -        * default if provided.
> -        */
> -       if (!oldc) {
> -               struct context *defcon;
> -
> -               if (def_sid == SECSID_NULL)
> -                       return -EINVAL;
> -
> -               defcon = sidtab_search(s, def_sid);
> -               if (!defcon)
> -                       return -EINVAL;
> -
> -               return mls_context_cpy(context, defcon);
> -       }
> -
>         /*
>          * If we're dealing with a range, figure out where the two parts
>          * of the range begin.
> @@ -364,14 +330,11 @@ int mls_from_string(struct policydb *p, char *str, struct context *context,
>                 return -EINVAL;
>
>         tmpstr = kstrdup(str, gfp_mask);
> -       if (!tmpstr) {
> -               rc = -ENOMEM;
> -       } else {
> -               rc = mls_context_to_sid(p, ':', tmpstr, context,
> -                                       NULL, SECSID_NULL);
> -               kfree(tmpstr);
> -       }
> +       if (!tmpstr)
> +               return -ENOMEM;
>
> +       rc = mls_context_to_sid(p, tmpstr, context);
> +       kfree(tmpstr);
>         return rc;
>  }
>
> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> index 67093647576d..e2498f78e100 100644
> --- a/security/selinux/ss/mls.h
> +++ b/security/selinux/ss/mls.h
> @@ -33,11 +33,8 @@ int mls_range_isvalid(struct policydb *p, struct mls_range *r);
>  int mls_level_isvalid(struct policydb *p, struct mls_level *l);
>
>  int mls_context_to_sid(struct policydb *p,
> -                      char oldc,
>                        char *scontext,
> -                      struct context *context,
> -                      struct sidtab *s,
> -                      u32 def_sid);
> +                      struct context *context);
>
>  int mls_from_string(struct policydb *p, char *str, struct context *context,
>                     gfp_t gfp_mask);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 12e414394530..ccad4334f99d 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1425,9 +1425,35 @@ static int string_to_context_struct(struct policydb *pol,
>
>         ctx->type = typdatum->value;
>
> -       rc = mls_context_to_sid(pol, oldc, p, ctx, sidtabp, def_sid);
> -       if (rc)
> -               goto out;
> +       if (!pol->mls_enabled) {
> +               rc = -EINVAL;
> +               if ((def_sid == SECSID_NULL || !oldc) && (*p) != '\0')
> +                       goto out;
> +       } else if (!oldc) {
> +               /*
> +                * If a def_sid is provided and no MLS field is present,
> +                * copy the MLS field of the associated default context.
> +                * Used for upgrading to MLS systems where objects may lack
> +                * MLS fields.
> +                */
> +               struct context *defcon;
> +
> +               rc = -EINVAL;
> +               if (def_sid == SECSID_NULL)
> +                       goto out;
> +
> +               defcon = sidtab_search(sidtabp, def_sid);
> +               if (!defcon)
> +                       goto out;
> +
> +               rc = mls_context_cpy(ctx, defcon);
> +               if (rc)
> +                       goto out;
> +       } else {
> +               rc = mls_context_to_sid(pol, p, ctx);
> +               if (rc)
> +                       goto out;
> +       }
>
>         /* Check the validity of the new context. */
>         rc = -EINVAL;
> --
> 2.17.2
>


-- 
paul moore
www.paul-moore.com
