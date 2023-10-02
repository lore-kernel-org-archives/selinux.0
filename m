Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106F9E784AB
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 17:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbjJBROi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 13:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbjJBROh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 13:14:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D083C4
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 10:14:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5041cc983f9so25577741e87.3
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696266871; x=1696871671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQunpasKycudthciWUUdabdShyfKCv0rGOglnSvwVac=;
        b=HcElIYw2lebTbeaqByS1nTTH/j57uwXVyeIeBjCwKR3+Am4ycyowZepRXindJdaO7R
         bhvtJg8M0GETZlBpWUOPzOcH2CgHko2V83Ie/x2u8/cNo4ZvEyY1RNFITNwGSPD1dFCo
         KG1NNZMuVnpf/ehwKly7eP2NPeatBOgfJP4obK3tQe4Taj8GiU8YexiLBkylAZxMh6GI
         V3mQ0Ehl8eG5AaSePidZ8bzMHC7Wwwb8a5wCD/hskIq+mNHPCav+GTwpG/hFi4Ui3czL
         lOqo/7uMQYUCKv3rG+c3xUp2326RTfu5IogkUeh2rgprH6HPQejfI3xqYTOfVZ8K56Dt
         CY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266871; x=1696871671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQunpasKycudthciWUUdabdShyfKCv0rGOglnSvwVac=;
        b=OoGrz1vddtgxYm6jomce0aFaL0rJn8qTLJ93gY+b8d3bpP0B4tphErw/Z72EsbisFM
         q2D4HiPndNZbbqMIw6gAL0MlrAZ6N5OxfGaWKhJtPUYRDW95W9Vynf1oUhqYIApPNon2
         fxm9pcK602nEMO9PPP50zopk45hdwfd9V13RCh2IteFbKdrRG3aFam6FV4uYq+5ygVmm
         td0zc++oTGYxmSXnP2L671rw2sqGLaxQyIEFWwMjyl7oQe1v3B050jlFMHDs695Ez4bV
         +EGgPDAN+Yd12QayhGLpoAMoS8nUkJCQek8kZl0Dm5EPm0LiWinMQOvCD1uN6gXJJ8P1
         iLkw==
X-Gm-Message-State: AOJu0Yx9jImD+xwSseHN/nfoDdRYrE4HlHeDCmU8fCUcv4qU56hhgrfQ
        IxO+NKqLnU1Xn5bHy0HobJRHiqclYYR52fXmidDZ9Q42JBY=
X-Google-Smtp-Source: AGHT+IEy342k3ypRZt6UI/fL1jZKyixk43x9JDqCr9z8XAnDEXFNFJaPi0hA8r5CRlO7gSfghVJiFTN+WmxnPp84/sU=
X-Received: by 2002:a05:6512:1189:b0:502:a46e:257a with SMTP id
 g9-20020a056512118900b00502a46e257amr10304596lfr.56.1696266870538; Mon, 02
 Oct 2023 10:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-4-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-4-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Oct 2023 13:14:19 -0400
Message-ID: <CAP+JOzQvz1C6JGuzU4TgKvbsieRuPV6W4NEZbgLCj4XVQ33vrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/27] libselinux: drop obsolete optimization flag
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The flag -fipa-pure-const is enabled by default in GCC at -O0 and above.
>
> The flag is not supported by Clang, which might result in issues if a
> compilation database was created via GCC.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2: add missing signed-off
> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index f9a1e5f5..b1620113 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -61,7 +61,7 @@ SRCS=3D $(filter-out $(GENERATED) audit2why.c, $(sort $=
(wildcard *.c)))
>  MAX_STACK_SIZE=3D32768
>
>  ifeq ($(COMPILER), gcc)
> -EXTRA_CFLAGS =3D -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat =
-Wsync-nand \
> +EXTRA_CFLAGS =3D -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
>         -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=3Dnf=
c -Wsuggest-attribute=3Dconst \
>         -Wsuggest-attribute=3Dnoreturn -Wsuggest-attribute=3Dpure -Wtramp=
olines -Wjump-misses-init \
>         -Wno-suggest-attribute=3Dpure -Wno-suggest-attribute=3Dconst -U_F=
ORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 \
> --
> 2.40.1
>
