Return-Path: <SRS0=eYI8=NZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B63C43441
	for <selinux@archiver.kernel.org>; Wed, 14 Nov 2018 08:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AA621582
	for <selinux@archiver.kernel.org>; Wed, 14 Nov 2018 08:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AA621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeKNSFH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:05:07 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33936 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeKNSFH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Nov 2018 13:05:07 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so13972325otk.1
        for <selinux@vger.kernel.org>; Wed, 14 Nov 2018 00:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wnfFYfeq5cZSdwIBycYFGOAjJnCvkUlArDP5yjQnPo=;
        b=Tza6EjxLlBaGoa3YRZoijfafcFAhr9GCtO5aufkS3XUrIZiHUvb4hwcv6R6TANi1kc
         sh8yer8Py6ufI35rsKC+Cmjoiq7A/NjHF6rCAOgV7ptlJ91mcXfkbkBNk2bLzCPKA+eT
         cTQKIHwgaeSvMYwiaeve3jGx5ZTVxhO/fk2rPIOPRtvaWARHa3GukTPkmFWFqWeJbjwS
         mCV7zqrVQFMQ+dpwHzjPBpmOokRBqq3CQew10P4xSKWl1NDTifV9naE/uTIoCtyCRCY/
         UFy42D2w0kCr3jv6P/po826x1lU5OpKQml9KNm9SQL1+Z3/9sacgLxDZDwhyCaskMhM1
         aM2g==
X-Gm-Message-State: AGRZ1gKHIWjEYS8mhkOkF8IuvvwglGsRE5O1nqsDhO7wAkqzAW+27BBt
        AueWN7hzrozG1cOmP8H0Kj1r54BbLlK1fgbUlANeAqHB
X-Google-Smtp-Source: AJdET5cclTkpOK5e4gvj4rJJIoAXwH7FhCJR6l/JS8KSaXbwjzZnF/7lNMzVssEj20ScqJnQMlkqDIEelkDgkgGtrLw=
X-Received: by 2002:a9d:582e:: with SMTP id r46mr514994oth.238.1542182579029;
 Wed, 14 Nov 2018 00:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20181112114426.20887-1-omosnace@redhat.com> <6eab4acd-a802-efba-db19-9593419025e2@tycho.nsa.gov>
 <CAHC9VhSV0ZDYBffe+nCH7N8GZ-4ZkH6Wpt+R62Ca7kO4hYrdsQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSV0ZDYBffe+nCH7N8GZ-4ZkH6Wpt+R62Ca7kO4hYrdsQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 14 Nov 2018 09:02:47 +0100
Message-ID: <CAFqZXNtJKJ+SYRZ+EWZ-aoSufUAMbTgk8MHbVJLO-EDJv0oByg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: simplify mls_context_to_sid()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        SElinux list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 14, 2018 at 4:14 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Nov 13, 2018 at 4:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 11/12/18 6:44 AM, Ondrej Mosnacek wrote:
> > > This function has only two callers, but only one of them actually needs
> > > the special logic at the beginning. Factoring this logic out into
> > > string_to_context_struct() allows us to drop the arguments 'oldc', 's',
> > > and 'def_sid'.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > Changes in v3:
> > >   - correct the comment about policy read lock
> > >
> > > Changes in v2:
> > >   - also drop unneeded #include's from mls.c
> > >
> > >   security/selinux/ss/mls.c      | 49 +++++-----------------------------
> > >   security/selinux/ss/mls.h      |  5 +---
> > >   security/selinux/ss/services.c | 32 +++++++++++++++++++---
> > >   3 files changed, 36 insertions(+), 50 deletions(-)
> > >
> > > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > > index 2fe459df3c85..d1da928a7e77 100644
> > > --- a/security/selinux/ss/mls.c
> > > +++ b/security/selinux/ss/mls.c
> > > @@ -24,10 +24,7 @@
> > >   #include <linux/string.h>
> > >   #include <linux/errno.h>
> > >   #include <net/netlabel.h>
> > > -#include "sidtab.h"
> > >   #include "mls.h"
> > > -#include "policydb.h"
> > > -#include "services.h"
> > >
> > >   /*
> > >    * Return the length in bytes for the MLS fields of the
> > > @@ -223,20 +220,12 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
> > >    * This function modifies the string in place, inserting
> > >    * NULL characters to terminate the MLS fields.
> > >    *
> > > - * If a def_sid is provided and no MLS field is present,
> > > - * copy the MLS field of the associated default context.
> > > - * Used for upgraded to MLS systems where objects may lack
> > > - * MLS fields.
> > > - *
> > > - * Policy read-lock must be held for sidtab lookup.
> > > + * Policy read-lock must be held for policy data lookup.
> > >    *
> > >    */
> > >   int mls_context_to_sid(struct policydb *pol,
> > > -                    char oldc,
> > >                      char *scontext,
> > > -                    struct context *context,
> > > -                    struct sidtab *s,
> > > -                    u32 def_sid)
> > > +                    struct context *context)
> > >   {
> > >       char *sensitivity, *cur_cat, *next_cat, *rngptr;
> > >       struct level_datum *levdatum;
> > > @@ -244,29 +233,6 @@ int mls_context_to_sid(struct policydb *pol,
> > >       int l, rc, i;
> > >       char *rangep[2];
> > >
> > > -     if (!pol->mls_enabled) {
> > > -             if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
> > > -                     return 0;
> > > -             return -EINVAL;
> > > -     }
> > > -
> > > -     /*
> > > -      * No MLS component to the security context, try and map to
> > > -      * default if provided.
> > > -      */
> > > -     if (!oldc) {
> > > -             struct context *defcon;
> > > -
> > > -             if (def_sid == SECSID_NULL)
> > > -                     return -EINVAL;
> > > -
> > > -             defcon = sidtab_search(s, def_sid);
> > > -             if (!defcon)
> > > -                     return -EINVAL;
> > > -
> > > -             return mls_context_cpy(context, defcon);
> > > -     }
> > > -
> > >       /*
> > >        * If we're dealing with a range, figure out where the two parts
> > >        * of the range begin.
> > > @@ -364,14 +330,11 @@ int mls_from_string(struct policydb *p, char *str, struct context *context,
> > >               return -EINVAL;
> > >
> > >       tmpstr = kstrdup(str, gfp_mask);
> > > -     if (!tmpstr) {
> > > -             rc = -ENOMEM;
> > > -     } else {
> > > -             rc = mls_context_to_sid(p, ':', tmpstr, context,
> > > -                                     NULL, SECSID_NULL);
> > > -             kfree(tmpstr);
> > > -     }
> > > +     if (!tmpstr)
> > > +             return -ENOMEM;
> > >
> > > +     rc = mls_context_to_sid(p, tmpstr, context);
> > > +     kfree(tmpstr);
> > >       return rc;
> > >   }
> > >
> > > diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> > > index 67093647576d..e2498f78e100 100644
> > > --- a/security/selinux/ss/mls.h
> > > +++ b/security/selinux/ss/mls.h
> > > @@ -33,11 +33,8 @@ int mls_range_isvalid(struct policydb *p, struct mls_range *r);
> > >   int mls_level_isvalid(struct policydb *p, struct mls_level *l);
> > >
> > >   int mls_context_to_sid(struct policydb *p,
> > > -                    char oldc,
> > >                      char *scontext,
> > > -                    struct context *context,
> > > -                    struct sidtab *s,
> > > -                    u32 def_sid);
> > > +                    struct context *context);
> > >
> > >   int mls_from_string(struct policydb *p, char *str, struct context *context,
> > >                   gfp_t gfp_mask);
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > > index 12e414394530..ccad4334f99d 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -1425,9 +1425,35 @@ static int string_to_context_struct(struct policydb *pol,
> > >
> > >       ctx->type = typdatum->value;
> > >
> > > -     rc = mls_context_to_sid(pol, oldc, p, ctx, sidtabp, def_sid);
> > > -     if (rc)
> > > -             goto out;
> > > +     if (!pol->mls_enabled) {
> > > +             rc = -EINVAL;
> > > +             if ((def_sid == SECSID_NULL || !oldc) && (*p) != '\0')
> > > +                     goto out;
> >
> > I don't think this is your bug, but unless I'm mistaken, p could be OOB
> > and be dereferenced here.  Seems to have been introduced by
> > 95ffe194204ae3cef88d0b59be209204bbe9b3be.  Likely not caught in testing
> > since both Linux distributions and Android enable MLS to use the
> > category sets for isolation.
>
> Yep, and we should fix that in v4.20-rcX independent of this patch.  I
> think if we simply remove the "(*scontext) == '\0'" from the check we
> should be okay; I believe the only time we would want to return 0 when
> not running a MLS policy would be when there is something in the MLS
> portion of the label.

I think I'll leave this part to you guys. I don't feel confident about
changing the logic in this part of the code. I can't even parse the
meaning of that scary if statement... Bug for bug compatibility was
the best I could do here :)

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
