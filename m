Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7630EC433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 20:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5116021582
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 20:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WHB3heK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFQUvs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUvs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 16:51:48 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF017C06174E
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 13:51:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f7so4060875ejq.6
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7d9D7DdOBCkM3WVfrd5zaJp7zmJiHbkabHOk+GNLzg=;
        b=WHB3heK02RYqhtR3KBCfEAY1anEU5eNIbCqZeFyh4umG6SHs/pxirhfkrcZguGC2uI
         Pv4pKoM8JCf5BgObp/El9D556uBr+jPuURqa6sI/MGoO1flZH7hQNhsKHWd4PYo7EMza
         aOka3zm67A/gc3Nc3nNSY9/w6AtLi+49g3t2ZydOFcijMcWOe2KTDA89Sa3+UfCh8mWZ
         ofTwgLi3HOhjwakYHlC9cefjBiMgR6yrZcdCUpSk32j1K2cvSciElvUSmtpoH+x/6zsx
         2xOjp7E0J8/I/uTfs0ZkJ5EV9KxVqmy7yI9jfusnYrDWcdrFc2Ni2/WdhHrXaQJNvvDd
         Uvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7d9D7DdOBCkM3WVfrd5zaJp7zmJiHbkabHOk+GNLzg=;
        b=dwwE/bDOwnEHrI40YEYsFnOV6pHZe+uGFsmXT6WitPkq+071oOnWoB7zxP7m77dK0O
         qV74OFTd4LnUqN0IcKw/QcHyMPW+YPzvuuXXs76d4tWsPqR49uMjPsKHskPUtDRvO5YF
         nxYorxphjsb2tsP4LnJ8LzG+7dyl9Mc30vVjuyDqE4bYZxP2T7Y4WOBcgZ5KQaMWR5Gn
         eHEKC7WGx+5cBavcmHqUnPbpXaXkMYEnPXg1zRUUb++TdHPfgq1INUG5vBmZ1YmPoKXs
         xfIqjGWwuYUjhgoYenaapq3Sfr90D3j/bjpWlfNn/poKXDyZjJcKFDGN27KuzR70+xJ8
         3vBg==
X-Gm-Message-State: AOAM531Ux0yQRhoc4UwTvpCnSlw/+SWa5zoDyV75hT8RS8Oxco+Kj4rp
        Kih1bDLruWCKwGAhLOl0FnXs6w+SQuH5v759TkHD
X-Google-Smtp-Source: ABdhPJz9hItxcmRzrDNjTZGtBxaQNc6TKqZsdmfqLsX90TBETGCVk3qgfIre0UJ61l4pYuwSEk2Jya74/urncX+8RdA=
X-Received: by 2002:a17:906:434f:: with SMTP id z15mr951887ejm.178.1592427105550;
 Wed, 17 Jun 2020 13:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200617124028.14130-1-trix@redhat.com> <CAEjxPJ5uGV-SjKL7v5J=7YYEBOjyHwK625SX8fzCrbatuB=9hg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5uGV-SjKL7v5J=7YYEBOjyHwK625SX8fzCrbatuB=9hg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Jun 2020 16:51:34 -0400
Message-ID: <CAHC9VhT_mAd8pkboQX1xQpxmYkFvK=HW3pUB8_UzbgnW4+=RjA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix undefined return of cond_evaluate_expr
To:     trix@redhat.com
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, weiyongjun1@huawei.com,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 17, 2020 at 9:58 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jun 17, 2020 at 8:40 AM <trix@redhat.com> wrote:
> >
> > From: Tom Rix <trix@redhat.com>
> >
> > clang static analysis reports an undefined return
> >
> > security/selinux/ss/conditional.c:79:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
> >         return s[0];
> >         ^~~~~~~~~~~
> >
> > static int cond_evaluate_expr( ...
> > {
> >         u32 i;
> >         int s[COND_EXPR_MAXDEPTH];
> >
> >         for (i = 0; i < expr->len; i++)
> >           ...
> >
> >         return s[0];
> >
> > When expr->len is 0, the loop which sets s[0] never runs.
> >
> > So return -1 if the loop never runs.
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> clang didn't complain about the similar pattern in
> security/selinux/ss/services.c:constraint_expr_eval()?

Related question: I appreciate the work you are doing Tom, can you
share how far along you are testing the SELinux code with clang?  I
ask because it would be nice to roll all of these patches up into one
PR for Linus instead of sending multiple updates.

-- 
paul moore
www.paul-moore.com
