Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427F5C48BF9
	for <selinux@archiver.kernel.org>; Wed, 15 Nov 2023 13:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbjKONcR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Nov 2023 08:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343937AbjKONcQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Nov 2023 08:32:16 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FA0AC
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 05:32:11 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a0907896so9498823e87.2
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 05:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700055130; x=1700659930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR+rn49eN60wa17+MGmTJN9GwJLuDkvP4Tclug2ku2k=;
        b=Y0csEgSs3E/iov93iQi4KS81bAJ21hmqGLjulULUD9acjf59jdpJa18/zir0Cvyfkb
         Hq9pL94+FkEtUUmDgBxr42fCr1dKWaY4U2sdjsS3THdeWNvrEZ5sunMcbcAxonCqKDrj
         gQUiej6ox6mMhM6WZUevGLnhTpMu4Ot1DIGR80zcRQEryuPf15byK4PHCILeOK6dzTIv
         N/AOEie4euGTdPAuL+2M6ddGUlx6wq90I+oeQLEf2khyFlp5X3eDkY6Gh69Y8eYLP+hI
         sPr+gYPKdx1bwhZ2CSoUNK3n7GuVn9IoUS3e30kSejrV1Dj9ESMLsqqY+Yn2Xv/u9NuN
         0f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700055130; x=1700659930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR+rn49eN60wa17+MGmTJN9GwJLuDkvP4Tclug2ku2k=;
        b=Ckvq6sK/PkWsfUd8dLhzQe3s5aFb5Yv06t+mWd2jTtK89UcBWlN2yxaMk9lf3uadZl
         du8abe6+MHvvd2+UHgOBzOdmLZ2rr3i8WJvCpcJs9fIOjVzQUxMq6vaeHIJiskDxI8jA
         FHo2o6FYrlSWth+N7IxSc8wwl9v8EHwhaSPAEbzjkIqqVlOHOSORydErif4brkn5TANk
         Pa6YQw49HmuH8uhvHXFEaA+NGsk15oI06/j4phBiFSoKv9XvssSbW2mZgLF4orD1gWRK
         QNLZuHNJPYeO3OVd34wbDSAQH3pdKb8yZzGvaQ8H35S/ktRt+Mrd5xFtyV1Fb0BhoEjw
         jKIA==
X-Gm-Message-State: AOJu0YzNQ9gvQYTP9ya/N+NoOHADR2PxgNllwaCYhHG3ay5zwpVB7hCL
        8B92p0Mp3VbmtqbAJrmsMyDExqEYz9AKC5xvAQA=
X-Google-Smtp-Source: AGHT+IFSRQ1Czv3s+fzQ1bHuBxplfIWWVShmMk9Bz33IpAtDEpk0E5m4R6/iTao6VfQ7FemxNE8QQJC5lUzo8oI2NaI=
X-Received: by 2002:a05:6512:360f:b0:509:5d4b:742f with SMTP id
 f15-20020a056512360f00b005095d4b742fmr7805732lfs.20.1700055129399; Wed, 15
 Nov 2023 05:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20231109152150.691053-1-cgzones@googlemail.com>
In-Reply-To: <20231109152150.691053-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 15 Nov 2023 08:31:57 -0500
Message-ID: <CAP+JOzSb_gukgC9qt35V7O-tSHJkeUaUmJVaxk9Wu9QvSUaAdw@mail.gmail.com>
Subject: Re: [PATCH] github: bump action dependencies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 9, 2023 at 10:22=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  .github/workflows/cifuzz.yml       | 2 +-
>  .github/workflows/run_tests.yml    | 2 +-
>  .github/workflows/vm_testsuite.yml | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.yml
> index 92523db4..c4e592c5 100644
> --- a/.github/workflows/cifuzz.yml
> +++ b/.github/workflows/cifuzz.yml
> @@ -33,7 +33,7 @@ jobs:
>            report-unreproducible-crashes: true
>            sanitizer: ${{ matrix.sanitizer }}
>        - name: Upload Crash
> -        uses: actions/upload-artifact@v1
> +        uses: actions/upload-artifact@v3
>          if: failure() && steps.build.outcome =3D=3D 'success'
>          with:
>            name: ${{ matrix.sanitizer }}-artifacts
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_test=
s.yml
> index 198ba7b6..3bd859a3 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -36,7 +36,7 @@ jobs:
>              python-ruby-version: {python: '3.11', ruby: '3.1', other: 's=
anitizers'}
>
>      steps:
> -    - uses: actions/checkout@v3
> +    - uses: actions/checkout@v4
>
>      - name: Set up Python ${{ matrix.python-ruby-version.python }}
>        uses: actions/setup-python@v4
> diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_te=
stsuite.yml
> index 92155da2..b96d58a5 100644
> --- a/.github/workflows/vm_testsuite.yml
> +++ b/.github/workflows/vm_testsuite.yml
> @@ -9,7 +9,7 @@ jobs:
>      runs-on: macos-12
>
>      steps:
> -    - uses: actions/checkout@v3
> +    - uses: actions/checkout@v4
>
>      - name: Create Vagrant VM
>        run: |
> --
> 2.42.0
>
