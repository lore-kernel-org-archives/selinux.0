Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB471DED77
	for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818827; cv=none; b=nh0l+JLcQrtpc8lvUxSCJMA159RMJT7POYuwrrVa2YDu/Ik3v8ynCA+fB/5o1GVsYBSNyKkgXnOZQ/NnGDQad4t0/3dpkR9ziQxgRG2awozYKDHnhXO6Co4piZsobhW6kDFrm6oUz5p6AtJ9niC4SWwY5pyVVlci4x4Fch0M0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818827; c=relaxed/simple;
	bh=emKBfV5hNwEmDam8Cj8+ScapDL407gqk4/4GJy9Z53M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIp4MZnN6MH1tTg6x+iafsEu1BdUhM4DmLKRuWseSqDlb9TlJcO+mBD2JL3WbNkXQjT0PYNh6+ttiYVqdKhpD1RstXoVq4mqFD4qIgT0liNTrK+rPG+cY5VFaezGL2C60wbG4h3uwWeb41qUrrwJgDWGISu/lEZk5xzZ9YEwx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaVa4cES; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaVa4cES"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d42f08135so2484865241.0
        for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744818824; x=1745423624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUp3OtOuGMnZEC1zw4VUWloueIkACFymjJ3MDKEXyq4=;
        b=gaVa4cESQ7hpqK/Ryfo1BNCH7JFh3UaeNQhUcvedbac2r8EZdD0E+gcfb81Il57t5M
         FV1T+0fwKC/AJAx39ImqpnkI2iYaSwH3tdTxGMqeV4rXrx37HPLgHCEmmBJXOEOKPt4k
         iLCDMXedijEZS/xflnSD9r484BFS5HAhBEYpEyob3OdAUEOtmWrK98atKzAghyCfEihc
         DnqlDsNddGb4D0nJMk6toCoi1LfWhtDbCjw5W2Qe+KnAK7//rHABCUnvHdDupBB035aM
         8K/Kv3Be0yaRcMqUjrf5EVNm4m0wgFJwtIMyUMt3njZzJDe2Ukk/L3QSHeqqXnn+ZeQX
         l6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744818824; x=1745423624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUp3OtOuGMnZEC1zw4VUWloueIkACFymjJ3MDKEXyq4=;
        b=MMT/u95rfFMlMBv5fGcxBocds+r8ChpeGMhBvDdw+1DmZ6676DW90YBQmDABUpzbsk
         d9ZMtftaxSim9ODikDbFEvY8cH88T2p7BdkFCmNB/5TO0peAxTRkYv8oIeF4st8vL5py
         EeTO892fLnL/INX3SFaUbwMpQmMaEk6/cdBM4ei6QzrAaUJGdM+oFRuKddAYFHYYBrQQ
         vwtystSnTOR6AjU1VN7h9BpbH1F/S4R/H8Uh8hIiP4VIQeRm2jr/6YjwvznSA0yrmNOR
         99PkN2cUt4rGAGjmjf4yQdaHbpP0c0K/2DwBNXpQlvj2Ji/3jZF6WK9xyQxmP29/comd
         L7fA==
X-Gm-Message-State: AOJu0YyzU358nsBKuE752VmsaVYdo9di+RthwZBNpEyr8/+N5KWscjTz
	8jrc8FoHSp/+ka3r6KSg8vjswlmN2B1VgrB5t984geywhK96cBdCbc7KWZLlH+Prdf8tAF7VwXx
	Aw51t2ucOQHXwPFGDHt6rdabc38KRuQ==
X-Gm-Gg: ASbGncuT3NJzDWnmUHVUBHAzRYgE+qggoo9pLLh49xVCqu/Mj+3bmmDTo9agY0hkQFk
	o5WWNShw5TnqQSc2DCmDEY6V9kJQR96hHE/BfX5nMpFqZHvaGn9K3N4v/VayrGTJJC+NIJcLM8R
	z2lXS6brOmX0SaKvbzGFw=
X-Google-Smtp-Source: AGHT+IEEI6RBSipvSSK6nwdHawWM5joSN/Z1AJ3vb9kvlD8NP0OWneZvII6W/BFvArHl6M9H9EISEZmPaIA9eNaCWyw=
X-Received: by 2002:a05:6102:53ce:b0:4c1:801e:deb2 with SMTP id
 ada2fe7eead31-4cb591df1a9mr1273921137.7.1744818824151; Wed, 16 Apr 2025
 08:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ2a_Df2p03otFfJ7wpGJ_izTw8SGAKr5vztFf0XxnnVypKFnw@mail.gmail.com>
 <20250416045011.29923-2-tristan.ross@midstall.com>
In-Reply-To: <20250416045011.29923-2-tristan.ross@midstall.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 16 Apr 2025 11:53:33 -0400
X-Gm-Features: ATxdqUENlUJxUsEZIV1olivRWkSYvIR-Odhnvnx9H_8pJFX5ZrfNnbQesyAsflM
Message-ID: <CAP+JOzQDSAtyN8WBFj6H87dHm5JoyjY9RcTxrJ_RHwzK0FnBYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsemanage: add semanage_handle_create_with_path
To: Tristan Ross <tristan.ross@midstall.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 12:50=E2=80=AFAM Tristan Ross <tristan.ross@midstal=
l.com> wrote:
>

Along with a "Signed-off-by" tag, both of these patches need a commit
log that describes what they do and why they were created.
Thanks,
Jim

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
> index c8214b26..5dab7bf7 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -350,3 +350,7 @@ LIBSEMANAGE_3.4 {
>      semanage_module_compute_checksum;
>      semanage_set_check_ext_changes;
>  } LIBSEMANAGE_1.1;
> +
> +LIBSEMANAGE_3.5 {
> +    semanage_handle_create_with_path;
> +} LIBSEMANAGE_3.4;
> --
> 2.47.2
>
>
