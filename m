Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183242065
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069477; cv=none; b=DdbjRRYVV9/ZwvdkrGSAHRpGqL6E8fsVTW9hSOTNLGvaQsZZRW1ncglzX4qEVXE6keD3PuYFZX8VzBrXeY5GS82BJVIFgtBvIPQYvyxLqgQclnYNoHPCctvZDR8fVqgRRt4LOHBFGjClJYAF0QYTtQELlCNGaIMPG2FNDUKnn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069477; c=relaxed/simple;
	bh=O3Kps6hrk6kGSDpvWtgAbTUONih4R5FNalDVAJJ58qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNujRcrvufa2ZQXUIhVKmBA+mKD0NAXb+kx6EhxLZusfl3Nxbc5oFYdMafjKpXFYrhts5OTw2UvTJmSS+BSdlyZayM2hJ3w7yykku4Gmbl/4TcYK07vHpTWIi4ELTYzknP8w7QWwkGksPYtjhlu21wBHoX6jr5X9P3QQt+c9KsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQEaXmbn; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQEaXmbn"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso1645561a12.2
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754069475; x=1754674275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o20G30InIaYf/S0thUK8+Ch+EYzJX4aQlK7ub99Q0+E=;
        b=mQEaXmbnqa5Y4pgJGv6HCEw88qGCaIhJO+VveXSNg2Jxf8CW6KyfL1OYDVNAXiZUrP
         WmIMDMh4izDDLJJWKiup3hGx0tubO4n5m+EfbZh0RtGU5LhR/kZr9UYeywU5jNV9MCag
         xObWrOErj07lmY5VvxP1H8X134fSXv+ZqwK+xGzv8g9MY9GHqv2n5u1A7N3YfB3pjLuS
         k+oHOACPo7Rft8jsyMKzHSbpg5DlNJlcIygKMRozawBJvWRkxj/pXnoOO6gO5M9EaH76
         38AWaSN4HJPhKUAMSwe3jR/Zns8lN1Ou9Drrgj0tviJgoVf+XU97KI0fRTi2uA+BS2We
         uY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754069475; x=1754674275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o20G30InIaYf/S0thUK8+Ch+EYzJX4aQlK7ub99Q0+E=;
        b=pAIPvtn5N4eu2aFbWvjnaKxW7tMr1On6Wp5oNWXN2lzIE2FSfOvplTtfJFMReC6AQo
         ORATd8Wo2v61jJkBWA3sZPMUXc5qvhbaRqGVfkXdE6jmx44VJOkkMVF3yTYGkPrEPzoq
         MX74BROCTG/DJMUSgMkANsCXUZpehoSo0Wi+kK5P8PTw7A4nI5KlEyOBdMD+3duERSON
         clGFNtUIkffeiy9qKddwdW4r4HjCN/BRsOK0NeyQeLA/5pAzQDWaUxg+Z6V67WS5PiFH
         rwaMmguYnpXXWwXPqxXxcJvSDyMCXwwXKmDY/1UO/GQo+n+gxMSc5ywDQYfjUZF++HCc
         exrg==
X-Gm-Message-State: AOJu0YyEvb5Na5tnGvW2vVHMalKHELya+RkWjZmTj5Bx/w/mBb3d4pAV
	4CKPbFcEiwqqUKf9nZ5EXIwVej3NPqgBw+vyMepVcxIld0tZno5hWEEamjq7geWb1H5Z7MaGcBf
	bykMvl3IO877y7Y51jw6S0diPOmEVao1VdA==
X-Gm-Gg: ASbGnctGzc6pmZIyQ484zEo7UwaUXFymbXvaqiDKcbR/TB37EEGakbPYjgsiIZu0+vu
	4SDoj83J+EgVdE1EjEos/klXgdHmTYj+OeX+jWFwAOfscUIeqGQTFudL7uimJhkCVPyEBZ0Ogui
	uL6AMPhUFtHuuHPs34Ly4NcekZWjnqCESvQOpEW38Yawz/QLkUOefPkP6y31gVxoEqg7lnqzl45
	8TBNek=
X-Google-Smtp-Source: AGHT+IG2ulyi74DlK77CN0x/Rtj4VdS8lWBX/M8tF8/NFhYc+qEZE0nvl2q2ZpWM8M33VdXlphfvwPj+hmV4bZIqNSo=
X-Received: by 2002:a17:90b:2802:b0:311:e8cc:424c with SMTP id
 98e67ed59e1d1-321162c9371mr689635a91.25.1754069475272; Fri, 01 Aug 2025
 10:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731162139.1074252-1-nvraxn@gmail.com>
In-Reply-To: <20250731162139.1074252-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Aug 2025 13:31:04 -0400
X-Gm-Features: Ac12FXyqLA15SFAzHIDgznjbOcVZMf4Ee7xupHpWD0w6B_CzMbOtw8dU05zKqs8
Message-ID: <CAEjxPJ60msaQXmD3kWOPoLb-=Fx1WK2TdGObpg+Vq40-yJEfTw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: refactor selinux_check_securetty_context
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 12:22=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>
> Invert the checks for fp and con, and initalise char *end as NULL.

spelling (initalise) and *end was already initialized, also see below.

>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> ---
>  .../src/selinux_check_securetty_context.c     | 80 +++++++++++--------
>  1 file changed, 46 insertions(+), 34 deletions(-)
>
> diff --git a/libselinux/src/selinux_check_securetty_context.c b/libselinu=
x/src/selinux_check_securetty_context.c
> index 7609752e..f04b66e0 100644
> --- a/libselinux/src/selinux_check_securetty_context.c
> +++ b/libselinux/src/selinux_check_securetty_context.c
> @@ -1,3 +1,4 @@
> +#include <fcntl.h>
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -8,45 +9,56 @@
>
>  int selinux_check_securetty_context(const char * tty_context)
>  {
> +       context_t con =3D context_new(tty_context);

This means we allocate con before we even know if we will ever reach
code that will need it.

> +       if (!con) {

No need for { } for single-statement bodies.

> +               return -1;
> +       }
> +
> +       FILE *fp =3D fopen(selinux_securetty_types_path(), "re");
> +       if (!fp) {
> +               context_free(con);
> +               return -1;
> +       }
> +
> +       const char *type =3D context_type_get(con);
> +
>         char *line =3D NULL;
> -       char *start, *end =3D NULL;
> +       char *start =3D NULL;

start is only set and used within the loop body so no need to
initialize it here.

> +       char *end =3D NULL;
>         size_t line_len =3D 0;
> -       ssize_t len;
>         int found =3D -1;
> -       FILE *fp;
> -       fp =3D fopen(selinux_securetty_types_path(), "re");
> -       if (fp) {
> -               context_t con =3D context_new(tty_context);
> -               if (con) {
> -                       const char *type =3D context_type_get(con);
> -                       while ((len =3D getline(&line, &line_len, fp)) !=
=3D -1) {
> -
> -                               if (line[len - 1] =3D=3D '\n')
> -                                       line[len - 1] =3D 0;
> -
> -                               /* Skip leading whitespace. */
> -                               start =3D line;
> -                               while (*start && isspace((unsigned char)*=
start))
> -                                       start++;
> -                               if (!(*start))
> -                                       continue;
> -
> -                               end =3D start;
> -                               while (*end && !isspace((unsigned char)*e=
nd))
> -                                       end++;
> -                               if (*end)
> -                                       *end++ =3D 0;
> -                               if (!strcmp(type, start)) {
> -                                       found =3D 0;
> -                                       break;
> -                               }
> -                       }
> -                       free(line);
> -                       context_free(con);
> +       ssize_t len;
> +       while ((len =3D getline(&line, &line_len, fp)) !=3D -1) {
> +
> +               if (line[len - 1] =3D=3D '\n') {
> +                       line[len - 1] =3D 0;
> +               }
> +
> +               /* Skip leading whitespace. */
> +               start =3D line;
> +               while (*start && isspace((unsigned char)*start)) {
> +                       start++;
> +               }
> +               if (!(*start)) {
> +                       continue;
> +               }
> +
> +               end =3D start;
> +               while (*end && !isspace((unsigned char)*end)) {
> +                       end++;
> +               }
> +               if (*end) {
> +                       *end++ =3D 0;
> +               }
> +               if (!strcmp(type, start)) {
> +                       found =3D 0;
> +                       break;
>                 }
> -               fclose(fp);
>         }
>
> +       free(line);
> +       context_free(con);
> +       fclose(fp);
> +
>         return found;
>  }
> -
> --
> 2.50.1
>
>
