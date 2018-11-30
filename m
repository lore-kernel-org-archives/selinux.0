Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A62CC04EB8
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E7320867
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E7320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLACXC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:23:02 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45073 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLACXC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 21:23:02 -0500
Received: by mail-oi1-f193.google.com with SMTP id b141so4955041oii.12
        for <selinux@vger.kernel.org>; Fri, 30 Nov 2018 07:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fexxgSKkdfCNE6T17IF/eH950T7HpB8c/BVcDrSM+yc=;
        b=NBwM887sXmPtJml3l6AUtMqYGNVAG/Y8bv+PBHRr2gZaaP0lS7dCbcF/moBIIu0c8C
         3p4JXfAPRSi/m9b2HBarrnX8GGfk7Px5YW7iiVpP8j+Vz8hI2q9/VVVC+GbOmedAGmoU
         C0hV9+UTAVbCz9cw2kiqEhrjzCBDdlPjqhbQqSCdq/NPPS+6pnb1VmRm0z5pcQleVNco
         e+XEDt48ExWxcw7dBn4EttLBTu1yf4rEuWK7ACkb2St7MFOF+0Rsk3wgeRDevcFhvVyY
         tjM/yevbotoD+tnx6nkkNRwAOwmB4Ks4GkZLr4E9OHwBaY6u0Er6hVUtUyw/zqsSED2v
         RaAA==
X-Gm-Message-State: AA+aEWaFqB7VCPFYEYGiL5NB1BTd3DKcZ5gL6iEoPAfORQfAMZS+8rCC
        2FtqrdyjscDPN/Z86BbLnWfHJdB7y21Nk04UrGJTETbHRLY=
X-Google-Smtp-Source: AFSGD/UcUPa93+OkATXJ05qHI9WG/wPhWPGchVAqjW1NzXIylwysCRKyIwoxP//gw82a4U7xE+PuSB3q3R9FZ0k/XoA=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr3372951oix.246.1543590803494;
 Fri, 30 Nov 2018 07:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20181129125402.5900-1-omosnace@redhat.com> <20181129125402.5900-4-omosnace@redhat.com>
 <CAHC9VhSbbi5+_eqbZ0Gvjx01q-yfS7nQWx-tMh8OCs0mvT3zWQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSbbi5+_eqbZ0Gvjx01q-yfS7nQWx-tMh8OCs0mvT3zWQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 30 Nov 2018 16:13:12 +0100
Message-ID: <CAFqZXNtZL1weyxDc4msaS6Yfh-mtotT8p9JTyhLpZaZz8-vrBg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/9] [fixup] fix handling of SECSID_NULL
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 29, 2018 at 11:14 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Nov 29, 2018 at 7:56 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > ---
> >  security/selinux/ss/sidtab.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
>
> A quick administrative comment: please don't send "[fixup]" patches
> except under the most extreme circumstances, especially in the case
> where you are respinning the patch{set}.  Using fixup patches makes it
> much harder for me to review, test, apply your patches which makes me
> grumpy.
>
> I don't like being grumpy.

Oh, sorry... I hoped it would actually make review easier to have each
new change clearly separated out. Now I will know that's not case and
will change my practices accordingly.

I will do a new squashed respin identical to this patchset (except for
one tiny change that came into my mind in the meantime).

>
> > diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> > index e157d8240cf1..31588d704b98 100644
> > --- a/security/selinux/ss/sidtab.c
> > +++ b/security/selinux/ss/sidtab.c
> > @@ -123,17 +123,19 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
> >         struct context *context;
> >         struct sidtab_isid_entry *entry;
> >
> > -       if (!s || sid == 0)
> > +       if (!s)
> >                 return NULL;
> >
> > -       if (sid > SECINITSID_NUM) {
> > -               context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
> > -       } else {
> > -               entry = &s->isids[sid - 1];
> > -               context = entry->set ? &entry->context : NULL;
> > +       if (sid != 0) {
> > +               if (sid > SECINITSID_NUM) {
> > +                       context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
> > +               } else {
> > +                       entry = &s->isids[sid - 1];
> > +                       context = entry->set ? &entry->context : NULL;
> > +               }
> > +               if (context && (!context->len || force))
> > +                       return context;
> >         }
> > -       if (context && (!context->len || force))
> > -               return context;
> >
> >         entry = &s->isids[SECINITSID_UNLABELED - 1];
> >         return entry->set ? &entry->context : NULL;
> > --
> > 2.19.2
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
