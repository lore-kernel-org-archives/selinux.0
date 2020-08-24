Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C55C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EED62074D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 22:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="q8aqKNgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgHXWS2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgHXWSU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 18:18:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4652C061795
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 15:18:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id oz20so8954844ejb.5
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbf1ipuYiVgdUWQ8HAa35vLjx5URShNXD1uA8qol15c=;
        b=q8aqKNgAlrJcW1DfAsWkK0x70/h9sqAj6sG9yqn4l/81Q41m4/G0P59I57LZClkaXi
         CPRLqLU/FdeEg+A0IImj5/xmgMzpxLzV0U9aJUwFuwU3geGJYK3FSk86WpPspnvnCuHc
         lw2P/Pm6qanEAdo3l1ruLGUEqfthWuBXvPR7BlqcKs2ZOdJXVKdhy5zbtJGbRokQ+hlf
         Rc/Zp2cKm0uj5jtbaIIJ7vTYZl3New8ZpWpAvBSNXx6c6BJLfSJczOJCxTqywbT6jrff
         qDtfZZQwwLNKFMrIDwZ5J/yokHCrMA2+vPPJ17xngNIpCph3FoV8syaw2e0zK33I2uSz
         IaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbf1ipuYiVgdUWQ8HAa35vLjx5URShNXD1uA8qol15c=;
        b=I8+rSxoaEhPWeUd9vBY0a1wSHTOgvAgB3O6SqELZV0gEl3wOFOQgBS59Doo0hMPSkk
         xtEOZPi5yTA2UBdlx+M2dw2idR41xGVSDwYjQGxNteRdJFXfG3/5P9pbYIZFTklzlhQq
         snekQLVtEHC6FNhweFblMAVIc+I/S0IKVcaWQZUSa2NMOH/BR0N3PC6xyogY3eJBsMIk
         yqxLQ9Ocix/7SXrTllfP0wHuefBd3ygd3jWpMgAfEzdsLTjNCRysVwdGg03g+GxtoHIY
         piS/GQhDZFO400zbvXieKg7Nlcjt40dZ/a/JWbrc54v+6WNrvu1Hsw1IKrQA0OrlSK1Z
         O50Q==
X-Gm-Message-State: AOAM5322SGtG1GufRF3arUeAgQD1K1fbHo6ZfGkZElUNycsucOtXalb3
        KG6Fw6/R2uJcFnN1Bmq5cjpddmLqUK8rD0MYV+ul
X-Google-Smtp-Source: ABdhPJyWFqwCWCfOf3aV/DF5A9ybjw9coxTPI7UoJ5H9ThnSSr/T7I4PmxsgQ0RTLjLnYwrNv3pGmxT7ITZ5GTP/Ijs=
X-Received: by 2002:a17:906:e0e:: with SMTP id l14mr7179237eji.398.1598307497548;
 Mon, 24 Aug 2020 15:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
 <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
 <418618c4-a0c6-6b28-6718-2726a29b83c5@linux.microsoft.com>
 <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
 <CAFqZXNvVQ5U6Ea3gT32Z0hfWbu7GPR-mTF2z6-JZZJT57Heuuw@mail.gmail.com> <f041e8ee-3955-9551-b72d-d4d7fa6e636d@linux.microsoft.com>
In-Reply-To: <f041e8ee-3955-9551-b72d-d4d7fa6e636d@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Aug 2020 18:18:05 -0400
Message-ID: <CAHC9VhQP7_rV+Oi6weLjVhrx2d8iu9UJ8zeE=ZcqnBMqngrJ4Q@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 5:29 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 8/24/20 1:01 PM, Ondrej Mosnacek wrote:
> > On Mon, Aug 24, 2020 at 9:30 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> On Mon, Aug 24, 2020 at 2:13 PM Lakshmi Ramasubramanian
> >> <nramas@linux.microsoft.com> wrote:
> >>> On 8/24/20 7:00 AM, Stephen Smalley wrote:

...

> >>> Is Ondrej's re-try approach I need to use to workaround policy reload issue?
> >>
> >> No, I think perhaps we should move the mutex to selinux_state instead
> >> of selinux_fs_info.  selinux_fs_info has a pointer to selinux_state so
> >> it can then use it indirectly.  Note that your patches are going to
> >> conflict with other ongoing work in the selinux next branch that is
> >> refactoring policy load and converting the policy rwlock to RCU.
> >
> > Yeah, and I'm experimenting with a patch on top of Stephen's RCU work
> > that would allow you to do this in a straightforward way without even
> > messing with the fsi->mutex. My patch may or may not be eventually
> > committed, but either way I'd recommend holding off on this for a
> > while until the dust settles around the RCU conversion.
>
> I can make the SELinux\IMA changes in "selinux next branch" taking
> dependencies on Stephen's patches + relevant IMA patches.

I know it can be frustrating to hear what I'm about to say, but the
best option is probably just to wait a little to let things settle in
the SELinux -next branch.  There is a lot of stuff going on right now
with patches flooding in (at least "flooding" from a SELinux kernel
development perspective) and we/I've haven't gotten through all of
them yet.

> Could you please let me know the URL to the "selinux next branch"?

git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next

-- 
paul moore
www.paul-moore.com
