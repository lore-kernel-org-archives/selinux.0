Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2D9C2BB1D
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 22:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC68A206D6
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 22:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Q6AAicc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgDQWX6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728617AbgDQWX6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 18:23:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CA0C061A0C
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 15:23:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s9so2735708eju.1
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sLIkR7VtGIZqbhYahF1XxZ7gCbMECfcYmNC4KsFaZrk=;
        b=Q6AAicc/3/RBTEq/NSG4N8WZVzfxpUIy7hroBQlyrgxzMYLm96UbHfBZC/zEfXPQZX
         lGoLUck0AdPBn1S//tIOu9W4hbqOGakfmKPK9OI4jI/N4yC7axMaKCcn6HkpM3cevehR
         11NfEKpRd/+z8sUhxjbXiCeK/CqEsgXIt9h37lDVriH3VDPoU9Xy6RP88RhVh/JXfJdM
         w6iE/oQBIVGPxqVSz8//eeP3EqKFjVERvUeY08m269uVu1Qtbuzw4ZJHsSKHJgbuIZvU
         ECnKR/j3jKFVkTNjLQv7+WBlwvbEDqnmImgVi+XqNR3MVWd/qA53MP3fMCtmd9XG+ABb
         bA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sLIkR7VtGIZqbhYahF1XxZ7gCbMECfcYmNC4KsFaZrk=;
        b=eF1InlBh9uGwHnychmObcjfMPgvLLKVJlh+VgOtnzT0QuRO/TvfvT4WfkRLQm7PLoR
         D+ULup1LfHPaubncb2htz+B6Pg1LeyqRWmsbmzszwcpLqu2irE4aqxlHdfTluRKsp8fj
         LXSbVTdp7irFsPp3E5odhL3IrBTQ2cGeQ20y11qCCtGVvLesAEE6EfGPsxdZO3iywXMM
         kyv4z5Bk4M2YEej26BF60CLyhRhh+r4tCH3CpUiFVv7dIPr57tSBP/oh6JCu9EC8p44n
         5VpYKtCPskN9+BrungFC3fiTJXePIgecgTsj0NygWuj6CJXsGoyQ9IUfFyPcv+JYhzWm
         DwlQ==
X-Gm-Message-State: AGi0Pua+0piDYSCk91GahauCqTGEPbFyP4ebys7kyzZ3CxSxEn/gx3CF
        zfE9kq18Og6WNQ5lqIUp4adykM3dO0xSGI5NaZ5a
X-Google-Smtp-Source: APiQypJvBYbTUn+yN3qJNIRfWI+B/f+XGAKd5jTQInp7PTOLNtxaluCwPqIrUI79GAfMLJfWpGLXUs2z6dyC6P8u9Rw=
X-Received: by 2002:a17:906:35d0:: with SMTP id p16mr5118443ejb.77.1587162236436;
 Fri, 17 Apr 2020 15:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200414142351.162526-1-omosnace@redhat.com> <CAHC9VhRZgntyb4SneJDmpSSvfLYiox1Bz-SYMs6V9ncyCZPqSw@mail.gmail.com>
 <202004171446.B5B5647ED9@keescook>
In-Reply-To: <202004171446.B5B5647ED9@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 18:23:45 -0400
Message-ID: <CAHC9VhRszsy2iHg4+y3Qx4JqKcZZTpCuds4TYwOsD8n7g0sLMw@mail.gmail.com>
Subject: Re: [PATCH] selinux: free str on error in str_read()
To:     Kees Cook <keescook@chromium.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 17, 2020 at 5:47 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Apr 15, 2020 at 06:04:53PM -0400, Paul Moore wrote:
> > On Tue, Apr 14, 2020 at 10:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > In [see "Fixes:"] I missed the fact that str_read() may give back an
> > > allocated pointer even if it returns an error, causing a potential
> > > memory leak in filename_trans_read_one(). Fix this by making the
> > > function free the allocated string whenever it returns a non-zero value,
> > > which also makes its behavior more obvious and prevents repeating the
> > > same mistake in the future.
> > >
> > > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > > Addresses-Coverity-ID: 1461665 ("Resource leaks")
> > > Fixes: c3a276111ea2 ("selinux: optimize storage of filename transitions")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/ss/policydb.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > I just merged this into selinux/stable-5.7 and assuming all goes well
> > in testing I'll send this up to Linus later this week.  Thanks Ondrej.
> >
> > I also want to add my thanks to the "coverity bot", thanks Kees.  Are
> > you only running this only on Linus tree?  If it's open to other trees
> > it might be nice to get the selinux/next branch into the automated
> > testing.
>
> It's being run on linux-next. The free coverity scanner barely has the
> resources is keep up with one tree, so I just feed it -next. They were
> kind enough to let us upload daily now, so I've been trying to feed the
> emailed reports back. It's all just the tip of the iceberg, of course.

Ah, okay, thanks.  I had wondered about doing regular coverity runs
for the SELinux/audit kernel code but was scared off by the limits; it
looks like that wasn't an unwarranted fear.

Regardless, thanks for setting this up and running it on linux-next.

-- 
paul moore
www.paul-moore.com
