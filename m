Return-Path: <SRS0=eYI8=NZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF47C43441
	for <selinux@archiver.kernel.org>; Wed, 14 Nov 2018 03:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED9E20871
	for <selinux@archiver.kernel.org>; Wed, 14 Nov 2018 03:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WCHoX8Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED9E20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeKNNPl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Nov 2018 08:15:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43020 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKNNPk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Nov 2018 08:15:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id g26-v6so12764412lja.10
        for <selinux@vger.kernel.org>; Tue, 13 Nov 2018 19:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQ13quZJ/eDqiDEhGmgLmqPi0RY18SMJobVubxoZq4Y=;
        b=WCHoX8VbgogD+Dn+vs32fwjQQCQFtl9YCzv+UBJhfSOsOzfdPJhlXMERDHT9Kb7yuK
         y2Y1idi/rWrbEIf7llibu7r+nY4DFGDY7iE6dZ9QEhZS42R15kZaDocCKQIhrUWUahUX
         BGAfxHSIzku8e476psCWx1LWP2E+M6Kif+wxoWm7FdRUe5SMFXPzMYRe+x2Q96r6W+qi
         WlgBN6DIsmtgaDLO7akXqqAMPxaLSXXhEc2LIyAHrS1gBaYOrGhi4y+NXKv6MtEt0G0f
         frGHQK6EJho3MrZudFCXkii9BwNvswuyOrBQUN7vJDdHsskZK8RpFaInUGaxDwkkxZzU
         1nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQ13quZJ/eDqiDEhGmgLmqPi0RY18SMJobVubxoZq4Y=;
        b=DqDMVsAN9tvGDLg/Rmj2F8D4TtmIzPktDvyZgh4/tjJ7zQICxekWShh7AgfiM6R2lI
         J84SE0adn33VZk3Y64gIMdtek9eWee1cXgMhJkOd6UKQ8HXIfF6FNvmZ+wy7xPmUss7h
         b7hHlGIcQq/johVNwyzE5FzreLRtdVjE8hSQhPkz5bpOcnP8ZIxP9jpU0/lTgbaFHE2C
         1XhF8gUQuDtIDB8ufdmSQioSDCh1lYKAdiXKHT/vuskIGmatpwN5aGR8rUSYd1gT527G
         Uc1Nb2YmNT1N5vaeZlOmPxKevbvSMMqKMfGDAsch/bAauVXkDsSB+Nwn/ppUs7iEf4RO
         +GVw==
X-Gm-Message-State: AGRZ1gIWakIRh5whrr5S4xTR/QIl0ztarOsvR9vYhAYPxtlI6ToV/tNB
        T/s5TVFEFrgF4shRHF1OCanoncJ204VDWjRQ9wlp
X-Google-Smtp-Source: AJdET5ffuTi+3KPT1KpZ/roTEMJOkjQsjwwkxVSrbODainLGfj68BTkTa+Eljg+H8bYGFU8CPMZMErA3V7QkPqxkU58=
X-Received: by 2002:a2e:4b11:: with SMTP id y17-v6mr88471lja.42.1542165262319;
 Tue, 13 Nov 2018 19:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20181112114426.20887-1-omosnace@redhat.com> <6eab4acd-a802-efba-db19-9593419025e2@tycho.nsa.gov>
In-Reply-To: <6eab4acd-a802-efba-db19-9593419025e2@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 13 Nov 2018 22:14:10 -0500
Message-ID: <CAHC9VhSV0ZDYBffe+nCH7N8GZ-4ZkH6Wpt+R62Ca7kO4hYrdsQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: simplify mls_context_to_sid()
To:     Stephen Smalley <sds@tycho.nsa.gov>, omosnace@redhat.com
Cc:     selinux@vger.kernel.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 13, 2018 at 4:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/12/18 6:44 AM, Ondrej Mosnacek wrote:
> > This function has only two callers, but only one of them actually needs
> > the special logic at the beginning. Factoring this logic out into
> > string_to_context_struct() allows us to drop the arguments 'oldc', 's',
> > and 'def_sid'.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > Changes in v3:
> >   - correct the comment about policy read lock
> >
> > Changes in v2:
> >   - also drop unneeded #include's from mls.c
> >
> >   security/selinux/ss/mls.c      | 49 +++++-----------------------------
> >   security/selinux/ss/mls.h      |  5 +---
> >   security/selinux/ss/services.c | 32 +++++++++++++++++++---
> >   3 files changed, 36 insertions(+), 50 deletions(-)
> >
> > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > index 2fe459df3c85..d1da928a7e77 100644
> > --- a/security/selinux/ss/mls.c
> > +++ b/security/selinux/ss/mls.c
> > @@ -24,10 +24,7 @@
> >   #include <linux/string.h>
> >   #include <linux/errno.h>
> >   #include <net/netlabel.h>
> > -#include "sidtab.h"
> >   #include "mls.h"
> > -#include "policydb.h"
> > -#include "services.h"
> >
> >   /*
> >    * Return the length in bytes for the MLS fields of the
> > @@ -223,20 +220,12 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
> >    * This function modifies the string in place, inserting
> >    * NULL characters to terminate the MLS fields.
> >    *
> > - * If a def_sid is provided and no MLS field is present,
> > - * copy the MLS field of the associated default context.
> > - * Used for upgraded to MLS systems where objects may lack
> > - * MLS fields.
> > - *
> > - * Policy read-lock must be held for sidtab lookup.
> > + * Policy read-lock must be held for policy data lookup.
> >    *
> >    */
> >   int mls_context_to_sid(struct policydb *pol,
> > -                    char oldc,
> >                      char *scontext,
> > -                    struct context *context,
> > -                    struct sidtab *s,
> > -                    u32 def_sid)
> > +                    struct context *context)
> >   {
> >       char *sensitivity, *cur_cat, *next_cat, *rngptr;
> >       struct level_datum *levdatum;
> > @@ -244,29 +233,6 @@ int mls_context_to_sid(struct policydb *pol,
> >       int l, rc, i;
> >       char *rangep[2];
> >
> > -     if (!pol->mls_enabled) {
> > -             if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
> > -                     return 0;
> > -             return -EINVAL;
> > -     }
> > -
> > -     /*
> > -      * No MLS component to the security context, try and map to
> > -      * default if provided.
> > -      */
> > -     if (!oldc) {
> > -             struct context *defcon;
> > -
> > -             if (def_sid == SECSID_NULL)
> > -                     return -EINVAL;
> > -
> > -             defcon = sidtab_search(s, def_sid);
> > -             if (!defcon)
> > -                     return -EINVAL;
> > -
> > -             return mls_context_cpy(context, defcon);
> > -     }
> > -
> >       /*
> >        * If we're dealing with a range, figure out where the two parts
> >        * of the range begin.
> > @@ -364,14 +330,11 @@ int mls_from_string(struct policydb *p, char *str, struct context *context,
> >               return -EINVAL;
> >
> >       tmpstr = kstrdup(str, gfp_mask);
> > -     if (!tmpstr) {
> > -             rc = -ENOMEM;
> > -     } else {
> > -             rc = mls_context_to_sid(p, ':', tmpstr, context,
> > -                                     NULL, SECSID_NULL);
> > -             kfree(tmpstr);
> > -     }
> > +     if (!tmpstr)
> > +             return -ENOMEM;
> >
> > +     rc = mls_context_to_sid(p, tmpstr, context);
> > +     kfree(tmpstr);
> >       return rc;
> >   }
> >
> > diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> > index 67093647576d..e2498f78e100 100644
> > --- a/security/selinux/ss/mls.h
> > +++ b/security/selinux/ss/mls.h
> > @@ -33,11 +33,8 @@ int mls_range_isvalid(struct policydb *p, struct mls_range *r);
> >   int mls_level_isvalid(struct policydb *p, struct mls_level *l);
> >
> >   int mls_context_to_sid(struct policydb *p,
> > -                    char oldc,
> >                      char *scontext,
> > -                    struct context *context,
> > -                    struct sidtab *s,
> > -                    u32 def_sid);
> > +                    struct context *context);
> >
> >   int mls_from_string(struct policydb *p, char *str, struct context *context,
> >                   gfp_t gfp_mask);
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 12e414394530..ccad4334f99d 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1425,9 +1425,35 @@ static int string_to_context_struct(struct policydb *pol,
> >
> >       ctx->type = typdatum->value;
> >
> > -     rc = mls_context_to_sid(pol, oldc, p, ctx, sidtabp, def_sid);
> > -     if (rc)
> > -             goto out;
> > +     if (!pol->mls_enabled) {
> > +             rc = -EINVAL;
> > +             if ((def_sid == SECSID_NULL || !oldc) && (*p) != '\0')
> > +                     goto out;
>
> I don't think this is your bug, but unless I'm mistaken, p could be OOB
> and be dereferenced here.  Seems to have been introduced by
> 95ffe194204ae3cef88d0b59be209204bbe9b3be.  Likely not caught in testing
> since both Linux distributions and Android enable MLS to use the
> category sets for isolation.

Yep, and we should fix that in v4.20-rcX independent of this patch.  I
think if we simply remove the "(*scontext) == '\0'" from the check we
should be okay; I believe the only time we would want to return 0 when
not running a MLS policy would be when there is something in the MLS
portion of the label.

--
paul moore
www.paul-moore.com
