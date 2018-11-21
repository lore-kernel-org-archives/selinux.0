Return-Path: <SRS0=ZtKf=OA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A78C43441
	for <selinux@archiver.kernel.org>; Wed, 21 Nov 2018 08:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC5C2145D
	for <selinux@archiver.kernel.org>; Wed, 21 Nov 2018 08:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC5C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeKUTJZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:09:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40092 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbeKUTJZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Nov 2018 14:09:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so4230010oth.7
        for <selinux@vger.kernel.org>; Wed, 21 Nov 2018 00:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ewLlKoDomdADf8WrMn+lXN/DFTpBMV1yqX2HXJF7+kg=;
        b=hmwatgponnp4D3te7oCjMJM8pCLD7nhTkW1Q/KahoXi9lceg+8H6kuR9+r0mkZ6AZK
         1xmgo1kadRTsK9tV5OLrDytXOQeHztLfxPD91cwpUMgHfLJVOUeuoDz3m6oxApqpTMXH
         ykC7ZV8OLMmO00bu4PXtsrot7iepdFGFv+Y5EKhmSX9zd28McT1vfNZxocA7It+GQKPH
         P8p2y3IeUG1bYo+3yxZ6o7U+JlChvCs0ZEXh2Ay1gFeM7uTZ3kt2UH9C/Jkxa68RjuhU
         nLn8NmEWBa8rjkhEr+ni4mIeG0iCydnoQlPW2G/gpma/ji79bqauiZxK/4DujemSTxK0
         3rGQ==
X-Gm-Message-State: AA+aEWZ/f90zjNpTPIDksXGjavofv2xQW6krcsOGFPczIBBSd7rQiATx
        OhT4xoO3kuc5bZt+2A6E2GfMI8Bw8vz/BVzfMnWZ4A==
X-Google-Smtp-Source: AJdET5f9kG3hBPJGTBCyordr1Kz8IaMzxVr1kFobg8goQ7j6F7Y1ju8DgmPvB4ZTqZySdikcAf4s6FwLrldQjE6lYcE=
X-Received: by 2002:a9d:da:: with SMTP id 26mr3176496otk.105.1542789349215;
 Wed, 21 Nov 2018 00:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20181112114426.20887-1-omosnace@redhat.com> <CAHC9VhTwQbAKvCxFNzRYOLL=cGQoCnpoggqGHks5C7-q5gGP5w@mail.gmail.com>
In-Reply-To: <CAHC9VhTwQbAKvCxFNzRYOLL=cGQoCnpoggqGHks5C7-q5gGP5w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 21 Nov 2018 09:35:38 +0100
Message-ID: <CAFqZXNuMiSF_s4yotxPrT6VJE+vz8ByCNu1Cc2tN63JimnHhaw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: simplify mls_context_to_sid()
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 20, 2018 at 10:06 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Nov 12, 2018 at 6:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > This function has only two callers, but only one of them actually needs
> > the special logic at the beginning. Factoring this logic out into
> > string_to_context_struct() allows us to drop the arguments 'oldc', 's',
> > and 'def_sid'.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > Changes in v3:
> >  - correct the comment about policy read lock
> >
> > Changes in v2:
> >  - also drop unneeded #include's from mls.c
> >
> >  security/selinux/ss/mls.c      | 49 +++++-----------------------------
> >  security/selinux/ss/mls.h      |  5 +---
> >  security/selinux/ss/services.c | 32 +++++++++++++++++++---
> >  3 files changed, 36 insertions(+), 50 deletions(-)
>
> What was the original motivation for this patch?  Is there a performance issue?

No, there is no performance issue that I know of. I simply wanted to
move the sidtab_search() reference out of mls.c when I was adding the
sid_to_context/content_to_sid wrappers to services.c. I have now
dropped the wrappers in favor of just rewriting the sidtab functions,
but the mls_context_to_sid() interface looked really awkward to me,
especially considering that the 'ugly' part of the function is really
used by only one caller, so I decided to post the patch anyway.

>
> I'm asking because I'm not really convinced this is an improvement.
> While I agree the number of function arguments is a bordering on "too
> many", I think I like having the logic in mls_context_to_sid() for
> right now.

I disagree, but I don't mind leaving it as it is if that's what you prefer.

>
> > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > index 2fe459df3c85..d1da928a7e77 100644
> > --- a/security/selinux/ss/mls.c
> > +++ b/security/selinux/ss/mls.c
> > @@ -24,10 +24,7 @@
> >  #include <linux/string.h>
> >  #include <linux/errno.h>
> >  #include <net/netlabel.h>
> > -#include "sidtab.h"
> >  #include "mls.h"
> > -#include "policydb.h"
> > -#include "services.h"
> >
> >  /*
> >   * Return the length in bytes for the MLS fields of the
> > @@ -223,20 +220,12 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
> >   * This function modifies the string in place, inserting
> >   * NULL characters to terminate the MLS fields.
> >   *
> > - * If a def_sid is provided and no MLS field is present,
> > - * copy the MLS field of the associated default context.
> > - * Used for upgraded to MLS systems where objects may lack
> > - * MLS fields.
> > - *
> > - * Policy read-lock must be held for sidtab lookup.
> > + * Policy read-lock must be held for policy data lookup.
> >   *
> >   */
> >  int mls_context_to_sid(struct policydb *pol,
> > -                      char oldc,
> >                        char *scontext,
> > -                      struct context *context,
> > -                      struct sidtab *s,
> > -                      u32 def_sid)
> > +                      struct context *context)
> >  {
> >         char *sensitivity, *cur_cat, *next_cat, *rngptr;
> >         struct level_datum *levdatum;
> > @@ -244,29 +233,6 @@ int mls_context_to_sid(struct policydb *pol,
> >         int l, rc, i;
> >         char *rangep[2];
> >
> > -       if (!pol->mls_enabled) {
> > -               if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
> > -                       return 0;
> > -               return -EINVAL;
> > -       }
> > -
> > -       /*
> > -        * No MLS component to the security context, try and map to
> > -        * default if provided.
> > -        */
> > -       if (!oldc) {
> > -               struct context *defcon;
> > -
> > -               if (def_sid == SECSID_NULL)
> > -                       return -EINVAL;
> > -
> > -               defcon = sidtab_search(s, def_sid);
> > -               if (!defcon)
> > -                       return -EINVAL;
> > -
> > -               return mls_context_cpy(context, defcon);
> > -       }
> > -
> >         /*
> >          * If we're dealing with a range, figure out where the two parts
> >          * of the range begin.
> > @@ -364,14 +330,11 @@ int mls_from_string(struct policydb *p, char *str, struct context *context,
> >                 return -EINVAL;
> >
> >         tmpstr = kstrdup(str, gfp_mask);
> > -       if (!tmpstr) {
> > -               rc = -ENOMEM;
> > -       } else {
> > -               rc = mls_context_to_sid(p, ':', tmpstr, context,
> > -                                       NULL, SECSID_NULL);
> > -               kfree(tmpstr);
> > -       }
> > +       if (!tmpstr)
> > +               return -ENOMEM;
> >
> > +       rc = mls_context_to_sid(p, tmpstr, context);
> > +       kfree(tmpstr);
> >         return rc;
> >  }
> >
> > diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> > index 67093647576d..e2498f78e100 100644
> > --- a/security/selinux/ss/mls.h
> > +++ b/security/selinux/ss/mls.h
> > @@ -33,11 +33,8 @@ int mls_range_isvalid(struct policydb *p, struct mls_range *r);
> >  int mls_level_isvalid(struct policydb *p, struct mls_level *l);
> >
> >  int mls_context_to_sid(struct policydb *p,
> > -                      char oldc,
> >                        char *scontext,
> > -                      struct context *context,
> > -                      struct sidtab *s,
> > -                      u32 def_sid);
> > +                      struct context *context);
> >
> >  int mls_from_string(struct policydb *p, char *str, struct context *context,
> >                     gfp_t gfp_mask);
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 12e414394530..ccad4334f99d 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1425,9 +1425,35 @@ static int string_to_context_struct(struct policydb *pol,
> >
> >         ctx->type = typdatum->value;
> >
> > -       rc = mls_context_to_sid(pol, oldc, p, ctx, sidtabp, def_sid);
> > -       if (rc)
> > -               goto out;
> > +       if (!pol->mls_enabled) {
> > +               rc = -EINVAL;
> > +               if ((def_sid == SECSID_NULL || !oldc) && (*p) != '\0')
> > +                       goto out;
> > +       } else if (!oldc) {
> > +               /*
> > +                * If a def_sid is provided and no MLS field is present,
> > +                * copy the MLS field of the associated default context.
> > +                * Used for upgrading to MLS systems where objects may lack
> > +                * MLS fields.
> > +                */
> > +               struct context *defcon;
> > +
> > +               rc = -EINVAL;
> > +               if (def_sid == SECSID_NULL)
> > +                       goto out;
> > +
> > +               defcon = sidtab_search(sidtabp, def_sid);
> > +               if (!defcon)
> > +                       goto out;
> > +
> > +               rc = mls_context_cpy(ctx, defcon);
> > +               if (rc)
> > +                       goto out;
> > +       } else {
> > +               rc = mls_context_to_sid(pol, p, ctx);
> > +               if (rc)
> > +                       goto out;
> > +       }
> >
> >         /* Check the validity of the new context. */
> >         rc = -EINVAL;
> > --
> > 2.17.2
> >
>
>
> --
> paul moore
> www.paul-moore.com

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
