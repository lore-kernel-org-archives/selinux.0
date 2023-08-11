Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F3C0015E
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 13:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjHKNNT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 09:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjHKNNT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 09:13:19 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C349818B
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 06:13:18 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b962c226ceso31523771fa.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691759597; x=1692364397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcddOlfEvmklhTvT2K3aYB9gVlFLe39F+PL5KUOY7Aw=;
        b=h5BcLrAi8fhcVOWfyo+PvapLrQAvEPejOpoDan3dcOxS6TTj/PJIklo9B1oICPC1sQ
         On3bEUrvezqZ7csGjlRMn9TzQdoTjPxEWjaIjWz3PGDirQSvskiza6mNCOrWUGB09VuN
         mrln3S4/48RDYp2o5P3OMHpcl/25jmNqkiky1sRHZeEyGiZhBgPggcnJiE1YoTFH4I09
         j4b5QkrmmTEgR3K0yHPbgD76l3zqIMO648rPTV5SH5ZJNZIQP2YvLssspOWdqcwinTOn
         hmQCTSmsNN0B08QssxIM7BgqTI4lf7Dtlv6b9UZXOvadO2jQRv/ez5A1AcY+9lC8d3rW
         hXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759597; x=1692364397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcddOlfEvmklhTvT2K3aYB9gVlFLe39F+PL5KUOY7Aw=;
        b=ggMlul1ENl9UezI9TDHdpqs805Ip+fWrCR6I0Cw7AzxlY8c3fWPheFDAa88mzLM5MS
         ACFKh6ZOTwytmqYan4PlsFl3cWm59k7NE8Kvl3nnxEDYJbdHyfZ4QuvybX5muiVahPXu
         Ts4Wtz2l0Fj366oeQ6yyJqDz9M3jcnGMLKkAKlR0/b3RyotfLyq6LieQC9+RV+9c2mVc
         LE6ZRAeVTUZFi0v+G6UTNFrmfOY6t5caD3UaOL5ByTOsqJpDctSwcHGtwnw36LGQ9RMI
         BN10luo026trvo+y++ytTKfo83eUQAP+2bqRXYWAc2jkFN3SzT1RSnvKyuNkK83nSRwe
         flzQ==
X-Gm-Message-State: AOJu0Yy079Ezk5WUUa82dqNkmUySvJXulnA2947DjeXaJhtd4eMQVx0g
        9AwPRzDXr/nOTaL2x3L2hgaYLIPqdk0MJxBHsE2C3cVm
X-Google-Smtp-Source: AGHT+IHzboz6uf4jF0RW+pmn58UtEIjUuAyf334/+IOGWFD9Cshx6Tcw+tVtoki+aBLeAf8clB9NLGUyKXfImrfHoyM=
X-Received: by 2002:a2e:a316:0:b0:2b9:b067:9554 with SMTP id
 l22-20020a2ea316000000b002b9b0679554mr1773335lje.2.1691759596611; Fri, 11 Aug
 2023 06:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230803162326.302824-1-cgzones@googlemail.com> <20230803162326.302824-3-cgzones@googlemail.com>
In-Reply-To: <20230803162326.302824-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Aug 2023 09:13:05 -0400
Message-ID: <CAP+JOzQN9ZfUPr-8-GhwU4wwB0PJ72r1nGJfLXbcLAtic8Wb5w@mail.gmail.com>
Subject: Re: [PATCH 3/4] libselinux: drop obsolete optimization flag
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 3, 2023 at 12:38=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The flag -fipa-pure-const is enabled by default in GCC at -O0 and above.
>
> The flag is not supported by Clang, which might result in issues if a
> compilation database was created via GCC.


Oops. I just realized that your signed-off is missing.
Jim

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
