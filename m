Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F68C197A0
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 14:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345350AbjKPO6u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Nov 2023 09:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbjKPO6u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Nov 2023 09:58:50 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D956DB4
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:58:46 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507bd644a96so1257666e87.3
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700146725; x=1700751525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdfJ2w8BJDRAxf1/30I13Yq/fJlD9+Z9vxT0h83ZykU=;
        b=eXZpzUUAgjH2UAEdgek2Kz/fe+B7NfjScBZhEDYZovyQJ4EeLxC6y5cH9X2O3iuMOo
         Q3wx3DMMHgZhZM1g5oPJL7nwTvzrTEB1L0NsM+wfdu7N3KpOwSfD/Kr3kRz+U5mrVVXI
         ZVBkoj6hdMS2Vz/HNDJlNBySpUc+plQMREtQQgvL9VdTgzq2qni5JGb8yr8IbiQBcgjh
         1ZYQjY1SyZXuPND72k5BReWF5yiiyuGUp8OVtCynT093rRLwRGYGaCvTi9c5yIf/aXkR
         QhMDJHjLGoLwLXIw9DHv5Z+ZBNFOLtghP5D715swGWtjqVMVGlu3uNuSjVh0Eb/AbZ64
         rA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146725; x=1700751525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdfJ2w8BJDRAxf1/30I13Yq/fJlD9+Z9vxT0h83ZykU=;
        b=Qz81mvXe/nHRXAvi67CzwPVmbFqcn17owgLwIQKCjMtZDWoyGs+PogUqX9HVbFEX3z
         cFi5YOOSqYjig1zoiPvW0LBbSK3HlIr78uAQNsL/3OzYVu5G2XubM+nDmdz93BljYft/
         owpBUqUuA3E5vdN4mD5t7JRhRpbYZ4pI4P2Y36uCJneWN8ZwSzXcaul+OjluymdUjsd7
         3+mha6a+wHdVnneAVf72TLELTiUh8kHaohpIS5soFt3Gkah5gfloaC9Y6hv06XHjZCZK
         RlMWEW+XjhIPZD7XPklzPRP1LYjfRU+18MqSyD4mvmlHIzvzc4y78lL6N8NqXu639mDX
         3tnQ==
X-Gm-Message-State: AOJu0YzDxnlbUiOYsQn7NNNOtj1rF+G291az10nWIjGSUHr/nfgHaQQ6
        iU0zZ72bjBLb1t5DBSXWdtPiMqoE+5B8o5iXA2Q=
X-Google-Smtp-Source: AGHT+IF9zBl9KZhODBKGeTQk206BTNki0qe5fQS0ASuS/IRCPXsCxMRQpEKbvHt0rEddVC2wuc1TJvybRb7YLaAJKTM=
X-Received: by 2002:a05:6512:238b:b0:50a:7575:1339 with SMTP id
 c11-20020a056512238b00b0050a75751339mr13297340lfv.18.1700146724827; Thu, 16
 Nov 2023 06:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20231109152150.691053-1-cgzones@googlemail.com> <CAP+JOzSb_gukgC9qt35V7O-tSHJkeUaUmJVaxk9Wu9QvSUaAdw@mail.gmail.com>
In-Reply-To: <CAP+JOzSb_gukgC9qt35V7O-tSHJkeUaUmJVaxk9Wu9QvSUaAdw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 16 Nov 2023 09:58:33 -0500
Message-ID: <CAP+JOzQpT33PFE9puvz6sMSKR8nkNZeYrYf_NiPN33gfEi0wWQ@mail.gmail.com>
Subject: Re: [PATCH] github: bump action dependencies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 15, 2023 at 8:31=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Nov 9, 2023 at 10:22=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

This patch has been merged.
Jim

> > ---
> >  .github/workflows/cifuzz.yml       | 2 +-
> >  .github/workflows/run_tests.yml    | 2 +-
> >  .github/workflows/vm_testsuite.yml | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.ym=
l
> > index 92523db4..c4e592c5 100644
> > --- a/.github/workflows/cifuzz.yml
> > +++ b/.github/workflows/cifuzz.yml
> > @@ -33,7 +33,7 @@ jobs:
> >            report-unreproducible-crashes: true
> >            sanitizer: ${{ matrix.sanitizer }}
> >        - name: Upload Crash
> > -        uses: actions/upload-artifact@v1
> > +        uses: actions/upload-artifact@v3
> >          if: failure() && steps.build.outcome =3D=3D 'success'
> >          with:
> >            name: ${{ matrix.sanitizer }}-artifacts
> > diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_te=
sts.yml
> > index 198ba7b6..3bd859a3 100644
> > --- a/.github/workflows/run_tests.yml
> > +++ b/.github/workflows/run_tests.yml
> > @@ -36,7 +36,7 @@ jobs:
> >              python-ruby-version: {python: '3.11', ruby: '3.1', other: =
'sanitizers'}
> >
> >      steps:
> > -    - uses: actions/checkout@v3
> > +    - uses: actions/checkout@v4
> >
> >      - name: Set up Python ${{ matrix.python-ruby-version.python }}
> >        uses: actions/setup-python@v4
> > diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_=
testsuite.yml
> > index 92155da2..b96d58a5 100644
> > --- a/.github/workflows/vm_testsuite.yml
> > +++ b/.github/workflows/vm_testsuite.yml
> > @@ -9,7 +9,7 @@ jobs:
> >      runs-on: macos-12
> >
> >      steps:
> > -    - uses: actions/checkout@v3
> > +    - uses: actions/checkout@v4
> >
> >      - name: Create Vagrant VM
> >        run: |
> > --
> > 2.42.0
> >
