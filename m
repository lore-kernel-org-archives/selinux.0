Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73F13BC0E
	for <selinux@vger.kernel.org>; Mon, 24 Jun 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235082; cv=none; b=X1vqboYj3g/HlUqZCyKRzHB8K3E85DF6d0Onm02vEewi4TKIFPM9tc85/fJvUzRnLpRonq/H3XMc6Q/L4zJhEtWjdQRUHSkY6w0gS9M4qFlcfAy1Bovko/1b1xfacmWUVGxtV4IJ86yfDaFpSfYvQay9G8tmamub4X+TWFWvunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235082; c=relaxed/simple;
	bh=o9zHteJvqMZwTDcC6vkx+uXc2gRfRic4L7Sw1uqUjzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3JUd23zfBExG04IBkGdQL0rVtkHol+nOgy+7TycC2G3Z5NRiYX6HwLRIvuZnsxTKn0mR3GRtJHdTSdMftqv20yI+sZGEcfK9zphgAVUdXcKbKDthl7dYk+8NN6jCIHRi3LfeSQmWDpZO+XkbSOwV5w0fvCNc24yeXzgqwJdRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIc7xesk; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIc7xesk"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-80fa1509989so418539241.0
        for <selinux@vger.kernel.org>; Mon, 24 Jun 2024 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235080; x=1719839880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5KVP2poljZIHPze518OWOl/PM8FXoSkh2ls+mMPX7o=;
        b=NIc7xesktx4qTBtTe5fdJY5rH9APdr4inPhxJHWGNkkMMXRiV9T/iNvjBE2JE4625h
         qH5hYWTpy/NT70vInf/f+mtEwbzgBnFlsLWY/ZKyIfme1gJk3eqXevNrziOX9EG865BO
         D7zTvDMdPcVoxoBn3jR/yutURo9uWpJ36e9XoyfWMcWTfLZQmVSVupXkGaabcc0DJc5+
         cMbCj9n984/c0bEaeuLS1Cx0BT+DC69H7pljC/NNRZHPAShUovHpfjBLLd9proweFWW/
         UfTHNeTaHDBBHaa4RTQViBdeOzqT4BEgh3UqBMNL6QxvmfRJQX7BFS6Y5/UTIVpuMJkQ
         Gvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235080; x=1719839880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5KVP2poljZIHPze518OWOl/PM8FXoSkh2ls+mMPX7o=;
        b=lAf9ws8gY/WDqrpL40ji+n+zqlAMQvTX/bTCCZznmgQEaRNuZ0l44jSnwHFuyB8Hwb
         ebZCxL2HGW1e5y2Z4YBLcOvA9YUHrQnEkfP8+AYRErYxP0qXcpmlneVoR7rRgfTpr3cG
         3wQojLB3j7WSDD7rt6YMCV9DXuHlv5yFSVZDXGzGVtIm8mn1jezYbzwyVlWdncXdGZvd
         GsSxgrHNy17Ihdpz80vhJj5smPJd9xX4DkAZzGi71iziO8IMCa3TD6bJOLyU6ya0sCfQ
         9fsnjVRRz9oDBQo0zmrp7u7WgkAMrZNWq7tBKMlMDFDeiHDUX53DTN/KTUF26JDJwI/8
         7YwA==
X-Gm-Message-State: AOJu0YzLRPYgAWNyAIjytMpVNStU9i3mEGbOL21PxMjuE+RhvUrkndCS
	LiszUhVQsaZaJQlbWEXNWtZ0ffGmgXbpBfvSa8XaBFGHg5c4tkFsYGx6PJZou1z66XtRgKww5PQ
	VyQy6P5yFfgl6n+vgKRd4pgMBuJ0tcuNf
X-Google-Smtp-Source: AGHT+IEZNiglVBqEMZe+VOC6kXvbqO39WZYqS49nSV7Oow3ANJr7Boz5FaryjIv9zemkeVz/RKfuKbjAzIXXcD2nSPs=
X-Received: by 2002:a67:fd6a:0:b0:48f:12e5:bd8a with SMTP id
 ada2fe7eead31-48f49b8bdecmr2988816137.12.1719235080159; Mon, 24 Jun 2024
 06:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623122604.34890-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240623122604.34890-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 24 Jun 2024 09:17:49 -0400
Message-ID: <CAP+JOzQs=vt+LxDtAqe1qWk-PEOC97U6qiq+jo3BsbwmS+joXg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: deprecate security_disable(3)
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 8:26=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The runtime disable functionality has been removed in Linux 6.4.  Thus
> security_disable(3) will no longer work on these kernels.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>    Ignore deprecation warning by the internal usage of
>    security_disable(3) in load_policy(8).
> ---
>  libselinux/include/selinux/selinux.h   |  6 +++++-
>  libselinux/man/man3/security_disable.3 |  3 ++-
>  libselinux/src/load_policy.c           |  2 ++
>  libselinux/src/selinux_internal.h      | 18 ++++++++++++++++++
>  4 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index 61c1422b..1318a66a 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -367,7 +367,11 @@ extern int security_deny_unknown(void);
>  /* Get the checkreqprot value */
>  extern int security_get_checkreqprot(void);
>
> -/* Disable SELinux at runtime (must be done prior to initial policy load=
). */
> +/* Disable SELinux at runtime (must be done prior to initial policy load=
).
> +   Unsupported since Linux 6.4. */
> +#ifdef __GNUC__
> +__attribute__ ((deprecated))
> +#endif
>  extern int security_disable(void);
>
>  /* Get the policy version number. */
> diff --git a/libselinux/man/man3/security_disable.3 b/libselinux/man/man3=
/security_disable.3
> index 072923ce..5ad8b778 100644
> --- a/libselinux/man/man3/security_disable.3
> +++ b/libselinux/man/man3/security_disable.3
> @@ -14,7 +14,8 @@ disables the SELinux kernel code, unregisters selinuxfs=
 from
>  and then unmounts
>  .IR /sys/fs/selinux .
>  .sp
> -This function can only be called at runtime and prior to the initial pol=
icy
> +This function is only supported on Linux 6.3 and earlier, and can only b=
e
> +called at runtime and prior to the initial policy
>  load. After the initial policy load, the SELinux kernel code cannot be d=
isabled,
>  but only placed in "permissive" mode by using
>  .BR security_setenforce(3).
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index 57d7aaef..dc1e4b6e 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -326,7 +326,9 @@ int selinux_init_load_policy(int *enforce)
>
>         if (seconfig =3D=3D -1) {
>                 /* Runtime disable of SELinux. */
> +               IGNORE_DEPRECATED_DECLARATION_BEGIN
>                 rc =3D security_disable();
> +               IGNORE_DEPRECATED_DECLARATION_END
>                 if (rc =3D=3D 0) {
>                         /* Successfully disabled, so umount selinuxfs too=
. */
>                         umount(selinux_mnt);
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index b134808e..450a42c2 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -113,4 +113,22 @@ void *reallocarray(void *ptr, size_t nmemb, size_t s=
ize);
>  #define ignore_unsigned_overflow_
>  #endif
>
> +/* Ignore usage of deprecated declaration */
> +#ifdef __clang__
> +#define IGNORE_DEPRECATED_DECLARATION_BEGIN \
> +       _Pragma("clang diagnostic push") \
> +       _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"")
> +#define IGNORE_DEPRECATED_DECLARATION_END \
> +       _Pragma("clang diagnostic pop")
> +#elif defined __GNUC__
> +#define IGNORE_DEPRECATED_DECLARATION_BEGIN \
> +       _Pragma("GCC diagnostic push") \
> +       _Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
> +#define IGNORE_DEPRECATED_DECLARATION_END \
> +       _Pragma("GCC diagnostic pop")
> +#else
> +#define IGNORE_DEPRECATED_DECLARATION_BEGIN
> +#define IGNORE_DEPRECATED_DECLARATION_END
> +#endif
> +
>  #endif /* SELINUX_INTERNAL_H_ */
> --
> 2.45.2
>
>
