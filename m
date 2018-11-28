Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A1C43441
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 12:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1A2208E7
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 12:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1A2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeK1XJS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:09:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37599 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeK1XJS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Nov 2018 18:09:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id 40so23276074oth.4
        for <selinux@vger.kernel.org>; Wed, 28 Nov 2018 04:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTFcWl6AAyn9DMCYKmfo0+wTpSc+KjFiO7YIajvsJZc=;
        b=L6H4ZNWMqDT5s3KFk+JvQg/EoRWuvqc+pnjaVp4+gllorlJRYQYL5S2FMCl8sArwGk
         sLekvW6yGSJiJ5kG+aJwUf3bKrLQU7Hn+IVs5CGrHxK21VeR78ELeMFNxxiFORLbS/MW
         csm/YRgzEzuwcChgF78quiKZL5936iVnq4DIfSrkjauYinlen4x1TNE62MVdDkKfWd3j
         ifBJl8PPsouClJhzsl2AhWffYhtOP2vYfb1adM3HUyxqDNtkoVyTuHo7ddDmJf7FI9OW
         xxz+EqG7anhN4Uc1EzvUiBdSohwmcM0oCtSYkcuFRgPDCEDAN5NCf1Fv6jIGpsnqPeEJ
         5rUA==
X-Gm-Message-State: AA+aEWYBtPnfuvkVudhp2us4Ut+KsgARNvh9NfdcQYj2e+DSap1gw2hu
        yZ7KG9HEiAe81cZKXJHs7QezcRYBVgTJx7ObASwxouBpdhM=
X-Google-Smtp-Source: AFSGD/Xq0+lBLwgt63QQP0xrPje2hUVfCH614RIqTUFoWlAVpVJf4QgVC7IcB33oMwA/6DEs00DzsgrymywVsn/BQGo=
X-Received: by 2002:a9d:32c7:: with SMTP id u65mr19753831otb.236.1543406871724;
 Wed, 28 Nov 2018 04:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20181127103605.32765-1-omosnace@redhat.com> <20181127103605.32765-3-omosnace@redhat.com>
 <1bd2a5dd-d8cb-1081-76ca-5f4f3de6111f@tycho.nsa.gov> <CAFqZXNt-9OOM1D+RdGL-cfchuZe8z7ixY1f6XSbYhUXvbGM8HQ@mail.gmail.com>
In-Reply-To: <CAFqZXNt-9OOM1D+RdGL-cfchuZe8z7ixY1f6XSbYhUXvbGM8HQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 28 Nov 2018 13:07:40 +0100
Message-ID: <CAFqZXNtXRr01=OLsdjG6iWY1ZPpLTLAWpv9A1gcGaKcT1GB0Dg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] [squash] do not store entry for SECSID_NULL
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 27, 2018 at 8:45 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Nov 27, 2018 at 5:58 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 11/27/18 5:36 AM, Ondrej Mosnacek wrote:
> > > This patch is kept separate only for review. Eventually it will be
> > > folded into the previous patch.
> >
> > This one triggers a lot of warnings (security_compute_av: unrecognized
> > SID 0, security_sid_to_context_core: unrecognized SID 0) and some
> > failures during selinux-testsuite inet_socket tests.  While the policy
> > doesn't provide an entry for SECSID_NULL, the sidtab search logic was
> > remapping it to the unlabeled context and that was apparently being
> > relied upon by the labeled networking code IIUC.
>
> You're right, I made a mistake in the sidtab_search_core() function -
> it shouldn't just return NULL when sid == 0, but instead skip to the
> default-to-unlabeled fallback. This will be easy to fix.
>
> Thanks for testing!
>
> I wonder why I didn't get any inet_socket failures when running the
> testsuite myself... I will have to look at it closer tomorrow.

Hmm... I must have been accidentally testing a wrong kernel build. I
am now able to reproduce both the failures and the hang.

I am now building a new kernel with this and the convert_context issues fixed.

>
> >
> >
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >   security/selinux/ss/policydb.c |  2 +-
> > >   security/selinux/ss/sidtab.c   | 25 ++++++++++++++++---------
> > >   security/selinux/ss/sidtab.h   |  3 ++-
> > >   3 files changed, 19 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > > index 59359fa0bd74..a50d625e7946 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -912,7 +912,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
> > >                       sidtab_destroy(s);
> > >                       goto out;
> > >               }
> > > -             if (c->sid[0] > SECINITSID_NUM) {
> > > +             if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
> > >                       pr_err("SELinux:  Initial SID %s out of range.\n",
> > >                               c->u.name);
> > >                       sidtab_destroy(s);
> > > diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> > > index fd8115b211a6..e157d8240cf1 100644
> > > --- a/security/selinux/ss/sidtab.c
> > > +++ b/security/selinux/ss/sidtab.c
> > > @@ -23,7 +23,7 @@ int sidtab_init(struct sidtab *s)
> > >       if (!s->htable)
> > >               return -ENOMEM;
> > >
> > > -     for (i = 0; i <= SECINITSID_NUM; i++)
> > > +     for (i = 0; i < SECINITSID_NUM; i++)
> > >               s->isids[i].set = 0;
> > >
> > >       for (i = 0; i < SIDTAB_SIZE; i++)
> > > @@ -86,8 +86,15 @@ static int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
> > >
> > >   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
> > >   {
> > > -     struct sidtab_isid_entry *entry = &s->isids[sid];
> > > -     int rc = context_cpy(&entry->context, context);
> > > +     struct sidtab_isid_entry *entry;
> > > +     int rc;
> > > +
> > > +     if (sid == 0 || sid > SECINITSID_NUM)
> > > +             return -EINVAL;
> > > +
> > > +     entry = &s->isids[sid - 1];
> > > +
> > > +     rc = context_cpy(&entry->context, context);
> > >       if (rc)
> > >               return rc;
> > >
> > > @@ -116,19 +123,19 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
> > >       struct context *context;
> > >       struct sidtab_isid_entry *entry;
> > >
> > > -     if (!s)
> > > +     if (!s || sid == 0)
> > >               return NULL;
> > >
> > >       if (sid > SECINITSID_NUM) {
> > >               context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
> > >       } else {
> > > -             entry = &s->isids[sid];
> > > +             entry = &s->isids[sid - 1];
> > >               context = entry->set ? &entry->context : NULL;
> > >       }
> > >       if (context && (!context->len || force))
> > >               return context;
> > >
> > > -     entry = &s->isids[SECINITSID_UNLABELED];
> > > +     entry = &s->isids[SECINITSID_UNLABELED - 1];
> > >       return entry->set ? &entry->context : NULL;
> > >   }
> > >
> > > @@ -283,11 +290,11 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
> > >       int rc;
> > >       u32 i;
> > >
> > > -     for (i = 0; i <= SECINITSID_NUM; i++) {
> > > +     for (i = 0; i < SECINITSID_NUM; i++) {
> > >               struct sidtab_isid_entry *entry = &s->isids[i];
> > >
> > >               if (entry->set && context_cmp(context, &entry->context)) {
> > > -                     *sid = i;
> > > +                     *sid = i + 1;
> > >                       return 0;
> > >               }
> > >       }
> > > @@ -334,7 +341,7 @@ void sidtab_destroy(struct sidtab *s)
> > >       if (!s)
> > >               return;
> > >
> > > -     for (i = 0; i <= SECINITSID_NUM; i++)
> > > +     for (i = 0; i < SECINITSID_NUM; i++)
> > >               if (s->isids[i].set)
> > >                       context_destroy(&s->isids[i].context);
> > >
> > > diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> > > index dc0a80bc8894..e657ae6bf996 100644
> > > --- a/security/selinux/ss/sidtab.h
> > > +++ b/security/selinux/ss/sidtab.h
> > > @@ -36,7 +36,8 @@ struct sidtab {
> > >       struct sidtab_node *cache[SIDTAB_CACHE_LEN];
> > >       spinlock_t lock;
> > >
> > > -     struct sidtab_isid_entry isids[SECINITSID_NUM + 1];
> > > +     /* index == SID - 1 (no entry for SECSID_NULL) */
> > > +     struct sidtab_isid_entry isids[SECINITSID_NUM];
> > >   };
> > >
> > >   int sidtab_init(struct sidtab *s);
> > >
> >
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
