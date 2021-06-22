Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371C4C2B9F4
	for <selinux@archiver.kernel.org>; Tue, 22 Jun 2021 13:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE7160FDC
	for <selinux@archiver.kernel.org>; Tue, 22 Jun 2021 13:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFVNly (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jun 2021 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFVNlx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Jun 2021 09:41:53 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BA6C061574
        for <selinux@vger.kernel.org>; Tue, 22 Jun 2021 06:39:38 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso12033372otp.8
        for <selinux@vger.kernel.org>; Tue, 22 Jun 2021 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtP8GfFP/95Hjj4ynMQPD60raI0rlusNG4LwjN2cPds=;
        b=RIOscTJ87tbesNS4NKcGDk5/V0aS01kw8vD+Zg6r6Np2zUMPrOj5x4vtlzgFxhoGEH
         uAOqqS3zdmoKWLC95yy3qzC+F0NuQN9Er9EwBw9GVUu93O3JWUscCVAWNaahNmVRzJGK
         rLIXsvLnbh9IJfMobG3uLrGO8OBXzTw4jW2MXgYGd/4vPcah2bIWZBlL/L/Is6owrxLH
         S44L1RT9LGUMFMRHh86OIgqCnY5lBZ6jCHLgBniiR+pBUHx8lO76Ybibi5Ldf7+b5fO3
         k4yLzsCi0CZNvbXglF9hAakCc7h+m4iA+VkAAB0/Ey2FYD0AMeHwFSpS95Tld28Xne9i
         6M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtP8GfFP/95Hjj4ynMQPD60raI0rlusNG4LwjN2cPds=;
        b=hU6X5y251cYFTuNvxI5RukhnJv4yE0CIbl5XcZ6CdDi3P/ZWrFHfE/RhgKCOGrbaEg
         IZWxif3NwODqaV5TZnGVs2KTOnPM7lqktwM4SkqBgWqfzASagH0EUGjDM23NUdsZD/Og
         mvP+m+Cg3xxcS+L+yBkxKs2CgxlQseJ7Ave18AtbyuZGzXuwlNYUPrziFgZ1LQFqVp6T
         mMHD/3IjoVtQserVHoPbdqfAVEevYXUzCp/f79lDekbhzP9ivsjCBFWrONnC9oYFDP6t
         McYUdxG9WozY2Wzm9j8ArGb2Cz81pMsHXiNU4PgnVWZ7Obf8u0SVwdKlfyMGvbfVKoMI
         30Hg==
X-Gm-Message-State: AOAM530IMGQyNMZfkjmhaJ661Rvm1QpzIeblsKTGQ3YMq73icrcYnZbe
        ZedwGTKC1kPTwHoKdh/pQiN105/ekpRNLSyDr526uGm3/Sc=
X-Google-Smtp-Source: ABdhPJyi5ZwE0XkhTEmnoft5w2/AsnGdKwBztHe2sBNDazshcyiEGVrMbyl7GiXITI0rFfFST/qbSwddYwITPzjItBc=
X-Received: by 2002:a05:6830:108a:: with SMTP id y10mr3203255oto.59.1624369177593;
 Tue, 22 Jun 2021 06:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210615185655.34064-1-jwcart2@gmail.com> <CAJfZ7=n476qTnveGzqXCFzbD1P_OWE=CXZ0mSrnyoFOu2kUp9g@mail.gmail.com>
In-Reply-To: <CAJfZ7=n476qTnveGzqXCFzbD1P_OWE=CXZ0mSrnyoFOu2kUp9g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 22 Jun 2021 09:39:26 -0400
Message-ID: <CAP+JOzTCEQew4=dBcO9WoVos7E+AFKQWB6vP6p7E74GZ6rXG+A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix problems with CIL's handling of anonymous call arguments
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 19, 2021 at 10:19 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Jun 15, 2021 at 8:57 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > For more information on anonymous call arguments, see the third patch.
> >
> > The first two patches fix a couple of bugs in the handling of anonymous
> > call arguments.
> >
> > The last patch adds a test policy that can be used to test the handling
> > of anonymouse call arguments.
> >
> > James Carter (3):
> >   libsepol/cil: Fix anonymous IP address call arguments
> >   libsepol/cil: Account for anonymous category sets in an expression
> >   secilc/test: Add test for anonymous args
> >
> >  libsepol/cil/src/cil_build_ast.c   |   4 --
> >  libsepol/cil/src/cil_resolve_ast.c |  47 +++++++------
> >  secilc/test/anonymous_arg_test.cil | 106 +++++++++++++++++++++++++++++
> >  3 files changed, 133 insertions(+), 24 deletions(-)
> >  create mode 100644 secilc/test/anonymous_arg_test.cil
> >
> > --
> > 2.26.3
>
> For these 3 patches:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

This series has been merged.
Jim

> Thanks!
> Nicolas
>
