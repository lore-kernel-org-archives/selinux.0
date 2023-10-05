Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217B8E9270C
	for <selinux@archiver.kernel.org>; Thu,  5 Oct 2023 15:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjJEPTn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Oct 2023 11:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJEPSj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Oct 2023 11:18:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B302047
        for <selinux@vger.kernel.org>; Thu,  5 Oct 2023 07:44:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5046bf37daeso1424906e87.1
        for <selinux@vger.kernel.org>; Thu, 05 Oct 2023 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696517093; x=1697121893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdojfNgzT0WD6KuF5gvCoi0/pnIT7M9l0LzKLcdyPgQ=;
        b=TrMNA5DIzhLuEwrLhpmaESPmeK6zE83mD+b7WcSo68DVQkGLgPNV11XyLOpT5+MtrF
         t3f1tSAwTZD2ol1Qijt/nVXo6tNRb89cAmlFa1MqJvNYYQ0Y+8m0yHzu+DatnQFSAUbA
         SfuVJtzdPOrYN3jMqICtqo5uvz3rjD27L5NhkHz6SYM+BwZwe+OXOT5OyI+sRrlD8IXX
         sggIZwJJc6XsNwv9nyrMhzm5I7vjxf5d4Oz1jz9oNcuwxvlQX/AuiGcSp22/J8VMKMK8
         /EryQzj+LXajwQeBiraNKIUFxBUoNDMQS0JRKEmmTTssxDqzG56E/gA8nBCc2BhitT07
         7uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517093; x=1697121893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdojfNgzT0WD6KuF5gvCoi0/pnIT7M9l0LzKLcdyPgQ=;
        b=SgvlMt6yZFL/hv7hSKqh7SoS/Xyh1ynhCr57lRvpkOBh/W9Ty0zqF/FjnEwha1yUiZ
         HW5Ca19XLrvH9kbXognx36j9ia0PkOLcBn+tjIaCLmWWv3CpfHuOnQbTLVPwA3Yn/kdr
         lf5XX/Yl3bSRlp3f0FTY9p10Wdbvv0v2qpJi3HJwxVzKzccX8H3vHvbplg4xu55N4y46
         91XyTGnqb8vG0MhMGo2YbaEnGJEDRiGzMxeh/UuIveSPZraNC2/pv7Dp1G2oFHfxXdUs
         tBb1kjGBlPWcBlVUtAuq0qJ6mB8V+PC7tt61cZr960JiWqTyxbEXRr3g+59+lwH/uy6p
         YjIA==
X-Gm-Message-State: AOJu0YwqYGb0BtPknWH53q2M4c+y1dWh39zKTbjoHtOO9s2jPUql2LHx
        nC1pdBHu+x3d4WQJHXBAHLLSG2a2BpOonMslr38=
X-Google-Smtp-Source: AGHT+IEN9gqufabddci960ekL0bMIB09vwpvVScNVvBHqxDLeUqBdy7UVdw2cHy4uEfnaEQ7mgNk0N6LzbMw0za6v+M=
X-Received: by 2002:a19:5e06:0:b0:504:4165:54c1 with SMTP id
 s6-20020a195e06000000b00504416554c1mr4236990lfb.7.1696517092899; Thu, 05 Oct
 2023 07:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-13-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-13-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 5 Oct 2023 10:44:41 -0400
Message-ID: <CAP+JOzR5_Ac8QFLk+V6XW9YBnqAxg+4rFkzii-sKi7ac74=ETA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/27] libselinux: avoid regex serialization truncations
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
> Check (for the probably impossible) case the serialized data is longer
> than the compiled fcontext format supports.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/regex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 16df6790..88d82fed 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -176,7 +176,7 @@ int regex_writef(struct regex_data *regex, FILE *fp, =
int do_write_precompregex)
>                 /* encode the pattern for serialization */
>                 rc =3D pcre2_serialize_encode((const pcre2_code **)&regex=
->regex,
>                                             1, &bytes, &serialized_size, =
NULL);
> -               if (rc !=3D 1) {
> +               if (rc !=3D 1 || serialized_size >=3D UINT32_MAX) {
>                         rc =3D -1;
>                         goto out;
>                 }
> --
> 2.40.1
>
