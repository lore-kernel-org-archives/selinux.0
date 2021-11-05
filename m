Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E2C433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23E461053
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhKEPfZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhKEPfZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:35:25 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A0C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:32:45 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id q39-20020a4a962a000000b002b8bb100791so3159187ooi.0
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=67KP7/S3X0f8nx3UO8jHKV6+YsBY75S0Q39eH06Arwg=;
        b=jeJ+6KZ8OUKVuT6KG13NASNlqLl/kYgDJJePhjuZ+MGhfz4aX4Rc4EHUFovxTWudZx
         UiB/fMRZ00UupCDE/LRtgE/CxYTYTD+5HTHwOM1o44pa5XDqNEw/xR/JqavvZcGXHDw7
         PMRb0ieDhYV0AEnHjR678Zf8trMd0swXC8Etvv8K+Mb3FH1HfPRGBsWEWJHsp3v/ri+P
         9tVmKk3FuBEsup6As9nlhGKR6elDfbVqfb0bKsySJnkZNDgfcVHlY4/4OnjjISMHREZT
         FxV3zkBAoaWs1M/RA1MTiN3hhCEm3dG3Kcq7tsDXmyqLllKSal9lw0nYA2tI8kJuUR/Q
         J5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=67KP7/S3X0f8nx3UO8jHKV6+YsBY75S0Q39eH06Arwg=;
        b=1WlzTdMweRpBfYKDkkf+32+/qFS5eFaRbFamndbGQMrgJSWnrAMvw7gHXhatqoSk/R
         TFrydjFAT5cCzYnPInK7BCiSd5ONC71AM44S7j+DJtbcJttZsJrCTTzG6k/RrebZ/hPS
         3u4UHT5R55l8aCzZc9P2Gs3z4ecQNrKk9uNp+KHU5M6jJM+rBXWvQzIvoRXL5PwqM9vK
         8n0vCM1GAawnfJd4CZ3Qgso2+PRsFPSK8VhUYQz7OlyQahifUut+lyzO1vcxyKSr7Vf2
         dAI2U9E0v9kz0TfC9gX8kx6Wz4CxQkXwjQ+wO2FhaEX2IZhg6mkPBELaDyykPj2+cJzH
         b6nQ==
X-Gm-Message-State: AOAM5322O9hcDOKaulZ2tP1AaHKkKvR1zrs260+ulwAFtxJJP/ndNmsX
        zxw9m8DUAa0in23RHy45dJ2++tJWlYCxI9CqQOw=
X-Google-Smtp-Source: ABdhPJxSWldH8JOEXcj0gIUAlT+GGMEDVDU6ehKuv8t/aJE5Mddlc0UUyRY0W6d3C0KkZpw9KGXyrz3bWZc8MpVoP4w=
X-Received: by 2002:a4a:9204:: with SMTP id f4mr9177528ooh.87.1636126365071;
 Fri, 05 Nov 2021 08:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211026115239.267449-1-omosnace@redhat.com> <20211026115239.267449-6-omosnace@redhat.com>
In-Reply-To: <20211026115239.267449-6-omosnace@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 5 Nov 2021 16:32:34 +0100
Message-ID: <CAJ2a_DcRqvoXCJHcJkQ-RWCt7yjWM_FFUrH8nqZKz5F95p_YcQ@mail.gmail.com>
Subject: Re: [PATCH userspace v4 5/8] libselinux: make is_context_customizable()
 thread-safe
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 26 Oct 2021 at 13:52, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Use the __selinux_once() macro to ensure that threads don't race to
> initialize the list of customizable types.
>
> Reported-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  libselinux/src/is_customizable_type.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>

Tested-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Found no further thread sanitizer issues while testing.

> diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_cu=
stomizable_type.c
> index 1b17860c..f83e1e83 100644
> --- a/libselinux/src/is_customizable_type.c
> +++ b/libselinux/src/is_customizable_type.c
> @@ -9,7 +9,10 @@
>  #include "selinux_internal.h"
>  #include "context_internal.h"
>
> -static int get_customizable_type_list(char *** retlist)
> +static char **customizable_list =3D NULL;
> +static pthread_once_t customizable_once =3D PTHREAD_ONCE_INIT;
> +
> +static void customizable_init(void)
>  {
>         FILE *fp;
>         char *buf;
> @@ -18,12 +21,12 @@ static int get_customizable_type_list(char *** retlis=
t)
>
>         fp =3D fopen(selinux_customizable_types_path(), "re");
>         if (!fp)
> -               return -1;
> +               return;
>
>         buf =3D malloc(selinux_page_size);
>         if (!buf) {
>                 fclose(fp);
> -               return -1;
> +               return;
>         }
>         while (fgets_unlocked(buf, selinux_page_size, fp) && ctr < UINT_M=
AX) {
>                 ctr++;
> @@ -54,23 +57,19 @@ static int get_customizable_type_list(char *** retlis=
t)
>         fclose(fp);
>         free(buf);
>         if (!list)
> -               return -1;
> -       *retlist =3D list;
> -       return 0;
> +               return;
> +       customizable_list =3D list;
>  }
>
> -static char **customizable_list =3D NULL;
> -
>  int is_context_customizable(const char * scontext)
>  {
>         int i;
>         const char *type;
>         context_t c;
>
> -       if (!customizable_list) {
> -               if (get_customizable_type_list(&customizable_list) !=3D 0=
)
> -                       return -1;
> -       }
> +       __selinux_once(customizable_once, customizable_init);
> +       if (!customizable_list)
> +               return -1;
>
>         c =3D context_new(scontext);
>         if (!c)
> --
> 2.31.1
>
