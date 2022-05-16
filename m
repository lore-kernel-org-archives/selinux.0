Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8717AC433EF
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 17:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbiEPRHz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 13:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiEPRHz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 13:07:55 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CFE275F2
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:07:54 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id z5-20020a9d62c5000000b00606041d11f1so10497733otk.2
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U7nhkbOV1MQCqN2Or5xBsbiXFN/oNkJG5LL/zf1IDsU=;
        b=MembkJRc3nJ4kZ85errVZBM1ylW4gsyZS48MZSPwhEAOISPS8YY2pvqKxFShR0FEHE
         uiuAq4kyyYlHJlWrYdb67TT5Twz8CUqsCHrrcfgh3+7B4fzLQgjTXeax9+h3WhbTn2Ah
         lHXpQOjdyCYA9yN9JqlDUdSkaGGri2kIizpcQNvGNeHlC2pGnvwzdPXjiaG0GfKK6Jm0
         QBN88DnjtkYPIZ76expnoVkmsC0sHplRzbmikR7I3ij7ymS8tJe1W+6G51xq1h07lLJJ
         5Ug1kHHWDpeHRJQdKIEd2OG0vbZAwr5eqxsiEzFEIgQFzbiHa+w+ee57a/wgI0Hg6EHW
         au/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U7nhkbOV1MQCqN2Or5xBsbiXFN/oNkJG5LL/zf1IDsU=;
        b=jsNF/W5vtPuwxgIWZ4Q4mpAFVJJsLBAXczvNgU61p0TMEMZlScx24zreO2udtvkwUy
         Ia/LrYNcsQ6QLGARao8vaJQ4kS4loZBxc80OcyfvoyfPpzdXaWwyl5geaZL8/y7xNDrb
         3a1Uw1dRXeKZAfwkkBfmWlToMVUBM1gRuI7gZAU0+MknHuQbPHh5x7OGON70a/U/S8ob
         9G9YTMSJagOlIKBgcm14WYjUCfPI+tT07TXODtSWy0Qz/9wZQzuQdO/gRIah4vMXYKjf
         gCskHWHJ/g6i5bAPv4hYU/TqN6gv2zRy87N82hlEGHvzi0vU/Ati3sn3EQCQRu0v3G4J
         CWTg==
X-Gm-Message-State: AOAM530xockCUcHEdhz3tS+GGIKGT6k/w7KhiCuEmDUi2v6pd7iZRl4u
        AZQyEfKtTJ30tyKS7TAfuSVqqfVshjp5eGtTQuwv6abz
X-Google-Smtp-Source: ABdhPJyVl7B8u9+KoQoqCWVx4sZfOt0d+SEJwPuiQehQOtMuoMjaa1GacwXEbjL7y9oE5y3WRJYfbSYCaJyzyd8KyLo=
X-Received: by 2002:a05:6830:60c:b0:606:3e1:322c with SMTP id
 w12-20020a056830060c00b0060603e1322cmr6549201oti.53.1652720873543; Mon, 16
 May 2022 10:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174420.24537-1-cgzones@googlemail.com> <CAP+JOzRe0Ode3nugPJc_sj=_+i9GSQQ_2dC9O_3yOHafmDO21g@mail.gmail.com>
In-Reply-To: <CAP+JOzRe0Ode3nugPJc_sj=_+i9GSQQ_2dC9O_3yOHafmDO21g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 May 2022 13:07:42 -0400
Message-ID: <CAP+JOzTxbp-fW-z_G=UP_FukkdW2OaY_3=udxM6w3XYBwutQMQ@mail.gmail.com>
Subject: Re: [RFC PATCH] libselinux: emulate O_PATH support in fgetfilecon/fsetfilecon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 11, 2022 at 3:09 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sun, May 8, 2022 at 3:19 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Operating on a file descriptor avoids TOCTOU issues and one opened via
> > O_PATH avoids the requirement of having read access to the file.  Since
> > Linux does not natively support file descriptors opened via O_PATH in
> > fgetxattr(2) and at least glibc and musl does not emulate O_PATH suppor=
t
> > in their implementations, fgetfilecon(3) and fsetfilecon(3) also do not
> > currently support file descriptors opened with O_PATH.
> >
> > Inspired by CVE-2013-4392: https://github.com/systemd/systemd/pull/8583
> > Implementation adapted from: https://android.googlesource.com/platform/=
bionic/+/2825f10b7f61558c264231a536cf3affc0d84204%5E%21/
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Works as advertised.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/man/man3/getfilecon.3 |  4 +++-
> >  libselinux/man/man3/setfilecon.3 |  4 +++-
> >  libselinux/src/fgetfilecon.c     | 28 +++++++++++++++++++++++++---
> >  libselinux/src/fsetfilecon.c     | 23 ++++++++++++++++++++++-
> >  4 files changed, 53 insertions(+), 6 deletions(-)
> >
> > diff --git a/libselinux/man/man3/getfilecon.3 b/libselinux/man/man3/get=
filecon.3
> > index 5bb575b5..c3e92ba1 100644
> > --- a/libselinux/man/man3/getfilecon.3
> > +++ b/libselinux/man/man3/getfilecon.3
> > @@ -33,7 +33,9 @@ is identical to
> >  .BR getfilecon (),
> >  only the open file pointed to by filedes (as returned by
> >  .BR open (2))
> > -is interrogated in place of path.
> > +is interrogated in place of path.  Since libselinux 3.4 a file opened =
via
> > +.I O_PATH
> > +is supported.
> >
> >  .BR getfilecon_raw (),
> >  .BR lgetfilecon_raw ()
> > diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/set=
filecon.3
> > index 0e9a383f..61f9a806 100644
> > --- a/libselinux/man/man3/setfilecon.3
> > +++ b/libselinux/man/man3/setfilecon.3
> > @@ -29,7 +29,9 @@ link itself has it's context set, not the file that i=
t refers to.
> >  is identical to setfilecon, only the open file pointed to by filedes (=
as
> >  returned by
> >  .BR open (2))
> > -has it's context set in place of path.
> > +has it's context set in place of path.  Since libselinux 3.4 a file op=
ened via
> > +.I O_PATH
> > +is supported.
> >
> >  .BR setfilecon_raw (),
> >  .BR lsetfilecon_raw (),
> > diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.=
c
> > index 8c748f8a..baf38ec1 100644
> > --- a/libselinux/src/fgetfilecon.c
> > +++ b/libselinux/src/fgetfilecon.c
> > @@ -3,10 +3,32 @@
> >  #include <string.h>
> >  #include <stdlib.h>
> >  #include <errno.h>
> > +#include <stdio.h>
> >  #include <sys/xattr.h>
> >  #include "selinux_internal.h"
> >  #include "policy.h"
> >
> > +static ssize_t fgetxattr_wrapper(int fd, const char *name, void *value=
, size_t size) {
> > +       char buf[40];
> > +       int fd_flag, saved_errno =3D errno;
> > +       ssize_t ret;
> > +
> > +       ret =3D fgetxattr(fd, name, value, size);
> > +       if (ret !=3D -1 || errno !=3D EBADF)
> > +               return ret;
> > +
> > +       /* Emulate O_PATH support */
> > +       fd_flag =3D fcntl(fd, F_GETFL);
> > +       if (fd_flag =3D=3D -1 || (fd_flag & O_PATH) =3D=3D 0) {
> > +               errno =3D EBADF;
> > +               return -1;
> > +       }
> > +
> > +       snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
> > +       errno =3D saved_errno;
> > +       return getxattr(buf, name, value, size);
> > +}
> > +
> >  int fgetfilecon_raw(int fd, char ** context)
> >  {
> >         char *buf;
> > @@ -19,11 +41,11 @@ int fgetfilecon_raw(int fd, char ** context)
> >                 return -1;
> >         memset(buf, 0, size);
> >
> > -       ret =3D fgetxattr(fd, XATTR_NAME_SELINUX, buf, size - 1);
> > +       ret =3D fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, buf, size - 1=
);
> >         if (ret < 0 && errno =3D=3D ERANGE) {
> >                 char *newbuf;
> >
> > -               size =3D fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
> > +               size =3D fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, NULL=
, 0);
> >                 if (size < 0)
> >                         goto out;
> >
> > @@ -34,7 +56,7 @@ int fgetfilecon_raw(int fd, char ** context)
> >
> >                 buf =3D newbuf;
> >                 memset(buf, 0, size);
> > -               ret =3D fgetxattr(fd, XATTR_NAME_SELINUX, buf, size - 1=
);
> > +               ret =3D fgetxattr_wrapper(fd, XATTR_NAME_SELINUX, buf, =
size - 1);
> >         }
> >        out:
> >         if (ret =3D=3D 0) {
> > diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.=
c
> > index 5cf34e3f..be821c7a 100644
> > --- a/libselinux/src/fsetfilecon.c
> > +++ b/libselinux/src/fsetfilecon.c
> > @@ -3,13 +3,34 @@
> >  #include <string.h>
> >  #include <stdlib.h>
> >  #include <errno.h>
> > +#include <stdio.h>
> >  #include <sys/xattr.h>
> >  #include "selinux_internal.h"
> >  #include "policy.h"
> >
> > +static int fsetxattr_wrapper(int fd, const char* name, const void* val=
ue, size_t size, int flags) {
> > +       char buf[40];
> > +       int rc, fd_flag, saved_errno =3D errno;
> > +
> > +       rc =3D fsetxattr(fd, name, value, size, flags);
> > +       if (rc =3D=3D 0 || errno !=3D EBADF)
> > +               return rc;
> > +
> > +       /* Emulate O_PATH support */
> > +       fd_flag =3D fcntl(fd, F_GETFL);
> > +       if (fd_flag =3D=3D -1 || (fd_flag & O_PATH) =3D=3D 0) {
> > +               errno =3D EBADF;
> > +               return -1;
> > +       }
> > +
> > +       snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
> > +       errno =3D saved_errno;
> > +       return setxattr(buf, name, value, size, flags);
> > +}
> > +
> >  int fsetfilecon_raw(int fd, const char * context)
> >  {
> > -       int rc =3D fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(co=
ntext) + 1,
> > +       int rc =3D fsetxattr_wrapper(fd, XATTR_NAME_SELINUX, context, s=
trlen(context) + 1,
> >                          0);
> >         if (rc < 0 && errno =3D=3D ENOTSUP) {
> >                 char * ccontext =3D NULL;
> > --
> > 2.36.0
> >
