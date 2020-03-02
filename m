Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B64EC3F2D1
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 23:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FBC21D56
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 23:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="h4oL/2ON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgCBXQA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:16:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36600 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgCBXQA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 18:16:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id a13so1906962edh.3
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 15:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4KwS7e277agKXLiOz6H+ckHJyejPn9hJZYIjNCCctc=;
        b=h4oL/2ONOAJ5ZOu4tlUpxW4J/MampYn5cWkJMBCcWgYLJaYfPvBbk9l72R2QGulA/M
         4imbYdZdn2HE3X4neHNEEqymbzd7+bLKyuP2LNehHkOe6/4JukC+NRHdRosRPvJb5Lch
         q8eciNplqx1mOVsOiobNfjHryWqN+9l+sCU5T31j0UdVHSYrOHxkXMq6jp96mHB8IYmd
         zcpKCtYH5WlM+oCQwqTDs2+ukVTV1ElbjRawsodbUjv+XLI0nSJGYNrMY1nfDyCtzstw
         kQKeL/YJxu2iz5POwcFSJzFOlpJljEFkU/CwE9eJV7xL0XRxcThnzDXIyn9n9WLMvbxh
         0cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4KwS7e277agKXLiOz6H+ckHJyejPn9hJZYIjNCCctc=;
        b=OO2EH6LRjMTAgluvDoG5zb6YrFliNUqHZpgxAFtopo2dBBNF34kJT0TNJOys5Cf5NV
         2ofDW5VwOkQpSSrq3/bKA7Y9yuxRRDLQMUzANXw/gJGiGb27GDrmosu2z1tYNVckMRo8
         9+zzySqOK2kD5JyMCtE3JjPbm8CxZWD7IZQPVVshJvDOCsTAzXGgGHJG0lSAmGoeIKAE
         Lp5Wo09nH0Y2BCeK+guAKNgufwXbQymxkdegjdj5z+LP9Nm/C+hzVm4f9rWMsmFWakWe
         q6NRksrGlya6W5DAMk520k3uIsSo3iLQVhd8iBtCOylCETxQB0lh9ixNRlH4m0KCUEZF
         tkDA==
X-Gm-Message-State: ANhLgQ1kchlBKmKMghpZjHdhWKoUa+54BRlVH71TaVDkkH2SBAIegwEq
        TpZpIVzLw5aGERXdJ/Bfc0i0dV+nKLIC2cOb8Mla
X-Google-Smtp-Source: ADFU+vuFY01ArJorVDXn2IvlDVWmOmd/MLMpo1Qu942tb18WMNARUMrfknbo61AzAlkIR3TckpcUGED1strX1p1gRtU=
X-Received: by 2002:a17:907:9d8:: with SMTP id bx24mr1510001ejc.271.1583190958469;
 Mon, 02 Mar 2020 15:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20200226155452.301544-1-omosnace@redhat.com> <CAEjxPJ5M=iaVBQQGT8QqnHsndXKzxvRMSxSNbm3arNwXnmu4GQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5M=iaVBQQGT8QqnHsndXKzxvRMSxSNbm3arNwXnmu4GQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Mar 2020 18:15:47 -0500
Message-ID: <CAHC9VhQ0MHSRyHwnLjA_dpMMGY=kX22oFm0WNSO3B7zn2BTHeQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: reduce the use of hard-coded hash sizes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 2:11 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Feb 26, 2020 at 10:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Instead allocate hash tables with just the right size based on the
> > actual number of elements (which is almost always known beforehand, we
> > just need to defer the hashtab allocation to the right time). The only
> > case when we don't know the size (with the current policy format) is the
> > new filename transitions hashtable. Here I just left the existing value.
> >
> > After this patch, the time to load Fedora policy on x86_64 decreases
> > from 790 ms to 167 ms. If the unconfined module is removed, it decreases
> > from 750 ms to 122 ms. It is also likely that other operations are going
> > to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> > but I didn't try to quantify that.
> >
> > The memory usage of all hash table arrays increases from ~58 KB to
> > ~163 KB (with Fedora policy on x86_64).
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
>
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 32b3a8acf96f..7ca8c74efba3 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -503,20 +482,12 @@ static int policydb_init(struct policydb *p)
> >                 goto out;
> >         }
> >
> > -       p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
> > -       if (!p->range_tr) {
> > -               rc = -ENOMEM;
> > -               goto out;
> > -       }
> > -
> >         ebitmap_init(&p->filename_trans_ttypes);
> >         ebitmap_init(&p->policycaps);
> >         ebitmap_init(&p->permissive_map);
> >
> >         return 0;
> >  out:
> > -       hashtab_destroy(p->filename_trans);
> > -       hashtab_destroy(p->range_tr);
> >         for (i = 0; i < SYM_NUM; i++) {
> >                 hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
> >                 hashtab_destroy(p->symtab[i].table);
>
> Sorry, just pointed out to me that this left the symtab destruction
> code in the out path of policydb_init()
> even though we are no longer creating them there.  Harmless but should
> be dropped.

Ondrej, can you submit a cleanup patch for this?

-- 
paul moore
www.paul-moore.com
