Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7AC2746A
	for <selinux@vger.kernel.org>; Tue, 29 Apr 2025 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939953; cv=none; b=Lq6RfeKcSa4CE2WrDtB3oUzeoc/8u9jDiRoZhiNr6Eti2YPUdZUc3yl3PleRZ5ieZScAnINX3XjHNWcHenBybI24+3NuHCk0/QZAFB0xXodwEIZHx3w/O0oAnr4VBGzmIXv3UxhHYi/aStoh678nnZuOYRERVOJq6fLX9k9pJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939953; c=relaxed/simple;
	bh=uEMv8Wy40XSOd6+sKJMlZY3/uDx4IF3gZCu+9UbvgNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieImIC9qlXvLCyrUi0dc046RBu0Lv+ruw3wKolOmYzz/Ezvfq/fd7cm3vTGra3bo/a9P7iyTJ7mFfdew1r7BAK8pWKzL6z0QpmhyDVI/PKbk1DjT1cv9MrS91bXymPmwtfhknE1r4RFwJV3dMOSqw178NTI4KebDZ52zuBLsCMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfPtFs5Y; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfPtFs5Y"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47ae894e9b7so134135091cf.3
        for <selinux@vger.kernel.org>; Tue, 29 Apr 2025 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745939950; x=1746544750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCPtBstHzFpuO6kAwCpOx/f9DmK51+EHdqB20L8H+GM=;
        b=QfPtFs5YyznqARBP5O55CG4x37cRAfQZO+N8pqdHwzaZ4DS+9oMrAmbsqYtdLaC/ip
         xD/RH0hVpCAGi/GYHH+Hug7eAsucoQacozmHGh0o2G16CsewLkq1fnTI+GaVh8KBfx5O
         baVBDKI5FQELRovLnhyjKXM6sz9meLTR8H2gqA8BkIZlFPhk3o1GRFTMZ5qsuzSZhzHE
         lShtGjcDD3Z7BrI9b5oiKDeorrS5Y6qAB+q7p2EGyy+6U4LY/uLq6wLs1jcHsjTENypt
         ktIPGNSQ4wKGbLvCtJkuuxIlJFY3uDAZJMl4kVDCN7RyUZIlLOPMORyNs55Hu6h+bIe8
         8Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745939950; x=1746544750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCPtBstHzFpuO6kAwCpOx/f9DmK51+EHdqB20L8H+GM=;
        b=MIpb5ltb9QXOkwhedUDu5T3r1UdCP6eIymvCs3itesusdWfMF1HS/tXzwWLQI7Cfy1
         66zMkSg5cHpWGQDYD8fNHOAk/AUzxF5wzd0HiaPuGVjelKYzdbcypsxeOCHCiGWJYQk1
         KJCoit3Q8F+puQx1H4e3kBRPyZ8N+lEFsfmQigOOT6qYNT1Jm9eS7fyorf/rd6Is6pZX
         SJgcuVEhkZKK6TFJ6o/NfRHdFPKe1S3xn1qkfEM6WOUBqaYj7gmPfaxG0ei7CbRW1m6D
         n+355da2eHH6PG3uBlJBfmbi5xi/jG/J+I038MJcZHkzTK0QeVyzvWPzzsE4wQ44GQZy
         IGOw==
X-Gm-Message-State: AOJu0YxZr0isac0nw2FBmHn0rRtUgVyRymyFzSDWYT6dIi5/LddmGfoK
	kUXkxyN7DRXHQoUaFESk3kHK5Iw9Eo/ckX+S6y05vbK3htKb6oMsG849TkeX4vDpWWtsQAK/l3q
	aHUX6Mhil/pPhI1M+A7LCILm54JaRvuaM
X-Gm-Gg: ASbGncsGuD4UB+9VK7JM9BWTpeqvPyOkFpPxmq68a8zgq9rP3FsezS9W6smvwhhZG4o
	bufCjTybKsy8aS/xgEkFpNZIMbBFnwOi76esaqzZzZs7UnOEhfoo57VW8ctZjZ6I0kPiT6Bfa6F
	u/jyUHmvYlwIqrZVU3caA=
X-Google-Smtp-Source: AGHT+IHu6MZmSqhACwdELYIDuTYNVpKTaXlG7VMObc1gjM9HjJLJQcxACKfN8/PqcF+bfNBiWIGPIiJ+ljI9HoXbESo=
X-Received: by 2002:a05:622a:28c:b0:474:fe31:a239 with SMTP id
 d75a77b69052e-48131227277mr192448461cf.3.1745939950103; Tue, 29 Apr 2025
 08:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzSG74saeVmTz5kdX_Lj3B+5BO-5MbKtxU7VLBOhp-h8Vw@mail.gmail.com>
 <20250425180925.241079-1-tristan.ross@midstall.com>
In-Reply-To: <20250425180925.241079-1-tristan.ross@midstall.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 29 Apr 2025 11:18:58 -0400
X-Gm-Features: ATxdqUFqXoZ9YwmclmgLH8wFfD1_ZDPLch_4ijIEtG58mOuBwcXv-FSmv5prlRk
Message-ID: <CAP+JOzSsZu-bepCMh1iqO9o4YJhLfevN28Bf2sLuCjOgjf4_UA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsemanage: add semanage_handle_create_with_path
To: Tristan Ross <tristan.ross@midstall.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 2:09=E2=80=AFPM Tristan Ross <tristan.ross@midstall=
.com> wrote:
>
> Adds "semanage_handle_create_with_path" to create an semanage handle
> with a config file from a specific path. This is useful for baking
> SELinux policy generation into a Nix derivation.
>
> Signed-off-by: Tristan Ross <tristan.ross@midstall.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/include/semanage/handle.h |  6 +++++-
>  libsemanage/src/handle.c              | 26 +++++++++++++++++++-------
>  libsemanage/src/libsemanage.map       |  4 ++++
>  3 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/=
semanage/handle.h
> index a5ea31de..601cd9ee 100644
> --- a/libsemanage/include/semanage/handle.h
> +++ b/libsemanage/include/semanage/handle.h
> @@ -30,7 +30,11 @@
>  struct semanage_handle;
>  typedef struct semanage_handle semanage_handle_t;
>
> -/* Create and return a semanage handle.
> +/* Create and return a semanage handle with a specific config path.
> +   The handle is initially in the disconnected state. */
> +semanage_handle_t *semanage_handle_create_with_path(const char *conf_nam=
e);
> +
> +/* Create and return a semanage handle with the default config path.
>     The handle is initially in the disconnected state. */
>  extern semanage_handle_t *semanage_handle_create(void);
>
> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> index faea0606..ca57702a 100644
> --- a/libsemanage/src/handle.c
> +++ b/libsemanage/src/handle.c
> @@ -59,19 +59,14 @@ const char * semanage_root(void)
>         return private_semanage_root;
>  }
>
> -
> -semanage_handle_t *semanage_handle_create(void)
> +semanage_handle_t *semanage_handle_create_with_path(const char *conf_nam=
e)
>  {
>         semanage_handle_t *sh =3D NULL;
> -       char *conf_name =3D NULL;
>
>         /* Allocate handle */
>         if ((sh =3D calloc(1, sizeof(semanage_handle_t))) =3D=3D NULL)
>                 goto err;
>
> -       if ((conf_name =3D semanage_conf_path()) =3D=3D NULL)
> -               goto err;
> -
>         if ((sh->conf =3D semanage_conf_parse(conf_name)) =3D=3D NULL)
>                 goto err;
>
> @@ -106,13 +101,30 @@ semanage_handle_t *semanage_handle_create(void)
>         sh->msg_callback =3D semanage_msg_default_handler;
>         sh->msg_callback_arg =3D NULL;
>
> +       return sh;
> +
> +      err:
> +       semanage_handle_destroy(sh);
> +       return NULL;
> +}
> +
> +semanage_handle_t *semanage_handle_create(void)
> +{
> +       semanage_handle_t *sh =3D NULL;
> +       char *conf_name =3D NULL;
> +
> +       if ((conf_name =3D semanage_conf_path()) =3D=3D NULL)
> +               goto err;
> +
> +       if ((sh =3D semanage_handle_create_with_path(conf_name)) =3D=3D N=
ULL)
> +               goto err;
> +
>         free(conf_name);
>
>         return sh;
>
>        err:
>         free(conf_name);
> -       semanage_handle_destroy(sh);
>         return NULL;
>  }
>
> diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanag=
e.map
> index c8214b26..8d7d8b05 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -350,3 +350,7 @@ LIBSEMANAGE_3.4 {
>      semanage_module_compute_checksum;
>      semanage_set_check_ext_changes;
>  } LIBSEMANAGE_1.1;
> +
> +LIBSEMANAGE_3.9 {
> +    semanage_handle_create_with_path;
> +} LIBSEMANAGE_3.4;
> --
> 2.47.2
>
>
