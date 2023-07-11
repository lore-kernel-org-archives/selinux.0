Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0FEEB64DC
	for <selinux@archiver.kernel.org>; Tue, 11 Jul 2023 19:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGKTQp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jul 2023 15:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKTQo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jul 2023 15:16:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC9EA
        for <selinux@vger.kernel.org>; Tue, 11 Jul 2023 12:16:43 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b698937f85so100137911fa.2
        for <selinux@vger.kernel.org>; Tue, 11 Jul 2023 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689103002; x=1691695002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHuVOtah+w4U9ydZvyKA2v6i4l++ZavKo/qHS2WhNTY=;
        b=b90BZEwzJwugq/qw4zp8z4/nSk/LxJJlpS8jYGuNaq5E7MyEO9kPobOFtwOi9o3vYq
         jrj8WbeLTjakni0Vg+Cb4JP10n8mpfucWoJjZFXd6Wr3AQBKZaGhqP8dI26WRwBaMqTP
         E7mc5j0jg03vws5ysI0KN+XuGE6iNYtRbVmilQhu/L+unk67NDXLyGuBvLrDW/ISUc6M
         2JdvGSSpvZqX10jeN7jijcu+tfs/CPo/jY7WRVxEbpaLHFY7wC8tHqPWYxOnBM8KzNZx
         n8CUspqSe3aUAcDz7HM7+uUCiJNREeaok2xsITnSDrAzZRDTt3bDHAZo8Qfyn+G6wjas
         ssBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689103002; x=1691695002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHuVOtah+w4U9ydZvyKA2v6i4l++ZavKo/qHS2WhNTY=;
        b=adrs2A8YQFv3GT3VGBEJi7d4pv0qi3xBz/IcWZpo8PRu3ndnUoJP/WjUDsumTJl0wq
         7VRf3udE0Z0e7G/eq+cr8SWkj2Ta4jUudtMz17uKgfATWpRspC1dCHU1IzfchJaaOK2X
         XLfrPiUfJ/mTLIuYWGJjhXsiR+BuHxJMyQyEDQg5Vgvp7cRbI6RT3po5PXhA4RX+cWbs
         n9rIY5A7AOX/40iy5qF+sXVTVbUT0ilQryUinYOvZbhqxwmoT0Fjn5o15ch9KQj2Xa1X
         kDj6IqICLvMdUDyF1orJAj6g52MA8Rjr5oN1g2qfLZO+VccW619Hw+H+7HQEMVoBytuw
         roeg==
X-Gm-Message-State: ABy/qLbbfMuGAJxk2jVdXLKuyEmiv7wrZ1ZvDRQiGKbS+sW8BQ//KnMU
        wkMLlXDpNa7VTTGeepsYIkYGzSlPMFfoD/eLlY1bxe4jVYs=
X-Google-Smtp-Source: APBJJlGjhbwwgBNia1eVGIlXuEko/BdTa0WiAtZRHu9d3rSeHtTAjJGStK5/b9e7bELro65o7CqNMqmlh10Re+ishQQ=
X-Received: by 2002:a2e:b0ca:0:b0:2b6:e105:6174 with SMTP id
 g10-20020a2eb0ca000000b002b6e1056174mr13733280ljl.47.1689103001616; Tue, 11
 Jul 2023 12:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230706135718.44908-1-cgzones@googlemail.com>
In-Reply-To: <20230706135718.44908-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 11 Jul 2023 15:16:30 -0400
Message-ID: <CAP+JOzThojv3f2ScWr4v7-6oBDidzXqB3fHWA4OufUjRi9rt5g@mail.gmail.com>
Subject: Re: [PATCH] libsepol: check for overflow in put_entry()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 10:03=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> put_entry() is used during writing binary policies.  Avoid short writes
> due to an overflow.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/services.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 062510ab..07ae051b 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1708,7 +1708,10 @@ int next_entry(void *buf, struct policy_file *fp, =
size_t bytes)
>  size_t put_entry(const void *ptr, size_t size, size_t n,
>                         struct policy_file *fp)
>  {
> -       size_t bytes =3D size * n;
> +       size_t bytes;
> +
> +       if (__builtin_mul_overflow(size, n, &bytes))
> +               return 0;
>
>         switch (fp->type) {
>         case PF_USE_STDIO:
> --
> 2.40.1
>
