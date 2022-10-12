Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0024AC433FE
	for <selinux@archiver.kernel.org>; Wed, 12 Oct 2022 15:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJLPj0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Oct 2022 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJLPjZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Oct 2022 11:39:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804D7D9978
        for <selinux@vger.kernel.org>; Wed, 12 Oct 2022 08:39:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 70so15572313pjo.4
        for <selinux@vger.kernel.org>; Wed, 12 Oct 2022 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dsueB/dMOnbFqHpOUuMu8wJmabTScgHkEHlP2QHWX8=;
        b=AFeylghzz7KTCSgYvO429ZptrqOGZbMbPHrFn1pi7tHLiLPn+YENbzcpaWhIMliCnF
         5T0F0AAt4d/VgXWtAGm3OY7p44CLEKLakmJpQDXV6C/1uidv3Bzswz60QNIkTjJga1Os
         ex+P1fZpYp8DYhkaiK94hIp8bIwk+Ydvc80d6IW5A5CYkFDq7GiZuHJuG39ELxRQLNp1
         CSS7Gxg2MFQ3Wnm0RzmNL894DG7mY62OgSy/oHbaUmMGUFCngG4tgFEn3rRVmbpwcS80
         R4X2c+dQX9Pib7q+jg0SmaM3PuumMqsAmfw1xMduStA5UXRRnSSpxvwDNHeO+mWY+48H
         Ak9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dsueB/dMOnbFqHpOUuMu8wJmabTScgHkEHlP2QHWX8=;
        b=5FXkcjMibb/p4nJAGI4C1kpXR1rzWoYKo930a9rAedkG0pYIP/HTAkHQdVoADmsttv
         SluWpp2VupOF8ngWmwZAVxbh+HAwGA/A2ozwCTzcSrRhkz3+yujMKWtJ1R4uYMwoBtQf
         EYM0S5hoWBjra+HjpCIoeSbprXsA+JREQsSvZNwRzm6zNyovNndMLbstBQnVqKqXQWXx
         lg40IXhr59FCL2XrgA9THrFL+IWaPIFeeIjzx3iT+qEBAGCKXyQezaD3SeJtMfsC8/J9
         MSiLIE3H5Z3W/8knWbYHxBX8EzSHX9QuNuBedOJ0MPlCjjjCEQ3fKv+kHaN0aeqw78LR
         6aNQ==
X-Gm-Message-State: ACrzQf1KAMQYcigoSbXPqdgSFJKbOfIPdb4N8gljZ4uFlm2M1ERdBeaO
        xG6vW7u9hpYd873wYqRZJblObik/7km3mVnjxiIIholahl8=
X-Google-Smtp-Source: AMsMyM5P18JujaL2tbURGE00D0dsu4B/u5GpK67K6dLMW2RcVB2Z3mF9iD63AVjg68Y3fOJH9E1nO5PR3EJM4+HbLB8=
X-Received: by 2002:a17:902:d4c6:b0:180:9675:3eac with SMTP id
 o6-20020a170902d4c600b0018096753eacmr25339313plg.77.1665589163968; Wed, 12
 Oct 2022 08:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220830175455.40660-1-cgzones@googlemail.com>
In-Reply-To: <20220830175455.40660-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 12 Oct 2022 11:39:13 -0400
Message-ID: <CAP+JOzTxAjJ0SKL-eDxn0GmY0ZJTfqa9BpdorfTvjXajK68ibQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: support objname in compute_create
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 30, 2022 at 2:04 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Support passing an optional object name to compute_create for name
> based type transitions.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/compute_create.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compute=
_create.c
> index c6481f4b..5401fe96 100644
> --- a/libselinux/utils/compute_create.c
> +++ b/libselinux/utils/compute_create.c
> @@ -10,10 +10,11 @@ int main(int argc, char **argv)
>  {
>         char *buf;
>         security_class_t tclass;
> +       const char *objname;
>         int ret;
>
> -       if (argc !=3D 4) {
> -               fprintf(stderr, "usage:  %s scontext tcontext tclass\n",
> +       if (argc !=3D 4 && argc !=3D 5) {
> +               fprintf(stderr, "usage:  %s scontext tcontext tclass [obj=
name]\n",
>                         argv[0]);
>                 exit(1);
>         }
> @@ -34,7 +35,9 @@ int main(int argc, char **argv)
>                 exit(2);
>         }
>
> -       ret =3D security_compute_create(argv[1], argv[2], tclass, &buf);
> +       objname =3D (argc =3D=3D 5) ? argv[4] : NULL;
> +
> +       ret =3D security_compute_create_name(argv[1], argv[2], tclass, ob=
jname, &buf);
>         if (ret < 0) {
>                 fprintf(stderr, "%s:  security_compute_create failed:  %s=
\n",
>                         argv[0], strerror(errno));
> --
> 2.37.2
>
