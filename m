Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23884C433EF
	for <selinux@archiver.kernel.org>; Thu,  7 Jul 2022 17:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiGGRpK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Jul 2022 13:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiGGRpJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Jul 2022 13:45:09 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECB5C956
        for <selinux@vger.kernel.org>; Thu,  7 Jul 2022 10:45:08 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id c123-20020a4a4f81000000b0042fb3929713so95516oob.3
        for <selinux@vger.kernel.org>; Thu, 07 Jul 2022 10:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VZ+xM4ifQEIJj7GEhMxezIl9TnqlWzPV/B9qCXOEfrg=;
        b=pGfutEYyzo4VevXyDEL48eETKv9CvnTsq8dvdCYu2kL+02m0dEnzIT0qeAQoNSOi+1
         0aXWM7MpJSvRsIz+CkJWHQb5gWUd0EJmHVGzvdSE+CsZJYD6MPrESpTpnP3i5dV1esTB
         /Bj+rBK00j6TjGJiJ0aVpiK70XDV8CMnCSHkKYWygCtueLiYxmp90lDKGTTOi4LjkiYA
         p8+6xvfNG0BSKZaHJiboO3LCjAUtt0VFTn8Sf4FcayuBWHaZJ9Sp+Jlia+XtK47AyJCI
         8lCzEUyxqk0jsOh2cI8JmnJu07oAsFRAI02uhzBxUtVWHtZHExDFpQTB1Hd0RR0lmQHa
         f44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VZ+xM4ifQEIJj7GEhMxezIl9TnqlWzPV/B9qCXOEfrg=;
        b=EQK6P9b9ZwlXKnPwVfsxx9hqOnF+pv/Y9NSw1EHl0yJMSBRDewr7qRflrw97nFpYVF
         wZjYKUJKPTmziE919qMx4K95zLSE+aO+eaFJhhz2uk7lCPQJ0CBS1jAmuOuVPI6z1g6w
         UxnZU0b8UoqaqBzJFAecDwFHZyDRuhnPUKq+jCwKL8PcCFMVeabIEpvSUwthJD+HWr1Q
         2/BrU7tcZWpPtF765PPisKQ9UaXW967urNRt+69AU9wX+EJv15Xa35Bf2eo7u7/q/g1p
         i2k7ZG68jPyuUWLD7lOygn9fASLywsCWJW2HVe7Gx7d/gKnywUPxkXQaeEVbB5gfB/Ee
         y+zQ==
X-Gm-Message-State: AJIora96YkPH9naPFU+VOQasv1uMjUxrqTb5xAWNaK7lJStwm2mALK8F
        P8qg9/tHj63rIwDwF5WyoK61aCq9BUyIZWbFIqA2wSKVM5k=
X-Google-Smtp-Source: AGRyM1vsjENVRzzyl7PjigjYs5aSsNbwyNPAoh6N1vConcwAgAWkzME6vxqcyOtmrMn7SjGfud5Ixupl1mEvKgJYHlk=
X-Received: by 2002:a4a:c19a:0:b0:425:ce1e:dec2 with SMTP id
 w26-20020a4ac19a000000b00425ce1edec2mr18661988oop.50.1657215907882; Thu, 07
 Jul 2022 10:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220706104729.14975-1-cgzones@googlemail.com> <20220706113804.8272-1-cgzones@googlemail.com>
In-Reply-To: <20220706113804.8272-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 7 Jul 2022 13:44:57 -0400
Message-ID: <CAP+JOzSrhTZwa=nYZEXntYzKTCUTtos-p72aXdiLqOzvR9s0tg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: set errno to EBADF on O_PATH emulation
 ENOENT failure
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 6, 2022 at 7:42 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> When the O_PATH emulation fails due to getxattr(2)/setxattr(2) failing
> with ENOENT, e.g. because no procfs being available, override the errno
> value to EBADF.  This avoids confusion to the caller as it would suggest
> the target of the operation does not exist, which is not the case:
>
>     setfiles: Could not set context for /:  No such file or directory
>
> Fixes: a782abf2 ("libselinux: emulate O_PATH support in fgetfilecon/fsetf=
ilecon")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>    only override errno on ENOENT
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/fgetfilecon.c | 5 ++++-
>  libselinux/src/fsetfilecon.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
> index baf38ec1..d7051171 100644
> --- a/libselinux/src/fgetfilecon.c
> +++ b/libselinux/src/fgetfilecon.c
> @@ -26,7 +26,10 @@ static ssize_t fgetxattr_wrapper(int fd, const char *n=
ame, void *value, size_t s
>
>         snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
>         errno =3D saved_errno;
> -       return getxattr(buf, name, value, size);
> +       ret =3D getxattr(buf, name, value, size);
> +       if (ret < 0 && errno =3D=3D ENOENT)
> +               errno =3D EBADF;
> +       return ret;
>  }
>
>  int fgetfilecon_raw(int fd, char ** context)
> diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.c
> index be821c7a..19ea15b7 100644
> --- a/libselinux/src/fsetfilecon.c
> +++ b/libselinux/src/fsetfilecon.c
> @@ -25,7 +25,10 @@ static int fsetxattr_wrapper(int fd, const char* name,=
 const void* value, size_t
>
>         snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
>         errno =3D saved_errno;
> -       return setxattr(buf, name, value, size, flags);
> +       rc =3D setxattr(buf, name, value, size, flags);
> +       if (rc < 0 && errno =3D=3D ENOENT)
> +               errno =3D EBADF;
> +       return rc;
>  }
>
>  int fsetfilecon_raw(int fd, const char * context)
> --
> 2.36.1
>
