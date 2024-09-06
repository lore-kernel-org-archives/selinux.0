Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925C1D1F69
	for <selinux@vger.kernel.org>; Fri,  6 Sep 2024 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635302; cv=none; b=rl0ufhUjoJLla++JrWk3GL6gamvpXm/Sxbc0DZO0IShqZ/hOvbsLKN9cvGPYW7hO5Lbaku7fAdMH1VPJyhHjKaVYgrfgxdt+SUcYxKLayHS34ASX5LPv1paUnsT3SIY+wVbIuwRa6Elk2+YN32L3Rzv/ManAjfpQ5D07+jO2fCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635302; c=relaxed/simple;
	bh=CfwA+7g+HrXEdbWCSTlc/6vfhCHNjAmjh8fb1L7ct9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fr2P7W26c14guiOS8cQHPr15bmFrEPHNKurNKupUBG0Ero17M6QE2+7e0dp21M0RFytkCAxR7xps1/PNdk/MYd23zcabIKl/y/wWv+wd/CejnBzI5u7815Z7CoTLzpmghO2hgDImmUZkkag9QWy8n5ufnxTMYd9Up9YgWq8ILD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=gPntb3te; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="gPntb3te"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso6242286a12.0
        for <selinux@vger.kernel.org>; Fri, 06 Sep 2024 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1725635299; x=1726240099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8bMi8neSlk0H33MBuzRIDN5M+I0beTdNpKiekVDuiU=;
        b=gPntb3tebZJATK5fL7ndBC01PsTB42YlHF0sGstq2pZvipVEWMVFbgKDcLY3LBTlI6
         81eRnLl3IDof0i2YDajnEh5XHdqKwWmTu/EJ4u3PUtt5+k92ZMtP3isuSTsxBT49RXf5
         fVuxpdA3C2KwdoSKhvxyIx0JXpQ4qWJmXUjqxBmSMVdEFI4AgkDP0oy+M5fSUmMTwYbU
         C0NEdCUmDjM4G31bEqqQDm0hvCR5MEI4CajF87lB9Hx8odEYFWekdKnr97K+1WShzXSN
         1za+yWZYjNdSBHXRA0HDobthVXbE5pBXs0/edWUAvhDIxRlbIZ6m3gXaEcZXlu4Ignc6
         4IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725635299; x=1726240099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8bMi8neSlk0H33MBuzRIDN5M+I0beTdNpKiekVDuiU=;
        b=nEkYG/6J1Kl4c2QNrogQWdauAk0M4foZnF4uP0cQOimQowQntUJhnPGRYug1K3mlKD
         kf0Cq/poExRvRVd0L0gRaHRIna0zx0UXCqxkGG1bhowl7dtrRG5EVQOKkr0VEeduqFyX
         fmLVdsEzujJGjHZmgRmn3CfzS/Fh+QBKXKK2EzAmzOaqmq15P7yMYUNNTcYt6rvkm3ad
         24gxlCCgdroxHUJZEUHGQ4kvtsVgfToV4cfFqcAUtdVxhkSYB3XsMEyGXOvNTffBTVdi
         u1MQLb6BFcn4QSJyT/uc4WEUOCH5isxZa+33AC2sHtReWsC9VwjkCG/DMo3eIyUWVMpb
         WcvA==
X-Forwarded-Encrypted: i=1; AJvYcCU+rcTZvQdtDJ4Tyxnj9ZWmmxCY6P2WzKvjDbTBcYsrAwLJOjGklwoLEXYYO7vjQmiIqIVoS8uM@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQnc/yvpMWdQ/U9h2fNpp90JO2tpnpuqS9Zg5KEJhX3J2d2N3
	zn8LsQFegkc1t1Ivnk3HuBN/3hWzGgbwmXccd2h0NofqJtA2jo09JvOUOI5yvdh9OfHgvA8Ypi6
	yznXeG/va6Cr/KNhG02sN+5Q+IEAt0XAil9Zrnw==
X-Google-Smtp-Source: AGHT+IGUA1wnLPvaqVG65cpWb2qjjv+ZYvS15NsPxrxeFhQA7Z9cxOvMhyKovH+37PHRvGwnr/HounhIwA1d4bXQ4q8=
X-Received: by 2002:a17:907:ea7:b0:a7d:89ac:9539 with SMTP id
 a640c23a62f3a-a8a42f8af35mr889231466b.7.1725635298533; Fri, 06 Sep 2024
 08:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-macos-build-support-v2-0-06beff418848@samsung.com>
 <20240906-macos-build-support-v2-6-06beff418848@samsung.com> <CAHC9VhRpHgqN2fp1J3x9=zBqNr3QHsSDgUnoZ7M-SuOQ6hQ4nw@mail.gmail.com>
In-Reply-To: <CAHC9VhRpHgqN2fp1J3x9=zBqNr3QHsSDgUnoZ7M-SuOQ6hQ4nw@mail.gmail.com>
From: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>
Date: Fri, 6 Sep 2024 17:07:52 +0200
Message-ID: <CABj0suDY3duFeZx8ghEJm3vTuJvcVuoYZ6BpYn9SCaHetw3oNA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] selinux: do not include <linux/*.h> headers from
 host programs
To: Paul Moore <paul@paul-moore.com>
Cc: da.gomez@samsung.com, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	William Hubbs <w.d.hubbs@gmail.com>, Chris Brannon <chris@the-brannons.com>, 
	Kirk Reiser <kirk@reisers.ca>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	speakup@linux-speakup.org, selinux@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev, 
	Finn Behrens <me@kloenk.dev>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 4:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Sep 6, 2024 at 7:01=E2=80=AFAM Daniel Gomez via B4 Relay
> <devnull+da.gomez.samsung.com@kernel.org> wrote:
> >
> > From: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Commit bfc5e3a6af39 ("selinux: use the kernel headers when building
> > scripts/selinux") is not the right thing to do.
> >
> > It is clear from the warning in include/uapi/linux/types.h:
> >
> >   #ifndef __EXPORTED_HEADERS__
> >   #warning "Attempt to use kernel headers from user space, see https://=
kernelnewbies.org/KernelHeaders"
> >   #endif /* __EXPORTED_HEADERS__ */
> >
> > If you are inclined to define __EXPORTED_HEADERS__, you are likely doin=
g
> > wrong.
> >
> > Adding the comment:
> >
> >   /* NOTE: we really do want to use the kernel headers here */
> >
> > does not justify the hack in any way.
> >
> > Currently, <linux/*.h> headers are included for the following purposes:
> >
> >  - <linux/capability.h> is included to check CAP_LAST_CAP
> >  - <linux/socket.h> in included to check PF_MAX
> >
> > We can skip these checks when building host programs, as they will
> > be eventually tested when building the kernel space.
> >
> > I got rid of <linux/stddef.h> from initial_sid_to_string.h because
> > it is likely that NULL is already defined. If you insist on making
> > it self-contained, you can add the following:
> >
> >   #ifdef __KERNEL__
> >   #include <linux/stddef.h>
> >   #else
> >   #include <stddef.h>
> >   #endif
> >
> > scripts/selinux/mdp/mdp.c still includes <linux/kconfig.h>, which is
> > also discouraged and should be fixed by a follow-up refactoring.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >  scripts/selinux/genheaders/Makefile              |  4 +---
> >  scripts/selinux/genheaders/genheaders.c          |  3 ---
> >  scripts/selinux/mdp/Makefile                     |  2 +-
> >  scripts/selinux/mdp/mdp.c                        |  4 ----
> >  security/selinux/include/classmap.h              | 19 ++++++++++++----=
---
> >  security/selinux/include/initial_sid_to_string.h |  2 --
> >  6 files changed, 14 insertions(+), 20 deletions(-)
>
> Similar to patch 7/8, please read my comments on your previous posting
> of this patch, it doesn't appear that you've made any of the changes I
> asked for in your previous posting.

Sorry for the noise, Paul. I=E2=80=99ll review this one as well.

>
> https://lore.kernel.org/selinux/317c7d20ab8a72975571cb554589522b@paul-moo=
re.com
>
> --
> paul-moore.com
