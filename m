Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695DF156897
	for <selinux@vger.kernel.org>; Tue,  9 Apr 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685399; cv=none; b=EoM3yq6IyDw7rBfFmwxBVyXYjeNGco3JdVJwGVG5bbyhneebH9pCcOTHYoihfS8a0KVfsD1XoA3ksBJKAfy/jUxSG+u3mAyAEdA5RKQNo41hOk4+d1IlXfYYDR6+cY4dauIdcFyl/HBFSBnUTi8ciEGkWSTIYngZQt4bCCnim0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685399; c=relaxed/simple;
	bh=f06BiU5YAir87dUVhYe7S27GW3Clx28YQpJ8bZAW0DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nL9uuzOjXcp9ntTm/AVcrSOt5337FrA3rxz76dJWZ1Estjxm/wsEIJRi1LRG6Ur1TVPzs9tMAymE4iVq2z7/n+TTxWjCIOigJOIAShOlGBY4hay05lLgDrRaGKS4HCqZBdnjyt69Kj5LiF5snnRfSU888tvIRj0fMZXCOGlY4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+ZYCuGd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+ZYCuGd"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a2c9903ef0so4117830a91.3
        for <selinux@vger.kernel.org>; Tue, 09 Apr 2024 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712685398; x=1713290198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=douY77uov0oPm3OewBNF1szJ406Ie+uoE/Yq074n0rw=;
        b=J+ZYCuGdyVMtNFjwGcKzlLGfHxzR+N7qXERVDZMtacp2WDM2zWX/d1uBiJrkbQUwSe
         auyikW8VvMnVnh2LVqfpT0oA9Xoc+D+oPmExE7xl3DaIgYm1v/5AUvI7ETv6Oz22/Uw+
         x3K/ZnTfrHzxEAMqW1zmCkx6JNugfzhslF3R5SbB3+zOd1VRcxxKxOCkfIcJf7DdXqOI
         cTjoCX/VodfWiCzLMheDdl+kA4XFr/cjeoW4zgZkRskAcHyMjPO4THAHK6F5MT/WqpJ4
         gJ0RRYoUuipxm2e5sFkjKPrCnGAyTpgGco93fMmnrGb6DM1KB54K4oA9mbXKw+0uD3A4
         J7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712685398; x=1713290198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=douY77uov0oPm3OewBNF1szJ406Ie+uoE/Yq074n0rw=;
        b=i7nbPcO15o6T3j4LIlpbfC0ye7QVbWeATdApPoTWbJz0P8lN9W1Hp3J7XFUm4eqv6j
         F7L+vUcQynHBQ4crKqboq9XC/Cai9lKd36+LRti+VHIJwBx9/JA7hieRGIeo5wWhxKfP
         zAc9TRw5+EyuEOeP5hwDbr05QbdGWYpCuWuPnj77M9lMC8oBh5n5yvk+4VjLmOLApmZG
         hsFj4/KYsD4CuwT+usSVw00c5ki5Q3NadKdALeBdRopwceDldG+ME7oYZV8SPjJF7KVJ
         31ancRuyvfTQlb8OjesgfjJaQXjNf1ZsfBSs8AykJY6etqHtndEumylJMWl8YSQD3nnP
         m0qg==
X-Gm-Message-State: AOJu0YyTvj2kOskgZwqkbbsYJ6dmrCC1fYKLlmfaXqm+2StfCo0Ze0Ek
	fyiD+yqy63Aejp7Ab4vzCRADAbkyM1QcxqYiOINwAum2W67ID7CG29Og60DCBQn9CrygS/8GIBT
	TuuiJPL+BZ9n1xUvQkYUwGn3U9oA=
X-Google-Smtp-Source: AGHT+IEKUk975uVYKTStD5Xnl5nmzE0hFbXTPqR/MIH7Ou4wsNoqs746fP7Ci+MaCXwftm78C/aXs06rI0VZ+mCuSCk=
X-Received: by 2002:a17:90a:d243:b0:2a5:1c68:4435 with SMTP id
 o3-20020a17090ad24300b002a51c684435mr367870pjw.40.1712685397492; Tue, 09 Apr
 2024 10:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408153006.69840-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240408153006.69840-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 9 Apr 2024 13:56:26 -0400
Message-ID: <CAEjxPJ4MRkgTSjc1uzASZzcvCNgnkcpZW-QHCYU7sMHqVQB8Eg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] newrole: constant time password comparison
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:31=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Perform the password hash comparison in a time constant way to avoid
> leaking the length of the identical prefix via a side-channel.
> Since only hashes are compared leaking the total length is non critical.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Should we just require PAM for newrole and be done with it?

> ---
>  policycoreutils/newrole/newrole.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/=
newrole.c
> index 5a1a1129..1e01d2ef 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -338,6 +338,24 @@ static void memzero(void *ptr, size_t size)
>         }
>  }
>
> +static int streq_constant(const char *userinput, const char *secret)
> +{
> +       const volatile char *x =3D userinput, *y =3D secret;
> +       size_t i, u_len, s_len;
> +       int ret =3D 0;
> +
> +       u_len =3D strlen(userinput);
> +       s_len =3D strlen(secret);
> +
> +       if (u_len !=3D s_len)
> +               return 0;
> +
> +       for (i =3D 0; i < u_len; i++)
> +               ret |=3D x[i] ^ y[i];
> +
> +       return ret =3D=3D 0;
> +}
> +
>  /* authenticate_via_shadow_passwd()
>   *
>   * in:     uname - the calling user's user name
> @@ -383,7 +401,7 @@ static int authenticate_via_shadow_passwd(const char =
*uname)
>                 return 0;
>         }
>
> -       ret =3D !strcmp(encrypted_password_s, p_shadow_line->sp_pwdp);
> +       ret =3D streq_constant(encrypted_password_s, p_shadow_line->sp_pw=
dp);
>         memzero(encrypted_password_s, strlen(encrypted_password_s));
>         return ret;
>  }
> --
> 2.43.0
>
>
