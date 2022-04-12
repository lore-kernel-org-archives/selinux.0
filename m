Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76142C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Apr 2022 13:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiDLNP6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355013AbiDLNOv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Apr 2022 09:14:51 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6949E5FFF
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 06:04:09 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-d6ca46da48so20623149fac.12
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 06:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dNd1p9vO7NkPxEjplBrs9WrRhErq1k0o3F9KSSCuDfs=;
        b=WKcYkoZkfnkCqNRvgdQztIB11G3CJC7dQFqvGFlsq3TNz6/2GOB/ycUau0TIAV5anH
         vcsp2e9+ZTAEKbCRtw2F9Mf7NmKw5mK97eFHVa18v5ZZsL3tn3hvfADTCM6+vP2DEJ+U
         ZQvwIq8+rC8H26r1/S/FgoRdnXW+VOPf3oRWSMNL9B0FgWGCtuqvLkTiR7smPs7BWhjj
         Ny4EwmXM6zJDYzOoBTPJuweQw3mIu1AGUUlSB4hLfAwO6NpqXVicvjMdgpiUauJlP717
         CUXhrKlqHl0a0bLBKCKCkuuukgFimTTZv8cqnrIOyBVoY7vvR1fSK4FhDQLg/a/7MC/g
         q4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dNd1p9vO7NkPxEjplBrs9WrRhErq1k0o3F9KSSCuDfs=;
        b=QB5/VSbpDPtma/XXSNDr1YNalLJ6bpxJQILGLC6/mmNStrGzqvq3URUZLoVFe2NtRI
         kIsB0B+JowBGtZsjUuq2cAs3RvzDSCKLiwGJKn62lI/BpHqT4yl9amcD4uopDw59Jb3G
         SgaGYZdmfgyRWuZtgLJlfTPhtB6HKUfgndFKRi59viMjPWctAb3OQCUTQcLhAppP+P8W
         PsXyIr1DMWa2VZzNugn4RQRv98YdEvNl9D6u47mSpJnf/dolA8V6yzIrvASZGxQSdcYM
         JhT1IZbidzSGJ/EngBBuQ9yaFaGgTVglH0aUyGGkvsVKH40squS0qNUbrNFMWaZYVQ4v
         fgTw==
X-Gm-Message-State: AOAM533u1KDYZXinCh/mxFd9tugcmbUhJBKP8vcpCCNdJmnHN+A7HJ30
        8W8zbiIMG/DsDx07mRAu397NYg3h480fAQWbbZU16BzH42g=
X-Google-Smtp-Source: ABdhPJzvUkU5FyDY7bpdb0IPS1++hTGWsfKtlMLGzsuUGEZeTKZ9amvRBmkZ7oiE5NcrL8krHDPh88tNxy58dtNvkZ8=
X-Received: by 2002:a05:6870:d68e:b0:e2:861:8b15 with SMTP id
 z14-20020a056870d68e00b000e208618b15mr2017947oap.156.1649768648404; Tue, 12
 Apr 2022 06:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220408131054.7957-1-cgzones@googlemail.com>
In-Reply-To: <20220408131054.7957-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Apr 2022 09:03:56 -0400
Message-ID: <CAP+JOzRBK=rEb5Kfa1DFOMwS24D5fuLTB7NXFy=7QBj5BqmKcw@mail.gmail.com>
Subject: Re: [PATCH 1/5] libsepol/cil: declare file local function pointer static
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 8, 2022 at 9:37 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
>     ../cil/src/cil_log.c:45:8: warning: no previous extern declaration fo=
r non-static variable 'cil_log_handler' [-Wmissing-variable-declarations]
>     void (*cil_log_handler)(int lvl, const char *msg) =3D &cil_default_lo=
g_handler;
>            ^
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these 5 patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_log.c b/libsepol/cil/src/cil_log.c
> index e45c58fc..f4c6e415 100644
> --- a/libsepol/cil/src/cil_log.c
> +++ b/libsepol/cil/src/cil_log.c
> @@ -42,7 +42,7 @@ static void cil_default_log_handler(__attribute__((unus=
ed)) int lvl, const char
>         fprintf(stderr, "%s", msg);
>  }
>
> -void (*cil_log_handler)(int lvl, const char *msg) =3D &cil_default_log_h=
andler;
> +static void (*cil_log_handler)(int lvl, const char *msg) =3D &cil_defaul=
t_log_handler;
>
>  void cil_set_log_handler(void (*handler)(int lvl, const char *msg))
>  {
> --
> 2.35.1
>
