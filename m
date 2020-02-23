Return-Path: <SRS0=I/QZ=4L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FDAC35671
	for <selinux@archiver.kernel.org>; Sun, 23 Feb 2020 14:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F09206ED
	for <selinux@archiver.kernel.org>; Sun, 23 Feb 2020 14:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSCEeR/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgBWOqo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 23 Feb 2020 09:46:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24414 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgBWOqo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 23 Feb 2020 09:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582469202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oolRvNndqwWbv+YW8+bpBWlXJID8UZ3SAeiqY9BywZs=;
        b=BSCEeR/aqrv2pPx1PmyUqYf8TX8F7kXrLzsiLFp+5uBtDvUEsBd2zCLfFLiI2lrSIRNXsR
        ZDzn3HqC+lEE3deaH/QalJEigclvU6p+JveCrpjLirOHYVtttRDdw9CR9IgvOyHdmpK0M3
        QlH8cshmhq1yWZeSGi5GXFpeS0eGKgs=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-SWSS3p_APU6lRiGf2WN27Q-1; Sun, 23 Feb 2020 09:46:40 -0500
X-MC-Unique: SWSS3p_APU6lRiGf2WN27Q-1
Received: by mail-ot1-f69.google.com with SMTP id z62so4522677otb.0
        for <selinux@vger.kernel.org>; Sun, 23 Feb 2020 06:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oolRvNndqwWbv+YW8+bpBWlXJID8UZ3SAeiqY9BywZs=;
        b=BKWVB99hUZ7HxT3SIwVZu0tNwUU993kMcjwCMziXE2h1zbuQJ2xL8IE5fL5M+eMSls
         bN7pSjAJRQRU8ofTD5DUEjyKa996Df/lgxSwYACTpYKF7xUnZHcHX1cCsVsoMNmSkime
         4o5aDu43Fv86K66NNpl14M/eHj/F8Yss/0f+loZjSYuEFpRBTWVNVPG5W//fT8NgnCQh
         Z+PdvlzN8x8dwOpP8Uen4pw+xumc0fra84nehvpEU9JB8ZZKsDSivjg5+vi7Gnj+oaMr
         zLGkEpqWoAG5QJa0vSMa50+YMpX9QGvcsJOxwZmqH8BqfLX/DnfC25KMYRgdPu1s5VcT
         ZNbA==
X-Gm-Message-State: APjAAAWPentqDm9uyV1SvtkvketRcn6+Qn0kFajSS8z3HniNotVT1y+G
        YrW31i2WRgyUtTvCqqELtffG6K3KxO8xcAays2btEO2c21/xCSCXyUTy96J4z/Y9qmzQpPPRdaZ
        AtYSHzxXgObQDGWtbFZqaynzU8NpxElHHDw==
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr34413701oth.43.1582469198954;
        Sun, 23 Feb 2020 06:46:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxIHmzCx5oPc5J7SsbJZAu0wvlyyY299H5nLZ7oT1vQQnn8ESHz0MFP+mz2F0owSbvyb/ZFVb1qdsLeqxOml50=
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr34413689oth.43.1582469198596;
 Sun, 23 Feb 2020 06:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20200219093255.157758-1-omosnace@redhat.com> <CAHC9VhSCx=Xm_QeH70294RdDXq8JZoJ0aD9EQhw_fq601EcORw@mail.gmail.com>
In-Reply-To: <CAHC9VhSCx=Xm_QeH70294RdDXq8JZoJ0aD9EQhw_fq601EcORw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sun, 23 Feb 2020 15:46:27 +0100
Message-ID: <CAFqZXNuteeV+m7b69FUAbU-JNv8V0yWu-gXJQbXAYe-x5RC5Dg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: reduce the use of hard-coded hash sizes
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 22, 2020 at 8:38 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Feb 19, 2020 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Instead allocate hash tables with just the right size based on the
> > actual number of elements (which is almost always known beforehand, we
> > just need to defer the hashtab allocation to the right time). The only
> > case when we don't know the size (with the current policy format) is the
> > new filename transitions hashtable. Here I just left the existing value.
> >
> > After this patch, the time to load Fedora policy on x86_64 decreases
> > from 950 ms to 220 ms. If the unconfined module is removed, it decreases
> > from 870 ms to 170 ms. It is also likely that other operations are going
> > to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> > but I didn't try to quantify that.
> >
> > The memory usage increases a bit after this patch, but only by ~1-2 MB
> > (it is hard to measure precisely). I believe it is a small price to pay
> > for the increased performance.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > Changed in v2:
> >  - guard against h->size == 0 in hashtab_search() and hashtab_insert()
> >
> >  security/selinux/ss/hashtab.c  | 25 +++++++++++++---
> >  security/selinux/ss/hashtab.h  |  2 +-
> >  security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
> >  security/selinux/ss/policydb.h |  2 --
> >  4 files changed, 42 insertions(+), 40 deletions(-)
> >
> > diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> > index ebfdaa31ee32..87ad83148cbd 100644
> > --- a/security/selinux/ss/hashtab.c
> > +++ b/security/selinux/ss/hashtab.c
> > @@ -12,12 +12,26 @@
> >
> >  static struct kmem_cache *hashtab_node_cachep;
> >
> > +static u32 hashtab_compute_size(u32 nel)
> > +{
> > +       u32 size;
> > +
> > +       if (nel <= 2)
> > +               return nel;
> > +
> > +       /* use the nearest power of two to balance size and access time */
> > +       size = roundup_pow_of_two(nel);
> > +       if (size - nel > size / 4)
> > +               size /= 2;
>
> It would be nice if the commit description (and possibly the code
> itself via a shorter version in the comments) gave some insight into
> why you chose this particular adjustment to the hash table size.  Was
> this based on observations with real world policies?  Just a gut
> feeling?  Things like this are the sort of thing that one wonders
> about five years later when modifying the code and by then no one can
> remember if it is important or not.
>
> Also, considering the adjustment above, why not use
> rounddown_pow_of_two() instead (perhaps coupled with a minimum size
> check)?

Good point. I think I was tuning this formula back when I haven't
rebased this patch on top of the filename transition rework, so I
suspect that the filename_trans hash table was what was causing high
memory usage with plain roundup_pow_of_two()... With ~225k rules it
should be taking up ~2 MB in such case, which is quite a lot. (In
fact, even with the adjusted formula it would still allocate the same
table, so my crude method of measuring the memory usage apparently
wasn't reliable...) Now that this hash table is only at ~2500 elements
even with our imperfect policy, it should only take up ~32 KB when
rounding up, which is a pretty small overhead.

I'll re-test the patch with hashtab_compute_size() ~
roundup_pow_of_two(), this time logging the exact amount of bytes
taken up by the hash table arrays (which is the only thing that is
changing here). I expect it will show only a few 10s of KB difference,
in which case I'll respin the patch with this simpler (and likely a
bit faster) variant.

>
> > +       return size;
> > +}

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

