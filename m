Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD0C433F5
	for <selinux@archiver.kernel.org>; Wed, 11 May 2022 19:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiEKTJw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 May 2022 15:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240841AbiEKTJv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 May 2022 15:09:51 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF116EB3E
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 12:09:49 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id y20-20020a056830071400b00606a2ebd91bso1125761ots.5
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7FQnLLQuAlbjG7SL414Ew2uysZGXchcwYtQIh36Kzhk=;
        b=NF2OUQco2YXhLo3OL7IckmCPkQQLm+bO1uKYiv4XJFO9L3zKhTF0bXmWnuqhIIyRrg
         cK4VCrhMjjCetaaicf70W04ul2nvHIJ9EZQ9YMpDABiq8OcrFF4xMiRU/TmQ+1l0mH7f
         BDjz6pZhfz9PlXgYi7EGuFR9nYKJsA2ByfXM9E88M9Dw94g4qf8FHGGTAMlqbDQhVVCR
         HuxrErJ0g4iB+QPqW/NSObTjqYk8KA6ptZpWSFdPBV7ShI1olq4V+EwRoln1xCiZcD6R
         FXhDSA3ZD5OHkJ5YNxwR1y5a7Zx5gevK6y4K32SF1mWSRibM/eol4pyRSWPWnLKvuz2w
         vaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7FQnLLQuAlbjG7SL414Ew2uysZGXchcwYtQIh36Kzhk=;
        b=lvaNvB6VWngzyyAqv5Skj5kd+qxKOyN63xTHMGJ/JO8b3qAg3FQj/pTt5uFid6acLh
         NayKPRqfawVg1v5VulCQlIqSf5no+Hg9ELoTWNBW4Q2NVmXq7bHRJDdJb72KzZKkuwR5
         o3LyL010ls4QZr5SDeVYM01UjfEAFHuq/PsPYG7w0Oi9GP8UqAakPX9GjPU/a9G8rytt
         lYwg8FOBG/K4gEE8zfSuK2yPyO50GKQmD9htGPWOo0cJHslmy9saq/jiwcBmVqPX7wBf
         KIVuXO5TjUcvYqAn7KU9+nrxH76balLgb2oIet5jHKqZTHLlNgVf08XkJIDhYjIoRNNh
         15cw==
X-Gm-Message-State: AOAM533r8CxUez+Piz3t6QEUGS81DCpQRwDQb8zyJCMb3Yd7e5DEtSRn
        vj6xAvR/BtQ3qkv2uJbsi7OpdDXLszfaYuoLbC147L+qAYw=
X-Google-Smtp-Source: ABdhPJyyYf3UKiU1oSCn2E2lxoguc+5Soxdh7aU2A494wdtmIfpayn+hB8xOeKE0suCyLHd1Z7/XnxghqZBwUsuAl3Y=
X-Received: by 2002:a9d:12f6:0:b0:606:5f8:a407 with SMTP id
 g109-20020a9d12f6000000b0060605f8a407mr10425597otg.154.1652296189124; Wed, 11
 May 2022 12:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174420.24537-1-cgzones@googlemail.com>
In-Reply-To: <20220505174420.24537-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 May 2022 15:09:37 -0400
Message-ID: <CAP+JOzRe0Ode3nugPJc_sj=_+i9GSQQ_2dC9O_3yOHafmDO21g@mail.gmail.com>
Subject: Re: [RFC PATCH] libselinux: emulate O_PATH support in fgetfilecon/fsetfilecon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, May 8, 2022 at 3:19 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Operating on a file descriptor avoids TOCTOU issues and one opened via
> O_PATH avoids the requirement of having read access to the file.  Since
> Linux does not natively support file descriptors opened via O_PATH in
> fgetxattr(2) and at least glibc and musl does not emulate O_PATH support
> in their implementations, fgetfilecon(3) and fsetfilecon(3) also do not
> currently support file descriptors opened with O_PATH.
>
> Inspired by CVE-2013-4392: https://github.com/systemd/systemd/pull/8583
> Implementation adapted from: https://android.googlesource.com/platform/bi=
onic/+/2825f10b7f61558c264231a536cf3affc0d84204%5E%21/
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Works as advertised.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/man/man3/getfilecon.3 |  4 +++-
>  libselinux/man/man3/setfilecon.3 |  4 +++-
>  libselinux/src/fgetfilecon.c     | 28 +++++++++++++++++++++++++---
>  libselinux/src/fsetfilecon.c     | 23 ++++++++++++++++++++++-
>  4 files changed, 53 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/man/man3/getfilecon.3 b/libselinux/man/man3/getfi=
lecon.3
> index 5bb575b5..c3e92ba1 100644
> --- a/libselinux/man/man3/getfilecon.3
> +++ b/libselinux/man/man3/getfilecon.3
> @@ -33,7 +33,9 @@ is identical to
>  .BR getfilecon (),
>  only the open file pointed to by filedes (as returned by
>  .BR open (2))
> -is interrogated in place of path.
> +is interrogated in place of path.  Since libselinux 3.4 a file opened vi=
a
> +.I O_PATH
> +is supported.
>
>  .BR getfilecon_raw (),
>  .BR lgetfilecon_raw ()
> diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/setfi=
lecon.3
> index 0e9a383f..61f9a806 100644
> --- a/libselinux/man/man3/setfilecon.3
> +++ b/libselinux/man/man3/setfilecon.3
> @@ -29,7 +29,9 @@ link itself has it's context set, not the file that it =
refers to.
>  is identical to setfilecon, only the open file pointed to by filedes (as
>  returned by
>  .BR open (2))
> -has it's context set in place of path.
> +has it's context set in place of path.  Since libselinux 3.4 a file open=
ed via
> +.I O_PATH
> +is supported.
>
>  .BR setfilecon_raw (),
>  .BR lsetfilecon_raw (),
> diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
> index 8c748f8a..baf38ec1 100644
> --- a/libselinux/src/fgetfilecon.c
> +++ b/libselinux/src/fgetfilecon.c
> @@ -3,10 +3,32 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <errno.h>
> +#include <stdio.h>
>  #include <sys/xattr.h>
>  #include "selinux_internal.h"
>  #include "policy.h"
>
> +static ssize_t fgetxattr_wrapper(int fd, const char *name, void *value, =
size_t size) {
> +       char buf[40];
> +       int fd_flag, saved_errno =3D errno;
> +       ssize_t ret;
> +
> +       ret =3D fgetxattr(fd, name, value, size);
> +       if (ret !=3D -1 || errno !=3D EBADF)
> +               return ret;
> +
> +       /* Emulate O_PATH support */
> +       fd_flag =3D fcntl(fd, F_GETFL);
> +       if (fd_flag =3D=3D -1 || (fd_flag & O_PATH) =3D=3D 0) {
> +               errno =3D EBADF;
> +               return -1;
> +       }
> +
> +       snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
> +       errno =3D saved_errno;
> +       return getxattr(buf, name, value, size);
> +}
> +
>  int fgetfilecon_raw(int fd, char ** context)
>  {
>         char *buf;
> @@ -19,11 +41,11 @@ int fgetfilecon_raw(int fd, char ** context)
>                 return -1;
>         memset(buf, 0, size);
>
> -       ret =3D fgetxattr(fd, XATTR_NAME_SELINUX, buf, size - 1);
> +       ret =3D fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, buf, size - 1);
>         if (ret < 0 && errno =3D=3D ERANGE) {
>                 char *newbuf;
>
> -               size =3D fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
> +               size =3D fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, NULL, =
0);
>                 if (size < 0)
>                         goto out;
>
> @@ -34,7 +56,7 @@ int fgetfilecon_raw(int fd, char ** context)
>
>                 buf =3D newbuf;
>                 memset(buf, 0, size);
> -               ret =3D fgetxattr(fd, XATTR_NAME_SELINUX, buf, size - 1);
> +               ret =3D fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, buf, si=
ze - 1);
>         }
>        out:
>         if (ret =3D=3D 0) {
> diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.c
> index 5cf34e3f..be821c7a 100644
> --- a/libselinux/src/fsetfilecon.c
> +++ b/libselinux/src/fsetfilecon.c
> @@ -3,13 +3,34 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <errno.h>
> +#include <stdio.h>
>  #include <sys/xattr.h>
>  #include "selinux_internal.h"
>  #include "policy.h"
>
> +static int fsetxattr_wrapper(int fd, const char* name, const void* value=
, size_t size, int flags) {
> +       char buf[40];
> +       int rc, fd_flag, saved_errno =3D errno;
> +
> +       rc =3D fsetxattr(fd, name, value, size, flags);
> +       if (rc =3D=3D 0 || errno !=3D EBADF)
> +               return rc;
> +
> +       /* Emulate O_PATH support */
> +       fd_flag =3D fcntl(fd, F_GETFL);
> +       if (fd_flag =3D=3D -1 || (fd_flag & O_PATH) =3D=3D 0) {
> +               errno =3D EBADF;
> +               return -1;
> +       }
> +
> +       snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
> +       errno =3D saved_errno;
> +       return setxattr(buf, name, value, size, flags);
> +}
> +
>  int fsetfilecon_raw(int fd, const char * context)
>  {
> -       int rc =3D fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(cont=
ext) + 1,
> +       int rc =3D fsetxattr_wrapper(fd, XATTR_NAME_SELINUX, context, str=
len(context) + 1,
>                          0);
>         if (rc < 0 && errno =3D=3D ENOTSUP) {
>                 char * ccontext =3D NULL;
> --
> 2.36.0
>
