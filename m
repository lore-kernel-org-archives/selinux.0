Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6C51D1E7A
	for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294050; cv=none; b=VEItZKejXpwcY1BwiUe2qS3izfppBIS6yadyd+br4Es7rx+Q0PtthoLLY8fjBwKfK+VQ057kNi6UI5i618rdVe/qfxHjYDK5Vr4JDvqTdwDNIEDqx3tCIaQcAI5GIPr2CrtvMw2GIegLYQpHkhroPV+cPi5IvdaAg7wuGuig54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294050; c=relaxed/simple;
	bh=YWz11gSaK+4WBn5EpoaAFSOknIX8/a6caJzwOpdrfEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+vN/K9md9Y2hjpWnZVL8sGxEUg3+fNp77QRK9T4YI25CLyjvaRuUPzzQQjlhYiN0kESnekNqeVTdRiyrO9/LaVxonVx0vLA4gxPwlDFfCVeL8P2qfpFezJ4T5Wwarh+u0yJwZQYgRzutfWc7yYyynDXqNTKNSri+R4BqYXddlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLFvLYw6; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLFvLYw6"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e602a73ba1so3747000b6e.2
        for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294047; x=1730898847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKZk5QXUsgtnclQnP2+pn0IVWhgUtxEfFsAKBuiZ5SI=;
        b=WLFvLYw6kNcD0douvk7OH5SAOeUk8rOPDtKxt3iA8hxzMdOmTBSDGZfmqUcEr/4RgX
         xnrbWjeM+NxHHUpr6aM3mDTFlz4zwsEbInxSqhF4Lk8x9MpcmR6UsN3UDmvZE/vVjTz3
         1V3UeNw8K6/5G/Eu5PA1ZaIlmthm1G/fCct5sRlqvSqFLeR6KUOHzYhTiG3p6X2e20OR
         wthWdkuv2JpG+LmYL1hD4eqGP28UaNsgn5Dj1NX7xkAYUR9D3o4K+tuTu59P7DK//b9+
         35F6JthwkB9JZGZSKJJ+0msC4qgnPI5MS923qs6yZUKjqjsNwm9GZnDHsvOlBWGfFMdr
         u9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294047; x=1730898847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKZk5QXUsgtnclQnP2+pn0IVWhgUtxEfFsAKBuiZ5SI=;
        b=C3eE3avQ1jCe842bPJs6L54oWdKRBYIhugQKxkeIRTJ0xQX1EZzNsvPXEl0PeG0fuh
         KiO4lSK1LTy/nI3TBAnl9zL4WV06cc+l/jLO17q1GgZImWUKkPc1fZg3XQh39jpDUuUJ
         vUgI2p3dCOeC7cC61znL0LA8rugyA9cBrQ9O9BBdVQbRsD1Q79upj5Dhskmj2qVlU8+Q
         jy0zYSRepfX+bcsHQcv2mg1BqdXj82clnGVFkbzftqB6J+RUjBjmm+V8JocGRV1iXvXW
         u3UDPTyATwWIkIihrULo9VkA029hcy0re53GHABxv/CPTMp//hanA71Qf3n4dk8K7/N1
         QWdA==
X-Gm-Message-State: AOJu0YygfSSLPxAjOlqoAPkKZ+g+T1tXqtnUm+FwIT8bhKSnkoeu364h
	5mzK/vaAJGIoJU+UnF+QG4170O32lkQzv14Ykq6FsFFzHNLcEhkS2VUGcZ4Y248loSEUgArOE3b
	y+k+5L8SLNuVo0Cb3CCpHm2l3lfw=
X-Google-Smtp-Source: AGHT+IEbTWh8vqvTNKjzLMhhQ1Ls1xt2bMkwKQiCBMf8vFwTH50O9h/w7Ypb+1uFTVJoq3jhLwdNt9jBHjpS6Ju5fEA=
X-Received: by 2002:a05:6359:45a0:b0:1b5:f81c:875f with SMTP id
 e5c5f4694b2df-1c3f9d4973dmr685909355d.5.1730294047230; Wed, 30 Oct 2024
 06:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018151300.445618-1-cgoettsche@seltendoof.de> <CAP+JOzRwYeawhhALJpcHftegkp_f_Ni=Vz8zhZs7Dftm8fV1hA@mail.gmail.com>
In-Reply-To: <CAP+JOzRwYeawhhALJpcHftegkp_f_Ni=Vz8zhZs7Dftm8fV1hA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 30 Oct 2024 09:13:56 -0400
Message-ID: <CAP+JOzRpeJ8RRpY9+=VqAVP4AXhP8Yijpf-CQ6fZti4WmunBjw@mail.gmail.com>
Subject: Re: [PATCH 1/4] libselinux: avoid errno modification by fclose(3)
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:30=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Oct 18, 2024 at 11:13=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > In case fclose(3) might modify the global variable errno, use a wrapper
> > retaining the errno value.  In the affected cases the success of
> > fclose(3) itself is not important, since the underlying descriptor is
> > only read from.
> >
> > Reported-by: clang-analyzer
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These four patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/src/get_context_list.c |  4 ++--
> >  libselinux/src/label_file.c       |  4 ++--
> >  libselinux/src/selinux_internal.h | 11 +++++++++++
> >  3 files changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_con=
text_list.c
> > index 0ad24654..222b54c1 100644
> > --- a/libselinux/src/get_context_list.c
> > +++ b/libselinux/src/get_context_list.c
> > @@ -438,7 +438,7 @@ int get_ordered_context_list(const char *user,
> >                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
> >                 rc =3D get_context_user(fp, con, user, &reachable, &nre=
achable);
> >
> > -               fclose(fp);
> > +               fclose_errno_safe(fp);
> >                 if (rc < 0 && errno !=3D ENOENT) {
> >                         selinux_log(SELINUX_ERROR,
> >                                 "%s:  error in processing configuration=
 file %s\n",
> > @@ -451,7 +451,7 @@ int get_ordered_context_list(const char *user,
> >         if (fp) {
> >                 __fsetlocking(fp, FSETLOCKING_BYCALLER);
> >                 rc =3D get_context_user(fp, con, user, &reachable, &nre=
achable);
> > -               fclose(fp);
> > +               fclose_errno_safe(fp);
> >                 if (rc < 0 && errno !=3D ENOENT) {
> >                         selinux_log(SELINUX_ERROR,
> >                                 "%s:  error in processing configuration=
 file %s\n",
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 2fad0c93..40628e2c 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -628,7 +628,7 @@ static int process_file(const char *path, const cha=
r *suffix,
> >
> >                 rc =3D fcontext_is_binary(fp);
> >                 if (rc < 0) {
> > -                       (void) fclose(fp);
> > +                       fclose_errno_safe(fp);
> >                         return -1;
> >                 }
> >
> > @@ -639,7 +639,7 @@ static int process_file(const char *path, const cha=
r *suffix,
> >                         rc =3D digest_add_specfile(digest, fp, NULL, sb=
.st_size,
> >                                 found_path);
> >
> > -               fclose(fp);
> > +               fclose_errno_safe(fp);
> >
> >                 if (!rc)
> >                         return 0;
> > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux=
_internal.h
> > index 450a42c2..372837dd 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -2,7 +2,9 @@
> >  #define SELINUX_INTERNAL_H_
> >
> >  #include <selinux/selinux.h>
> > +#include <errno.h>
> >  #include <pthread.h>
> > +#include <stdio.h>
> >
> >
> >  extern int require_seusers ;
> > @@ -131,4 +133,13 @@ void *reallocarray(void *ptr, size_t nmemb, size_t=
 size);
> >  #define IGNORE_DEPRECATED_DECLARATION_END
> >  #endif
> >
> > +static inline void fclose_errno_safe(FILE *stream)
> > +{
> > +       int saved_errno;
> > +
> > +       saved_errno =3D errno;
> > +       (void) fclose(stream);
> > +       errno =3D saved_errno;
> > +}
> > +
> >  #endif /* SELINUX_INTERNAL_H_ */
> > --
> > 2.45.2
> >
> >
