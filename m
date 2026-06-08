Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED9259C82
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922868; cv=pass; b=Uf8/iodWpJLdyz3Rm1NsXWAgo3lV7IYJYw/xsXXp/dTJBJqY39OF/+G+AouBgVn7dOl+NGvLAqyB7+FXoH/i/vlqHs5ad/HX5e6rcx2u6ZVyXUV+Q0yumzaDr2aAK9RfMS41Quvafv63q0+Ag25MMr/DaECJG6sOYMFRruFRlvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922868; c=relaxed/simple;
	bh=zz5Yhr7vRHHWPi6D73tdeVXiJJhmEpyu7HuF7g6R+ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ex+jnRhGTEq+BBT43za0ua+3SAlCavuuihkMeEmsXeGUvCapwYBMAeTCq2EUzgK8ZQZcX/g8Cm0HB+DNzYPD+PpqOc9Ahl0eA/5mztsbbjekpdaiOJQY6g8NNAffdOSrhfb2VKzcmNgqsSM+E/eZ8Qf+/z7q5MDJDAIccESAtrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3UkOAXG; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3UkOAXG"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c858cc9870aso2295678a12.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 05:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780922865; cv=none;
        d=google.com; s=arc-20240605;
        b=f+AIRLdlpN9+NIWmovc1NuunOkWLMr9ekOK3iHJxkfWijINWg1IbQnzmcOIPZ4BuRe
         XozQm5JriFJlruZV0meVjZZDesj9L79k5w10dz6Fy+ZPXu4xXYJ9u1PhoOzVXHJtLyjD
         9bOCv1fPbddau7vhnmCYiBlPajSdskMLlHdq1bZ6XwSUrTRJCapnvToZq3gZKnZ1ILBy
         eLbvQz2EqRuyHyxmWEa/7ne9IeQGx5UgOg+WnVakeEfaYUHahYOBWNeUJgH/cQFpbmz8
         rD7o0Yeosan/CNZFr6Kfx9npD4ftom2N6fsyZWJZ9VnmPEJYtlOvur/IfmMMOmX5SJQ1
         Kplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kz4XKscbNmYQzkZ0Ik2USW3dCutGoZ2uyit9wH+5F1M=;
        fh=teCuqbtyRM4Tgu/qjn48lO8vG8x3Xo0e287DZw7JaQM=;
        b=cHZadr2/s4yupTKlTEFYb9XIWEOBpVS5eYdArgAz7F1nMZPUdAFFYjVxhYiQRDyIQV
         Y2byWII5CZ7CibxhK/8rUHh1gis3zfK/w4lwHZy/CmKjc/yYBc8k1+VxM0WTyQVhAgl/
         vnkdNvF2lTZyfMFoZTNtKvxNiBfWEgPfplvEu92PktQ3qbYpBRiH16zR5XyPoTo/8/28
         sRkiFSiM9/P+8+7Mz/PZbic6V7B9X/rCPfKXYj/WW3Tk99jlByKau+P6zceI8gcu1lxI
         qSSUBXKwJaRsGmvMfCcINOiCDy0AYUNBEbTVUkQmKBYSR2q9xnSL+Rr3qq/9IAYe/lGP
         hA0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780922865; x=1781527665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz4XKscbNmYQzkZ0Ik2USW3dCutGoZ2uyit9wH+5F1M=;
        b=B3UkOAXG7rRamcEI/1B6StZUs8BmNKVdFqbRZ8DBBGI1NLh3y4lAmm8sB/LI3lp5Oo
         4nojcA3itklKanDFcPYxfgOsJc3v8JSqdl9HNOTSL+FWfo59RG0Vhq6aSVkBIVupnHVg
         A2uTWbu2ZKtWDBtkexXie55FQmxkmediom2xErjGFxNpH/YUoo77e102H87Np6Z6Moax
         rPVtfQ5W5x3L7FAYHQCSyiJ992XSPRUEDHKw/Vv/WXhaUNrQU+mZvJXQexODRXK/hHvL
         1Ht9/miUHxRm7GaM3IsrixeCJSBlzme870QA9bBPKVrdpY8v1JE71/q62vqu7JsrrVjI
         BP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922865; x=1781527665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kz4XKscbNmYQzkZ0Ik2USW3dCutGoZ2uyit9wH+5F1M=;
        b=RVqKXuCWbq0Km7OnXPRhLvrBR0mAuppF1/hqJuamvrGZTuQum4oKyym10tVBty4Jj1
         CaDVzU5fE3glTdO98I7Tjh7SzRk2v7J2eQNOBbQdAsVSXYJbxhLWij58uCPZnfRXBlnz
         1wAgN8dkzy43QCGcpsPDsCggONxOtLIyBsgbzMvRVmjAbOxHubNwLMqDr+b9ULKYL8+p
         yNxxNrebmwota+lYVs5QGD3H+iGPGuwZt5yybY2iwo0diZq0hiFJ+S+eSXcGTWZWlrt7
         rlpTc1gyUmfcVZBVBzSL10qdOqrXUD4EdAOk9t3NdHZaC5piOUI5zGZ6IgDnP3QIphN/
         vLvA==
X-Gm-Message-State: AOJu0YztfZ/wjtRtP0OIzy3UWRrLJdBsc+Yz2lkWBjFIQwFrtcAzlJVw
	DP2uXjYEtjTGgzbPE4OPmPRagoiV7ITi8Xr7oqkM9ngRO2Om5OGJ9i6By12Ue1aSq7Agh8mDXHJ
	zcV6Sc4qzzt3XD1AfA77l6mwg84w7Tyh0Zg==
X-Gm-Gg: Acq92OGjoFrgwh9TFElvAvMbDJ6o8jFkxCpVzqakWcPnOpuyU9cEkfS6e5kROEvNZWy
	wwqHnGWWJEuKIpqmBZdcHuSRaTINgj28D+UUUazgWaUWIDuWJ2cTqBrccGZ/H+etpwpteL2/kRe
	iDMnVZ0KmmUT40LpAn6o+9SU2QR99qYD6tmZdB6QemqbQ8wVJB11L1w892rIDF+vnYr+s3N5cYR
	cllAGqLBQyeqpqmfHAfuIMk91LKlb2uRy2TGcoPIlSKoYSiaYPXHkvipSnFHXNovbjF1FQzd0A+
	Q5XuV+nWTdgGPxhvXQ==
X-Received: by 2002:a05:6a21:9e0f:b0:398:76d4:c7e9 with SMTP id
 adf61e73a8af0-3b4d3dd3711mr12176204637.35.1780922864835; Mon, 08 Jun 2026
 05:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605191355.281484-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260605191355.281484-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Jun 2026 08:47:33 -0400
X-Gm-Features: AVVi8Cfu4zyEXWlPxbz7_p7ERqQrxkyAs5dN60H0x-wR_XhEkvNA7agXDbe09k0
Message-ID: <CAEjxPJ63zyB8EYL0ngjrg=D-Sxd2NrWNkNzX4gnk6fa3v12-pQ@mail.gmail.com>
Subject: Re: [PATCH] add test for fts_* availability
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 3:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Pepper Gray <hello@peppergray.xyz>
>
> check if fts libs are-builtin (glibc) or add -flts
> to use standalone fts (musl)
>
> fix: #514
> Fixes: https://github.com/SELinuxProject/selinux/pull/515
> Signed-off-by: Pepper Gray <hello@peppergray.xyz>
> ---
>  Makefile                | 6 ++++++
>  libselinux/src/Makefile | 3 ---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 0e70f3d4..0e465f94 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -27,6 +27,12 @@ else
>                 -fno-common
>  endif
>
> +# check for fts_* availability
> +H :=3D \#
> +ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return ft=
s_close(0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=3Dimplicit-f=
unction-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))

I recall seeing some bug reports where -o /dev/null is not supported
by some cross-compiler toolchains and therefore triggers errors on
them.

> +export FTS_LDLIBS :=3D -lfts
> +endif
> +
>  ifneq ($(DESTDIR),)
>         LIBDIR ?=3D $(DESTDIR)$(PREFIX)/lib
>         LIBSEPOLA ?=3D $(LIBDIR)/libsepol.a
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index c0e18321..9982faad 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -99,9 +99,6 @@ override LDFLAGS +=3D -L/opt/local/lib -undefined dynam=
ic_lookup
>  LD_SONAME_FLAGS=3D-install_name,$(LIBSO)
>  endif
>
> -# override with -lfts when building on Musl libc to use fts-standalone
> -FTS_LDLIBS ?=3D
> -

I assume this was originally added here to ensure a successful make if
run from libselinux/src or from libselinux rather than at top-level;
is this not necessary here?

>  override CFLAGS +=3D -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_=
CFLAGS)
>
>  # check for strlcpy(3) availability
> --
> 2.54.0
>
