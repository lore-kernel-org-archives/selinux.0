Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4B367B81
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218460; cv=pass; b=Td4kuSXy9cy7t+kI4bB/+H5Q3+so2vAEsbrQm6XsKY5iUYyTNhL0cEGD0B+Ic1flXjOdBwgTLvIQkySKyyQsyt9jM5C6tl9jO3zHhXkaC40vd94l5dfZ2n8MfgVwZAhohjhS6krPX0GLAY74OvDJNr7z2pKqgaCpjiv1cM9SqXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218460; c=relaxed/simple;
	bh=fAqs/fCsSr7NjuUC6Z4FphOn0GVfMflWxE4Vw+9MOxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrvUfY3+mFYnh7RT/sYjoYolZ3xEkot0XGpA1KIxOrfp6nn0ozybqTQjpj2pZnrvEqF1PJAR2/Az3JIFvd8JKrMGmBAmeiAcHCqM8O2Dskgvqb63WrvoTjis3zp0AynaMYdw7zECnGMzbZqlz+jFYZOVkoQ0r+sJ1tsGPcqzYyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULqpPh5A; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULqpPh5A"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b4583f0a1aso25663755ad.3
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 12:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779218458; cv=none;
        d=google.com; s=arc-20240605;
        b=U56BXhi0xi7gDz76ETUNH3eC34LBQwAEq/FXbPpQkWM2VLXwCVNtOakpg1wuGI0gEU
         P/Xl7L2Zr22FhEO46vGP6Zsv+WV/Cz9jKTRtRaInbw/LIMK/fwLEjYNPRpueCZBFNgQX
         VLc5k5xitH0Ca6g9XcRWIG/q4GzTw9p6f2n3HTFIKFDqBwoHwTsnWStCimehXCzobBo8
         O/kN+ZHDPeIn511OglBlG4s1MfFInhtTBv6AhuHKoQoCHhfqqvZmceQhV5jZcG9e/lmd
         jrxIM0OrR3PTK0a+0HyGO58ubCwvR1DwPIfInTrkG53AMUTK6PfkxIg7KD5kXxEh6d7L
         KG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=86AL7wGyzcgMOygG86spmOAsXRgC7Cs2vdi5V/X0wtA=;
        fh=XPfnPeS4wglRmelDXjWECDrUzh1HlzFzhPotAf04/Ag=;
        b=EEg3tMocLfCmBl4UT0x0T3NrgXQdxGsMKfhTF4AbasIvLp6E4rfeLrc22pOQWWQqXh
         q4ZksnP9Zfg7x4SHaBpXzjjvg17Ery3HNgMyeXbedmwMlrvPWaQikUxLacI4O5kl31Kk
         o/6vtIowaw5RbtNlSfkjbX8l1n34mZir1urXTz3kKz6MgYnr92Zy2jn1982coeqG179d
         al6hb6cv+m2eOzyvJWFs9VI6iccZhUGnYdo2cBKS8j5SBEty6pByHkhc1jlFegFlQbM1
         fHuPmDfyv0Up3uWVQs2YLXjhQrbHgl2dYFH3qK3fRqrfR+/nIHbK5uZmtSji5z3nDK7J
         pyKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779218458; x=1779823258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86AL7wGyzcgMOygG86spmOAsXRgC7Cs2vdi5V/X0wtA=;
        b=ULqpPh5Am9OEh0PX2EHUmcKNGMXJaeYTwkgZBO1HsTBXOga8uT2mOb4BLpmqlsDxYM
         zQe62Lg6B9akTVRG+plcjKj9nljRBlMSmAy8EFes5qbD7asQgKKcGsh1FV4RuisayTib
         u5+LVTX/Yy4h5K2eo4h0mw42yC7MIKP2PwsZ88hZLQR6tf8VWkFKzAUBlJgPNc/22uvs
         7KgA+FgPWI5CodHqUCrKinjHALmy8nXtss0Vmg4NvoT5PcPdZj0I5bE38iRXDwmCF6Nn
         UnicZ1mQ8apxXMyBh+7WrZqeMJZuJtLr6yu4pyQKWIGgv9eUJqYpO4+euWDmgi2s91Wi
         vFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218458; x=1779823258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86AL7wGyzcgMOygG86spmOAsXRgC7Cs2vdi5V/X0wtA=;
        b=Wq/1j9F4IMbgSZXlZrf8Fhn/WkRBm5pB/aDBubEFu2vuq3cCXRMg6HEBMLmklYHIDd
         Qk2RROKMMv1VZ4DAxh2MGiabRwde7nVOmfv6bIpI2a97EYpp0POva0kbfgxDUFbh3wAk
         4Tl0X9EcCU4ty9fNly43v4PZVwEdvaf1uHEl6YbQJH6FH8uREmoRGLqba1wjVDmwUiij
         nM0OFDAbXk9KwGdkVVCIYQYZLsHeBg12FFACm3CiGwLq0VqlF1kGj60yKKy27DQVLb3y
         SjGRxH9VdL0mGU6BkyJBUu/MNLuimpVzZoHOMGnYDci6FPQ5v3wdUMa1opBObLYjUU+b
         GPhQ==
X-Gm-Message-State: AOJu0YzL+JI4wf5TxVTb61TEGFoCf2tT7siAci1sx0EUqbUAZ16BHLgt
	ZedVOcUFcjt9qYCYeTGgDxlqHF9Tqvn12zWSJn0z+Hr4rvgr9QLgXGH1HnIxYPYD2mYq+xGtlMR
	orNcpsfXyaxrAMyW0AiEqjeDPOr1ShDvZwg==
X-Gm-Gg: Acq92OE0gknI9uhOs9abUrxYoqTb3wGSkJxfKptRj77ilIcO3N9nzpwH/BpT2hvYH3K
	qPQ6Q2E9MDl0LeCnWif14bGbEpaAbZ7VaA/UujtjVWFI+GTSkRLWd5k/9npTTllIpkvcRDMmmf3
	uEB+MZe0Fp624OnvkiuaqJig6agHvXoU7bY9WqqXq1ZRxUbSBFLs2ulvLiJfGOQv7WXi9R/5pJq
	B+c5ET6UUO/8j2+Uf0lbmMmwrd/s5N9Bo1BRNqpgewu+qGNw1j6m+jPW9am0ptxgmAFeJvGTkVT
	S1D8w4lpDue++NGVEhIE1TbLjXxe
X-Received: by 2002:a17:902:f707:b0:2ae:4a4e:1e25 with SMTP id
 d9443c01a7336-2bd7e8aef4amr229002485ad.25.1779218458473; Tue, 19 May 2026
 12:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219132151.34299-1-cgoettsche@seltendoof.de> <CAJ2a_DcODAx5xGABLHbuTjKgGpAB46KNdHC31ffWGj1h4m-ARw@mail.gmail.com>
In-Reply-To: <CAJ2a_DcODAx5xGABLHbuTjKgGpAB46KNdHC31ffWGj1h4m-ARw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 19 May 2026 15:20:47 -0400
X-Gm-Features: AVHnY4LQcUNxcF5hjFyF_Dh01nGP2QN5nz65E3TllZz8O4d9quQxNDmwRBT0iog
Message-ID: <CAEjxPJ7kLu1Fv=QZPzzDoHqLvN8kvKYDKAw+5=z6LU3ioM5Ckg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: improve restorecon progress locking
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 9:53=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Thu, 19 Feb 2026 at 14:21, Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Use an atomic counter to avoid acquiring the synchronizing mutex for
> > each file.  Only acquire when actually writing to stdout.
> >
> > Also reset the scanned file count at startup in case the calling proces=
s
> > calls selinux_restorecon(3) multiple times during its lifetime.
> >
> > Suggested-by: Copilot
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Kindly ping.

Can you split into two separate patches, one for the progress locking
improvement and one for resetting the count?

>
> > ---
> > v2: use GCC builtin __atomic_add_fetch() instead of C11 atomics for mus=
l
> > support
> > ---
> >  libselinux/src/selinux_restorecon.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 8fadf4d2..ac9f6bc5 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -39,8 +39,6 @@
> >  #include "label_file.h"
> >  #include "sha1.h"
> >
> > -#define STAR_COUNT 1024
> > -
> >  static struct selabel_handle *fc_sehandle =3D NULL;
> >  static bool selabel_no_digest;
> >  static char *rootpath =3D NULL;
> > @@ -694,19 +692,23 @@ static int restorecon_sb(const char *pathname, co=
nst struct stat *sb,
> >         }
> >
> >         if (flags->progress) {
> > -               __pthread_mutex_lock(&progress_mutex);
> > -               fc_count++;
> > -               if (fc_count % STAR_COUNT =3D=3D 0) {
> > +               const unsigned STAR_COUNT =3D 1024;
> > +               uint64_t fc_count_local;
> > +
> > +               fc_count_local =3D __atomic_add_fetch(&fc_count, 1, __A=
TOMIC_RELAXED);
> > +
> > +               if (fc_count_local % STAR_COUNT =3D=3D 0) {
> > +                       __pthread_mutex_lock(&progress_mutex);
> >                         if (flags->mass_relabel && efile_count > 0) {
> > -                               float pc =3D (fc_count < efile_count) ?=
 (100.0 *
> > -                                            fc_count / efile_count) : =
100;
> > +                               float pc =3D (fc_count_local < efile_co=
unt) ? (100.0 *
> > +                                            fc_count_local / efile_cou=
nt) : 100;
> >                                 fprintf(stdout, "\r%-.1f%%", (double)pc=
);
> >                         } else {
> > -                               fprintf(stdout, "\r%" PRIu64 "k", fc_co=
unt / STAR_COUNT);
> > +                               fprintf(stdout, "\r%" PRIu64 "k", fc_co=
unt_local / STAR_COUNT);
> >                         }
> >                         fflush(stdout);
> > +                       __pthread_mutex_unlock(&progress_mutex);
> >                 }
> > -               __pthread_mutex_unlock(&progress_mutex);
> >         }
> >
> >         if (flags->add_assoc) {
> > @@ -1118,6 +1120,8 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
> >         int fts_flags, error;
> >         struct dir_hash_node *current =3D NULL;
> >
> > +       fc_count =3D 0;
> > +
> >         if (state.flags.verbose && state.flags.progress)
> >                 state.flags.verbose =3D false;
> >
> > --
> > 2.51.0
> >
>
