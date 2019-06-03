Return-Path: <SRS0=Kl1g=UC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D93C04AB5
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 21:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891AD26D2C
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 21:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iHxItZmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFCV7Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:59:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34562 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCV7P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jun 2019 17:59:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id y198so4311995lfa.1
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2019 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39SsS75pnQ5vHdEqbne0WJ2yXM1xbTpEuZ3/IBKSvQw=;
        b=iHxItZmO7EMI3oQoeYJNo81cTXL+a2p2lGyUDGhwEFPlL7xmIzWMz2BXM9RXXpR8HJ
         bArXNfvV6zQe9IVr2+s/xKS8FaFXc/zYRj4s8VwQUrsFbtonyI6viek4fO8KY8ypzEhP
         8yPBFAHB2MiATF/1ZdJoqWHdv0wyyNK5PXublbT5pKOGjVLjmQp27zoYA6KWmMIBVk4n
         KLoHEK3LWJD5b+6lDu+yQ0byVhXODfaT4qcOgyoqCn1LN2X/NKX81uXtFnrvjiX+XoR4
         7XMccsJarvfaKxnubqoBtMZFM2Wbo6yl1WFEvAqILRdXP5cwozFrPoWhqw6KmJJ8+9ks
         Ph/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39SsS75pnQ5vHdEqbne0WJ2yXM1xbTpEuZ3/IBKSvQw=;
        b=FrLHqa6dUYs3+u6wv4RkQFIcMB8Bvaz+xlWKgC4PMueF/2iCFCXunh5smrWUhmgARv
         mp9Yl/IJtgIbp8cBJRX+9kG6v0cYzb9wK9m9S3saiya/UWYbu9/obbB/gGvh4uVMNx7e
         EmHcgxBzOFkYVJlfdGK3/B5xULGVsskrN6cLS8sdAig61xwSheDLuUIwgtJ4pjel7x5U
         QQtoyX3F77oe8ySMNc6IbztPq4DsIqY+2B6v0Y3dhOOUKy+a9Zogq02Ll5MZxnVMC/Tn
         abMhOQRcWxWSCOD67OwPI0pbs/Plxm3E1QpIlV0K/c5yUkAjLFwrmUqyo5mgcxy9cno6
         hnjQ==
X-Gm-Message-State: APjAAAU5/v4WClm1IySRyg3u82K4bVYjxKaZXM5qyfiX8dUTUJqxgvpx
        aOn6UIoguBptjajy6lgy60pKGh+jb5MUh5z3lVnL
X-Google-Smtp-Source: APXvYqxKd5fwr8QHl9rJyGVa9hftw7WKVY4g2KKTll9Io6rs88ViptI9pRCooetIr8mIjw9lSzXtBYo7RsBEknadaiw=
X-Received: by 2002:a19:c301:: with SMTP id t1mr15151815lff.137.1559595462723;
 Mon, 03 Jun 2019 13:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190601021526.GA8264@zhanggen-UX430UQ> <CAFqZXNuPMxOQeq-5evh4dSuGC-Q5sQPjbhRgCBh4Q=u6OrEi9Q@mail.gmail.com>
In-Reply-To: <CAFqZXNuPMxOQeq-5evh4dSuGC-Q5sQPjbhRgCBh4Q=u6OrEi9Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Jun 2019 16:57:31 -0400
Message-ID: <CAHC9VhSt9Qsj1Lgr+H0unbbxOR18KZqoSbfXPR=XpJ8uD8Q2AQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: lsm: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Gen Zhang <blackgod016574@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 3, 2019 at 3:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sat, Jun 1, 2019 at 4:15 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> > In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> > returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
> > should be freed when error.
> >
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
> > ---
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3ec702c..f329fc0 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2616,6 +2616,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
> >         char *from = options;
> >         char *to = options;
> >         bool first = true;
> > +       int ret;
>
> I'd suggest just moving the declaration of 'rc' here and simply reuse
> that variable. Otherwise the patch looks good to me.

Agreed.  Creating "ret" only makes the patch larger and doesn't add any value.

I try to avoid making broad statements, but if you are unsure about
which approach to take when fixing a problem, start with the smallest
patch you can write.  Even if it turns out not to be the "best"
solution upstream, it will be easier to review, discuss, and
potentially port to other/older kernels.

> >
> >         while (1) {
> >                 int len = opt_len(from);
> > @@ -2635,15 +2636,16 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
> >                                                 *q++ = c;
> >                                 }
> >                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> > +                               if (!arg) {
> > +                                       ret = -ENOMEM;
> > +                                       goto free_opt;
> > +                               }
> >                         }
> >                         rc = selinux_add_opt(token, arg, mnt_opts);
> >                         if (unlikely(rc)) {
> > +                               ret = rc;
> >                                 kfree(arg);
> > -                               if (*mnt_opts) {
> > -                                       selinux_free_mnt_opts(*mnt_opts);
> > -                                       *mnt_opts = NULL;
> > -                               }
> > -                               return rc;
> > +                               goto free_opt;
> >                         }
> >                 } else {
> >                         if (!first) {   // copy with preceding comma
> > @@ -2661,6 +2663,12 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
> >         }
> >         *to = '\0';
> >         return 0;
> > +free_opt:
> > +       if (*mnt_opts) {
> > +               selinux_free_mnt_opts(*mnt_opts);
> > +               *mnt_opts = NULL;
> > +       }
> > +       return ret;
> >  }
> >
> >  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.

-- 
paul moore
www.paul-moore.com
