Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168F3C19F2D
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 15:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiHIPSR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiHIPSP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 11:18:15 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EA010549
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 08:18:15 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so8721002otk.0
        for <selinux@vger.kernel.org>; Tue, 09 Aug 2022 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=9TB8H19X152UOh74DvtAyFZu+Kqtbh0GLJiY11MEy3o=;
        b=FsSUrQAjXFY5KIcnmYqy7vBt5j3ZGgNL91LRZJaQofe+Cj7y3bEpd963jkzzXHFi4z
         9WMPJGo/vn11Q6oPgSuC8QuqMed2MhyYrM1+vhzPyXPkudJpoXUV2skenSvIHEvwiq3j
         o5TxasFW+mRFid//bYHqSUW57YYweMnIbq4uMosopwhvH/ZZBg9YxCq6tmebuLng4ZZX
         WfYI2xzcEcuMKQ9GohCcdXUWJqYBc/87DsEpze31QVjYIbhZ1V5w6v/BtysJhY9EEcot
         /XkFd2rkFRw+InCd7Jn3/ll4mYkqGczaYSrqs2Mprj1z7XAt34SBParPpNm0WkGviRhX
         BpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=9TB8H19X152UOh74DvtAyFZu+Kqtbh0GLJiY11MEy3o=;
        b=FGMaRC9vvAVVAzoHVy4yFcR7wfs769WokPiy526qgK/F3laup2Ggq20oZSQ6B/cPip
         cjkYZ83HWVOKkks9RX3XkWBTGzBPFleVkO1YpFCI8mN3P355cHLrLB+AgG7B31Ey2LiM
         xNl7t5t8lvFeYjSM1hiNCEwPSjBywDqgpRAM0wp1TjjRNnIdemjlDwtYx3AsNuKGLgrU
         l2qcEF44lPeE0l+CWbXf2er1c+XWIRFxETbFA79ihob8w1n7me3kYYrWU8GWpQD1Pr4s
         kcugQUE1iaw8FW2pU8BpVDJ3e24q+7UFTjUgFTzFAQRPxNMopn6IBZEkiL1wZYPiEkAq
         8c9g==
X-Gm-Message-State: ACgBeo11sgLzfmbybe5i+mqSk4IbYOhNcf3X+4mMeSfhr4DHS4ghSqw8
        kiFdgnPlJFUXL1UqCe1PuLl/kB03mkvFxlH823s=
X-Google-Smtp-Source: AA6agR679mRQ20nVum+2X/aX2QvipaCEGV+zxfp4rb55Th/F3hUbqAn9qzth5hSTnTmLUOU99hsuF1cX53d2/+S/09o=
X-Received: by 2002:a05:6830:61cd:b0:618:d560:b787 with SMTP id
 cc13-20020a05683061cd00b00618d560b787mr9021405otb.154.1660058294430; Tue, 09
 Aug 2022 08:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220706104729.14975-1-cgzones@googlemail.com>
 <20220706113804.8272-1-cgzones@googlemail.com> <CAP+JOzSrhTZwa=nYZEXntYzKTCUTtos-p72aXdiLqOzvR9s0tg@mail.gmail.com>
In-Reply-To: <CAP+JOzSrhTZwa=nYZEXntYzKTCUTtos-p72aXdiLqOzvR9s0tg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Aug 2022 11:18:03 -0400
Message-ID: <CAP+JOzRT8wUnZz9vbdtnJ2KZU6qZagSrzi6vxzCb3OMNt6w=GA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: set errno to EBADF on O_PATH emulation
 ENOENT failure
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 7, 2022 at 1:44 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jul 6, 2022 at 7:42 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > When the O_PATH emulation fails due to getxattr(2)/setxattr(2) failing
> > with ENOENT, e.g. because no procfs being available, override the errno
> > value to EBADF.  This avoids confusion to the caller as it would sugges=
t
> > the target of the operation does not exist, which is not the case:
> >
> >     setfiles: Could not set context for /:  No such file or directory
> >
> > Fixes: a782abf2 ("libselinux: emulate O_PATH support in fgetfilecon/fse=
tfilecon")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > v2:
> >    only override errno on ENOENT
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/src/fgetfilecon.c | 5 ++++-
> >  libselinux/src/fsetfilecon.c | 5 ++++-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.=
c
> > index baf38ec1..d7051171 100644
> > --- a/libselinux/src/fgetfilecon.c
> > +++ b/libselinux/src/fgetfilecon.c
> > @@ -26,7 +26,10 @@ static ssize_t fgetxattr_wrapper(int fd, const char =
*name, void *value, size_t s
> >
> >         snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
> >         errno =3D saved_errno;
> > -       return getxattr(buf, name, value, size);
> > +       ret =3D getxattr(buf, name, value, size);
> > +       if (ret < 0 && errno =3D=3D ENOENT)
> > +               errno =3D EBADF;
> > +       return ret;
> >  }
> >
> >  int fgetfilecon_raw(int fd, char ** context)
> > diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.=
c
> > index be821c7a..19ea15b7 100644
> > --- a/libselinux/src/fsetfilecon.c
> > +++ b/libselinux/src/fsetfilecon.c
> > @@ -25,7 +25,10 @@ static int fsetxattr_wrapper(int fd, const char* nam=
e, const void* value, size_t
> >
> >         snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
> >         errno =3D saved_errno;
> > -       return setxattr(buf, name, value, size, flags);
> > +       rc =3D setxattr(buf, name, value, size, flags);
> > +       if (rc < 0 && errno =3D=3D ENOENT)
> > +               errno =3D EBADF;
> > +       return rc;
> >  }
> >
> >  int fsetfilecon_raw(int fd, const char * context)
> > --
> > 2.36.1
> >
