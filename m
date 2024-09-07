Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE71384BF
	for <selinux@vger.kernel.org>; Sat,  7 Sep 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725701570; cv=none; b=p9opv899qm0SDhwYcKAfHNzXGyhJfhMlY7w4EasU6Yqd74B/jfHZiW50Zlh6M/galviBTZ2xLhTjtiisbSnG7PxjrAYWXyYcW3CS3Cwt1W6oyXn8Xz1iIYKqg2lA9PtzUg0qCNt6uc46SO8C+vTyPj6gV9abFhvu7GPzcrmWX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725701570; c=relaxed/simple;
	bh=pLRCLThgiNm0DnTCnzf1SU7HK+Xdrn0HCAQw1/fv6eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmezqDgE3Ne6bGtRcP57jil3NvAknGyFusxX0o7GfzHkG4ppwZVsKKz4jK8JLoZzhVdCEjFGhuRSHZF4kJD3kPoKfPqfR098ho8tSmgE6mX6Obu+MREPH20ykbsB9tweRRNt0DgRpVtD0PDwaxQ1ivkt+/ruXdHeO5IoK2zQgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=Q0Y38i1z; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="Q0Y38i1z"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a868d7f92feso390029366b.2
        for <selinux@vger.kernel.org>; Sat, 07 Sep 2024 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1725701567; x=1726306367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYAYDwYU9XEQd7B0n4GlUaSi+kByWiSIqgApWZK2k7Y=;
        b=Q0Y38i1zmVilqk1yG+h0lMBTvNoXrstnG7FdvQT8ONLupqjAecalrZo0u+cE9rqkPY
         nbPkTsjQ3X2RFPVhFq8ZfypcIzXf/hUceAGd3FIhNTU/YUO4v+ZNGJO/nyzqWusL2+V7
         jULr/5wfpqPxho4ZxsOzJ5JHOVp5qeTxdk8ziOyPF1ZSx1IBJwfxiLP+xWEM1rzB3p6T
         XcrmI/pvptqHprJFglWaeNVLadbC2GsBGBlGhfCmbCVkHIAbn3KMq9p9btBW/EsTVUQV
         EU66u5jpoW4h6BfeNTp9HGGG6KaF4vGcP01qFBx36+A/e4eoIhfA/vhIHSrZNNofKAsB
         GAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725701567; x=1726306367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYAYDwYU9XEQd7B0n4GlUaSi+kByWiSIqgApWZK2k7Y=;
        b=Me3J2Zkcr//pKEr86alGovrhP09+I+AIWtJIZBLDgvMhgRwS1GfeI8aThV9hjMrQyf
         6SMW6uvDTqNwIXEUUU6FB2u7Fsu6DwU6W5JmJ1asHTIJl+n6B2vnAjUPR9TaRnTd1BLD
         8979n256c9KqHFwYbt/q71z+VTDrQ8HF4HPTIrkot1L1Dc4WUxyLDFIlsDyxVRWcoVLq
         xCkqU9bfvO79GtdCcEelJYF2zLSB0+y8EGmeaYm8lJ3YbBb7aLLgtciwsAupgk7UJsQM
         eq/wMCLayKsJhvQOFtq1sKh2GI7Crx+N4tBtYvTQtynX6iPbtnIqKp8FM87wUE3LvjMu
         IqlA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Pbzy8P919Vep9FwrQTynRofhax4we3bvCCzjIiGVwiMeioONtWN4gqh1NnG/vUm1VBwBAeu6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OLmDCciL9y/lkPvliaYdKmZ9ucgwM0ujl/Ol+TUo/yNdH8Ac
	YTKd14pgQ9qTLEa/uB8t1DEmCZQbgEwnoEBqJwwj5ot0qUfZsCsW6Fu9Ubo/fWujNq+PO83exYF
	P6Zb+orbtnt94AbyT7bnp6egQa2yPOC4wkJ1W8A==
X-Google-Smtp-Source: AGHT+IGWwhV1FppouK54v3V9A8eHwS6rbK0nonXkKqq2rXZ9hT6w4qHPiZkVwNteqV+2HfQ53hj21jvfFLgYyvqTkhg=
X-Received: by 2002:a17:906:6a15:b0:a7a:9144:e23a with SMTP id
 a640c23a62f3a-a8d248a6d5fmr79801166b.43.1725701567219; Sat, 07 Sep 2024
 02:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-macos-build-support-v2-0-06beff418848@samsung.com>
 <20240906-macos-build-support-v2-8-06beff418848@samsung.com> <CAK7LNASpWSXbjF_7n0MhosNism=BpvHOnKsa344RPM_wmC9dGA@mail.gmail.com>
In-Reply-To: <CAK7LNASpWSXbjF_7n0MhosNism=BpvHOnKsa344RPM_wmC9dGA@mail.gmail.com>
From: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>
Date: Sat, 7 Sep 2024 11:32:20 +0200
Message-ID: <CABj0suBQCc8=0tLng=OWW=K1hjFuLFZWhbjsqHtz2FzZt4i0sw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] Documentation: add howto build in macos
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

On Sat, Sep 7, 2024 at 10:33=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Sep 6, 2024 at 8:01=E2=80=AFPM Daniel Gomez via B4 Relay
> <devnull+da.gomez.samsung.com@kernel.org> wrote:
> >
> > From: Daniel Gomez <da.gomez@samsung.com>
> >
> > Add documentation under kbuild/llvm to inform about the experimental
> > support for building the Linux kernel in macOS hosts environments.
> >
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>
>
> Instead, you can add this instruction to:
>
> https://github.com/bee-headers/homebrew-bee-headers/blob/main/README.md

Sure, that can be done as well. But the effort here is to have this
integrated. So, I think documentation should be in-tree.

>
>
>
>
>
> > ---
> >  Documentation/kbuild/llvm.rst | 78 +++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 78 insertions(+)
> >
> > diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.=
rst
> > index 6dc66b4f31a7..de3bde925793 100644
> > --- a/Documentation/kbuild/llvm.rst
> > +++ b/Documentation/kbuild/llvm.rst
> > @@ -186,6 +186,84 @@ yet. Bug reports are always welcome at the issue t=
racker below!
> >       - Supported
> >       - ``LLVM=3D1``
> >
> > +Experimental Build in macOS
> > +---------------------------
> > +
> > +Building on macOS with LLVM is experimental. This section provides ste=
ps to
> > +install dependencies via Homebrew, set up the environment, and start t=
he build
> > +process.
> > +
> > +1. **Create a Case-Sensitive Volume**
> > +
> > +   For fetching and building the project, you need a case-sensitive vo=
lume. Use the following
> > +   command to create one:
> > +
> > +   .. code-block:: shell
> > +
> > +      diskutil apfs addVolume /dev/disk<N> "Case-sensitive APFS" linux
> > +
> > +   Replace `/dev/disk<N>` with the appropriate disk identifier.
> > +
> > +2. **Install Build Dependencies**
> > +
> > +Use Homebrew to install the required build dependencies.
> > +
> > +- **Core Utilities**: `coreutils`, `findutils`, `gnu-sed`, `gnu-tar`, =
`grep`,
> > +  `llvm`, `make`, and `pkg-config`.
> > +
> > +   .. code-block:: shell
> > +
> > +      brew install coreutils findutils gnu-sed gnu-tar grep llvm make =
pkg-config
> > +
> > +- **Bee Headers**: Install byteswap, elf and endian headers using the
> > +  `Bee Headers Project <https://github.com/bee-headers/headers>`_.
> > +
> > +   .. code-block:: shell
> > +
> > +      brew tap bee-headers/bee-headers
> > +      brew install bee-headers/bee-headers/bee-headers
> > +
> > +   After installation, verify the `CFLAGS` with `pkg-config`:
> > +
> > +   .. code-block:: shell
> > +
> > +      pkg-config --cflags bee-headers
> > +      -I/opt/homebrew/Cellar/bee-headers/0.1/include
> > +
> > +3. **Configure the PATH**
> > +
> > +   Include all the required GNU tools and LLVM in your `PATH`. This en=
sures that
> > +   the necessary tools are available during the build process.
> > +
> > +   .. code-block:: shell
> > +
> > +      PATH=3D"/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
> > +      PATH=3D"/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
> > +      PATH=3D"/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
> > +      PATH=3D"/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
> > +      PATH=3D"/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
> > +      PATH=3D"/opt/homebrew/opt/make/libexec/gnubin:$PATH"
> > +      PATH=3D"/opt/homebrew/opt/llvm/bin:$PATH"
> > +
> > +Building the Project
> > +--------------------
> > +
> > +Once the environment is set up, you can start the build process using =
LLVM. Run
> > +the following commands to initiate the build:
> > +
> > +.. code-block:: shell
> > +
> > +   make LLVM=3D1 allyesconfig
> > +   make LLVM=3D1 -j$(nproc)
> > +
> > +Supported in macOS
> > +~~~~~~~~~~~~~~~~~~
> > +
> > +At the moment, only arm64 is supported and tested with `allyesconfig` =
Makefile
> > +configuration target. Other Kconfig options not included in `allyescon=
fig`
> > +target and architectures may be supported as well as support in macOS =
is based
> > +on LLVM effort and maintenance.
> > +
> >  Getting Help
> >  ------------
> >
> >
> > --
> > 2.46.0
> >
> >
>
>
> --
> Best Regards
> Masahiro Yamada
