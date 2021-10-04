Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B142C433FE
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 13:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E022360F57
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 13:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhJDN6Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbhJDN6J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Oct 2021 09:58:09 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE132C04AED6
        for <selinux@vger.kernel.org>; Mon,  4 Oct 2021 06:52:36 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so21552088otv.4
        for <selinux@vger.kernel.org>; Mon, 04 Oct 2021 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpwFF5T0yQh+Gnl/0CNZWv01WcLi0vHYv8ukyekZj4c=;
        b=KRZDkfL9flUtUs/hoBVHX+boJOtPVyj1cLJIJxkZOtNA9yus+4FKkD1wqH8993/my3
         /i7BJPHsjMaZIfbRyFwrXtj/EIy51zVHyuXBDiKrKHw8MQ/KW5pKlyJNaqMi0BXQHAMa
         ZaLcWG0PM24x1fAr9UTkabiZJ8I4NkdGE3Ta64EczMYT75/5xcY3ULK4byRHGjoIXcmM
         AMIHOTNimnK+GM9jHOLU9Nn7yfIHiYJAs0WMRTHLgOjUzxe+mTO3l8w/H/1eCLQ1Smib
         40Wn8yyXMX0ZJt5ZOkCfSjohxXctsypOJPOdEOMWm6L4U32IBxlALoJaZmiVwjX8Z0CM
         1ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpwFF5T0yQh+Gnl/0CNZWv01WcLi0vHYv8ukyekZj4c=;
        b=fgXgDXRQ07KNUa+3YjAJyEma9QLwpu3AC92//mdWmrH3uiUP8iasJWZy4aFpiKI+H8
         VbhWtq45DDSktWS4O6NTkGBecuATShRQWiVQh03MpFPRBVhzHgPf3EXl88sIBbNaCbVv
         O33Nry7j41oqxWhGFpezrYkbKHgWjwJzFvabHEWYFt5O4i0DnyVgGP+aaYTXFJc6BwOk
         LYcbrzq/HMUHhovxlHiwYXwRqvMySMHiqOccdhNktPHz+/wD9CCtzXKUtAT0I2uHidhg
         jAf+oOauSTMhrUuRbjHtg3akNsC6Z0dNSJ8Id4LBdwW8L1IWHVnq9bmE1tbst10ijU09
         thcQ==
X-Gm-Message-State: AOAM532hJxKrOWnSzyl0iIpFSgb6TRkcNdwFK7pq+i19u3oSRMJtHj8N
        Obqc5+ZGo1eF8wuM1BQCBlGOR1uiuZwkl7h4aGs=
X-Google-Smtp-Source: ABdhPJxB7GA7nHDryHTvd+x2RhRvr722HaK7K0bHhiISpGFk7iG5Bs9/Xg+3OLiFgYLBv6vpMpzBdFuzJuIk6bxB9Z8=
X-Received: by 2002:a05:6830:1acc:: with SMTP id r12mr9775714otc.154.1633355556173;
 Mon, 04 Oct 2021 06:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210927084944.7197-1-nicolas.iooss@m4x.org> <CAFqZXNu=LTrN+TowDpU1f1J8NUcrFbFb_3_V-tGrwUxwHfDBpg@mail.gmail.com>
In-Reply-To: <CAFqZXNu=LTrN+TowDpU1f1J8NUcrFbFb_3_V-tGrwUxwHfDBpg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Oct 2021 09:52:25 -0400
Message-ID: <CAP+JOzTKyX252i2SX=AMbrQ=DCGYNgrrSceCRCTUR5tR=6732g@mail.gmail.com>
Subject: Re: [PATCH userspace] README: update continuous integration badges
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 27, 2021 at 5:22 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Mon, Sep 27, 2021 at 10:50 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > The CI now uses GitHub Actions to run tests and the SELinux testsuite in
> > a virtual machine. Replace the Travis CI badge with the ones for these
> > workflows.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/299
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  README.md | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/README.md b/README.md
> > index d1338e8765d1..e1c2fe641fc9 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -2,7 +2,8 @@ SELinux Userspace
> >  =================
> >
> >  ![SELinux logo](https://github.com/SELinuxProject.png)
> > -[![Build Status](https://travis-ci.org/SELinuxProject/selinux.svg?branch=master)](https://travis-ci.org/SELinuxProject/selinux)
> > +[![Run Tests](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml)
> > +[![Run SELinux testsuite in a virtual machine](https://github.com/SELinuxProject/selinux/actions/workflows/vm_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/vm_testsuite.yml)
> >  [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
> >  [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
> >
> > --
> > 2.32.0
> >
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>

This patch has been merged.
thanks,
Jim

> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
