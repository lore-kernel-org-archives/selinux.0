Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058423F4841
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665088; cv=pass; b=RVGD4t6oRM+hnEz02Lk6yP/vY5SWWSy94pjfP5pW+c9iMW+vammmzL4Fd01YwEYDaVb+ES5cRPlRHE6ibZB5F1ZsOu1OD+cmPSDnlK7IFjZiEUXbkLlPn1jYstQ2yv0EL89HhRibSRGXIs7CII4uTB1YT20aGbD8kcd71K/lJKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665088; c=relaxed/simple;
	bh=dcYoUmU1GTtTThroZ0dwbxa6fJnUOX3+dxiwajxjGQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yh2JmDCgNXGx03Puvt8BeUo1FFqPbCLEa0rhcGHYTxnnrjT+txYlTzdTbL1uF2YKEU2gHN9DuQQP3W6pHfubx5d1h8OqoNBI5bP6wBFDqWisPqMUvzWPdO/cMhnO+FHUYPGd/33zqIdgUfnScBioYcMswDN5ZlQNLLWrcVgF6JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2KeozAh; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2KeozAh"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3967738c801so17620151fa.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780665085; cv=none;
        d=google.com; s=arc-20240605;
        b=EuBVn2NfJk1dPvVo8/C9moH8X60THJxFKa1O9x8ZVMUNiCH7c4h5WbccyvoJDh/Gwe
         AY0ad3/GoWotANGSQI0AhuPIo7ySG4YZDC1sdi2jMoU4tRCbgYbKKkV8gLg8XT8ACkhl
         /joxkpC5MeT2n0FWDH6ZfdBE7ApbYQEQPPM9fDtMLL5yyTBJzZl/pv4guSw9cmQ7zKzX
         ILrqFin7gNLqU4FJ+2bhN2r9Pe6NSnEu4/DBsV1rjr8JaZwYh9sPjs9iJmcGG5uMXjU7
         1G/VxT81eJCS/y7+2daLxDzWqesLSGebOSEgw7s3WwiITtVUQcLqWPKBHS/DviSgPrI+
         c/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NH5SkOGRvQ+YubEtBXd1OUYTasS8R8ZET7jvvlCpWEw=;
        fh=SxuEGIRhsBI/HgVXy6YxyAU6VjKslyjaHpcMDC7Z52g=;
        b=RQeo7+4ulCsntllcVdOuqmXMeFOzvJ0G//AG/HuzVxc2GKjX/ontx24S7rIl9dwoNa
         oPpElUwzToYyUWR7gMp71ZxNOq42EPbQQRMDBe+b9Hiawglxbp3yhtsYPT0+Ym/iEP9y
         tm26/lBniHG8cJ2XwDInwx8bxEd6D8Yh7Q6BcqEhyOhQr9TQiTxOl5BYWrJbDwsXCqtf
         vApJgky12wynVKacYlVfuLIsWG1Vlfq+D5Jlro0FORbTq0Bbunqz6vkWabN+BH0cyx4X
         Z9UN3kJgvuc9oMiroPPjTh6EAM79mo+Pc3uW/0rwebYHe0tAbh7TxkcxAbOcdgdN3bC+
         h9bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780665085; x=1781269885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH5SkOGRvQ+YubEtBXd1OUYTasS8R8ZET7jvvlCpWEw=;
        b=K2KeozAhzgMeVY2JeosoYtwxfsVxNSosfMCLUP42F0nBqvahtcwq+E1HplThXdBAiF
         6qtYivmplNm1V6ob0xLUHdt7N5YnN4YyBv6kP8+j3n0SQLg6vzoX6lRkwZzkpxQxWeWe
         PJQNZ4DMUTuf0MC8C0z2lcsM1c2A2TgIAcnNAy6iVWZB0JaiKEBJQiyuaazv6ZR6bWDI
         NOdsV/pghzYc0RE5wCAUN2X/3DW7d7z8AmEs0Sf3lxISJt099L+KkIGHulWfBz/P4vGw
         6q+DrlMQ6j7hILXNvez76ndzHhYwcQSgBrUlzxIiOFyrOIFO7XDaEcrPCYQCrnCVFR/d
         KPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780665085; x=1781269885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NH5SkOGRvQ+YubEtBXd1OUYTasS8R8ZET7jvvlCpWEw=;
        b=q0RhosMUbYBOhKQTYYFshQDd4eES29DJcPPOa8FC+exxf6RHGWJioq1ogYGTjguGtn
         tWmsIMczQ1yEIu6PFa4grtCpch7jgvGZlr94qX/4bfXrooAYqFiCRLDUjdqfIxROE+7m
         rtlSMd8qWyPzEfIre7s7pIIiJbbrB3CSKKFl58Xjb+vjDbdbdBViJfo2e3biirymVF0b
         Q8akYK9c68zd77Pzl7KQBMB0Zn41AZVqlNBeovKHzuLhk/lWAHxKiCY1e2cZRd2EOt++
         0OTJ8ziD3rS1LTcXa/j0xplJNPoMGVcKZkca2dwc0ZQ1to/2fkG5CiP8+tcZ8+Bn9fnG
         6iTg==
X-Forwarded-Encrypted: i=1; AFNElJ8iwtgeFu292TII9GVdCKieSpD7DflGvEfNAH4e55i0vb6TqgPwYsf43l7md6yVstLNfjYbbDdE@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOCgGIICDYnV1XKSv8bQhRbKM2xRjubAAD678pjoEKTEkbkYs
	GDDFz/5LBpQLVt/QHWouoE4KuocZEjrGgtucU0Qdj10PZWkawdEaSwzby+3Y0hiaXo6UbM5Hqtr
	esg2zGvagw6nZSUpGxvJy4MOM+YYVHek=
X-Gm-Gg: Acq92OHk/vSupn0XBTWH7EKyb57fiE6C7s2TMopqxxgc/Cbw4Rp3g35fDWbfPEQDnOR
	mikc2zsTsAU1c7f5Wn9K+3hU+8Zvpgud3Dsea6lcg5GNGjjoFlnMHwYtFl2bnxfaTjbqnqfIFt4
	2+uKmq08IHD7ShSGGjmau5a0syGrxK8fznmCatVXx8/0hc7ZuEDE5o1O1Ef1psCfhB+FTYjn+Fh
	fWWG8UamTWbnGEqEPpwuRIr4yqZMFxo6mHDuV2epibU5cghWHITIHPjLPGCxM8exnl1MfliCmQq
	b1p/YJMX57aW3hY=
X-Received: by 2002:a2e:b8cc:0:b0:393:6041:4831 with SMTP id
 38308e7fff4ca-396d08c2a81mr10427721fa.23.1780665083798; Fri, 05 Jun 2026
 06:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4DhfG8-p9=B5fvv6_GFNtEg7T-KekJyXsYQ8TmJzabKw@mail.gmail.com>
 <20260602205343.3692139-1-slyich@gmail.com> <CAEjxPJ7-Eaiqactq3wXw3spXcC2zcHHNTgrsB9HZnz_aS3oFFQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7-Eaiqactq3wXw3spXcC2zcHHNTgrsB9HZnz_aS3oFFQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:11:12 -0400
X-Gm-Features: AVVi8Cd4wW_sEeDSjnFHbkk3VBrGhE7lCdgTacQPdwet15xiAIuU7W0w8Ty6XOk
Message-ID: <CAP+JOzSA5fq-RzH0izeHyMVCfeYsF22NKT92yebfOUv=97=uhQ@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: drop long deprecated `-Wstrict-overflow=5` flag
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Sergei Trofimovich <slyich@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:40=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 2, 2026 at 4:54=E2=80=AFPM Sergei Trofimovich <slyich@gmail.c=
om> wrote:
> >
> > `gcc-17` formally deprecated `-Wstrict-overflow` options in
> > https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommitdiff;h=3Db31a43560e88600=
d412318f75a43ac8e562ba8c5.
> >
> > I only noticed it because `gcc-17` deprecated it slightly incorrectly a=
nd
> > started to fail `libselinux` build: https://gcc.gnu.org/PR125558
> >
> > While it's a `gcc` bug `gcc` devs suggested removing use of the flag.
> > This change does the removal.
> >
> > Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Will defer merging until after the code reformat but shouldn't
> conflict since these are just Makefile changes.
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/Makefile   | 2 +-
> >  libselinux/utils/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index c62ad1ed..373a6251 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -65,7 +65,7 @@ EXTRA_CFLAGS =3D -Wlogical-op -Wpacked-bitfield-compa=
t -Wsync-nand \
> >         -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=3D=
nfc -Wsuggest-attribute=3Dconst \
> >         -Wsuggest-attribute=3Dnoreturn -Wsuggest-attribute=3Dpure -Wtra=
mpolines -Wjump-misses-init \
> >         -Wno-suggest-attribute=3Dpure -Wno-suggest-attribute=3Dconst -U=
_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 \
> > -       -Wstrict-overflow=3D5 -fno-semantic-interposition
> > +       -fno-semantic-interposition
> >  else
> >  EXTRA_CFLAGS =3D -Wunused-command-line-argument
> >  endif
> > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > index 20dc44eb..ddbd2445 100644
> > --- a/libselinux/utils/Makefile
> > +++ b/libselinux/utils/Makefile
> > @@ -33,7 +33,7 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat=
-security -Winit-self -Wmissi
> >            -Wno-format-nonliteral -Wframe-larger-than=3D$(MAX_STACK_SIZ=
E) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 \
> >            -fstack-protector-all --param=3Dssp-buffer-size=3D4 -fexcept=
ions \
> >            -fasynchronous-unwind-tables -fdiagnostics-show-option \
> > -          -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-=
overflow=3D5 \
> > +          -Werror -Wno-aggregate-return -Wno-redundant-decls \
> >            $(EXTRA_CFLAGS)
> >
> >  override CFLAGS +=3D $(LFS_CFLAGS)
> > --
> > 2.54.0
> >
>
