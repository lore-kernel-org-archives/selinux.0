Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B3299927
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764387; cv=none; b=OU3oG7oSRS4UcRpKDn2LeuyRofYTUInwhcrPS/La/aU52hhqadM59cU4S5hboVpa1SxokW/5laWZQbWnSGvlKfMyrZs0723kfD2r+4qLKcMPByhPQOFHCy7PEQY8TwynTORmmNXT+uBC7Oor5bcvlrmr8N3vrPyni2AwOJfyVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764387; c=relaxed/simple;
	bh=xgn6W3Mw3nIatAj9wnOmnRcTjd8DfkcJqUW+JBmRrLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/BD9GkPFekTmDu7oW2kAqwYWuqnHAATe9krrJfDkzYyx7qpAZRMLcHYa68rwa/aUM4cWzD7Iu5da2avIYK4I7IsHIKCw9GJSsfFw7APQB0lVeoxtgCOYe7cl5YoXxhHfJfbBs//5q+Oby3iVETJ0i/p0b2vAQT85W2/CxBlV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgoKWVHb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgoKWVHb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781251eec51so3785356b3a.3
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759764384; x=1760369184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIxIzysK0PjWOOGQ72Zy20mn3PkKWE312+es7okbF7c=;
        b=HgoKWVHbQSDVBbn8BJeIwBYP51T3c9PUVh7HfnMGFAgxorYOF00Ni+9Nqg60crrmvy
         Q47EqnpEN7P0wtp84GWuaWunGOv133I7QKR8El4F+xXWZP8VSzH3zDl4gAjzw/uRpL3p
         /B6FSn7BY+i6i6+VYSW/+QDNDeZyMi5R8MEdAsCn5dDSQ4J5AytkrR566kh68lkRc5zC
         utM3E2qguIZUX7NGV6U50wURhs32NyqW0eyrjzRpeYNQbdAgOVAgCOuQeN0jOSyW9WMe
         CV53JDJbCcQzBXCSFVw22exODFjrCKOGsYDtefxjinS1C0m7VR4JHlPax7gnSiB5xYgN
         HiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759764384; x=1760369184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIxIzysK0PjWOOGQ72Zy20mn3PkKWE312+es7okbF7c=;
        b=wkcYxPU10+dAjrw16ZOQqdfDrq02NpHU+gD/LYTwjhT8IDvC3QCMZqsrBMkNm6rf/b
         1/Ohs0C0KtQo7pLJSTTi8Yg92a3BTlIUeCXO+SqjkcuOVn+ZIVxfx5YJkAJpwNb5PTHj
         euLtxYjP/ZCVxxHvATfEUz2V2Ri3gLeZsAbMiHbC16+rQ512j7eE7kEK9Ui0GYyzoRn8
         fmzVTO3ZkR02E5cSEHoV4M4ILuJY1AM1L5tLcrH7a96PuY7eKCthWyTbB+MQM4jwbAAt
         ruYoLductgKv7h3/umZIDx5i9hI2RWcGzukr6Cze56gSzMJk6Du5EzIJZW0UavzmCxYZ
         G4IA==
X-Gm-Message-State: AOJu0YyBjxEjajhR8U2MQPEex/rDOT3bO3NZ90RbQJiJCQ0LH/K2JoFh
	1DQ4DpuO80lPJMf52YH9aIualSgjSuQcfvvvXk7SLkk5N3STRXwv+P0FLmZjSU6yC4yF5u+UY1s
	7U6C0GJGz7S6maLeCPjGCJQT5wXo3NvCiLw==
X-Gm-Gg: ASbGncvyqhW/M1bdp4d6WmDNHdv1bi0k5kmPc4rrs88O+Q0+zMOqKl8KamG46hetCLS
	4JdX9SiZ57zfQzZzKQoG00y8wWaVNOMSGJ+MRAt1cZzV7IyvKjuJN0D5l63dJIxtiGhaczR0153
	7vRJ8jQ2WCklxIuAWuOCbMnkrvwaxF/s2kNlbKMbs+kkBSOrhTj26dVXtF2aafxJeo0/HfF2wYQ
	Qny90VTy6Dp/+uUf5H8Y+M7HWOaz84=
X-Google-Smtp-Source: AGHT+IFDhBWjunXBEe+Ryic6LEJtLltvMEiiZqV6N3OJ3MXRrEJgbelgPrLiQrg9m9tQT2Zu83XitcCSaOpSqyG00dU=
X-Received: by 2002:a17:90b:3b86:b0:32e:5b07:15dd with SMTP id
 98e67ed59e1d1-339c2707b50mr13483250a91.1.1759764384173; Mon, 06 Oct 2025
 08:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731171706.1079400-1-nvraxn@gmail.com>
In-Reply-To: <20250731171706.1079400-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 11:26:13 -0400
X-Gm-Features: AS18NWAfa-KUIb1f0kdBmbGKlZaY6JsYttC0qOokbm6BmFuEUdxcFP_9X1xT0Ww
Message-ID: <CAEjxPJ7L7K1=1JE0+h28uRt3fySF5RgW1wt_k352_Wv+qr9TUg@mail.gmail.com>
Subject: Re: [PATCH] seunshare: always use translations when printing
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org, Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 1:18=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Some errors previously were not using gettext for translations, hence
> wrap them with the _ macro.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Obviously this will require updating the translation files.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> ---
>  sandbox/seunshare.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 106f625f..97430535 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -103,7 +103,7 @@ static int set_signal_handles(void)
>
>         /* Empty the signal mask in case someone is blocking a signal */
>         if (sigemptyset(&empty)) {
> -               fprintf(stderr, "Unable to obtain empty signal set\n");
> +               fprintf(stderr, _("Unable to obtain empty signal set\n"))=
;
>                 return -1;
>         }
>
> @@ -111,12 +111,12 @@ static int set_signal_handles(void)
>
>         /* Terminate on SIGHUP */
>         if (signal(SIGHUP, SIG_DFL) =3D=3D SIG_ERR) {
> -               perror("Unable to set SIGHUP handler");
> +               perror(_("Unable to set SIGHUP handler"));
>                 return -1;
>         }
>
>         if (signal(SIGINT, handler) =3D=3D SIG_ERR) {
> -               perror("Unable to set SIGINT handler");
> +               perror(_("Unable to set SIGINT handler"));
>                 return -1;
>         }
>
> @@ -353,7 +353,7 @@ static int rsynccmd(const char * src, const char *dst=
, char **cmdbuf)
>
>         /* match glob for all files in src dir */
>         if (asprintf(&buf, "%s/*", src) =3D=3D -1) {
> -               fprintf(stderr, "Out of memory\n");
> +               fprintf(stderr, _("Out of memory\n"));
>                 return -1;
>         }
>
> @@ -371,12 +371,12 @@ static int rsynccmd(const char * src, const char *d=
st, char **cmdbuf)
>
>                 if (!buf) {
>                         if (asprintf(&newbuf, "\'%s\'", path) =3D=3D -1) =
{
> -                               fprintf(stderr, "Out of memory\n");
> +                               fprintf(stderr, _("Out of memory\n"));
>                                 goto err;
>                         }
>                 } else {
>                         if (asprintf(&newbuf, "%s  \'%s\'", buf, path) =
=3D=3D -1) {
> -                               fprintf(stderr, "Out of memory\n");
> +                               fprintf(stderr, _("Out of memory\n"));
>                                 goto err;
>                         }
>                 }
> @@ -387,7 +387,7 @@ static int rsynccmd(const char * src, const char *dst=
, char **cmdbuf)
>
>         if (buf) {
>                 if (asprintf(&newbuf, "/usr/bin/rsync -trlHDq %s '%s'", b=
uf, dst) =3D=3D -1) {
> -                       fprintf(stderr, "Out of memory\n");
> +                       fprintf(stderr, _("Out of memory\n"));
>                         goto err;
>                 }
>                 *cmdbuf=3Dnewbuf;
> --
> 2.50.1
>
>
