Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7F2D7DF7
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765705; cv=none; b=Ci8KOOTemZO5Md/sdHTj/p7VwnDrgNhZQYg6kqdVpSTVa7G7/s/ic85Pae/JvWsGVJPqt9y3EjQuR+PGbAb8nP4dd4ED/kVQseOFRr+cDTaRP3nDMPUCN9dB1YU/aJuTnKWc6oH3NtI7IWMRG1/HZNWWfESGWg7Qqd3eDyVRxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765705; c=relaxed/simple;
	bh=RKpdFK4lBxt1deQ7lajcfXMG2L54FCcU5mSDWxOuGnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n44PuC94JASy7Tbrx0iTIXPHwgnsNnkR2tn3oc93snbvXmSwRmBNYLXom703s1SaJYvmLJ4GI9vS8+xmMrcJcBecQDi9JYeW8vyP60vGolGjGiOkhaErzbDX8+l26KknYFrUEYh1os9Lnyb8ktO0Gq3mD2N+qHerwdXQbODZAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM81ky9H; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM81ky9H"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b550a522a49so4430614a12.2
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759765703; x=1760370503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSVoDP1gMBKEyHdLBojGetmP9lwc24i/sF9TfuCE4Wo=;
        b=mM81ky9HdMhc3lPK09in7BvHG17xQDE28BLQVoswTj27qHvYO0YUKZXRbI9zzzIU3Q
         XTXA9IShzPRfYuv12Qw81nKdwOQCUAU4bjCM1EIRKFY2iIxbcLiSOzqnUrXsm0dj+48o
         WETc0oEe+MsqS47quVrc7zfnJUH6NoNhdzDLaw0o9hju/u10urDeVgpjJ1PWqWCn5a/G
         vBNheQtywLxLLpa+JpltetrFB4d5Yi/8CkUu1bYgShNdSXgmjPqgaeDY91wuc68+S4lY
         SAhDAt5d4DMyrfbQ6g1fPL58ENOKEV7pmXgBvnWiz2cWOvzsO4k6b6kM5HDzyOl8pq90
         ZOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759765703; x=1760370503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSVoDP1gMBKEyHdLBojGetmP9lwc24i/sF9TfuCE4Wo=;
        b=YIkisIxpCXdBzpd4UQAZezIaxoXjgLUkdZxLA2IIQgQrwVfD0F0y8ffrC+d0R1z/ca
         gJGRNBy6Nimc8oeexes/oy0P/2QEPa0UNvxHzsmoVRK8cd4BP3O1xIQPeUIXAVDnwFhP
         8ypzXkutOq0vx25T+tUiAcGexl3fh+Pv6hyD5FIWuSAQZjMOvSuGkGvhpePuBYSU+WxJ
         kU/qPWXAvMPenpikFVv5/Gv3NNCzkrvBgqr87kx2XYqRMBWoWCdtromDt6fxMjpSaMgr
         Y9qzKNPBBn+JJZbjvW22GZ3ajaoNcwewQ8oIcO7anuQI+yETC9f9TNmaiBOQ/p6fuDIp
         ftYA==
X-Gm-Message-State: AOJu0YzXrPYtp2KgI6BJjbmO3lbAC800IUi70xePlfs2adaEzetUzMp9
	5/TKlP9eDt+rpW4x4Y7YCPozJUokVseu73lXy0r2PkEnTD7xse33wVixjnGub5fPu+XVbemXeOE
	nbmu0VDsN9Y3ORBqVdU8Mj8h5DXL1TE8pvA==
X-Gm-Gg: ASbGncv4XuM9FtwHN00qINVwLWSIF7JxOCdvYVc5Cjx3oZuZQO5yQG+jDYhqG1rCt8f
	jWYYq1RgMpD5McVlL+EaL2TXyf+gMenIGyvIi5LH6FJNkDllEIfXtOfNlzEvX/kfjz931WGDNwS
	aZxejMRUbWrAAqe0GGLF3nRigPmEpvMijJnQa+ow+3EuUzqRLiRHhHrj88Il50oP+YcHnMSijop
	hvAnbo30KdJFR5pGqDThQHKc2QvPmufG5c4KNPsBw==
X-Google-Smtp-Source: AGHT+IElHn4/ltobpkmbA3qN7FIOW8lVu0ld6+EAmaAt70tNTm82sM0qGJtPEE7lrkfPMGGAdOYPHIiN8I2B1a43eoE=
X-Received: by 2002:a17:90b:1649:b0:332:8133:b377 with SMTP id
 98e67ed59e1d1-339c2728546mr19328712a91.15.1759765703436; Mon, 06 Oct 2025
 08:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912132911.63623-1-calebcenter@live.com>
In-Reply-To: <20250912132911.63623-1-calebcenter@live.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 11:48:12 -0400
X-Gm-Features: AS18NWAPLKBgpP2I7YNvdLybwrA84bVT1eFP_U6z7-Suco_wonuTYDmx2UPV2vo
Message-ID: <CAEjxPJ7y-vhX-dVRr6CPw4D-2+FjM9mYj9_HwJrM0XtzckFG=Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix TARGET and LIBSO on Darwin
To: Caleb Xu <calebcenter@live.com>
Cc: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 9:29=E2=80=AFAM Caleb Xu <calebcenter@live.com> wro=
te:
>
> On macOS (Darwin), shared libraries have the extension .dylib and the
> soversion is between the basename and the extension, e.g. libfoo.1.2.3.dy=
lib,
> which differs from the usual libfoo.so.1.2.3 scheme in Linux.
>
> This change sets the TARGET and LIBSO variables appropriately in the Make=
file
> for libsepol when building on macOS.
>
> Signed-off-by: Caleb Xu <calebcenter@live.com>

I am not a macOS user so I can't test this myself but it looks fine to me.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index a1aed072..90aed394 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -40,6 +40,8 @@ LD_SONAME_FLAGS=3D-soname,$(LIBSO),--version-script=3D$=
(LIBMAP),-z,defs
>  LN=3Dln
>  OS :=3D $(shell uname)
>  ifeq ($(OS), Darwin)
> +TARGET=3Dlibsepol.dylib
> +LIBSO=3Dlibsepol.$(LIBVERSION).dylib
>  LD_SONAME_FLAGS=3D-install_name,$(LIBSO)
>  LDFLAGS +=3D -undefined dynamic_lookup
>  LN=3Dgln
> --
> 2.39.5 (Apple Git-154)
>
>
