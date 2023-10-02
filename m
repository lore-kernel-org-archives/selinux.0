Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A925E784B0
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 17:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbjJBRNn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 13:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJBRNn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 13:13:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46357AD
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 10:13:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-504a7f9204eso7307924e87.3
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696266818; x=1696871618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll5WjUdAOSwF1306vF1qyxK/rdi3UAvivvM9Vc0LuJc=;
        b=NPv9IQ5Bm8kkBoDDqKN056M8GwT/sfGIZwEvIcOFPKDzzpKhyc+fuoX6XbApojZ3fH
         QQq3ioC50/+e36Ka+OMOMenFG/SXbh+LIlOmadFevqFGhmnxebrSkA34TgM/Bku6qPD1
         4kv5Oi/lRQF7l0RZs3OIqGTOjrsqdOQwIbIx+zZbRMDhGeEzJE7Oj5vkxVQiaOftRWAR
         Z8f6GXbce2sQsNn5qFsbYdeJy5mmxVE9AeclfYqJxTTvdGCeyE9QJ/8eMCFEQ0NgqqHV
         mcgYaUDnUdwOnJemWHjafTwuTs54A0gJ7f853frdrcv07SHDDeeqW/xY6PZfqyPMDFj9
         LyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266818; x=1696871618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll5WjUdAOSwF1306vF1qyxK/rdi3UAvivvM9Vc0LuJc=;
        b=bI2uSaoNLocVJ5ZrK4yeV4UwAor9EBxt5AqST6RDVr7SBgujMdLDCOGnGvlizklnRl
         zAvDOm5VNM2APoSi3h1HI2+X86gO5NVthFPHR7Zj79DjEQKH9fDpnOIe6re19D5PgDZW
         X8k6FtfEOxtdjFNAyysW4wuQ8NBoX9YbLycnAwbmi99XyYdK1SohmrCc71sVAIeN648e
         BMHAkJuZeNa2GsKWOlGy1PFzREVnHvlpznj5lqkMuuDH2MB21OxvkftyshrzaPqAg62R
         D2p1c6ZKetO0kOBDqKBWxMURsSHnBeDMeHGYLN/R0RMrEOipx3w9SZ7I/4NsTBHjjUG+
         js7Q==
X-Gm-Message-State: AOJu0Yw1VrZVWi9fIx67Q+yuTr4fkywoN03B5tPgT/F04QQYxp06wMzK
        H+as6IBd9Yv8+C00GvH0qKvZu1Xmk2ft8kzwOoGHGPF0ctY=
X-Google-Smtp-Source: AGHT+IFbn4Bs7/fnRpqOJTZvlhQbPxCdwadidgwfOTm0wnnLJAlBbBW5CHDuahIYlpqSDSOLiM5LalIJr50pERqkwi0=
X-Received: by 2002:a05:6512:4011:b0:500:9d6c:913e with SMTP id
 br17-20020a056512401100b005009d6c913emr11795014lfb.52.1696266818232; Mon, 02
 Oct 2023 10:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-2-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Oct 2023 13:13:26 -0400
Message-ID: <CAP+JOzTD6muhUFDoaMOP=bqbL76pPq_doWvZekW_v7QJeWEiNw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/27] libselinux/utils: update selabel_partial_match
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
> Print usage information and exit if required path option is not given
> or superfluous arguments are given.
>
> Constify read-only variables assigned command line arguments.
>
> Simplify bool evaluation.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/selabel_partial_match.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/utils/=
selabel_partial_match.c
> index 7bbd5777..0df2627a 100644
> --- a/libselinux/utils/selabel_partial_match.c
> +++ b/libselinux/utils/selabel_partial_match.c
> @@ -28,7 +28,7 @@ int main(int argc, char **argv)
>  {
>         int opt;
>         bool partial_match;
> -       char *validate =3D NULL, *path =3D NULL, *file =3D NULL;
> +       const char *validate =3D NULL, *path =3D NULL, *file =3D NULL;
>
>         struct selabel_handle *hnd;
>         struct selinux_opt selabel_option[] =3D {
> @@ -55,6 +55,9 @@ int main(int argc, char **argv)
>                 }
>         }
>
> +       if (!path || optind !=3D argc)
> +               usage(argv[0]);
> +
>         selabel_option[0].value =3D file;
>         selabel_option[1].value =3D validate;
>
> @@ -69,7 +72,7 @@ int main(int argc, char **argv)
>         partial_match =3D selabel_partial_match(hnd, path);
>
>         printf("Match or Partial match: %s\n",
> -                   partial_match =3D=3D 1 ? "TRUE" : "FALSE");
> +                   partial_match ? "TRUE" : "FALSE");
>
>         selabel_close(hnd);
>         return partial_match;
> --
> 2.40.1
>
