Return-Path: <SRS0=sd8A=UG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17064C2BCA1
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 12:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9AA20B7C
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 12:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOLcgTTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfFGMLv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:11:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50307 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfFGMLv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Jun 2019 08:11:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so1837515wmf.0;
        Fri, 07 Jun 2019 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lCuMQSiPp3S50sfJ3MfqfVj+SodtoDh9nFJUhWW72Tg=;
        b=IOLcgTTfVN1lKHhLQ8vgWF0dkmg15L/ybk7eFQJGBjBX8K2KWCOOr6YPVItt5AjZGj
         9v1zObGANDZjucgKTkPASuG2daCtO/BnvVWwKhR/c1mKyseGOdAUSgY8xA3PIPwb4rVB
         4upAtczueubzxODRbUY7vGA/r8YUK9yPyrpqWnMMFRMHGQOTL31SXoXcacFiVZkVuP/V
         QxQVkZlIN2xgjoTaHMvZ16MSyU2nmwxayRRIy38XueApqQIriCA4fFVnn/SQyg6S7BuV
         wwBKS45FuOM7eQngk821eUANQg5NaHATxitbsWv6BTNqcfhFp/etAjojy0JpxCQVWlOc
         HFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lCuMQSiPp3S50sfJ3MfqfVj+SodtoDh9nFJUhWW72Tg=;
        b=DwYbi5TvUN4sQUoiI/ACGscpS2m6y0dGjwBhQvIK1yrxrmFs9tKnexLeE93XguEcls
         GxknrQ71YPLoLNoGl6dmjjwcj1X2BNJCeWj3Lq8kN1oq/ePpeCoVgt7dC/cdlBMDernf
         XAbs2SBKpc9uR6wp+3fsyNu7T0xawrSfzApogRPsV5mbmcW1OfAFJSDZr58tXDW59HgB
         YCwBd/AzC0nj1/2BEIjT+EbpR2RMidHR61Vouy/ByeEof6KpNEbis8GmrzMQ/XVs5A5/
         2kOFv5G0BVxxFpQdxzwUHlefkHPwZOrAhJ9ufLVJOJUz3Yp/c+eJjMy6NyKL9B+pF0YG
         C5og==
X-Gm-Message-State: APjAAAWw20BU0ULXcZOGQzbR93klHputfKa69eTgbd+pxGuyYTuSNFZk
        +JezYcnGCpMQNqJyHb0494U=
X-Google-Smtp-Source: APXvYqycUI6/kxogTbm6Vep5dkn1W1WkOtlbUtisbPgFbmZ2HPeIw5+BVdAWy75GS17HraHMFPBTUg==
X-Received: by 2002:a1c:407:: with SMTP id 7mr3713361wme.113.1559909508107;
        Fri, 07 Jun 2019 05:11:48 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id t6sm1972015wrp.14.2019.06.07.05.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 05:11:47 -0700 (PDT)
Date:   Fri, 7 Jun 2019 20:11:34 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] selinux: lsm: fix a missing-check bug in
 selinux_add_mnt_opt( )
Message-ID: <20190607121134.GA3357@zhanggen-UX430UQ>
References: <20190606092342.GA21672@zhanggen-UX430UQ>
 <CAFqZXNuricWOMH3fQiCbPZyz2qwf7Gw1zmx1o+wLeTELSF=CUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNuricWOMH3fQiCbPZyz2qwf7Gw1zmx1o+wLeTELSF=CUQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 07, 2019 at 10:39:05AM +0200, Ondrej Mosnacek wrote:
> On Thu, Jun 6, 2019 at 11:23 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> > In selinux_add_mnt_opt(), 'val' is allocated by kmemdup_nul(). It returns
> > NULL when fails. So 'val' should be checked. And 'mnt_opts' should be
> > freed when error.
> >
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > Fixes: 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()")
> > ---
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3ec702c..4e4c1c6 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1052,15 +1052,23 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
> >         if (token == Opt_error)
> >                 return -EINVAL;
> >
> > -       if (token != Opt_seclabel)
> > -               val = kmemdup_nul(val, len, GFP_KERNEL);
> > +       if (token != Opt_seclabel) {
> > +                       val = kmemdup_nul(val, len, GFP_KERNEL);
> > +                       if (!val) {
> > +                               rc = -ENOMEM;
> > +                               goto free_opt;
> > +                       }
> > +       }
> >         rc = selinux_add_opt(token, val, mnt_opts);
> >         if (unlikely(rc)) {
> >                 kfree(val);
> > -               if (*mnt_opts) {
> > -                       selinux_free_mnt_opts(*mnt_opts);
> > -                       *mnt_opts = NULL;
> > -               }
> > +               goto free_opt;
> > +       }
> > +       return rc;
> 
> At this point rc is guaranteed to be 0, so you can just 'return 0' for
> clarity. Also, I visually prefer an empty line between a return
> statement and a goto label, but I'm not sure what is the
> general/maintainer's preference.
Am I supposed to revise and send a patch v4 for this, or let the 
maintainer do this? :-)

Thanks
Gen
> 
> Also, you should drop the "lsm: " from the subject - it is redundant
> and doesn't follow the SELinux convention. See `git log --oneline --
> security/selinux/` for what the subjects usually look like - mostly we
> just go with "selinux: <description>" (or "LSM: <description>" when
> the changes affect the shared LSM interface).
Thanks for your comments.
> 
> > +free_opt:
> > +       if (*mnt_opts) {
> > +               selinux_free_mnt_opts(*mnt_opts);
> > +               *mnt_opts = NULL;
> >         }
> >         return rc;
> >  }
> 
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
