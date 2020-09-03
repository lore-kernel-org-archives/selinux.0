Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D37C433E9
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 20:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85B420897
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 20:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+ROYLII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgICUN0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICUNY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 16:13:24 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9FC061244
        for <selinux@vger.kernel.org>; Thu,  3 Sep 2020 13:13:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r64so4395184oib.6
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0i8anA2sAWuKJQYwOV3xmAc+Kya29B49t6HnT4GnoIc=;
        b=W+ROYLIIGNYO8DZgy+spsK6boovU3wv95XzUvNMiYvaslYEGOV+sx3QzN55vFfEhCK
         KVGAZujGyptD10GK/vP5Zpmp7lp4IlIjTmL38V61SJAfbeIxxwuvIfXy3P9myVJy6Ui+
         Ulm4E9bvXALhhilxIhFLMknaDARuOVSyMu76iXEVa5+N5bm3wCGM3PqUuQ1vfGPpHkH0
         /6ZYC8DqOjCNLWV6elwWPrtdXuFtjZbqXSZecEqcUeWu1PYNx8mcbneWtDMVtZUKy+jZ
         o9fkqr7m0mm341q2xoro1//2lA5BAuhZEe9+XhUwOY7YskiO+HugfBU9F+0tcSAp4CIW
         GTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0i8anA2sAWuKJQYwOV3xmAc+Kya29B49t6HnT4GnoIc=;
        b=YAnRPDmAu5BRGmNNSpsseLzjGO9Gl2bDjFd7tDzccyGJ4IR67J3ghHo9Jz5jej3uJN
         QJ6VNdP+AQUkRlZT47jfUXBYukTFUx+kAuKDAd16yoOdPprJs8BByc1SyUvaS8NH0RTo
         J6lrp3vSJ2E2Loxt+DAg+UrCksjYLDYlM30qcBpgPgcNbsTde5ENiKZxN8sM5DDPgcuj
         P8qahHzUgA9Jngp9Wapnm0RrTD4UW4iS9nQj3lsdqhqs0fIGtHs5djfz3Fn4/a30sybW
         acdbStQnBubc+3Y9quQWavClrutKuxyfHuMKOAR0Odv1kEuIHnVuhcDlNSJeicwU1mtZ
         ntHg==
X-Gm-Message-State: AOAM531nEHxs4d2cEzDORjLJ1AwqEJ222ooJGBn+7L2rcMeTb0qaz1/Q
        eJBLmDNo+o5+BKeGw3E3fTT6EuSBLIgon9s96dE=
X-Google-Smtp-Source: ABdhPJwUgNxU8wGWlYqst6It0EfTREUyPLqBB39Vs3jiXEegmRIzL2ah618p3ceYtcfL7Ax7eyWS2Kn3W/8jolOFK0A=
X-Received: by 2002:aca:d4cc:: with SMTP id l195mr3311924oig.16.1599164003807;
 Thu, 03 Sep 2020 13:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200903181900.81179-1-jwcart2@gmail.com> <CAEjxPJ4VYKom3-tFeuErzJGWZMD-E8j0D39rsu9xjsM3BLTrNg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4VYKom3-tFeuErzJGWZMD-E8j0D39rsu9xjsM3BLTrNg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Sep 2020 16:13:12 -0400
Message-ID: <CAP+JOzSWSp_OoXOdnZ0rS_sL+WmbMRct9o-4ju4hL8YZS58FZA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Give an error when constraint expressions
 exceed max depth
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 3, 2020 at 3:42 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 3, 2020 at 2:19 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > CIL was not correctly determining the depth of constraint expressions
> > which prevented it from giving an error when the max depth was exceeded.
> > This allowed invalid policy binaries with constraint expressions exceeding
> > the max depth to be created.
> >
> > Correctly calculate the depth of constraint expressions when building
> > the AST and give an error when the max depth is exceeded.
>
> Does a similar bug exist for conditional boolean expression depth checking?

Yes it does.
Jim
