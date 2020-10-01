Return-Path: <SRS0=ZFtm=DI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2106C4727E
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 21:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76697206A5
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 21:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zaPIgyp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgJAVOY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Oct 2020 17:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgJAVOY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Oct 2020 17:14:24 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE41C0613D0
        for <selinux@vger.kernel.org>; Thu,  1 Oct 2020 14:14:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p9so10112402ejf.6
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2020 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xUBsd4gvX5SsYzR/5SEir1FuSIEDtJj41EORxyYh04=;
        b=zaPIgyp+wp2Uu/xEifj4o8sMUfIn7qmgUyEbKU9+pulc8RGui6REYs8lOFNsjzUWJK
         oZBGv1peTTeZssOHowoMpIwboxFZ+Y983n1G+NqEb4cLXvuUSFn/FGTUIqv2hyHTvq27
         aM/pFQ9U0SZLQYPHBgvtTVJgydK19D8JGI9WYurANlYQkkY5taz0khFJuwlAlI/amusg
         LsGjWwKch8fJdhWa/kAGiJ6J+y8iP6HkLy56RHuQoev1gjm8uqNUdfa6bsp2YbOydgj3
         qZlljrHcIp/9AzSGHZExTDo9Z0ZqmciEhxl9IUE3FIeg04AuVXgEA05a3YqvLJYDrjga
         aIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xUBsd4gvX5SsYzR/5SEir1FuSIEDtJj41EORxyYh04=;
        b=ZrPz+K5qyCo5cWqdTboiTKtErPLaWgwGnCUy0jKXT7rgfbTwelr3qBof+qFIWoVeiz
         X28fl1KqLq7NAp/fYXlVRLrjVtFh156Pq/6fxVjiQkKggPqCiC27YeGvQiwdOb9pPbdt
         zBO53JIvQuafpEUX0oXAWz/vYj2qRt8QuzDX8rqOMWr+rL+1kEgrF6Q5zq0hs/g642+8
         GAZ63niYEWX0HiQ4pli2UgovHeamayK5r9gvYfTywiDffX0uHN72F1xY8hZSzIOaokQu
         LCFzNd+jWNXfG/wqNWlwvrKFydFPjeJcokxBemyzPumALtdGzZmfjS1z14CLpUl8NjHW
         pDQw==
X-Gm-Message-State: AOAM530S/0HQwAfeAts2EXF3ZyXalzD2ER09nE9WxAWoEJoaIcQll3fX
        XM6NBW+7E0R6s5ZyeZT5e2SrBlwswZqvGnG/Zq27
X-Google-Smtp-Source: ABdhPJzRQB4Rgx5VvTz7LzK+V5cgnhKcY+jx4CIr4unRd3nM9otd36/zTa2CLzpjLSzYM+rBBBERCVhtWA1zY9gXtsA=
X-Received: by 2002:a17:906:2301:: with SMTP id l1mr9805498eja.488.1601586862094;
 Thu, 01 Oct 2020 14:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ7==mkXDKuDw2YueRP+ymoQjPDdCS8Wk7GJfth+CpLqkg@mail.gmail.com>
 <20200930013653.48787-1-rentianyue@tj.kylinos.cn> <20200930013653.48787-2-rentianyue@tj.kylinos.cn>
 <CAEjxPJ74F7D-3hJbObYXUsJdRcBJs9F5DW4Q-mwn2dm1TwMHmg@mail.gmail.com>
In-Reply-To: <CAEjxPJ74F7D-3hJbObYXUsJdRcBJs9F5DW4Q-mwn2dm1TwMHmg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Oct 2020 17:14:09 -0400
Message-ID: <CAHC9VhRbODSUv=DonaeUbfyXtJZTTETeot984-4b-q+L9Ge4FQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     Tianyue Ren <rentianyue@kylinos.cn>
Cc:     Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        yangzhao <yangzhao@kylinos.cn>,
        SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?B?5Lu75aSp5oKm?= <rentianyue@tj.kylinos.cn>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 30, 2020 at 9:50 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Sep 29, 2020 at 9:38 PM <rentianyue@tj.kylinos.cn> wrote:
> > From: Tianyue Ren <rentianyue@kylinos.cn>
> >
> > Mark the inode security label as invalid if we cannot find
> > a dentry so that we will retry later rather than marking it
> > initialized with the unlabeled SID.
> >
> > Fixes: 9287aed2ad1f ("selinux: Convert isec->lock into a spinlock")
> > Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thank you for the patch, and your patience with the submission process.

Considering that this has been broken for almost four years and we are
currently at -rc7, I'm going to hold this for after the upcoming merge
window in order to limit our risk for the upcoming v5.9 release.

-- 
paul moore
www.paul-moore.com
