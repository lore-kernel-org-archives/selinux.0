Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E384D10
	for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224742; cv=none; b=tvMJKb6as4gc8zS3Z80ycOx0F4iWH4fu2nArjjPM2aLOo5Grystbpuks6erE3nJgqtFQXVKjFNPd+8pNhWNZ+FRV603G7ey4Gqw1tZ62H1mKIfrvfUdhKE6rP6FNjemkoAEhA3J+p57yZuKEu2le47DHSxlNT1kVO2DMKIKIaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224742; c=relaxed/simple;
	bh=mpVTGU6a4CF+QVhiFzyV7W0yL6Nsw1QVstDCiWegsVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLrOiQRqlTjp21YokmaauPM1j/yDYzzuLL0S5/ge7vaqQ3MZAbkSK4i643/DaMhq+yxuOuU5Bp1hYsD3dlHLF5T5s6D0P5Cl0FM8soJYjuc0F4G0t0xp3Wh5vTX5YsxbymX2oGFJqb0bbhgUzFVuazcQfAc4U+oorv18mJGwKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjpZ3hb/; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjpZ3hb/"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48d9cbfe0ffso98073137.2
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718224740; x=1718829540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nysl/S6IbOaioFn4VX03L83gZ/MPNwNAOB81ucWzSYc=;
        b=FjpZ3hb/17/slWcGw/k6ZTCXOE3Wu2GZvwMEWZE2Qf6qQX5XA76wxXXJDq8MjfDZmN
         nGs4aden3vau3NjB33lBrfh/yQfdDpdlQpuevZhBRU9V8fe/ZBE3TpS2Kou7RbpsmV3U
         U+GbqvtIB4uMMo51I0TnrsK6dgfWCxoz1KnpwM502Jz97WTGQLj3B6CGRFAJU+jjJwMn
         4ZaZRyWgqqe9Bfhuh9sgbQHETGwkrdFKnuwgM+4MjVULVWhopyuHj8Gy1iG+VQP9l464
         U68n04z/f1CjY9OqCbAxn+gzSjXpisFDOIfauIlJZeK2ZuDzx+8QGLIW/6aXm+Y+d/ct
         43ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718224740; x=1718829540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nysl/S6IbOaioFn4VX03L83gZ/MPNwNAOB81ucWzSYc=;
        b=DDN/YB3Myepu5qNzUnYvXOed/UKNpXCEy4sCOwyozxfX9jqic3zqnrEWTLxgEqMvV4
         QApk1tIPaSRCbMJ39+Opv5SxRUw2IXA2S5YlnP9wKZWirmGuFD4l2fRB2hLGxQE5QGIR
         oscI6yZwYGu4nI8UBLKxqkBxUY2vvQhWY5A11TGeNh2p3TVFX71kfVr71Bzz9eSWCvxZ
         7IJsQiEnw3WMPhRgrDUFBc4tjsweYkGIL3soz7D3CbAALog+xRmLJ9eIQI10FZI3W/ZB
         5j/lJCmy/n3IY+OuQRWinlAG45CG1Qr/xRsFq2KjJ26DWz1KT0gFUOUD0NhNj7Vf9CYd
         c37Q==
X-Gm-Message-State: AOJu0Yw+O/kpj9dqzhIATPZ8jOkJ4aUSoRiF6BdgtxWVzZCtWcHgAr5o
	imsY6kSm/+1xeXLqw4cdjsCskDWgQkmzICHGxsxO6eMfwTcWHcJ6MP4yvetehxSYOAJ3TofigaE
	c/7WTH+9nrRUztHjGtR1ZFptCUhI=
X-Google-Smtp-Source: AGHT+IEC4dPy/XfMpmYALivXB4jk+IMK0nvDXw2GoR6/mG//0ty1hTS+KG4WJMqOQsGPnJvu5WAWmrbpjt9lOknm3go=
X-Received: by 2002:a05:6102:3913:b0:48d:a159:dd80 with SMTP id
 ada2fe7eead31-48da15a371cmr706206137.12.1718224739684; Wed, 12 Jun 2024
 13:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172025.137795-1-cgoettsche@seltendoof.de> <20240608172025.137795-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240608172025.137795-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 12 Jun 2024 16:38:48 -0400
Message-ID: <CAP+JOzSHwFvpuT-u9n3Ym9bYafK73qf6J-2_3DV1UrYVDMtJAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: constify avc_open(3) parameter
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:20=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The option array passed to avc_open(3) is only read from.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/include/selinux/avc.h | 2 +-
>  libselinux/man/man3/avc_open.3   | 2 +-
>  libselinux/src/avc.c             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinu=
x/avc.h
> index 4bbd2382..1f79ba16 100644
> --- a/libselinux/include/selinux/avc.h
> +++ b/libselinux/include/selinux/avc.h
> @@ -215,7 +215,7 @@ extern int avc_init(const char *msgprefix,
>   * is set to "avc" and any callbacks desired should be specified via
>   * selinux_set_callback().  Available options are listed above.
>   */
> -extern int avc_open(struct selinux_opt *opts, unsigned nopts);
> +extern int avc_open(const struct selinux_opt *opts, unsigned nopts);
>
>  /**
>   * avc_cleanup - Remove unused SIDs and AVC entries.
> diff --git a/libselinux/man/man3/avc_open.3 b/libselinux/man/man3/avc_ope=
n.3
> index 55683bb6..74f85593 100644
> --- a/libselinux/man/man3/avc_open.3
> +++ b/libselinux/man/man3/avc_open.3
> @@ -10,7 +10,7 @@ avc_open, avc_destroy, avc_reset, avc_cleanup \- usersp=
ace SELinux AVC setup and
>  .br
>  .B #include <selinux/avc.h>
>  .sp
> -.BI "int avc_open(struct selinux_opt *" options ", unsigned " nopt ");"
> +.BI "int avc_open(const struct selinux_opt *" options ", unsigned " nopt=
 ");"
>  .sp
>  .BI "void avc_destroy(void);"
>  .sp
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index ce87ac16..7af5d192 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -225,7 +225,7 @@ static int avc_init_internal(const char *prefix,
>         return rc;
>  }
>
> -int avc_open(struct selinux_opt *opts, unsigned nopts)
> +int avc_open(const struct selinux_opt *opts, unsigned nopts)
>  {
>         avc_setenforce =3D 0;
>
> --
> 2.45.1
>
>
