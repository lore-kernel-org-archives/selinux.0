Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409403E6396
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947446; cv=pass; b=jBXKswZOew1QWPywUzuJS+Syq9RCJRE4e+kuNxpLbGNBdzp09cZsS57Mn777NhU9EVkbduqMY3YD2OKf4kj4TGqmh4Sn4eg1MadwNKNl4Z/KAFAHK3qxgKRhwqtFeQ6EER4z9wkNxcXu/iKpLqsYffxnJUT5Xe+WhRfI4AJp1Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947446; c=relaxed/simple;
	bh=Qu6j8FwRl9zae2U/MBl8z3f4lhYsHDpt2+HBE+tbDzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBAbiHXqeKHw5rD79Gu8fgSqEsCYfVswANx03N3HeAfTDbUxhwfIZJHlH0fEu+sNdNc97O3UwZbCcBR+hJc+6hslPHXK6C9nkrr/WauoQSyZJ55DiwZEVtTGtk75RArWcPDqWf1VoJ/HZXkQtJIwKMuwuTvaeQIFBs8l6usJe1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMx6COZS; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMx6COZS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c3315c5dso50778965ad.3
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 12:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780947444; cv=none;
        d=google.com; s=arc-20240605;
        b=jbPfn2hlNszU1ShFW5+u6hHJsb94mF7J56J7rTlIo2IfFvqwRxNJ0Jkb2npHHsP+lT
         moVtyycSv6WXLQ3JVsFk7kbvSupC9ZwjPtzMzzV3NErY7Gxr5BKfIWVCUxgofmVMK9bE
         V2RsBUKkvmdXDpnDFHdRvrrwsnuwUAjnMyKnYfPh+oKGAhBpbcz2CnuuBsl37Hp8HCne
         3Dsfpt1KpxKo8NxJ2gdqkjTIyd2zVYePt+hQyngEeKh/qIiUWgKJ1QwRHjjHt0cVzk98
         Q5QHtqHBhEbBBDK/C+hqHy0d/MvZqIyGFM4sB3rjBTLcR8EsS8khtKK0shn2C/jTOKQf
         4kxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4W+lq6xt+RtC5ps6Pw1AjMfjeer+RO1fNo70DmL9KMw=;
        fh=UHzzgOk3N/r5UYAiC3X1RcIhf0mdwe8JBO/M3dg3Yk8=;
        b=aYp5DA6UtxzW/orgOnm/F3JJ3v5bdOdj6iCsw8/GOjgqz67DaSwdqH9OYjQ7c4KlWR
         5HMdEPAvzdyZVBqL5zSCoQE9LeTMBbQjh7lQdEihYV/PZ2Kb0QDiswskkssvO33gIb9z
         /y1W+2spMdYvQa6WEDnLyaw/9G70fY8EL0gy3NyjAVE8zx1FvbKuUo4Yya3m3ySxYLoX
         KMtLVJ+TncWQMqqxz40pgjFxzuCrF+InC8bWVRrArsd2/x+mCRj87kcV030UCXyup9av
         qDBxajGaEOPxWF8HYzj4a65pq6jrsWovUXlUvQtfOCoNVmI+MsVVrsFJXB2p5Qtu2noj
         3rJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780947444; x=1781552244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W+lq6xt+RtC5ps6Pw1AjMfjeer+RO1fNo70DmL9KMw=;
        b=UMx6COZSa6ILHTwFX8SjPbYLamMcpTVWPXMI23BUxsExm7LCEBf7CLkRhceXigNRsf
         XLj0JdPehaJetI5PNj16SVjNwgTkTBv6mvkVrREEA05dWkE07LvtHUoGxIALxeV39K3t
         kQsVptOrrGALac1iVDhz30Bh7byM9NpMd2F1pa6QZOScDSZaXbgrp95VTTzafTy69MTd
         ZKnyV1ntYz1qRxDbMe6tWIh6hMl4sY0+xq64eFqdjdVOV46TWh2/XjjWYbymHURz6E6l
         lmOzD1ookl42Gq/2YP0TvwHSgM4eUY6IiUVR6bpx5LDQ8DuWuGwbQXXUhAj6YpcjZhs9
         yuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947444; x=1781552244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4W+lq6xt+RtC5ps6Pw1AjMfjeer+RO1fNo70DmL9KMw=;
        b=B8l0pgGXQPnKuyW7fwgXS13NbtE1uAiPc6TipgTh2qGOqfPCbNrrms+RNgYUZwsYJU
         ZmMz9YORYQpNH4sfhef8vERuFCXHnm+VbppEthueRuHExiHq1KpRcUUNdRzGEUAPkBF9
         C54pPbFI2+XUPH7VY55ounmaWwIGMrNiurSRjSzsTLz2gnW1Xwn+fD9l/KgsBgIBeaeh
         pCOVV/xj68B0F0pA6exJFjBvfudft5rH1Y8HgdgqXQtwvuNWNuF5t46qbTdoIrTpxqCQ
         3kS2t5JYF2ABR1fFc9MZCSB3+qVaKLEU/bqNrRu+uO667Z3rwXjw4DPDD0ciiW8Ful9X
         sCXw==
X-Gm-Message-State: AOJu0YzjUFB2l/xZnXD/yTsovuAaiyaf9B8Hwc7HajWoBJC1eq6qfRYt
	xxNeXdevkbnu+XfJLDLd3hZuohNqu+vV8UZy6wLD/K7lFhmM2ijeQ0G5olDUIzNVgDNgW/X+ra6
	7Yhxi+RtQ/UcRBdD/8L/YxVzxQpMahg/PtQ==
X-Gm-Gg: Acq92OFEWhck0bIih//j3cZ3EssKVChObsTFjiqvhWmdnw0lk0Fo49TgImEXluUnUUZ
	E2aUIi/ix7SKF64uEuXguvgfpT6FfZepK5CfEAGk4640nyPzQPXeEYgZtaA9Zf5gy0fVal0KYuA
	LDl1x8Ku/G921kv+S/pAwQ7cu6BkG0sWPvJcL8lqMoPA9PfRWXY7YjC5GEGCOWO2Q0SolhUch+P
	hzlRxMHz2HL9z+npDUsLdcYQo4sdBZ9cuPHd9useMc13jUrMTbKQUGLum67TOvucHP+XPcsO8vT
	Ww5c8ysEN2bv0pmEAQ==
X-Received: by 2002:a17:903:228b:b0:2c0:d4a8:85d0 with SMTP id
 d9443c01a7336-2c1e85ac3e2mr197622355ad.32.1780947444388; Mon, 08 Jun 2026
 12:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605184558.280873-1-stephen.smalley.work@gmail.com> <CAP+JOzQ6ywdzxBzc=P+JLoY+sXjM-r5LucQ1WjRZDKvAYbXwDQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQ6ywdzxBzc=P+JLoY+sXjM-r5LucQ1WjRZDKvAYbXwDQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Jun 2026 15:37:13 -0400
X-Gm-Features: AVVi8CekABAYH5LeF-Yy2GEL3wK_CGeyIdFhgEbEJeDLZrmIQsFE91_gCJJSlSs
Message-ID: <CAEjxPJ74_fo7DDvy7-UHu4w8BZTupJ=KBa71K+SE9OZFXRUevw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Do not clobber errno of the world
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, 
	=?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cristian@rodriguez.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 3:22=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Fri, Jun 5, 2026 at 2:46=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Cristian Rodr=C3=ADguez <cristian@rodriguez.im>
> >
> > libselinux clobbers errno of all consumers (systemd, sshd you name it)
> > because its constructors do not properly save and restore errno.
> > The following program demonstrates it.
> >
> > int main(void)
> > {
> >         assert(errno =3D=3D 0);
> >         /* Just a test, it doesn't matter already clobbered */
> >         if(is_selinux_enabled() < 0) {
> >                 perror("not enabled");
> >                 return 1;
> >         }
> > }
> >
>
> I don't see that this demonstrates errno being clobbered. errno starts
> as 0 and finishes as 0.

You have to test with SELinux disabled to trigger it - with SELinux
disabled, the system calls invoked by the
constructor will fail and leave errno set.

>
> > if any function sets errno, it is not switched back to the original
> > value and standards DO NOT require errno to the set to zero before
> > entering main
> >
> > Fixes: https://github.com/SELinuxProject/selinux/pull/445
> > Signed-off-by: Cristian Rodr=C3=ADguez <cristian@rodriguez.im>
> > ---
> >  libselinux/src/init.c             | 1 +
> >  libselinux/src/selinux_internal.h | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/libselinux/src/init.c b/libselinux/src/init.c
> > index 499e4e44..abed3088 100644
> > --- a/libselinux/src/init.c
> > +++ b/libselinux/src/init.c
> > @@ -145,6 +145,7 @@ void set_selinuxmnt(const char *mnt)
> >  static void init_lib(void) __attribute__((constructor));
> >  static void init_lib(void)
> >  {
> > +       SELINUX_PROTECT_ERRNO;
> >         selinux_page_size =3D sysconf(_SC_PAGE_SIZE);
> >         init_selinuxmnt();
> >  #ifndef ANDROID
> > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux=
_internal.h
> > index 6089463d..ff191c76 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -147,4 +147,13 @@ static inline void fclose_errno_safe(FILE *stream)
> >
> >  #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
> >
> > +static inline void selinux_reset_errno(int *saved_errno) {
> > +        if (*saved_errno < 0)
> > +                return;
> > +
>
> I don't understand this check. errno should never be < 0, the
> saved_errno should never be < 0 either.

I am also confused by that.

> Jim
>
> > +        errno =3D *saved_errno;
> > +}
> > +
> > +#define SELINUX_PROTECT_ERRNO __attribute__((__cleanup__(selinux_reset=
_errno))) \
> > +                         __attribute__((__unused__)) int __selinux_sav=
ed_errno =3D errno
> >  #endif /* SELINUX_INTERNAL_H_ */
> > --
> > 2.54.0
> >
