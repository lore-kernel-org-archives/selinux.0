Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4F3B42FA
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676955; cv=pass; b=FpxIAOXB+zQTIimhvOq8azsnfMM7WY9stN9ronkcEQGJMpVuxgykGsWHMevvj7JXQozQVJBdEtD1ZuttQ3+8nKyprkTDVTiuWHsaLU+gHSUjmC045Iru9mqRgO16fiF5w/gmCpNtT3q9scXuffuLJDf/PMTuy1SW4Nb9tcNiVAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676955; c=relaxed/simple;
	bh=rJuZ4LARq2nMZQTPkG9oHNX0ssJh94D/rMzuZqKQWDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKVRGpXF6ThyAEZoRTsD4P2mTrJXvRSORQygRqYjp3d16ulhW41Tdf024Ve2bjmLm70XEx9LbwBvJX+DjAT6Twa34QXTy6xMPyLTujfiGG9CwZpH5agsfsdIH8qYNINbDaZ3Vw9gXK+rQR4BwEK4n82XRc1984rBha5aoHGp37k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pye5HHsB; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pye5HHsB"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8422871b42dso1276244b3a.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676949; cv=none;
        d=google.com; s=arc-20240605;
        b=IAjzTyQGqDFIlZo40Sd8W1dzHw+in3UNDFWJUyeOHgTg7cG2FmHgCJwzA9llvqsMKy
         o2Z9js+PkxjfWAwSD9nIeETGe+YG+P0xkL6NVVDR1D8OIDWfljsU/x3BKqR6bOeY3B/R
         kcW329VuwfDgK1vxmc3ZmAeX0lNNS6FglYnOLjCV5Kvt6Yb74j8bdwxjXINWVq9atQ57
         LWkrCurFUNPy78hjMvHjhTib15qG4DUqd9x8ONsdvzEgDCShjdDfuKP/NnLJrvQmLd9K
         EBRYhAscgJcqv0ZY6QGKMdU/TZqKNrIH1PoxBMox+fxRWrLyq0R7EkCvCw7GC62VpyU/
         /6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v+5C/Pmpew16ll0TUQSXZkgDaVzCrNBKMWmnHMOM8hA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=CPjsLmjNlahaQmPqfInrMwqVEicBnc5e3MmKvj5cKoRFgrUWMaHkrcnWjXR+jFmasj
         MTAhU/LfCJR/a8616yCA/EHicdMvj9zFNW4adVmMR28yVxYJ5AhSWymHPsvpfcUu9gnH
         qq9JlPu2iQnj65hXSGDMdgeNsihxqozJ2VaF+9geSbQtfnYkbYT8gIyCgtZbBxCR4iR9
         TYss9+gkRQ8X4lXgGtc/ESNSMpapCA61nt8DNMySI1a6l0xu5mN4scHAAtEIMIuU6EPM
         50Op6bVgxtEVFtrsHXd4A+2GUagl6dADleH98O+erP4sZcbb7iRccDS37n5xvvm+hMOH
         ABVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676949; x=1781281749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+5C/Pmpew16ll0TUQSXZkgDaVzCrNBKMWmnHMOM8hA=;
        b=Pye5HHsBYiHm3nc5e7e8XxTaWXIUMICSEViR3FljoYDaHL3dPXdo2qV+lOKPORxLnl
         gBC5J5WV7AoqEDLURv9QhAT6L4mzHDbZvlayZOR0AX3x5+OGl61YCB/2xV/N29/x0zwJ
         74bNKCt2nS3zyz+jAED5RUK2v8GeuzQU0sla6s0IjTMuZX940aac38ztX3pS2Gil2FAh
         vjxQZigBviwzBwkIEZkOdN/h7ha9raNYhgJPGzI/Dk0Ez4xlZgeV0BhEyv32Gr+K6bBJ
         fLBztSPfQyyaIiLWARRjqXpwBPz8kvA/8XbUu1+AN/HiK07NaXtbslzUT+faow1GiOhG
         MD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676949; x=1781281749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+5C/Pmpew16ll0TUQSXZkgDaVzCrNBKMWmnHMOM8hA=;
        b=g+Op7oG7UqWnmyGJxuKVgd7rdMIghmIf4TjukQJrVBwuVDFU8d/SjepRQzI3chMIl7
         mUhJXJNTIY0McYPH4pMYFNxmGGSNOutKGRdFJCGkWqgd3h0l6ojekYd0Q19miJ8qHzt/
         vzbvBVyeSppPGqjfb+bGNK3lcHh3BnOaIkOQH0STbje5bbr0JgNEHyElCWjEAd3ErZzA
         tvLkL0EEIjknPbY5wUEP/nW2l4M+p0a7kKjy9/j942IFl8QYEV2P7pIsYfFwAhTfJKd+
         Q4BgatsfJRE8cGHPKFBfnGB/mRXUKf42AKN74t0MM2fLNpoPizco2m9Y89U0p71JrAP8
         wZYA==
X-Gm-Message-State: AOJu0YyeInMxsxXuQuOLFzwaA5n4P5gb+NrssaZNs6C5GVKRWlLL5GJC
	3Y6ka1SSupQHPbzhf456O3C+nbfjvpU614l3v9xbeTVTfSSYDHvVwIYhebeqTNfCCzHaQmpAhFJ
	uSn/OErbHq375sqXp5sH9vlVDlg6AHVldGg==
X-Gm-Gg: Acq92OE4sdmZIni1vAYutgtjWueOrm4sOrw72JahAIDvYS9EtOM/MRVzzst4BbY8B5o
	kNaeUnoS/h+RjqxKpJMEvG2rj2/HTYK6aqed7Nwasu2nt0zdmvE+LKEkvE3+RK7Q/yVuDksAAcJ
	0BOAJFoS5VlQdNe9UCBWHbP+7qcnq8LPr6N/Sn12+87qs2aIHg0JZfoptaVpnZmjjQxZtVq7e0w
	QGbhfvSW74+vjq+xts+YsPLnI44wZkS1sBUqLnvPlj3LE9MIQvYGZcu3MskuXlow2LK7yuPkqxl
	Us9+E/7iboO1UphiUw==
X-Received: by 2002:a05:6a00:400a:b0:842:4387:34b7 with SMTP id
 d2e1a72fcca58-842b0c06b07mr4278604b3a.10.1780676948667; Fri, 05 Jun 2026
 09:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605133327.62535-1-cgoettsche@seltendoof.de> <CAEjxPJ6A4+MaU8hxp2WOtNPYxOG4pBkf89SRBHknOEK50kLxdQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6A4+MaU8hxp2WOtNPYxOG4pBkf89SRBHknOEK50kLxdQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:28:57 -0400
X-Gm-Features: AVHnY4LaWOneeq5P59fl3anP6EsSoR0YTmmlSgNUcf2uF17r83necJmSjB8Vlcs
Message-ID: <CAEjxPJ7F++wWzSC3Ktq1yGsR-vPgNOL432=YqFnae_Mx5AMDsw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: support custom clang-format binary
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:57=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Allow overriding the clang-format binary, e.g. for versioned LLVM
> > installations:
> >
> >     CLANG_FORMAT=3Dclang-format-22 make format
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
> > ---
> >  Makefile | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 972d5525..0e70f3d4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -4,6 +4,8 @@ SUBDIRS=3Dlibsepol libselinux libsemanage checkpolicy s=
ecilc policycoreutils $(OPT
> >  PYSUBDIRS=3Dlibselinux libsemanage
> >  DISTCLEANSUBDIRS=3Dlibselinux libsemanage
> >
> > +CLANG_FORMAT ?=3D clang-format
> > +
> >  ifeq ($(DEBUG),1)
> >         export CFLAGS =3D -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall =
-Wshadow -Werror
> >         export LDFLAGS =3D -g
> > @@ -55,7 +57,7 @@ distclean:
> >  FORMAT_SOURCE_FILES :=3D $(shell find $(SUBDIRS) -type f \( -name '*.c=
' -o -name '*.h' \))
> >
> >  format:
> > -       clang-format -i $(FORMAT_SOURCE_FILES)
> > +       $(CLANG_FORMAT) -i $(FORMAT_SOURCE_FILES)
> >
> >  check-format:
> > -       clang-format --dry-run -Werror $(FORMAT_SOURCE_FILES)
> > +       $(CLANG_FORMAT) --dry-run -Werror $(FORMAT_SOURCE_FILES)
> > --
> > 2.53.0
> >
> >
