Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385722D7DDB
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284324; cv=pass; b=nWAPVYE35klHLNZxB5WaNFk0MbojdiKXsVBGpgJHWek9ZmSzFChQzqxT2/cgH2/DqnFYpRN19fgqXkbYx1syqj1r+olKpjva7A15/KqvXJTJ7I4qOPbmvv0aDXRPPd3KIa7vfoO+MNrY5etCpKIgZGg0M5lNnT5ROKLaBP59Gvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284324; c=relaxed/simple;
	bh=0r2BcpPGYCHo4amlTT92EroLwtyuVwP2kZeLq4Js6uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRhT9PzOLSfiGUxITcnqsU87WhMJ4a4wu8q4diIHUEKXAKSsqEGUGZ6TEMnckKIilJnd9SZLSjiAhBHSsCWT+LnjrXQeW/qpJR86pd4q4svKwuF8Cur50xy+iB3Q0iKQMPK79EGD5L/vhvG1xwhzdpbwqdvlwECP5EC8X8yllMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh/z3ic3; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh/z3ic3"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso50357415ad.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 06:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284322; cv=none;
        d=google.com; s=arc-20240605;
        b=CDCwTbuzMiOxzj/8U/eqtZ0N9ovm6w4s/SX+tyxKj+TCymoNQDcn2ym3qm2y1LmLA4
         sbAepbOjjYt2plq6BR0FFBTnY/KCSEoU6LTaaKUqH/KCwv4hF9rOvKQST1+fUX8V59kL
         vEEFJwtkstYldw0z95z+ZnEW2g+csH64PE1crzwfWeYTcIb0OKGlenZIQeE5IBbwgyyp
         dLpeBTyNZonQdifib10jyik0oK4LVEF+NAxI5S1gj/QzWIKha4+4K/WsWI5jm8oT+oY1
         o8zteOr+lHuqsi3ph9mo0e9DptLuSoy5QflUHzkxH9wFYKRy3crLNa9yZtzSpP0dU0Aq
         l4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lWhzlOClnLxFuFGcgUl61vpOUY3crGim7XgM2st7juA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=ZvpRRK2oueX6g8ZRV4mrqhTX4yM7pQuQFFVfnorrZys3HVR+qvWMiZ+PYIztDEhJg6
         khAFuhTfVUwIDzK4Db4S+ssuqwmZM+XILfpULXbU0abeNWmYy/1YsJqg5/GJuVCfssGq
         I5i2R7H2mmw0mwScfh9F/F3FWAu7RTXsLHarm5wR7Den+yOw23oHfRsojJo1R9/wHUdO
         BiNIdQKl1Vnf0U6J6ru9HkIO0lRKT/sZIb7LoHTB2fNjfMNz2u0GRPOUlkFAonIJo7bH
         K+S+ISoD29Ju/lQZyyevou+4DX5ULF5qmpC1MazudUykkfZEerL9h6rLKXIvU0V8s9Z3
         VWVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779284322; x=1779889122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWhzlOClnLxFuFGcgUl61vpOUY3crGim7XgM2st7juA=;
        b=Gh/z3ic3gCPdvUdsnrnvr0VolpQnFBUVJG6958K70vb42bokvOOMoUvm3z8FdUAdYh
         AafrMdstGc4ozN+YevAzYzPsBdGAZCwkPiZGHi2W4B0ZcxzK08vyPE0nJnJJThj44ayk
         yDxvVt49QN5chbH9Y/jWDoVDVKsMACqRrjlYAd/mD2Z3zBSWm758di6Q0OvmogjEd0Sy
         8UBEV3Tevg78/VrhFUSTD3vPwrW+RlKmHwQplZfUU2dQtGEMYqFmPTM20H4Iy0RtEARw
         OLQqzQt1Ah0httma4GL2pFCduFXTJTtAce9gb/fMCuKXc2Y//Juwv0rrlACclzcsqW0K
         3ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284322; x=1779889122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWhzlOClnLxFuFGcgUl61vpOUY3crGim7XgM2st7juA=;
        b=eiklV1zSQBa2hCWnc58OSLTdaEzSmykr6OC07U+XhfLT2UOzMd7NE6w/efgSd6/Z0P
         faAIUPLsOTSDUbQsahSc/fggOozodYWHZQGozmthMzdhk3hWyPFlfCo0irS9XFTLgeSf
         y7KzEkPpHeVTctkpD+PougnyadMNULq7XguVxzXOro/t2PDg5exaWDN19rQiE//iVU7y
         OX1QuQh3uLK7JTmp+mpKof8MUAlIcUlxePcPjAlM9BlsbmeZ3OXMXitgHQ7fUrbfhYFk
         yUOC7XqrrOw9bzGrt8zxq1IZZGMOkuT5pjcjd5uvpyRBrIQod2QE9pMjNQEDKpjGPWPM
         JPzQ==
X-Gm-Message-State: AOJu0Yw2X6BYR/eZxBz9Pze6+YfQlGqbD1tV3icu2g4Wv0VpAw2kTYO4
	pKherkxfDNgBSbPsmvxdUGgqyfPkb4IXOMbosuSWoDF+Jg0e4ghRuHUQmD1ch5yx5CC7ZCY38FH
	kYwMNKzhNesTUKr+YGu4MvISLp3N0hEEN+w==
X-Gm-Gg: Acq92OGLDxk+lUlHZ3SGKHahgt4XPFU9jMPmUbLSGMw3dx8r3mW9QwF6j+EuYfyhDSu
	dFZlcHD40FCrMnJQnN+zki91zeW3tJXoH1kj5fs1UZBctzH9Gf+DXIXmW6zlG08vjktQIyUgEe1
	kyF+GwKTdRPlmIR6uYKcRq1YibM9c2VbXtqvkq07lJFCFJJGpVGvt4sk6cnSyArYC054XeKWRla
	b62XHzL6w8ZrPFKcGJhTdV+4/wuCspJsSGSeUEiPlBJAR0suQEvnug4Fh7ovgLbWUDeh6q2WrhP
	cTwOWnV8w/D9WcfuQg==
X-Received: by 2002:a17:903:2ece:b0:2bd:eeb6:ff1b with SMTP id
 d9443c01a7336-2bdeeb70286mr114388105ad.4.1779284322469; Wed, 20 May 2026
 06:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520121051.20863-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260520121051.20863-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 09:38:30 -0400
X-Gm-Features: AVHnY4ILaz7lH3TY7kFYUuYKuEFjKFGEBffztvSCVDgxxul7wZ8BymfRFAaZG10
Message-ID: <CAEjxPJ6rFoPTjd7++x59Ebz8N8MsSfyqNfHXiR_TJojg3nJGTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: reset scanned file count at
 selinux_restorecon(3) entry
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 8:19=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reset the scanned file count at startup in case the calling process
> calls selinux_restorecon(3) multiple times during its lifetime.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/selinux_restorecon.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index b4d58b05..b7defffb 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1446,6 +1446,8 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>         int error;
>         struct dir_hash_node *current =3D NULL;
>
> +       fc_count =3D 0;
> +

Should we use an atomic operation for clearing fc_count?

>         if (state.flags.verbose && state.flags.progress)
>                 state.flags.verbose =3D false;
>
> --
> 2.53.0
>
>
