Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611431E84E
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227541; cv=pass; b=uz3zpEd3LU3vVVeOXLSQOiX9JenzXVS6frEBZJxm9Tja9jdjZ4InEoagRZtNxgcFkVqUL5SjrvBqqqHeQ5O9S2mm4swCjl2T/VtHAnCYyYWEWk1VOgpgkPYqbmOM5PdFIomGa6/wgcHeLtjxW085CbiXvS160OuOolIcwKwkdz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227541; c=relaxed/simple;
	bh=wVOHHjrI/OdaeBLpkqBO+VdBWFhGa66nz9gwAE3ayss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nicyk1rAhG/mve5QlFjJc2jxSCkxbPbkKHDAhh7x8H987l4KvQV7k/uyuTZVBhpaHpUwYirEECqMH7DsBNwdEwI8tfKZzSkVhh38bYw9iqIQ+v11c2D/RZ266bgDasdI79WNWe0AZWLGw+K5LOZTGRH2vFDPS3FM07d5aOyOmIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liWp6tlZ; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liWp6tlZ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37cae11ba85so39509a91.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227540; cv=none;
        d=google.com; s=arc-20240605;
        b=NE795P2qlau127KmjwkY5ROOE4QQbVmvWQRxo3oZnsCr4bGQHfUzcA1aw2J7QtsRFh
         oTJ0Qu9g/dG6W+eIDhjQZ+dR0kjTxV6CX9eNrYhBcNWHr8GQXwho6BQQ7yOAkMxKJxvq
         +M2b3asKe6KisaUVIqk+bvFxszA8QyXnZSKIXNZ3523GiSsYXueKns6K4P9YLpe5BbKG
         lL5+Z5Y9cWIMja7z9lMsYwaA/9limNUgrM79+6phu4wxRAPkoqy41ud5VEokKeLWWL4M
         BBDVXSTrnd1akTX0XV0QR7RnN7JBSo9IgvOOZKYX2Seeiu0GQ1G/nF6Qf2rk+bXOvSYB
         nI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WGgvHHV1WbwGueHCojXjm+EXVXLRTj/aCMq+LrngjKI=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=V6ig3kuW2ieehQ85lLVQN+sAVM/TpElrVLBVQx4jvdqZV91kd7B1zL2ogGwjBW5AQh
         VnbPyffKiRi6o28lGgs9cXAffS2EPfZC6S+TnPET4DLD+69QHXEXsJdXYC6micjAyEof
         7F7hvg9+2MQL6jhE3gQNdpjMFVpAi96T5G+B269joCqsX6RcM0WGH4rtFhZLDhOuiJf0
         BbNrN2dVjaZi7vjiU1CN6OxJ0jsOfIEpjW5LkzukStlAnh1UrBo8BHPXwHkk3YNLHFkx
         UiTV254qkrIzSvqjKImmnli3sfcRjdcMBZ+CFJ6k58F8JqijfKBpj2q2hJcZcEDTXEdV
         njAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227540; x=1782832340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGgvHHV1WbwGueHCojXjm+EXVXLRTj/aCMq+LrngjKI=;
        b=liWp6tlZEdD15XlP08nJdRXM/hqq4UPyGUA5pkB96F+WRYJjCi3qxdCy8nSXI+KACg
         Q92/vQj8sFBYBpdGfA2gAkbDYnp/X0NvO22zyKetiLgoXV5bP7+xMGYNZsWNNkaWzkni
         Snzk1xK58mUpI4c8xH4OhZ4nlyL8EQiXED11UxmC7d6kDZY+DM7MZyEgM6LcpLh9fKZ2
         +rwGAlT4P0yUkVkyrltIU27Gs6qHxrphYzJ15tVuZHCo8Olld4sI1PHsaTzU9M6ScZ7m
         M0faK/5UBV2Kn61ayOMujIZvYEEG084LP983OCapLfF8uqjmf57+jctMpoEoQrx+Q8mG
         +6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227540; x=1782832340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WGgvHHV1WbwGueHCojXjm+EXVXLRTj/aCMq+LrngjKI=;
        b=mDcia2jYD2AGqJx6dvHb3GnJc4WKlVfJxCGvkgAJgpQ3p4GVRHiOFxTD3nYBwDGrtF
         nQ4U4PwJsES74nnZ3xowzQEh9gfyL00pvnNkMcSLaFOa9pdUGWahJJIAeH8uPlI2XR53
         E24JBwg8aImshzuB7I006lBsIty0CUblBAWUSejS8XFX01aNDp64uqpWUsxlN90CXoUm
         sbZWUqvBgwPN7zRjTOftidPs/8OhsSo+dJm9xcRNihSdZRP54Y2iu2z1u0io/v90F2Or
         CpRhZZjTGe3EKt0GSGswIUupZZp5/qn7y+d9xhSvgauzC5dv8d+bdlrk3Ld6vRiugrp2
         2TCg==
X-Gm-Message-State: AOJu0YyUzDDXpJa3H8fiISmeiGxhNF1uc5YhBpjKk1wzrWh01qYHQFEH
	FH3Mc+uAq0LmU8Fkt0sg/6WRVr24C6ytYmjiDsmP8VqMS7L5dmP2yBhTVVqsI+tXibiXBfYADzF
	RtLaM9LiMiYQMhHcmdeOzi0PnkpDHjUaNsxCL
X-Gm-Gg: AfdE7ck8HCvmVkVnMOgly+6JRkBJF9BTMuC05tvLbT0glPQ4ZpHrefvVhQN/GjbAulH
	E46bV7Rq8TnSUv8zYPNGgdBClEv4RqQCk8rwhxr3sDJn/QM6WKNGnjqatx2vCotTZNzrRpylPBj
	n7fVM8kc2VwUqkbqpsqMss7I3lddcdpvNcqIfe7yxOJrFk5ANjrAdX8owATaDuvW2WjYXsr4+Zt
	I+rjwk3urIWeeprYG41xZz5HD9mqjpTnyuvjK0Zloy5mxpp1nI7IQIel4ngoM+NqYWb6sL/
X-Received: by 2002:a17:902:eccb:b0:2bd:c925:3a16 with SMTP id
 d9443c01a7336-2c718cb09c1mr229313885ad.2.1782227539934; Tue, 23 Jun 2026
 08:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-11-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-11-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:12:07 -0400
X-Gm-Features: AVVi8CcTEYxM27KUNjeuQJIa4Dmn2VxGujSYFwtaNn-v_4sIesrp0LI5WT3vOFg
Message-ID: <CAEjxPJ7oUK+c_fpK=S=K919yXNNYZ3EEH5MQW1iS0yy9tsOhpQ@mail.gmail.com>
Subject: Re: [PATCH 12/24] libselinux: simplify type extraction in find_default_type
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> ptr already points at the NUL-terminated type after the matched
> "role:" prefix, so strdup copies exactly the type. The previous
> strndup length over-counted any leading whitespace on the line
> (harmless only because strndup stops at the NUL).
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/get_default_type.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_defau=
lt_type.c
> index f689b4dd..2f8e4781 100644
> --- a/libselinux/src/get_default_type.c
> +++ b/libselinux/src/get_default_type.c
> @@ -62,7 +62,7 @@ static int find_default_type(FILE *fp, const char *role=
, char **type)
>                 return -1;
>         }
>
> -       t =3D strndup(ptr, strlen(buf) - len - 1);
> +       t =3D strdup(ptr);
>         if (!t)
>                 return -1;
>         *type =3D t;
> --
> 2.53.0
>
>
