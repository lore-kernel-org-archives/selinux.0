Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E62C433FE
	for <selinux@archiver.kernel.org>; Tue, 11 Oct 2022 16:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJKQQj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJKQQh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Oct 2022 12:16:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5209DFE7
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 09:16:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so8452986wmb.0
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOv+uCiFA8V3hj/ORHjN8CDD2js79/sAOa5Buh8EX/8=;
        b=EDD8wEpthWvTYN4WuoUiUcFWZak6i5epqzVe09jtQ4pchST9/kp4mptawoVHFPw4ad
         9a/bbfYpHpiKOuOV78u/EW0cZaJvpNgb++SuzeEih69D0R1j5aHkD0NFMDl13JvcwPfP
         KHSubTWwLP+o1qUDbb0jnDrt/LCo3Z/ZgUyYmwUoXXdJ7wcXARVK3XTkDQHJoPWdlpZ1
         0kGQ0g7auRJZlIPj+LMYusbWR2uPM068k2wIBp3maBt+E8tIXnz3azLoZ3nSWuzklFBQ
         V9m6KYRrYNfDFLfkm6MiqdBJ8okZc3whDck0IfKoMD5Evblu3zRv5db4d88/boeRk7L1
         bxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOv+uCiFA8V3hj/ORHjN8CDD2js79/sAOa5Buh8EX/8=;
        b=V5bvRiTnMfBQ4Q5lz5Z9BTDxpsQT2OIyI0lapkqnwSMo4yGmJo7NAn4Zj5iLBFuNNy
         QnHsSzYITtlIqgAAZkKfytPynf9UCy43oDLh0ClPD9qMBwy41Jf8OdR6cpIHGM9hIYjS
         fiEEaBt9/E0DJIyDIblV5U0GEDzobzgOpVWIKYrQYTCHjKLLjO3nDHviDYoDRnQFcw8p
         /dy8Mz8OX++UbAAcouAh1g4AH8LsYTnAMEzrV8M8j3lzmsIrJzRKitNEPHZBBEBGnXAQ
         jGQdXpAGlG0/JtWfbIEW1UxAcF7/UrIsKxEU1/JZnauvHpWbQhSRLQRDwPckzRpzG52P
         EiFg==
X-Gm-Message-State: ACrzQf27LEBIs7I86iSeECjT2iALoe4Y4fdfjCvD0Q38l/PpaKuCqzfl
        8zv8fXp2ATb7A5osh5YcGPHM8iOOf/8xwJHf3xaJG4fdaRU=
X-Google-Smtp-Source: AMsMyM44de2zaem8ZFXYPEQCM0iAiYp7cEAU3nCZYAEzrnytQN7iF7Tla/61qdo26cEpqSofIb8pqyr2GZBes7LEHkc=
X-Received: by 2002:a05:600c:1695:b0:3c1:26cc:9950 with SMTP id
 k21-20020a05600c169500b003c126cc9950mr20604802wmn.5.1665504995281; Tue, 11
 Oct 2022 09:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220830175455.40660-1-cgzones@googlemail.com>
In-Reply-To: <20220830175455.40660-1-cgzones@googlemail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 11 Oct 2022 18:16:23 +0200
Message-ID: <CAJ2a_DcKj2=ZFgH=wty9h4bvH5CVkpcuAMjSwmhRXZ2w0pmRyw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: support objname in compute_create
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 30 Aug 2022 at 19:55, Christian G=C3=B6ttsche <cgzones@googlemail.c=
om> wrote:
>
> Support passing an optional object name to compute_create for name
> based type transitions.
>

Any comments?

Patchwork:
https://patchwork.kernel.org/project/selinux/patch/20220830175455.40660-1-c=
gzones@googlemail.com/

> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
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
