Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFC200128
	for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723050; cv=none; b=EZlkHzOqsqOhHZvdoZK8KRk7bTgDyEtLpUwVHHnT1EzXZQ0PuTfqgwCjqBJxo/YUN8yzTTZQzfhVNWFISIHb/Jp1CByVnNj59yKyO4AeEPOqcT/0+cv/0G/YuL+WTAK1OSLeCf+qXc8+1C8PqYFqzVYbBDdWA+zO3UaDW8I1r08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723050; c=relaxed/simple;
	bh=4pPNBbhcRXIdJEpdKH4HlS9+bQXlXLppnEOVmKMBkxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5QUPFepGnUKWKuBgYrCo8xdZETkz0Ii0i5IseeOUgEmjWQqjuUaIQyrkr6likDOb40RoGWHXEdwjzYdjmSB19iMQJ2UOAA2iAgB5EFEVjG5iOy0qB2tWQhqhkxMBEPwd29FvcxidrxtcqoR6uNYdWpgQJ77fThwqxGytGka52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUTCc0zb; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUTCc0zb"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71d4c462ab1so1572723a34.0
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 07:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732723046; x=1733327846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyWoY8bvqxfjKm/3jzhsCVjy1Ka1v1/YQrKV6NX7gI8=;
        b=BUTCc0zb4sc0Z1dGJ9A6XMIixWtYwJ2PcxBe8wkaMEB6upPSdxnYmU+K7aLSb7xmEB
         YJesP5VzQwlkz/Sc1tI2vMBanZVv+jrc+7k+po0PepLX+Oc7pM+GgfCrC8WDWQIDTBXy
         /FsGxnZel2TKMNKquCDq3eQnMhELfT+EXNWyJpwMQvG0RRLME2KnypI5hYXifh7obF0N
         MLu19m6LWFYn1HJ7XwNUU9dEahx6eJEXvp8GGk1ZWZjAIZ21VMcXsY7UsiHCCYhpO9dl
         dXUADyP35nsJAhDA5MB2XzEqQ1gEY2PZ2+LrcdrVRhcZeiXfMMKF/aCDapFOJ3WX3W/v
         Q1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732723046; x=1733327846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyWoY8bvqxfjKm/3jzhsCVjy1Ka1v1/YQrKV6NX7gI8=;
        b=l+pT3ypjX5w0+rkci+gs19iv/JBPTk0cO0QHa8toQHq/FV5OusYlRMn7YkIRXPvkgv
         6wMb03gfbB4qTn8PKLwGWk2vXnokoPLZfbtg0f8asejlZ8RDbXT5DgdNk8yCs2g99Vn7
         kvO2wGDtQq+m78f96i4yFeWtaeQZXP7qKsJintTLc24KBNzWfGT860B7eODGXGdtmS1u
         qtzHG+KFeo7YOQWMBTfcet/P99accJQIJF6PQyOp+YRF4tBoHDZGfcj4vog5JcPjieRK
         NUBP2MNW5F8dF4jSZoPHNP1JBAF/Fl0qHqQy6EKtzfiemBdim34c0wU/UpFeAX7VjkdH
         jZSA==
X-Gm-Message-State: AOJu0YxwCeAe6Mg5zGpsugN4VMx1bCR666U8FmwZJ9peYBdPt71isYxl
	j1gNogv8HPRd9CLNvUhIuPjzctslommWe7G9iBlsOW2F6mL6lIjzHaMr+gUoWEhbFBTFCTfXHIC
	TMmNcJ0asUv2OAVyFLKcDDYlG81A=
X-Gm-Gg: ASbGncvipyPqx+CbzcC//MDcYX+WvlnLpV1ch5xgLAJKxmNn/ne8amT7qsjmPQca7yz
	mKlZDNtVFXlIq9ZQ+ZhfZ6kR5y9uCYMA=
X-Google-Smtp-Source: AGHT+IEFOIVNKbTEEx8x0BOrq5l475AQjczjv+FBS+xZAPdww1X6sly8fE7DvXumcoSmpoaBgnmlc4riW9S/xj9NxZw=
X-Received: by 2002:a05:6218:280b:b0:1ca:9bd3:20df with SMTP id
 e5c5f4694b2df-1cab15a7902mr272032555d.9.1732723046581; Wed, 27 Nov 2024
 07:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125111840.63845-1-cgoettsche@seltendoof.de> <20241125111840.63845-9-cgoettsche@seltendoof.de>
In-Reply-To: <20241125111840.63845-9-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 27 Nov 2024 10:57:15 -0500
Message-ID: <CAP+JOzRyZWgpnoYO0T97F9zr=-DkSEsD9uvYFv-Av+5SN9NeBA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] libsemanage: respect shell paths with /usr prefix
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:46=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Consider paths with the prefix /usr for shells by including them in the
> list of fallback default shells and by extending the check for a nologin
> shell.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these nine patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/genhomedircon.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index 19543799..8782e2cb 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -192,15 +192,23 @@ static semanage_list_t *default_shell_list(void)
>         semanage_list_t *list =3D NULL;
>
>         if (semanage_list_push(&list, "/bin/csh")
> +           || semanage_list_push(&list, "/usr/bin/csh")
>             || semanage_list_push(&list, "/bin/tcsh")
> +           || semanage_list_push(&list, "/usr/bin/tcsh")
>             || semanage_list_push(&list, "/bin/ksh")
> +           || semanage_list_push(&list, "/usr/bin/ksh")
>             || semanage_list_push(&list, "/bin/bsh")
> +           || semanage_list_push(&list, "/usr/bin/bsh")
>             || semanage_list_push(&list, "/bin/ash")
> -           || semanage_list_push(&list, "/usr/bin/ksh")
> +           || semanage_list_push(&list, "/usr/bin/ash")
> +           || semanage_list_push(&list, "/bin/pdksh")
>             || semanage_list_push(&list, "/usr/bin/pdksh")
>             || semanage_list_push(&list, "/bin/zsh")
> +           || semanage_list_push(&list, "/usr/bin/zsh")
>             || semanage_list_push(&list, "/bin/sh")
> -           || semanage_list_push(&list, "/bin/bash"))
> +           || semanage_list_push(&list, "/usr/bin/sh")
> +           || semanage_list_push(&list, "/bin/bash")
> +           || semanage_list_push(&list, "/usr/bin/bash"))
>                 goto fail;
>
>         return list;
> @@ -210,6 +218,12 @@ static semanage_list_t *default_shell_list(void)
>         return NULL;
>  }
>
> +static bool is_nologin_shell(const char *path)
> +{
> +       return strcmp(path, PATH_NOLOGIN_SHELL) =3D=3D 0 ||
> +              strcmp(path, "/usr" PATH_NOLOGIN_SHELL) =3D=3D 0;
> +}
> +
>  static semanage_list_t *get_shell_list(void)
>  {
>         FILE *shells;
> @@ -223,13 +237,13 @@ static semanage_list_t *get_shell_list(void)
>                 return default_shell_list();
>         while ((len =3D getline(&temp, &buff_len, shells)) > 0) {
>                 if (temp[len-1] =3D=3D '\n') temp[len-1] =3D 0;
> -               if (strcmp(temp, PATH_NOLOGIN_SHELL)) {
> -                       if (semanage_list_push(&list, temp)) {
> -                               free(temp);
> -                               semanage_list_destroy(&list);
> -                               fclose(shells);
> -                               return NULL;
> -                       }
> +               if (is_nologin_shell(temp))
> +                       continue;
> +               if (semanage_list_push(&list, temp)) {
> +                       free(temp);
> +                       semanage_list_destroy(&list);
> +                       fclose(shells);
> +                       return NULL;
>                 }
>         }
>         free(temp);
> --
> 2.45.2
>
>
