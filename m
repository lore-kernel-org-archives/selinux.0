Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958ABC77B61
	for <selinux@archiver.kernel.org>; Mon, 24 Apr 2023 16:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjDXQ5s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjDXQ5r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Apr 2023 12:57:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA48B94
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 09:57:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso4005285b3a.3
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355459; x=1684947459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOsq+B+UCqVFU7IH9U837KV1faOwoMPEI8mb3//Nu/k=;
        b=Ll4aoClZ5LMnz7UrFLzftBFGymAZUdh1IIFjhyo0GtzXThohL7zr2V1EuxY/Eu3oNp
         yiAwcCG1bYlnWxiq/tKNQzHZGN/swUEoW/1Lt0ghqErz5kQ4E09nFsJ2+9xmb+k6tgCd
         d0IcnOEvmi+MIfNqWKWefAooAeSnTaryhssS67juWOv3Mg75wN4dajSquAdokonuuO68
         fKgQYcyXuaD8OqTWjtTfOdj/OaJWcvH2ssykuo16CkByjSu7Zli0gIbTkv0c+sg30yCS
         MXkVXarmd9CrgKJdqS/It+ZKLWeOOdK90AcNkGbVJKHUMe+nTNkAbZ34UqL/x9ZOfBn6
         Kk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355459; x=1684947459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOsq+B+UCqVFU7IH9U837KV1faOwoMPEI8mb3//Nu/k=;
        b=JRLgzPiFTqeUzNpCsl8wIA45tM6wTGkM3U4H7V2taL8Z1w9G9jOorYM6Xj3MApYR0u
         ZXY52TgFy/dHX72uz8WDAuxEXEerQMXBvYrWbjXF6ErU4yhhYRRu2mHzJEi+bE5gj2k7
         c0DT4k1NWnZdSXnAVeRQxa9iD4ZMoXtrBexg/2Nsaku/AROsNIhI0sj9qNI6H2w8E2WZ
         7zAxVXJAni/Zq75MISmxSNzoZmWDRxvs999ov2H3BR5s6Yu4eWO+tnBRa9znSMK18O3T
         kg779P2X1HvVV+87CWvTxhKiUZBnTeGuUJTYPvJQ8BpBuLQza4me3MKWEznt0qL83mJR
         Iwuw==
X-Gm-Message-State: AAQBX9cphTFp7ENU/BLlkR5ydC6scYnr/azNBECR5uA18LxWlxRUNYY2
        aidkoeY+EhfknuKX7CDlAymYASQTERB5HTUoeDQm50GY
X-Google-Smtp-Source: AKy350b3Jwk7oVQ/bwj9TPQ73gpdyzbiABlbc09JU/ywMOoR14AVCm+kSB9xVcUft8YEJ2YCeGNjWe6pAq1BieZrkyY=
X-Received: by 2002:a05:6a20:158d:b0:ee:bac2:c6e0 with SMTP id
 h13-20020a056a20158d00b000eebac2c6e0mr19388649pzj.44.1682355458706; Mon, 24
 Apr 2023 09:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230420153556.32115-1-cgzones@googlemail.com>
 <CAEjxPJ769sxp0CieV42iGEYYcnEAj51DvFu8oD+y+JH_EhXUgg@mail.gmail.com> <CAP+JOzTUX71FvYKL-1BoTtAxLxyz8xknSG4S-V7NeiSjgL+iSw@mail.gmail.com>
In-Reply-To: <CAP+JOzTUX71FvYKL-1BoTtAxLxyz8xknSG4S-V7NeiSjgL+iSw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Apr 2023 12:57:27 -0400
Message-ID: <CAEjxPJ7_WP_FejMCmfGR10_VHaEKDOL3oceia6DrovZRAitfgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] libsepol: rename struct member
To:     James Carter <jwcart2@gmail.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 24, 2023 at 12:38=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, Apr 21, 2023 at 11:27=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Apr 20, 2023 at 11:41=E2=80=AFAM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Avoid using the identifier `bool` to improve support with future C
> > > standards.  C23 is about to make `bool` a predefined macro (see N2654=
).
> > >
> > > Since the type `cond_expr_t` is part of the public API it will break
> > > client applications.  A quick search of the code in Debian shows only
> > > usages in checkpolicy and setools.
> >
> > NB Header files under the sepol/policydb subdirectory are not part of
> > the libsepol shared library API/ABI and thus changes there are not
> > considered to be API/ABI changes. They should only affect users of the
> > static libsepol and there is no warranty for them.
> >
>
> So should that paragraph be removed or should it say something like:
> "While header files under the sepol/policydb subdirectory are not part
> of the libsepol shared library API/ABI, these changes will break
> setools."?

Is setools using the shared libsepol or the static one?

Also wondering if we have violated the original intent here - I see
that #include's of sepol/policydb/policydb.h have crept into public
API headers in include/sepol/*.h. That was never supposed to happen.
They were only supposed to use the encapsulated sepol/policydb.h that
doesn't expose the internals.

Do we have users of the shared library that are now tied to the
policydb data structures?
