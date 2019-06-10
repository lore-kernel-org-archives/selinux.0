Return-Path: <SRS0=W683=UJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF09C4321A
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 19:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587D320820
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 19:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oKO4mbCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbfFJTcE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:32:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42166 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389129AbfFJTcE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Jun 2019 15:32:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so7455885lfh.9
        for <selinux@vger.kernel.org>; Mon, 10 Jun 2019 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIoSsHs2Gt3kHbX+cuP9jRibTu3kMb1fSTDPWFLywq4=;
        b=oKO4mbClwNDoCgUwCV9hFQelTUY+xAsbBQi8UXkaFFyxhzWF/FXpxQnPGBCRuSgfrN
         VLnPReDyxOanh93THZAyuRf18DZQLhRc9AdKcjG1fvNU3nc0NcslkzYjzk5r4KC7lA3T
         fHDSdZJQKDGB5Mgl9VB8V6UnMZESUdQdUUVSlTKHHLFCBkRavW8xXCQB4u/rcpNraDUL
         Zvr4WKdbV7BlJtsMg4qjWfYbJ2oFXIBh8sLbEk9dGSxvqmG8ZimxO+99J3ytAS378x8I
         iMwBcbKpuTZrkiNSkV1Nx17sKx+9zwJKNzQ9opk9OdqoZRwmoaF2S+Z3WY9cmyi2WgXD
         JOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIoSsHs2Gt3kHbX+cuP9jRibTu3kMb1fSTDPWFLywq4=;
        b=oJwWjqnqFt/N5kz8nmxGBy1xijoRVEV/y3f14uZJHFD2jT5utto01BzgUEiGIDSDOO
         2yug2gBHLO4ZoMn0UfQGKu4O62F2WqcxpZuMTM1H3uVC6NMQTYFwJ08Bi9RNTqCkdMP+
         CdOxlNoZDX4uN0dk/yNYxJDzBhAoTEOhwHhjYd7nWBoO8UncCiDRfl87vnAuk6ykZ16X
         QbHEmU+sn8TltbvUkjebZKBLiK5YOJZdPvMtDJAiScTMg4oIAtD8svDbQnKfZxt2sdtI
         XGGwYPoJA36PH7sGCphxL797ys3yxuUDzmRAGlIXuBiAXPHe9O47SydpYNOAM5DHSOXG
         fDRA==
X-Gm-Message-State: APjAAAUQ78U3Yb0EKUwbrvRjmdXZRU5OQsob7d866RZ+UFXrGN1lt2eX
        l/oqI3tVCWmt7UrCFlrqcQZTv04AGRSVeo5lvJRF
X-Google-Smtp-Source: APXvYqxvYthO9/gqYcTo77CUTe6wmEAHSs04Nn7iJsK2zbchLH0BsJ9Rd+mCQ8lntv+6VRIY5jRd+teiUkkJXjaPaAQ=
X-Received: by 2002:ac2:4109:: with SMTP id b9mr4940972lfi.31.1560195121827;
 Mon, 10 Jun 2019 12:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190606092342.GA21672@zhanggen-UX430UQ> <CAFqZXNuricWOMH3fQiCbPZyz2qwf7Gw1zmx1o+wLeTELSF=CUQ@mail.gmail.com>
 <20190607121134.GA3357@zhanggen-UX430UQ>
In-Reply-To: <20190607121134.GA3357@zhanggen-UX430UQ>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jun 2019 15:31:50 -0400
Message-ID: <CAHC9VhS8W8p+9FwB9OHBhfsxP45ckjpqsqt6p85U5PZY=N=rYg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: lsm: fix a missing-check bug in
 selinux_add_mnt_opt( )
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 7, 2019 at 8:11 AM Gen Zhang <blackgod016574@gmail.com> wrote:
>
> On Fri, Jun 07, 2019 at 10:39:05AM +0200, Ondrej Mosnacek wrote:
> > On Thu, Jun 6, 2019 at 11:23 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> > > In selinux_add_mnt_opt(), 'val' is allocated by kmemdup_nul(). It returns
> > > NULL when fails. So 'val' should be checked. And 'mnt_opts' should be
> > > freed when error.
> > >
> > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > Fixes: 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()")
> > > ---
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 3ec702c..4e4c1c6 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -1052,15 +1052,23 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
> > >         if (token == Opt_error)
> > >                 return -EINVAL;
> > >
> > > -       if (token != Opt_seclabel)
> > > -               val = kmemdup_nul(val, len, GFP_KERNEL);
> > > +       if (token != Opt_seclabel) {
> > > +                       val = kmemdup_nul(val, len, GFP_KERNEL);
> > > +                       if (!val) {
> > > +                               rc = -ENOMEM;
> > > +                               goto free_opt;
> > > +                       }
> > > +       }
> > >         rc = selinux_add_opt(token, val, mnt_opts);
> > >         if (unlikely(rc)) {
> > >                 kfree(val);
> > > -               if (*mnt_opts) {
> > > -                       selinux_free_mnt_opts(*mnt_opts);
> > > -                       *mnt_opts = NULL;
> > > -               }
> > > +               goto free_opt;
> > > +       }
> > > +       return rc;
> >
> > At this point rc is guaranteed to be 0, so you can just 'return 0' for
> > clarity. Also, I visually prefer an empty line between a return
> > statement and a goto label, but I'm not sure what is the
> > general/maintainer's preference.
>
> Am I supposed to revise and send a patch v4 for this, or let the
> maintainer do this? :-)

First a few things from my perspective: I don't really care too much
about the difference between returning "0" and "rc" here, one could
argue that "0" is cleaner and that "rc" is "safer".  To me it isn't a
big deal and generally isn't something I would even comment on unless
there was something else in the patch that needed addressing.  I care
a more about the style choice of having an empty line between the
return and the start of the goto targets (vertical whitespace before
the jump targets is good, please include it), but once again, I'm not
sure I would comment on that.  The patch subject line is a bit
confusing in that we already discussed when to use "selinux" and when
to use "lsm", but I imagine there might be some confusion about using
both so let me try and clear that up now: don't do it unless you have
a *really* good reason to do so :)  In this case it is all SELinux
code so there is no reason why you should be including the "lsm"
prefix.

You've been pretty responsive, so if you don't mind submitting a v4
with the changes mentioned above, that would be far more preferable to
me making the changes.  I have some other comments about maintainer
fixes to patches, but I'll save that for the other thread :)

-- 
paul moore
www.paul-moore.com
