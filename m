Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B342C11CF
	for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770995969; cv=pass; b=G7pDY1wY5OYonAgR1KWkZ5hraCo9cPWMdMoiN1OiDtpyJBCsjYybvEjbafzEuNHZZHiLFjxNFjSYrEDdF64GRxykXnlFwS2V3G8f7qO05/6DWh2b0mcPKJ5khWYw52Kz6XuyHhbU4PmaDKMOL1cc5UjOxZENGRe7bdqNuIbq8Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770995969; c=relaxed/simple;
	bh=FS/kspI2iAMNdyj8+zklC1WxAylzWwqWEosxFEfQsBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRSx1hzKkBzREZcwlygt3KWhlP+eXg5eSMxaWS6IdK4W6WEGogEof1BXOvl4wfzVkZVf8KALaHAh3ovdSYMeMLCGdQxG3Br83s7TPo7T+wVeVCa2ryO9KJ7hEs2mZi5h2ImdKZb9d5ROVsp7aCxbXKiAMzazI6BIQCLzCzL9H+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXHyJwh0; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXHyJwh0"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38709888abbso8463921fa.1
        for <selinux@vger.kernel.org>; Fri, 13 Feb 2026 07:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770995966; cv=none;
        d=google.com; s=arc-20240605;
        b=hoF/iWxPp8VrQ4qz7tSneyIbfT2JmQY8MTm+2MdDLMgE3p+ZHjMdYBwzhrYzAuHu5/
         ecXsPJtHw+Ynuu5WozSQxNyNeSbW+s7v4jm7J4ViquLmrUzZDH2KDEHt+Hzwes+ybXdu
         ZPFhI/V2zUHl00g/XWC4rk59WKkz3gSlkwQI/7xYnB72Ljheo+bkW3ISBG7u1nCyh0eZ
         XGOOzPT5Bu8h1k5r/epCzeE7G5RY/7gooS5Oew1hnmIIAJChXdQSmw5GdobkWQrAzEGi
         /xSUuzSPv2xRzEpsMIgUP5gFphINRHjug+A17RvcP5xXNvKGBy55Iap6atYLVq6mqjnN
         Okmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nKtUQExNnKnMzv5VmK26UWXFQ4/HvtBQISNEIMNlOz4=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=H7K6FT956sp6HXV7Fbjc2Mm2OtV3jP/o4JEs3mjLcTq0ZX8i5DL42ThCTzb5lC8yEl
         4OnKcyBeTnMFjiBuAVkZ9OWJZSVHsPnzLizoL8qr1fPFwk6neX32WXRo4T0QqKOnfRPO
         QR8lZVTe1g6uon8duuS5zvV+6wk/dv+YmVUtL0sSe4YeGIslWQEjKHVvClYn87pNJgrj
         ltyBX9wrJ61bKMv6g6tl3eaH+XUNxjQ6VQOiiQthNyY5Odzhfe/oTYiEPRDjkp81+ocH
         XZn9J7JdqU7qYtnpykSDZsHxPOHja7RByL0H28pd+T5FG1s7OnhJqv8r4H/coagNf5/b
         3IkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770995966; x=1771600766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKtUQExNnKnMzv5VmK26UWXFQ4/HvtBQISNEIMNlOz4=;
        b=hXHyJwh0U3NCmPefkUGjQ3/CoHN5Lrs1VZLd6ZN9BgPER5VQliiOyb+isFKog9oTNi
         5Rz791ZhFuF/bTiFDUAgxYHyLWdoXrd6kglfBiBUiVtY6HAM1EdDKRD4N3+yHS+ociAo
         sCYubcAnm9ur2i9rgdE6/33GxvJjsKxpYgPsFCMDk1zNBzsPCqtXUeXCB09utRraNaCp
         NZPvSOZjaKCCkVGGAgrEv2+CMn5MpgG51kBqnfHokbQygdS3feZG/hdUzPsZyRMMDwYU
         3ZQTt1fTPJ1Fm28ikba0tCfXNzyTnov6KH4gnLw26wM0+xYw+kweBTmzt16xuLKfkNog
         Z6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770995966; x=1771600766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nKtUQExNnKnMzv5VmK26UWXFQ4/HvtBQISNEIMNlOz4=;
        b=cnxRwCgu8IKWKRnlR5tTrXjJ4PbJPTxaYM51OCKKcIA6tdXR9nJMpUSA16hM+lOvu3
         3wIkfI+pES9p++DNyLBIO4wKHKS8A9qN/QIPbDwERnsfwLLN/soK+OdE5tqQ9cbRPKz4
         JicgFd89+gyC+cbDWgYMmle3H4/ajXJOvCm+KuUBIe69GLS/t8wXwG0hz7STk9uOgv2D
         QOA30spnaP7vNBxJfcvcCdOVUBeHMfwKQvKIqjnB2CDnhY1xoG6ANfU2b8J9SEJJdz27
         qexHzdKakYc5rpcg18hTKrIph7XHD+UJybqRid43rW1I0z+qUSSjqbgwkvn89krjWpSH
         Vg/Q==
X-Gm-Message-State: AOJu0Yxt5orecs0MEgtF3G6SGczxQmt5h8sS2lYYqu4GCQFq14pjpJza
	6lUJkHqKdUMKZuU2JuDxfNkKQQ8pet2RvT1IaMCGqjcvkrSE0uWRyEm5ysmMtQDJefq9MjnYMcX
	4vHnFx76laTnsmEYgE7QtTfBRMd3E/1FwaDOz
X-Gm-Gg: AZuq6aIIOsWbX8W1fDVbspK4TMaIs4d88bPuvgN5HHq0qhjOIsM+mhaTnExA55++I9H
	RWtOAELkLzKTcDwxOCMXbU3J8UPWCCCuiKQJhDYjmbgjXngMI5R3cCPYPpsA5isK9iMXR1EAKzx
	2BeFM+uxxkKh/W5N2YRtZ7c7SyBlQvgvQlcL+J25BvXhAlEFKH6stohxFfbRG0sY6G6RKZMm7NN
	V4d8ly3huvFyt2Q1W0Gr7foq03faxoNgNSD7DN/uF+2si8Y6g8ifMVH4ktw3haoG4e2KF3cpHSc
	DNhm
X-Received: by 2002:a05:651c:50d:b0:383:5a4f:2603 with SMTP id
 38308e7fff4ca-38810502365mr6498351fa.10.1770995965655; Fri, 13 Feb 2026
 07:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202143554.97209-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260202143554.97209-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 13 Feb 2026 10:19:14 -0500
X-Gm-Features: AZwV_Qi1Y8CBr3KgJZQ2cqXTZ6GUB0lD5GsH0uXt3CV44JK9MWUXT9E7sVmUs3Q
Message-ID: <CAP+JOzT4pYTE4AZf3mRrrNJnX0y6r_Nd7-+day7yM=O_B5+HBQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] libselinux: support non-pthread build
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 3:21=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Consistently use libselinux-internal __pthread wrappers to re-
> instantiate support for non-pthread builds.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 34927126..b1f6f672 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -905,7 +905,7 @@ static void *selinux_restorecon_thread(void *arg)
>         bool first =3D false;
>
>         if (state->parallel)
> -               pthread_mutex_lock(&state->mutex);
> +               __pthread_mutex_lock(&state->mutex);
>
>         if (state->ftsent_first) {
>                 ftsent =3D state->ftsent_first;
> @@ -1011,14 +1011,14 @@ loop_body:
>
>                         ent_st =3D *ftsent->fts_statp;
>                         if (state->parallel)
> -                               pthread_mutex_unlock(&state->mutex);
> +                               __pthread_mutex_unlock(&state->mutex);
>
>                         bool updated =3D false;
>                         error =3D restorecon_sb(ent_path, &ent_st, &state=
->flags,
>                                               first, &updated);
>
>                         if (state->parallel) {
> -                               pthread_mutex_lock(&state->mutex);
> +                               __pthread_mutex_lock(&state->mutex);
>                                 if (state->abort)
>                                         goto unlock;
>                         }
> @@ -1046,7 +1046,7 @@ finish:
>                 state->saved_errno =3D errno;
>  unlock:
>         if (state->parallel)
> -               pthread_mutex_unlock(&state->mutex);
> +               __pthread_mutex_unlock(&state->mutex);
>         return NULL;
>  }
>
> @@ -1279,7 +1279,7 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>                 pthread_t self =3D pthread_self();
>                 pthread_t *threads =3D NULL;
>
> -               pthread_mutex_init(&state.mutex, NULL);
> +               __pthread_mutex_init(&state.mutex, NULL);
>
>                 threads =3D calloc(nthreads - 1, sizeof(*threads));
>                 if (!threads)
> @@ -1316,7 +1316,7 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>                 }
>                 free(threads);
>
> -               pthread_mutex_destroy(&state.mutex);
> +               __pthread_mutex_destroy(&state.mutex);
>         }
>
>         error =3D state.error;
> --
> 2.51.0
>
>
