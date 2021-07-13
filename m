Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A352EC07E95
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A27D6101D
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhGMUDK convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:03:10 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:53726 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhGMUDK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 16:03:10 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E5027564797
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 22:00:18 +0200 (CEST)
Received: by mail-io1-f52.google.com with SMTP id v26so708247iom.11
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 13:00:18 -0700 (PDT)
X-Gm-Message-State: AOAM533QdCT6EfrYiyB7HmdZVks9mdIpNwzY9Wkfqib2Uye73lxu7XZK
        3JBPyXZudSxYoBrAUvSz3uTqAVwHE3uz7m7jlgw=
X-Google-Smtp-Source: ABdhPJzG2UkK18zPUGiSTKUKaHoVRPMe6QYMPlTvu3z1huCJcPXE9fy9hptQtUS15bDKLWDVf5CfHbbaX6z49u7zhjQ=
X-Received: by 2002:a02:9109:: with SMTP id a9mr5564472jag.93.1626206418092;
 Tue, 13 Jul 2021 13:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210701183430.145934-1-cgzones@googlemail.com>
 <20210706173629.22032-1-cgzones@googlemail.com> <CAJfZ7=nOpwQD8vZOZvwsc-W7Vo1GHVCKop0tat=OanK=+rqmDg@mail.gmail.com>
In-Reply-To: <CAJfZ7=nOpwQD8vZOZvwsc-W7Vo1GHVCKop0tat=OanK=+rqmDg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 13 Jul 2021 22:00:07 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==SkHF39KL+WUSq003dDYx3wzMmM4u4ZZcRDGmPotagdQ@mail.gmail.com>
Message-ID: <CAJfZ7==SkHF39KL+WUSq003dDYx3wzMmM4u4ZZcRDGmPotagdQ@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: avoid unsigned integer overflow
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 13 22:00:19 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 9:33 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Jul 6, 2021 at 7:36 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > Unsigned integer overflow is well-defined and not undefined behavior.
> > It is commonly used for hashing or pseudo random number generation.
> > But it is still useful to enable undefined behavior sanitizer checks on
> > unsigned arithmetic to detect possible issues on counters or variables
> > with similar purpose or missed overflow checks on user input.
> >
> > Use a spaceship operator like comparison instead of subtraction.
> >
> >     policydb.c:851:24: runtime error: unsigned integer overflow: 801 - 929 cannot be represented in type 'unsigned int'
> >
> > Follow-up of: 1537ea8412e4 ("libsepol: avoid unsigned integer overflow")
> >
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks!
> Nicolas

Merged.
Thanks!
Nicolas

> > ---
> >  libsepol/src/policydb.c | 10 +++++-----
> >  libsepol/src/private.h  |  2 ++
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index ef2217c2..0398ceed 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -817,11 +817,11 @@ static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
> >         const filename_trans_key_t *ft2 = (const filename_trans_key_t *)k2;
> >         int v;
> >
> > -       v = (ft1->ttype > ft2->ttype) - (ft1->ttype < ft2->ttype);
> > +       v = spaceship_cmp(ft1->ttype, ft2->ttype);
> >         if (v)
> >                 return v;
> >
> > -       v = (ft1->tclass > ft2->tclass) - (ft1->tclass < ft2->tclass);
> > +       v = spaceship_cmp(ft1->tclass, ft2->tclass);
> >         if (v)
> >                 return v;
> >
> > @@ -843,15 +843,15 @@ static int rangetr_cmp(hashtab_t h __attribute__ ((unused)),
> >         const struct range_trans *key2 = (const struct range_trans *)k2;
> >         int v;
> >
> > -       v = key1->source_type - key2->source_type;
> > +       v = spaceship_cmp(key1->source_type, key2->source_type);
> >         if (v)
> >                 return v;
> >
> > -       v = key1->target_type - key2->target_type;
> > +       v = spaceship_cmp(key1->target_type, key2->target_type);
> >         if (v)
> >                 return v;
> >
> > -       v = key1->target_class - key2->target_class;
> > +       v = spaceship_cmp(key1->target_class, key2->target_class);
> >
> >         return v;
> >  }
> > diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> > index 72f21262..c63238ab 100644
> > --- a/libsepol/src/private.h
> > +++ b/libsepol/src/private.h
> > @@ -47,6 +47,8 @@
> >  #define is_saturated(x) (x == (typeof(x))-1)
> >  #define zero_or_saturated(x) ((x == 0) || is_saturated(x))
> >
> > +#define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
> > +
> >  /* Policy compatibility information. */
> >  struct policydb_compat_info {
> >         unsigned int type;
> > --
> > 2.32.0
> >

