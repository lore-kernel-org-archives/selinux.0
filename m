Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04416C3F2D1
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 12:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7457246A0
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 12:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="M2Hcj3Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgB1M5P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:57:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33650 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgB1M5P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 07:57:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id c62so1718532edf.0
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 04:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0uFIqPgRIKQBug/P5hk+/gyQbxplp011oa6IC+oTzLw=;
        b=M2Hcj3Kt8y8GLPqB3UkkGISTrZZXiiEnhMbEpszl2Hl/0qAjqbl8G8jI5dV+jP/QBH
         4hEZ8ZC0BQo78z5n5aqLHUamDb6k5oCDNIcWTxTOb1/9nczG5xLStQfKeQfBLcfme/F/
         OkTs8Es9eGLHTHcjt+qHEbd5ZIpvLRQ2v0YOVv8a+fkk9ZHzcWSjyKrh8jmxbTMOnAAp
         UVOFLsYWMbXZxex8ffYbzk/VwENHxyDRiiPT+Bs/dMOkmFzMf+vvWQPn5ZRjKM/Kpqb0
         kFN29pZFMn/dGvKbP4K1bimtpfJAmmAjwHKYTEsDRjUfdodwUEhsMYOAqJaKqQIxUZhN
         dw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0uFIqPgRIKQBug/P5hk+/gyQbxplp011oa6IC+oTzLw=;
        b=dXkgXnTSFaBfncXgK5Vg0GqQJB3+rPv7wnTJS7rjg2i+lIfbS79758QVMI1G3+5Za7
         2CQ2BGIjI0QvyZuy7yZ/baIVg4DAfDJB3KuyOf+CXrE6VDn3TUqY59/m5qBiy2WjOD/I
         YPojLnJq1PxtXdiaM9By2mHHYp/Au9jn7kKmCb3YIZQap1W6mc0eRPwZOisuuIQEDDdI
         l7d2Kz7J6FREoIIareC9PfTbupGsPt93GaxmRbShvUNDH703aYOdffBTN5oBhEYM07S/
         ebBmX0Je3pkMQT2rrl+hiznMh4OPv1hQj+yjlFCeqFJwKhiCQDRJeyhLbqVWBi3X5Nca
         pVhg==
X-Gm-Message-State: APjAAAXs7rSENNmtmTVqMtAzFws0q1HRELdS/AJl+MO36HNfI0Pfjmbz
        gTq1ZXkHhIcSPPQtHL4rUHcp9zish2lEoX/ANViH
X-Google-Smtp-Source: APXvYqzm5h/tu4rWgvmsOKU7hS7oqpKKZ68TpwvyQomQkW4sl7cMgtKygKxXpgjMumY5waeg7dBZ6jSGje1KoYDATyE=
X-Received: by 2002:a50:e108:: with SMTP id h8mr3795157edl.196.1582894631865;
 Fri, 28 Feb 2020 04:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20200226155452.301544-1-omosnace@redhat.com> <CAHC9VhRWx5r=7fzh1UmL4Pcn_tDMJYLWvakv8uSqr23jcZ5U_g@mail.gmail.com>
 <CAFqZXNv9kHWfPYWRJy9wXE+OehP8q8Zbokk9DB_pSMwrhNx4Gw@mail.gmail.com>
In-Reply-To: <CAFqZXNv9kHWfPYWRJy9wXE+OehP8q8Zbokk9DB_pSMwrhNx4Gw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Feb 2020 07:57:00 -0500
Message-ID: <CAHC9VhTABKaFvz4HtYQq85a2ToGaAcsR=MrbnhSXu-Qg4M6h9A@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: reduce the use of hard-coded hash sizes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 3:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Feb 28, 2020 at 1:27 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Feb 26, 2020 at 10:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Instead allocate hash tables with just the right size based on the
> > > actual number of elements (which is almost always known beforehand, we
> > > just need to defer the hashtab allocation to the right time). The only
> > > case when we don't know the size (with the current policy format) is the
> > > new filename transitions hashtable. Here I just left the existing value.
> > >
> > > After this patch, the time to load Fedora policy on x86_64 decreases
> > > from 790 ms to 167 ms. If the unconfined module is removed, it decreases
> > > from 750 ms to 122 ms. It is also likely that other operations are going
> > > to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> > > but I didn't try to quantify that.
> > >
> > > The memory usage of all hash table arrays increases from ~58 KB to
> > > ~163 KB (with Fedora policy on x86_64).
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > Changed in v3:
> > >  - switch to simpler and more logical hash size heuristic
> > >  - add comment explaining the choice of the heuristic
> > >
> > > Changed in v2:
> > >  - guard against h->size == 0 in hashtab_search() and hashtab_insert()
> > >
> > >  security/selinux/ss/hashtab.c  | 28 +++++++++++++++---
> > >  security/selinux/ss/hashtab.h  |  2 +-
> > >  security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
> > >  security/selinux/ss/policydb.h |  2 --
> > >  4 files changed, 45 insertions(+), 40 deletions(-)
> >
> > Thanks Ondrej, this looks better; merged into selinux/next.
> >
> > Also, changing the hash heuristic in v3 really shrunk the memory usage
> > compared to v2 without much impact on performance - a ~100k increase
> > in memory is a small price to pay for the policy load improvement.
> > Well done.
>
> Er... sorry, I forgot to document it clearly in the e-mails, but the
> usage didn't actually drop between the last two versions (it actually
> increased by ~36 KB). It's just that In the previous version I
> "measured" the memory usage just by looking at the total memory usage
> reported by top, which is however fluctuating a lot and I was
> apparently just measuring noise... For this patch I actually printk'd
> the sizes of the tables exactly (since that's the only thing this
> patch touches) and this showed these much smaller numbers. So please
> disregard the 1-2 MB from the previous patch versions - they were
> bogus.

Okay, that makes a lot more sense now.  I was a little shocked about
the difference in memory usage (it honestly didn't make sense), but
numbers don't typically lie so I figured I was just missing some small
point which was having a big impact :)

Regardless, a ~36KB bump in memory usage over the non-patched kernel
is still a small price to pay for the performance increase.

-- 
paul moore
www.paul-moore.com
