Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CAB13B5A9
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363863; cv=none; b=GRCaHB1AAjRvYKHRuWGrywisTTWnvGNuenpnsDNbky52Mx7m1thBNdLTtHsZwC3vmiF/zWrU2Y+oh0TQYnxwkKctqmr4HJ00d7YWUOI5pOVUT69i9l0YC4aGROK7IbghWODd0UDP3UkJdvBLefiPYbbK9rcjnQbXl5lrAp2EtIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363863; c=relaxed/simple;
	bh=JnNibrsmwEtER49DjeIX5eoa7BMIB7HWva7zLybIVng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7QdSbdNaRr/SK5JWgRhQ6ajBvIvRBb+ae1EFU3UzEWUQ0C+jsvgm/8v86RmAAhFSaFsnoHTx+tXaLmr2aP9bsNxehUvpDl56Mw3w477+lX7NHO4w5Y1b23CQgvygslzGaNvHBZPoGCB+MN8TQqsb8BvFfMt1LTr7mzZ09Hkpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVln6eIm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVln6eIm"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313a001d781so797072a91.3
        for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753363861; x=1753968661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd//oG+PYjwsR5abxjsN2briEsPNvCGUAVjEYLALwfo=;
        b=CVln6eImCKGLAZfCz3Cgj+MatMEjNI3T69hS7IHY6DhDANTO2+LnU2ViGYLME2ulXW
         eKOzajVQv4kaVHi0tKur94+Cr1ej6biyuo75Zp8a+UQAVo7nw163rH8hdJ8veiow3y7i
         zJz3OgFUxIaLRz1PTULi9i0RB6mjrE2iOhTjPOTu5yhWJUErCq/afF2Z0tCt6xGfOtxM
         sOtCBhlj3DiwVvvb2iHLWjXc9y6sRpwu+EhQ6UD9jlc/qyg72SDmkerQYPc7sZ6RsP85
         pC9r0jQJBxpxPlheueP1wu6tavpCYJePUT6P5W3K/JzBlDS7efe6qWQMpSknqTYUODt8
         3RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363861; x=1753968661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vd//oG+PYjwsR5abxjsN2briEsPNvCGUAVjEYLALwfo=;
        b=bgRGDm6J0IdrvZXPQ+7uS+XNW3sI1Jvmbe70a1oc5qshi5XZYLTD9wXBKBCK356p0A
         NY7l67QSYXar9HpHNdiaZgO+/8yx6dMzGgQbdSwaqycseSE66D4/9pi06f47jch1405f
         wmEfYSjy0fJKGHL7VvZBTHyPCuvrVLx6FRzUAzdiThg2AlwKjfq4+mnMuO1o9wsHSsgG
         p/V2zHSuX6pXOJvnZSjVvrypb2B510FQMrPpxsfeKHdxXeHI+2Q8PKQjs7K3UeLjprk/
         YrFWu/RbZjFNXvNzuMGFm2kjEueBasvupKsjLB0FM/CfugYRFr+khunurpuUyPY1oUmR
         8eAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV65+dZUK5ckZEWjlLGrGwHShclOBV5UibLCGa87+DBiWxaWyp3R9zEC2op2f06Fa3zxhn9823+@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvY7t79U8l48IgoQV6mJ0rAh9n9A7JVbvdG1FMhjvV2ld923s
	Q+YPVfW0C3qbKcDrdJHN9UVKtnD242DwMqab5XCDVfHVJvfg4xpT1K4A9LiyypS+V4Gbp3WrMb+
	X6AYqPZfBEbNYPIPyrRvk+//xeuOJD30=
X-Gm-Gg: ASbGncvS3VQb+6O/CwHdH9/mhyd+8j175TDLseEFkv/r0ozIsEEnI/RLhLG0Yc96xQM
	8XZBWCSVlHstOQd7uck/P1ipeePbeTlvspscZM4Er/uUt8elFsOZiIPHbpJwol9BMGQawyGKQtq
	NTqVxzd2DzpzfH6UzAXadIZs/lgub+sQat7JVcn1HbV1Fflm1jX7ZE0l5LXpjsLExBg1fy9JawI
	78Tyxc=
X-Google-Smtp-Source: AGHT+IFzNQnZxvUmEoqYr3VGGCkhuFB+hHFLVP47vf+F/0rjzGIWRTYVznHOMMwwTJz9FOU+NTALFrsHspaGJgEtbzE=
X-Received: by 2002:a17:90b:3f8d:b0:311:e8cc:424c with SMTP id
 98e67ed59e1d1-31e507cdcebmr9709242a91.25.1753363860555; Thu, 24 Jul 2025
 06:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6AuwTX9soXmHSiJbE2r69mRt8qFTTOQj-FhWUjnnYdQg@mail.gmail.com>
 <20250724130511.317098-1-nvraxn@gmail.com> <CAEjxPJ5ZqR5wmqV_tpAz6erkrpR-QWFyDmFQiwmVKnO3s3XGqQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5ZqR5wmqV_tpAz6erkrpR-QWFyDmFQiwmVKnO3s3XGqQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 24 Jul 2025 09:30:49 -0400
X-Gm-Features: Ac12FXyOdeuEDk60aFxFgSgJavAW7uDmsiHnqzEAmiykGHXs5zZ6qcFzoToMuZU
Message-ID: <CAEjxPJ6-ZbOKxtpbpD4NixZeQy+gU6Z3T8C8jLRvCPDHC-mL3w@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: fix parsing of the enforcing kernel
 cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>, Petr Lautrbach <plautrba@redhat.com>, 
	James Carter <jwcart2@gmail.com>
Cc: omosnace@redhat.com, paul@paul-moore.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 9:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 24, 2025 at 9:05=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Currently, parsing of the cmdline has two issues:
> > - By using atoi, no error checking is done. What happens if an argument
> >   that isn't an integer is provided, e.g. enforcing=3Dfoo? And as there
> >   is also no validation that the number provided is actually valid, 1
> >   or 0, what happens if enforcing=3D2?
> >
> > - After the first strstr, no arguments that follow are searched for; if
> >   I have enforcing=3D0 enforcing=3D1, the latter enforcing=3D1 is not t=
aken
> >   into account. This is made even worse due to halting searching after
> >   finding the first "enforcing=3D" token, meaning that if the cmdline w=
as
> >   as follows:
> >
> >   fooenforcing=3D0 enforcing=3D0
> >
> >   the enforcing parameter is entirely ignored.
> >
> > This patch fixes this by:
> >
> >   - Using strtol to actually validate that we got passed a number, and
> >     then validating that that number is either 0 or 1. If instead we
> >     get passed an invalid value, we skip over the argument entirely.
>
> This is not quite correct but not a big deal to me since you clarify belo=
w.
>
> >
> >   - Looping until the last "enforcing=3D" in the cmdline. Latter (valid=
)
> >     arguments take precedence over previous arguments.
> >
> > For the case where "enforcing=3D" is provided with a valid integer, 0 i=
s
> > treated as permissive mode, and anything else (such as 1 or 2, etc) is
> > treated as enforcing mode. When "enforcing=3D" is passed an argument th=
at
> > is not a valid integer (such as "on"), default to enforcing=3D0, i.e.
> > permissive mode. This is in line with how the kernel parses the
> > enforcing parameter.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> This looks good to me wrt consistency with the kernel but will defer
> to one of the other selinux userspace maintainers to merge.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Also, not sure if this matters but b4 warns about the following:

Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH v3] libselinux: fix parsing of the enforcing kernel cmdl=
ine parameter
    + Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com> (=E2=9C=93
DKIM/gmail.com)
  ---
  =E2=9C=93 Signed: DKIM/gmail.com
---
Total patches: 1
---
NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
     Msg From: robinshao007@163.com <robinshao007@163.com>
NOTE: Rerun with -S to apply them anyway

>
> > ---
> >  libselinux/src/load_policy.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > v2: Follow the same argument parsing behaviour as the kernel does.
> > v3: Actually follow the kernel's behaviour where "enforcing=3D" is not
> >     provided with a valid integer...
> >
> > diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.=
c
> > index dc1e4b6e..ec2d5614 100644
> > --- a/libselinux/src/load_policy.c
> > +++ b/libselinux/src/load_policy.c
> > @@ -244,17 +244,28 @@ int selinux_init_load_policy(int *enforce)
> >         rc =3D mount("proc", "/proc", "proc", 0, 0);
> >         cfg =3D fopen("/proc/cmdline", "re");
> >         if (cfg) {
> > -               char *tmp;
> >                 buf =3D malloc(selinux_page_size);
> >                 if (!buf) {
> >                         fclose(cfg);
> >                         return -1;
> >                 }
> > -               if (fgets(buf, selinux_page_size, cfg) &&
> > -                   (tmp =3D strstr(buf, "enforcing=3D"))) {
> > -                       if (tmp =3D=3D buf || isspace((unsigned char)*(=
tmp - 1))) {
> > -                               secmdline =3D
> > -                                   atoi(tmp + sizeof("enforcing=3D") -=
 1);
> > +               if (fgets(buf, selinux_page_size, cfg)) {
> > +                       char *search =3D buf;
> > +                       char *tmp;
> > +                       while ((tmp =3D strstr(search, "enforcing=3D"))=
) {
> > +                               if (tmp =3D=3D buf || isspace((unsigned=
 char)*(tmp - 1))) {
> > +                                       char *valstr =3D tmp + sizeof("=
enforcing=3D") - 1;
> > +                                       char *endptr;
> > +                                       errno =3D 0;
> > +                                       const long val =3D strtol(valst=
r, &endptr, 0);
> > +                                       if (endptr !=3D valstr && errno=
 =3D=3D 0) {
> > +                                               secmdline =3D val ? 1 :=
 0;
> > +                                       } else {
> > +                                               secmdline =3D 0;
> > +                                       }
> > +                               }
> > +                               /* advance past the current substring, =
latter arguments take precedence */
> > +                               search =3D tmp + 1;
> >                         }
> >                 }
> >                 fclose(cfg);
> > --
> > 2.50.1
> >
