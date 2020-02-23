Return-Path: <SRS0=I/QZ=4L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BD5C35666
	for <selinux@archiver.kernel.org>; Sun, 23 Feb 2020 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1AE20637
	for <selinux@archiver.kernel.org>; Sun, 23 Feb 2020 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KkVhh55L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgBWPCH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 23 Feb 2020 10:02:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37083 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWPCH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 23 Feb 2020 10:02:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id t7so8780491edr.4
        for <selinux@vger.kernel.org>; Sun, 23 Feb 2020 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XG7dYMRo79cxroHtM+1eP6kMW6z01gxAEcz+Bh2SX2s=;
        b=KkVhh55LMbKYMERYixg5I0hZFwvSGzZDcjacqmgkl/bDl133NCcpOQi3zAgyMiwtA3
         D0+tB45PaPbL1Kv2fEATGscElXKRGLHu7iaFyO4wldg6zpAt+cCcy8LzkNN4SNga9m9h
         GcYv6/xIrRgxnvVMgbC9yqyjJ/hkHPAcqJzEWRVCyXI2pFOVIEML8xfxGLGJabV+6BR8
         G5S5ZI0RAohb56M048GbwgyJfcqRrdetC+xgYJ/Mc43vhuXzqmUiHfCO1pk6CZR+zk4T
         z5N84TFwS69xZe4zUPT/s+96zj/VLNvNVxwlXPwfAtFOhJ5bg6fk2bUwGy9bUuPnIPuB
         tdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XG7dYMRo79cxroHtM+1eP6kMW6z01gxAEcz+Bh2SX2s=;
        b=UyDXJW9I5+KPxXcy1kfOx04dA7FB19heUZ+O0Oy1K6nj7xDutW0f3RCfSOlFxZ2vkF
         rxS8z30UKwluy8cb+8hHxTK7crkZb8T2DRriQfXVniMaq9etfuI6cYc0BcMfvtCcenvZ
         U5zqLDkQWyHvlU2Y2a7p/P/tmhAS+gNeMr9X79S/1D968VFSpYWKE3a5EWGh2WW1ykhQ
         rni0t3NjiNmcW3tup3PdCaTpQW9fetOGIX9R+u0qhFK4Y57CCYkiDtgWya8ztJr+CSof
         pqQTlP+8zC7i3hGuYOOX0hl2aqgsQ/1ra+ltd9jiJcxE6HrSX6fWWVxoNFmohPtzDATk
         LBtg==
X-Gm-Message-State: APjAAAXSOBydiCrjNz7NX8WHAqVyOTKp2qZlmyADJVcKTABS1C7+oFoH
        OHAMvbdZRMi3QXBTw06ssPZBH7nxAzPf9ba8gayUECYfew==
X-Google-Smtp-Source: APXvYqx7+pGOIBJR4KrtBt5q/fxqj3VoMv559Vqu/yalKgoAiNC2rhPSZrGftFqHprn5jTzuPolV1SEcHK+tdAnykDE=
X-Received: by 2002:a05:6402:309b:: with SMTP id de27mr26213472edb.269.1582470124858;
 Sun, 23 Feb 2020 07:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20200219093255.157758-1-omosnace@redhat.com> <CAHC9VhSCx=Xm_QeH70294RdDXq8JZoJ0aD9EQhw_fq601EcORw@mail.gmail.com>
 <CAFqZXNuteeV+m7b69FUAbU-JNv8V0yWu-gXJQbXAYe-x5RC5Dg@mail.gmail.com>
In-Reply-To: <CAFqZXNuteeV+m7b69FUAbU-JNv8V0yWu-gXJQbXAYe-x5RC5Dg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 23 Feb 2020 10:01:53 -0500
Message-ID: <CAHC9VhSkAp-H7tnfZyfL1gKkjV+f+5FusRndN8w=q3iUjROfjw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: reduce the use of hard-coded hash sizes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 23, 2020 at 9:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sat, Feb 22, 2020 at 8:38 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Feb 19, 2020 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Instead allocate hash tables with just the right size based on the
> > > actual number of elements (which is almost always known beforehand, we
> > > just need to defer the hashtab allocation to the right time). The only
> > > case when we don't know the size (with the current policy format) is the
> > > new filename transitions hashtable. Here I just left the existing value.
> > >
> > > After this patch, the time to load Fedora policy on x86_64 decreases
> > > from 950 ms to 220 ms. If the unconfined module is removed, it decreases
> > > from 870 ms to 170 ms. It is also likely that other operations are going
> > > to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> > > but I didn't try to quantify that.
> > >
> > > The memory usage increases a bit after this patch, but only by ~1-2 MB
> > > (it is hard to measure precisely). I believe it is a small price to pay
> > > for the increased performance.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > Changed in v2:
> > >  - guard against h->size == 0 in hashtab_search() and hashtab_insert()
> > >
> > >  security/selinux/ss/hashtab.c  | 25 +++++++++++++---
> > >  security/selinux/ss/hashtab.h  |  2 +-
> > >  security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
> > >  security/selinux/ss/policydb.h |  2 --
> > >  4 files changed, 42 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> > > index ebfdaa31ee32..87ad83148cbd 100644
> > > --- a/security/selinux/ss/hashtab.c
> > > +++ b/security/selinux/ss/hashtab.c
> > > @@ -12,12 +12,26 @@
> > >
> > >  static struct kmem_cache *hashtab_node_cachep;
> > >
> > > +static u32 hashtab_compute_size(u32 nel)
> > > +{
> > > +       u32 size;
> > > +
> > > +       if (nel <= 2)
> > > +               return nel;
> > > +
> > > +       /* use the nearest power of two to balance size and access time */
> > > +       size = roundup_pow_of_two(nel);
> > > +       if (size - nel > size / 4)
> > > +               size /= 2;
> >
> > It would be nice if the commit description (and possibly the code
> > itself via a shorter version in the comments) gave some insight into
> > why you chose this particular adjustment to the hash table size.  Was
> > this based on observations with real world policies?  Just a gut
> > feeling?  Things like this are the sort of thing that one wonders
> > about five years later when modifying the code and by then no one can
> > remember if it is important or not.
> >
> > Also, considering the adjustment above, why not use
> > rounddown_pow_of_two() instead (perhaps coupled with a minimum size
> > check)?
>
> Good point. I think I was tuning this formula back when I haven't
> rebased this patch on top of the filename transition rework, so I
> suspect that the filename_trans hash table was what was causing high
> memory usage with plain roundup_pow_of_two()... With ~225k rules it
> should be taking up ~2 MB in such case, which is quite a lot. (In
> fact, even with the adjusted formula it would still allocate the same
> table, so my crude method of measuring the memory usage apparently
> wasn't reliable...) Now that this hash table is only at ~2500 elements
> even with our imperfect policy, it should only take up ~32 KB when
> rounding up, which is a pretty small overhead.
>
> I'll re-test the patch with hashtab_compute_size() ~
> roundup_pow_of_two(), this time logging the exact amount of bytes
> taken up by the hash table arrays (which is the only thing that is
> changing here). I expect it will show only a few 10s of KB difference,
> in which case I'll respin the patch with this simpler (and likely a
> bit faster) variant.

Thanks.  I also want to stress that capturing the logic behind the
decision in the patch description / comments is almost as important
(maybe more so) than what we end up deciding on for the actual size
algorithm.  I can almost guarantee the decision made now is going to
be brought up for discussion at some point in the future, so let's
help the poor future devs as much as we can ;)

-- 
paul moore
www.paul-moore.com
