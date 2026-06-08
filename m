Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3CC2DE6E3
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925725; cv=pass; b=tWpJnE7AKpNrsfIHV96TCxEd8cy3FBG4o/g01gwfv8rFpUlq06hXJIr23zt5MY1XxwgoX2v6KiINphjJFRPjegctjlmk1yIgVxfm4I7/kgUcWjJeC8ZAZGg1WqqcidXiSZT40KoGPYxWChbmSwOALrraKj+yHTnkruldW3SVSBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925725; c=relaxed/simple;
	bh=T1yX8OlTIIq+1MJGS4q4MJJcA0+Jd11E/hWL4qOb3b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UH4m2C1Gb5oFojfr7wZofWWjVI1fwnvedxiBPtVClzZmLtFE2r8G6+tI1M+5y/dEM9wkbvIY6fgVEZvhtJV6zOZSiJ/gsTLXmTIONnTtnE9N3oosDqhU3VnEsVqqPJGO0E6fgZ3M92rUudAtT5oBN+WZksWdN6dA+zhnMWZUo7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lbnmbfau; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbnmbfau"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6cfdcd6dc43so3614780137.3
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 06:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925723; cv=none;
        d=google.com; s=arc-20240605;
        b=Bb4DoZMzoLuhgGhZ5EfECZ3IN2BQ5+Xtb29tSRY/LdIqG8NCp6kqThFOL/t+q0FNP0
         6uxrC759zYO534rsxVR1abPW2rbpRTmNBXuWKDlZ/hH3r5hzfcaSHptOaZgHpagk9Nzp
         Mjj3NDJH1AB2eww+mN9aCc/VV86HUK70A6jIWzZkc3BqKga8OX40kzArJ/Dx7htGlmcI
         25eRKYjyFjiODTvnv/LAOK1TMQ/8p+dKvbujb05k8099YbWbu7RA3Gr6ZBsJksztxJYY
         ShHHliieCWCSmm9XFpc/ocg98YEmCeywG+j0JEr1Yz3dn8N8csi/pxvF50W+aS0ApR3t
         rLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mNE3M8/zjsFEsofAYLz2nrv01wgrt1XSKLB/XQE3yX0=;
        fh=zR5q/8/KngUdBc395D6LxVOJ2xpv0z29Xq3+CpgY55M=;
        b=YdeY9p1gBSg9t31of5aQcSGulJz003K+Nmy7Ynwy1YhoNILlFW49cLxtge9Y4w+u9u
         vZmSDc36yKXRc4dUYwVE6WCDihLyERTfspmjoTW7DSmnvlQ7XTV3NJFPt3W89K2PTWFT
         H/poVKy05PJcVDlKDRqOOD9A4BErugEoUs9cj8w24TtkR7lK9uuX9nDR5B0XZPMAfkcS
         6O/C9VQJQjAf1C0bx7JJJ2gFwX5+W2KE4f6njQoRdLG4c4nwSxfoaKuGPvjUDL1XMsWP
         va91tT0zno8Z6TQCicg3T4+zHhK2/IwR6J9Zp14MS8Ooy3hBQcnohd/92cIgiWvSIXAq
         E/Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780925723; x=1781530523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNE3M8/zjsFEsofAYLz2nrv01wgrt1XSKLB/XQE3yX0=;
        b=LbnmbfauNbYLmAhQ85x5uXaX0D3abzy23WO4/FAx/E58u3TD4H7THURrzPnoosF9mf
         NNReeFJaYSVQ+snNcZfRofp/VUlgUmHJs6GTYXrzs5XMP6CYsFYLWh0qc/JPgu7eGO/Z
         sk/M4lnkyIbehX6a3uUYh+39+8PD3ESPUvgzrAI/KmacZKGkGYOTEdPhDaMn7ccYD2Sh
         3GgxJTZcLrlfvAQYQ8FoRFoZoRKB3DOAbXN8qO9VIsObJcUVBiieTguF46zr+OXv8Hbg
         4fMI6jt3zLJ6+nsb5BXXWwwd4VFbKl+Lhl5Zf6dYWjiDokf0lx8H3XT+T9mi3MXNDl6E
         EYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925723; x=1781530523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNE3M8/zjsFEsofAYLz2nrv01wgrt1XSKLB/XQE3yX0=;
        b=tUtja0w/iY/ZHZ4wc99L39BbmS0gYK1qx2MMzFXxSu5fj7/wiM0nEJKjiXXLqta4/l
         ifogaliNyZIgXEFdR3HJYEFfjOhD9aGgZEcS7DR6iW6xak8kOOlAWVsXX/7G9vMbh73a
         90T2EQ9qVl56DNapyeFCcPjIgKP05bqRJ+QUnVQ8tHCbiK8wcxRTr69M/qMl54WOl+zQ
         3rvLDdvCrorc5hKfUZ12ElBg0qprci7T+Ssf/jvp643GkqWtp+9nQa5m15Jt44bXDlGW
         K2laZ1z7j3yzXiFYDFyBI6wiEUXPEJhPUWSsxfDVUBwms2MT1TV9+cgmr1YbI2AGeimx
         cibA==
X-Gm-Message-State: AOJu0YxcvOwDYCZJetYvjz1mJcJu0U5XHNLORQbnUWVdmXSg5UWeFrL7
	pUITWJOKDXsLna/YWqNGU5h5XsnqxnpZc0aeK2PGaCWWImdjy14KmTdZreexHsZGELAyRNOxdcI
	1Dc7+LJb62eFzDtjqGDMCR70Dw0iUML5ITyhw
X-Gm-Gg: Acq92OGHvJiTiD9+pcrUQaIwCsRBEZXYl+JyWflHB/0yRwbPQI4bGIFUF5SEhtVUZTy
	euwt2IhakZXi+EkWsS7U//WaO6DE/KL6/po0JvMonK1Gpm5+rxvlPgLNf1PE0oqD4A8kQtqSqyB
	KdAk76xA24xas5gWD7Zq/2NSSf3+QEbdDJn3V3KNhyajF7pCwwBjRCCbzOuLgVC6goEEnR+gXpG
	cnksaSt0wfuuzcIIMwsarmafOBC+yyShueHhgRDIFokNEqowFui0lNKzQwBnD3UMtKmpcGDEUEX
	gxFUMTL5wd6IrLTH6A==
X-Received: by 2002:a05:6102:5cc2:b0:631:2973:5c2c with SMTP id
 ada2fe7eead31-6ff0a27a19cmr8252487137.21.1780925723201; Mon, 08 Jun 2026
 06:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608133036.309348-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260608133036.309348-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Jun 2026 09:35:11 -0400
X-Gm-Features: AVVi8CeXcB-S9W2lZoNZZ7UP_XyKSkSy6Br7_loECHsji2jgrTJKw1lC8GuGq0Y
Message-ID: <CAEjxPJ7BWdm=MkoDGjGn1FwXQb5qzJpphbsPXx5o5LtfuYkTkw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: make reallocarray check more robust
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, 
	Waldemar Brodkorb <wbx@openadk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Waldemar Brodkorb <wbx@openadk.org>
>
> Some cross-compiler toolchains dislike the usage of -o /dev/null and fail
> with: ld: final link failed: file truncated
>
> As stdin and stdout is already redirected to /dev/null there is
> no need for gcc -o /dev/null.
>
> This fixes an Buildroot autobuild failure for libsepol package:
> http://autobuild.buildroot.net/results/72b/72baaab4658254f4c5b3348298af1d=
5c891cacd6/
>
> Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> ---
>  libsepol/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index c222a8fd..cd6ef442 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -31,7 +31,7 @@ endif
>
>  # check for reallocarray(3) availability
>  H :=3D \#
> -ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return =
reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS=
) -Werror=3Dimplicit-function-declaration -x c -o /dev/null - >/dev/null 2>=
&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return =
reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS=
) -Werror=3Dimplicit-function-declaration -x c - >/dev/null 2>&1 && echo ye=
s))
>  override CFLAGS +=3D -DHAVE_REALLOCARRAY
>  endif

This leaves an a.out file which then breaks CI,
https://github.com/stephensmalley/selinux/actions/runs/27141099174/job/8010=
6217168

Must be a better way to fix it.

>
> --
> 2.54.0
>
