Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577D3E77364
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 20:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjJBUhI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 16:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjJBUhH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 16:37:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EBCBF
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 13:37:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50433d8385cso165989e87.0
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696279023; x=1696883823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AS5cMKr+FVRWzOqqj2Qs4Zj1MgjbeLOFHFgHn/f+K4=;
        b=RglV26Rgw5Esu3yS+Ds3JDkcsL5r6uFMF4EgZwRlf6Z+cNW1uq3VIFxWBm3q/4DSnq
         wQbfO8GPI3If5R1xSVQBFHxHwqkGqXFZ9wUDPKTYgX+uEwqMbeyU3PmoqMWhlprhro2B
         vfWa8d2uj0hVBlJYpsDAFJVLiNVMNTF61SgzTEoNGUn4WRusmG53kEZAUfxHW5UJSQ/h
         ZKSo4afgxQIPpCFrHfUY3HmlZI16e+bYPqrefzI6QLMFMwziRtY38ut8bGZhEgQCQZwK
         iFsTKdek4TXxEqN0/vse0WGNf176IwlAvhd+SPfjmpclg97s6o2laEIIIvBja27djNqC
         ISAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696279023; x=1696883823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AS5cMKr+FVRWzOqqj2Qs4Zj1MgjbeLOFHFgHn/f+K4=;
        b=v/xOFg2ePHVgl3PHDSAaPJmgdVC/3vq8RcOxCXVR4+uO21Z/nig9fwbXrGLPhc5Pad
         PeqcHSr5OacithtOPtnrgOuM3D6iXTm9kaJ5N7eR5EUItEXHhlmPUL9uhhe3z+06mekC
         5sHCeghdL8Jj4F7FN08KpbI9v+agb1x8vBvF7UyQzfk2FLqYJenepMIxFl57vCSmUZn3
         +xHuL0+HUiMlEjtQ64noz70WZPW3KRDNNZGSDdwL+Ivb8ccjMs3P0Sp8eljLqPSyqVqh
         vPqoGc59aB/T8j5njiHB6m5KhvFE6D/nNvb/jRBnOLI3U3yVxLMygxFcuAsQfSvWR5HQ
         H/qw==
X-Gm-Message-State: AOJu0Yw2igF55DwfrnHAT3w/2YWclQV263Nayw0jfSjc2X9gZMmj/RyQ
        33f3u2KRLogwNh8/7oizKvS8Gafj/sMzewqp+1exsjB/cpM=
X-Google-Smtp-Source: AGHT+IHY/dKu5Qf/BviVY3sOsje6yCfUHFkzZYU5Vrc7RU169F3ZdU4i3JYKx/AsOsQVxcgrXIM1Nh1ltvr/WFoFAfk=
X-Received: by 2002:a05:6512:3f8:b0:503:1bb0:a658 with SMTP id
 n24-20020a05651203f800b005031bb0a658mr10119525lfq.32.1696279022864; Mon, 02
 Oct 2023 13:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-10-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-10-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Oct 2023 16:36:51 -0400
Message-ID: <CAP+JOzRgAN+rGpchidjvMR=pXdPTzv5nbCvCU_8v-rmGAt7BOg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/27] libselinux: simplify zeroing allocation
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
> Merge malloc(3) plus memset(3) call into calloc(3).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_file.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 5ac23e1f..b9be1c9d 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -716,10 +716,9 @@ static int selabel_subs_init(const char *path, struc=
t selabel_digest *digest,
>                 if (! *dst)
>                         continue;
>
> -               sub =3D malloc(sizeof(*sub));
> +               sub =3D calloc(1, sizeof(*sub));
>                 if (! sub)
>                         goto err;
> -               memset(sub, 0, sizeof(*sub));
>
>                 sub->src =3D strdup(src);
>                 if (! sub->src)
> @@ -1357,10 +1356,9 @@ int selabel_file_init(struct selabel_handle *rec,
>  {
>         struct saved_data *data;
>
> -       data =3D (struct saved_data *)malloc(sizeof(*data));
> +       data =3D (struct saved_data *)calloc(1, sizeof(*data));
>         if (!data)
>                 return -1;
> -       memset(data, 0, sizeof(*data));
>
>         rec->data =3D data;
>         rec->func_close =3D &closef;
> --
> 2.40.1
>
