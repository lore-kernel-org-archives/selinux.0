Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027714D6E1
	for <selinux@vger.kernel.org>; Sat,  7 Sep 2024 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725701299; cv=none; b=ROyoF9ISy9iSFTaSZJh/Tr37CuwQ7idvSZ3SY2G2yMvl7GouQ0RnvI/IghWgqzT1CK0b+0WJXbwNt8+X2NMJ2vq7uwJV/wyjAtJCJ0A/rNKEqKXX5GStk5pEQwRnZGCnFcxZMl8oYTjDChpNYzE6/xF89PCI90RKr4Me7weO4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725701299; c=relaxed/simple;
	bh=lbf9xF8T6QLgnvYifItrn1rqxgvbvmSNipCKwXxHqRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpokUZTxqN7LV/ahcHYoN8fy9mzZ+nC8S+4vrPfD1vd8SiA1BPZeN907f0pfE1x901r9+2uHjfRHj7er95PzDr6rtUGm1mIFMlXROZLKtl15BMRqlJK9YNjNuwlU7Y1O9BcikXurZWd4di2t/ItqEy4Kq1wt7ZA4aEqLb53IMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=QBkSqIgg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="QBkSqIgg"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d13b83511so94366466b.2
        for <selinux@vger.kernel.org>; Sat, 07 Sep 2024 02:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1725701296; x=1726306096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLjcQZPs76go0Vfx5eTZL9J6PO34NT3+t7m9ovsvig4=;
        b=QBkSqIggrc1IDFXRZb/FWuBGZlQgjUwQxBa9DrRKYIoMTPLVK7dZEkqzZu4aD13AT6
         mSIEGCtSWxqrUHT/p3tmUh7jHxKNy/RThweU1HW9mMGxmeoqIxWcVbiPlvIuNQ+YQ3U0
         jwQGtPlN4lYRcXBm4VdXFD8d4NaciuQ6NeuV07CtCOsJ/Y3lUFbJ/ZQxmG3I/qMLu5N/
         eWhKcRmoo1z5W8rUo+w6aUYs0rohG0UE4U/D5BSWoNgp+2N1FOL2yvwransFWAgEgnTq
         jHPaVaOvPTWrS460Wb6msEyHo/8BZOlOxkpRz1tL2sILgCnvurzYshLajlJP27bLmmtu
         veJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725701296; x=1726306096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLjcQZPs76go0Vfx5eTZL9J6PO34NT3+t7m9ovsvig4=;
        b=Ya1nZnT/0WB8n0oljyy1h2TmPxI/LbrEs84rNw0L1pi1SYJlMziIr7Ktl7jD7P4RUg
         U7qVO/9dN9cLamtd/EUY8i+mzHlCvddT6vBg1tOFp+WyLakCqDjlZyfcnssRN5qi5TAu
         cu+SgxWmsLF5LOJIrsfnzlwviUT1VDytmPuMqxl1fIsCnL/+L9cLd0doZKMQuBDWy+UD
         ywSkxVy1nIicccVKRDee7qFWNWpw2eosy73wfGMrVC2JFxCTHREpSYNJYbKZXVL5p6Kt
         mkcyZLsNjaaH2mLnNL07Gztk76e4npFvD31m6HfsejdOTrzIU2x8nh8QN6w5M/cUGm3B
         Yhjw==
X-Forwarded-Encrypted: i=1; AJvYcCUIUzCNJJtNk1DuskrVCPOp4OveUaD3MKaLAPfM0SE/R97Qk6PbZksBsqgZ3A0kpDpvhpUsqwQZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk03WC8XMPQsyR/lcz42TmRXsT4qPIrxGus/zj+HAtOJuY7AZA
	GT/O3jVLRU5hSsF4L+YAxEUB93l5QAxSOL6/TMwtD6QsSkr3FGAEBvSLjC0R8UHcEDlCr7V2omd
	t2tlCRVPDDuFepBHvxti/2fg0PPtHvn4u0Qk4ig==
X-Google-Smtp-Source: AGHT+IHhXXnbhoNhhw+Ovt49rejZC3sVAmWR3HQdOoxj8Eoar6lFd6KvmW+TQT/o1AMvFsui8ZDqx+Trbs/ZtjaLt7Y=
X-Received: by 2002:a17:906:730a:b0:a86:721d:3021 with SMTP id
 a640c23a62f3a-a8a885faa78mr441611866b.24.1725701295453; Sat, 07 Sep 2024
 02:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-macos-build-support-v2-0-06beff418848@samsung.com>
 <20240906-macos-build-support-v2-4-06beff418848@samsung.com> <CAK7LNARTnJ10ABuD96U-MaYitnX3AF=GD+N-skH7VBfAmOw9RQ@mail.gmail.com>
In-Reply-To: <CAK7LNARTnJ10ABuD96U-MaYitnX3AF=GD+N-skH7VBfAmOw9RQ@mail.gmail.com>
From: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>
Date: Sat, 7 Sep 2024 11:27:49 +0200
Message-ID: <CABj0suDiPf0ySOwQx=6k+6bTZqRmq1+tjPx7=dxSTO5DVqO4nQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] arm64: nvhe: add bee-headers support
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: da.gomez@samsung.com, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	William Hubbs <w.d.hubbs@gmail.com>, Chris Brannon <chris@the-brannons.com>, 
	Kirk Reiser <kirk@reisers.ca>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, speakup@linux-speakup.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-serial@vger.kernel.org, llvm@lists.linux.dev, 
	Finn Behrens <me@kloenk.dev>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 4:03=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Fri, Sep 6, 2024 at 8:01=E2=80=AFPM Daniel Gomez via B4 Relay
> <devnull+da.gomez.samsung.com@kernel.org> wrote:
> >
> > From: Daniel Gomez <da.gomez@samsung.com>
> >
> > endian.h header is not provided by default in macOS. Use pkg-config wit=
h
> > the new development package 'bee-headers' [1] to find the path where th=
e
> > headers are installed.
> >
> > [1] Bee Headers Project links:
> > https://github.com/bee-headers/headers
> > https://github.com/bee-headers/homebrew-bee-headers
> >
> > It requires to install bee-headers Homebrew Tap:
> >
> >   brew tap bee-headers/bee-headers
> >   brew install bee-headers/bee-headers/bee-headers
> >
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> >  arch/arm64/kernel/pi/Makefile     | 1 +
> >  arch/arm64/kernel/vdso32/Makefile | 1 +
> >  arch/arm64/kvm/hyp/nvhe/Makefile  | 3 ++-
> >  3 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makef=
ile
> > index 4d11a8c29181..259c9a45fba0 100644
> > --- a/arch/arm64/kernel/pi/Makefile
> > +++ b/arch/arm64/kernel/pi/Makefile
> > @@ -20,6 +20,7 @@ KBUILD_CFLAGS :=3D $(filter-out $(CC_FLAGS_SCS), $(KB=
UILD_CFLAGS))
> >  KBUILD_CFLAGS  :=3D $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
> >
> >  hostprogs      :=3D relacheck
> > +HOSTCFLAGS_relacheck.o =3D $(shell $(HOSTPKG_CONFIG) --cflags bee-head=
ers 2> /dev/null)
> >
> >  quiet_cmd_piobjcopy =3D $(quiet_cmd_objcopy)
> >        cmd_piobjcopy =3D $(cmd_objcopy) && $(obj)/relacheck $(@) $(<)
> > diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso=
32/Makefile
> > index 25a2cb6317f3..6cb8a04bd829 100644
> > --- a/arch/arm64/kernel/vdso32/Makefile
> > +++ b/arch/arm64/kernel/vdso32/Makefile
> > @@ -107,6 +107,7 @@ VDSO_LDFLAGS +=3D --orphan-handling=3D$(CONFIG_LD_O=
RPHAN_WARN_LEVEL)
> >  # $(hostprogs) with $(obj)
> >  munge :=3D ../../../arm/vdso/vdsomunge
> >  hostprogs :=3D $(munge)
> > +HOSTCFLAGS_$(munge).o =3D $(shell $(HOSTPKG_CONFIG) --cflags bee-heade=
rs 2> /dev/null)
> >
> >  c-obj-vdso :=3D note.o
> >  c-obj-vdso-gettimeofday :=3D vgettimeofday.o
> > diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe=
/Makefile
> > index b43426a493df..d20a440b6964 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> > @@ -15,7 +15,8 @@ ccflags-y +=3D -fno-stack-protector     \
> >              $(DISABLE_STACKLEAK_PLUGIN)
> >
> >  hostprogs :=3D gen-hyprel
> > -HOST_EXTRACFLAGS +=3D -I$(objtree)/include
> > +HOST_EXTRACFLAGS +=3D -I$(objtree)/include \
> > +       $(shell $(HOSTPKG_CONFIG) --cflags bee-headers 2> /dev/null)
> >
> >  lib-objs :=3D clear_page.o copy_page.o memcpy.o memset.o
> >  lib-objs :=3D $(addprefix ../../../lib/, $(lib-objs))
> >
> > --
> > 2.46.0
> >
> >
>
> NACK.
>
> Developers working on Linux distributions have no interest
> in your homebrew setup.
>
> For 99% of users, pkg-config does not do anything good.
> It is a waste of process forks.

I didn't think of this, and I agree with you.

>
>
>
> You need to do it outside.
>
>
>  $ HOSTCFLAGS=3D$(pkg-config --cflags bee-headers) make
>
> or
>
>  $ export HOSTCFLAGS=3D$(pkg-config --cflags bee-headers)
>  $ make

Would a Makefile variable be suitable for this use case to make it
easier in the command-line?

We can detect we are in a non-linux based environment and enable a
Makefile <VAR> (e.g., NOLINUX=3D1) and handle the NOLINUX build case
(with pkg-config/bee-headers) inside the Makefiles for these non-linux
cases.


>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada
