Return-Path: <SRS0=hg1M=T6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A320EC28CC3
	for <selinux@archiver.kernel.org>; Thu, 30 May 2019 15:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0D425C9F
	for <selinux@archiver.kernel.org>; Thu, 30 May 2019 15:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+i9hild"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfE3PQv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 May 2019 11:16:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37180 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3PQu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 May 2019 11:16:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id i4so4838758oih.4;
        Thu, 30 May 2019 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=doj4IenzvkfWML5SzqtumJTZIFAZxiRbmcpcN5zKAZ4=;
        b=p+i9hildaNu7ZwZqAZm4SxIdnxeld89mgtaKkYql/hwiBmxkwvCkJvkyfwaSd1STOY
         cYz3gUYDPJW9WckbtAChfhlS4R+VlqJLETLZnWu6vqn9LSmqnLSUAqXh7HcfdlB3UB/d
         /38MB49Vo7PfBnn1wNpyCCgLotzlxKoE97/X3rJ5+tqyT0dCIjdN2Aeeb9EbDiXSNe50
         uAC7Yo0mPz+WzxD3JmuwoJfuzT0707fuX2YBz3ushN+Vixav47djmprqcVjt6+Kmtsyn
         Wo82gOToZPmrlnLWBb/uP9GfwASMMSYZeRF70jr/B/mpbTqrokZd3fNNDm7R9Yn6gyTN
         xcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=doj4IenzvkfWML5SzqtumJTZIFAZxiRbmcpcN5zKAZ4=;
        b=i3YuAGo4TtRTa17cu7bDfZXXGKFXQAy6UdMgwGedSEgWMtEwrGl2upjGRgyV1EknBI
         diW/y2QTyf+jSHBdMquSzP8KZ4U1GHtfI6eKSQANaOAQMdaDF7cTZSu/Z8Dtir0JUXTv
         KHOZX9CK2g85j8HcAZSGDdEr75pwslOoeEpuKDf10YPDb2RIIi0frkQBtkVAAcHi8NxU
         ehiiz4yVe0qnBXB3Q5TcZG+5/Qb/HFo+2QWui7d2u99+3TKsPMNd+73EsBlNnoOzRrXg
         hdnSaT0n7imwgpXfd+Wkl3E1I/XAO+Zm9e9VKBz1QgXvl+aYuTCTPZDuqJOxGYZF5Fq5
         onOw==
X-Gm-Message-State: APjAAAXohrH6FTlmpxaidbzrwMT1OxOIRMBO3+6zudvpOcDEusa+U9NE
        LIVqMBTPzo00lCLwoqW1Il6OUO9Kv7981joE/CI=
X-Google-Smtp-Source: APXvYqxSZ3vGjHStGNJLCCQWu5Essf+jnKrYzgB4w8LB70DS2VmD7rdSIaH64go20Figke7PzWM99sEjxpsyWi+Qp8I=
X-Received: by 2002:aca:eb4a:: with SMTP id j71mr1562553oih.69.1559229409571;
 Thu, 30 May 2019 08:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190530035310.GA9127@zhanggen-UX430UQ> <CAFqZXNv-54DJhd8gyUhwDo6RvmjFGSHo=+s-BVsL87S+u0cQxQ@mail.gmail.com>
 <20190530085106.GA2711@zhanggen-UX430UQ> <CAFqZXNuVVTL4FmBRvsZri+tvv4T4U47tMLjTZvSr7Cro=hR5Dg@mail.gmail.com>
In-Reply-To: <CAFqZXNuVVTL4FmBRvsZri+tvv4T4U47tMLjTZvSr7Cro=hR5Dg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 30 May 2019 08:16:36 -0700
Message-ID: <CAFftDdoCmXCZwfr52wry+3eCZHiBAfHg_PQyLC-s-r3tEZw09g@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Gen Zhang <blackgod016574@gmail.com>,
        Paul Moore <paul@paul-moore.com>, tony.luck@intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 30, 2019 at 4:52 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, May 30, 2019 at 10:51 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> > In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> > returns NULL when fails. So 'arg' should be checked.
> >
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
> > ---
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3ec702c..5a9e959 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2635,6 +2635,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
> >                                                 *q++ = c;
> >                                 }
> >                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> > +                               if (!arg)
> > +                                       return -ENOMEM;

Yeah -ENOMEM is correct here. Ack by me.

> >                         }
> >                         rc = selinux_add_opt(token, arg, mnt_opts);
> >                         if (unlikely(rc)) {
>
> Looking at the callers of security_sb_eat_lsm_opts() (which is the
> function that eventually calls the selinux_sb_eat_lsm_opts() hook),
> -ENOMEM should be appropriate here.
>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
