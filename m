Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E65FC77B61
	for <selinux@archiver.kernel.org>; Mon, 24 Apr 2023 17:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjDXRKI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Apr 2023 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjDXRJy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Apr 2023 13:09:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06415B8B
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 10:09:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso6842875a12.3
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682356191; x=1684948191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvnV1kTflacvKA6bNILGtuxdgIFXtb/QOgVWrLOPG9U=;
        b=orbMDVvH7egzUcuNvftW4ZnqOwnQCvZr2Sy9s1NRaJKAjapYz3FnQmOMZNHUHRqdix
         0KmGQfhAtipaTj26irkLnkZCKLMHq2a7XduEkUqMwaP8ncFvcOX5zU/BQiEHmDsH/dE7
         5XcwvpILMdIdUbwyozI+Ork2UuFyTCAA5wXoq9RV/ztKvtxIwIfpUEgJNrMUWhcm4TCw
         6AOMU8vGY/zUzJH9hzAcQmKtuhWD131VQOqfWnrCpNC4DONr3JNpmE67zXgc2pOMuHms
         zthFYTwTmP5Ffuv+cLwnTCvbKBxPWyPY/S3q5G0PgbAD8feaRLLF+K4O6yK34Ntm/BU/
         j43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682356191; x=1684948191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvnV1kTflacvKA6bNILGtuxdgIFXtb/QOgVWrLOPG9U=;
        b=clto7bDxcJPuh7IEHt9nKC6zV1M9rsIHekFf00IshXu0JeJ304TNTlWLBOq/ttv+ec
         KnedS+hKdOh8HPGSsEyt2XFxizLHFcS3mNQYyV0eCLuLvuQ8HHllkVin4PDoiwinyVYW
         W8JhWGowh38ZDaqsgOg5rlzpWfPbbICUsnR6lBdn/JNjr5Ng1Na3Wr/JyuUPdyGF9Bzl
         PLH5th/HQ55RNfOIZowsiQ7FwZl72499JdRdVbBNMT6bUsq6IBdSAiu0ZFVln6Jx7I4A
         yi+OP5p32cCSvSP1Hlk+C+VK/plilHTGfvTR9/JYAN+GiGn0KRimXofPdc0Gam9A2NDy
         VhAg==
X-Gm-Message-State: AAQBX9cXHzx4bzD/9SXsOAvraOqlE2GRqRmETPw4tbhMdb26CiW1semH
        2D8qlNdzHpanphzmYLJiL8MSzx4nLEANagez09A=
X-Google-Smtp-Source: AKy350YDdMo+kg26ZPbJGpM9/gtc1MuF7qYg9mPtQXlJFuDrWg0S0ACaXboNeK3c585444UZC+OfNrwgnGihokxzIqs=
X-Received: by 2002:a50:e604:0:b0:506:e626:2da with SMTP id
 y4-20020a50e604000000b00506e62602damr14921863edm.4.1682356191352; Mon, 24 Apr
 2023 10:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230420153556.32115-1-cgzones@googlemail.com>
 <CAEjxPJ769sxp0CieV42iGEYYcnEAj51DvFu8oD+y+JH_EhXUgg@mail.gmail.com>
 <CAP+JOzTUX71FvYKL-1BoTtAxLxyz8xknSG4S-V7NeiSjgL+iSw@mail.gmail.com> <CAEjxPJ7_WP_FejMCmfGR10_VHaEKDOL3oceia6DrovZRAitfgg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7_WP_FejMCmfGR10_VHaEKDOL3oceia6DrovZRAitfgg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 24 Apr 2023 13:09:40 -0400
Message-ID: <CAP+JOzTDSz2uHaQwcHStq_X5S7BJT4Q7ETeT1KrV5sUdEYwc3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] libsepol: rename struct member
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 24, 2023 at 12:57=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Apr 24, 2023 at 12:38=E2=80=AFPM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > On Fri, Apr 21, 2023 at 11:27=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Apr 20, 2023 at 11:41=E2=80=AFAM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Avoid using the identifier `bool` to improve support with future C
> > > > standards.  C23 is about to make `bool` a predefined macro (see N26=
54).
> > > >
> > > > Since the type `cond_expr_t` is part of the public API it will brea=
k
> > > > client applications.  A quick search of the code in Debian shows on=
ly
> > > > usages in checkpolicy and setools.
> > >
> > > NB Header files under the sepol/policydb subdirectory are not part of
> > > the libsepol shared library API/ABI and thus changes there are not
> > > considered to be API/ABI changes. They should only affect users of th=
e
> > > static libsepol and there is no warranty for them.
> > >
> >
> > So should that paragraph be removed or should it say something like:
> > "While header files under the sepol/policydb subdirectory are not part
> > of the libsepol shared library API/ABI, these changes will break
> > setools."?
>
> Is setools using the shared libsepol or the static one?
>

It is python. I know the policyrep part includes sepol/policydb/conditional=
.h
Jim

> Also wondering if we have violated the original intent here - I see
> that #include's of sepol/policydb/policydb.h have crept into public
> API headers in include/sepol/*.h. That was never supposed to happen.
> They were only supposed to use the encapsulated sepol/policydb.h that
> doesn't expose the internals.
>
> Do we have users of the shared library that are now tied to the
> policydb data structures?

setools was the only thing (that I know of) that broke when we changed
how the filename transitions were stored in the policy.

Jim
