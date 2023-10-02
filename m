Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994D5E784B0
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 17:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbjJBRPJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 13:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbjJBRPI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 13:15:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F62AD
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 10:15:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c124adf469so262168001fa.0
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696266902; x=1696871702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg3lx2sUVPOpsVOqy60VAs1QLPHprXXg3C2sqtKGneA=;
        b=AUgT3298H4dJpspL1VAzjCFXYD4TO99U3v4bOW3zokiNGHG+CrRM2IfNMHLW/NmLMB
         SLyGEHZKZRDNJYg9EjTNrG19V0cgOI1WXccHqVg+PgM9tZeSPbjjtEiZxBdgNJo8oSwY
         XRhMXKKRtQUXhTBhnQwJ3d7yICskIP71/sfLn8K4Lq2l8P3w7fgJI/POiv3A4gqiRWOS
         ZKKruMUB5ggbtAwZlqvGkgqDLMufV3szF9wMPIfTuueR+ZGP7UpeD4SWg1xlCo2VsUsj
         LR0yl6HgiLgx/0PGQvvxEBokfCtpKVcFF7coVb9WC3JKgIDsjfNvPfWx02zIhDUrICzs
         9nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266902; x=1696871702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eg3lx2sUVPOpsVOqy60VAs1QLPHprXXg3C2sqtKGneA=;
        b=h9FataG+Pxtce3DtrLHdmppHiX04JcbaCEi6RKSsZ508I1kVfe3+4QjmuMeFBHxtbX
         Aa9o4U3oSdzRYknyOLr1J4w+4axQSA8WneAYalNqBbm/8SBGHZbgwh3y3IUHs90iYHOz
         MrpT0C93gbVKfG9Sn2hKBkFxABAjDbHDiR6n0OBVtNyWQjh06/2EV1VDqMrAmZj+Q49S
         FzIZb577stbDM1kbB6XAVjuG8/AksU93fo2evFrnkVvBu47ZjGSMo5MepR9zn9x/az8h
         caGi1R51mhXT1CUozejDkaA8svdvNK/CNcNC+jW5E8fgZvrOqJqjFg0zzaSLwMYW/7wu
         jV6w==
X-Gm-Message-State: AOJu0Yyf50UEXzM1eDTY6ylfMVq1CvLed4jT8wyzGEGqen7YnfuOM6EN
        woPuaacNeWDSGm/s2KOWZs8e1V8Oa+dYQlJG1RZKXDc4Kh4=
X-Google-Smtp-Source: AGHT+IFKtIMd+WU73RINf0BQ+rZsmsErvFkFYznXuo5qIE/e6OU7Wiww0WQa8xfaTqGMW/zz1BRkUEkAiNgn9oH+YAc=
X-Received: by 2002:ac2:434c:0:b0:4fe:94a1:da84 with SMTP id
 o12-20020ac2434c000000b004fe94a1da84mr10185812lfl.5.1696266902398; Mon, 02
 Oct 2023 10:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-5-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-5-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Oct 2023 13:14:51 -0400
Message-ID: <CAP+JOzS_2HoqWcH1kcrz=6=AxO7-SrxgKGcVk5917KWumQE+8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/27] libselinux: drop unnecessary warning overrides
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Drop overrides of warning flags which are not triggered by any code.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index b1620113..20d79312 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -83,11 +83,10 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat=
-security -Winit-self -Wmissi
>            -Wdeprecated-declarations -Wdiv-by-zero -Wdouble-promotion -We=
ndif-labels -Wextra \
>            -Wformat-extra-args -Wformat-zero-length -Wformat=3D2 -Wmultic=
har \
>            -Woverflow -Wpointer-to-int-cast -Wpragmas \
> -          -Wno-missing-field-initializers -Wno-sign-compare \
> -          -Wno-format-nonliteral -Wframe-larger-than=3D$(MAX_STACK_SIZE)=
 \
> +          -Wframe-larger-than=3D$(MAX_STACK_SIZE) \
>            -fstack-protector-all --param=3Dssp-buffer-size=3D4 -fexceptio=
ns \
>            -fasynchronous-unwind-tables -fdiagnostics-show-option \
> -          -Werror -Wno-aggregate-return -Wno-redundant-decls \
> +          -Werror -Wno-aggregate-return \
>            $(EXTRA_CFLAGS)
>
>  LD_SONAME_FLAGS=3D-soname,$(LIBSO),--version-script=3Dlibselinux.map,-z,=
defs,-z,relro
> --
> 2.40.1
>
