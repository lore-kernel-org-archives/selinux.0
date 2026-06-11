Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90015238D52
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197019; cv=pass; b=kSzyFrW29PFbQtQACffWRMXjUZPjKJeR5t8X23PZ7fhGPkzo8mB+sZG3joc4XEydpp1C/KDgL9byb8kUt+h28OI8FG1iNd3TlNgbvCSCeDlPdq2QyP15x73/OQdYecP2HiI57ZP1XhUV0P/AmRz8htcssCTrLDyJK6BRLw3FadA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197019; c=relaxed/simple;
	bh=GpVnL1WUh1oJK4AWv85fQtcLI+PORuBjmbMwWwxGM9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcGC4GvWFAZMhwRF+0BpYsnuU4tFgqY1iO6Py18oc4hcEMwQae45rWXlxVD034y5RgoYb/MDwTLl+x5rxatuJQlIGiyA3p4etehLERk3RcDTO/2ssuO4OE3H3DLxPUg5ysjMCsmeOwmVVuiUXX4rf2Z1baizHRZl2Yv9g0oYzY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVusB1y0; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVusB1y0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d8b644473so136176a91.3
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 09:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781197018; cv=none;
        d=google.com; s=arc-20240605;
        b=YGJwdua1qQCRW4+sjJPzylfQM0gJ3J9r5iT1PAZ/9kIwsE03PefDIOnw7dGdOao3aZ
         MftmZKsuowjEBzEa37qG6BvHINBDnept1yV/wq8wf0JUjXmkuenQhF1/+Mw/Z2lmXQU/
         0Kp6WUYE9itZjbmFKNKMLcvi6Q8WYRl4lIyOLGXzPqExSZXcRag3dpCtIBqO19jMOywo
         bfZ9DUPfILOftS+RC1dTsNPGQx6dNvlOd6Rgx00lNrvZ9fZj5P/sPc9DuT7EftCyBQBQ
         yQDoBhDu2B+oT/jueqSG3pI7tkWF78CHZULRmVu+vUsXBkNLdcjLc7CES0zZDCLCh9w/
         cdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kKmdeMKzxWqzQstucDskHqpU9HjvDKOyP6XvOSBUQzI=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=hRAA7ZUyvBmLWfjyy/uEbvnVPqkGypVys5nfM+A2Hc27fzxVhLvyMAnlPCTqFJmfvg
         uD/W9zEyECIceSJi0X/ZckFly64TbIo8/g5QBSE1tKpM6qaOCFMR34CJmtRG0FoP37kz
         4oOaeWrJaelilQt4vw9ds69Twl7T5FU9mbz6xvvinqdxLn/u7CiFKau5EQ/SBjVUw1r1
         PkHfN3yZi4J7tFAIKLeF/agVgCCA86IcMQw3SIAiwVlPzpZM5bGy4tVl6lO3htjLk9YW
         Tfug43K9rPwZqd95vHM6BonUgGJdNr/3g5gDhczQ4MF9fvsvf70fUpicRn8Wp9E+YiUs
         hjLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781197018; x=1781801818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKmdeMKzxWqzQstucDskHqpU9HjvDKOyP6XvOSBUQzI=;
        b=SVusB1y0YVukIL3OlNCXWhJUlzUF41Pumx3Qfogm144mqivoyn64ycGoxDudNsH96a
         MsBsHxaM+dol2JwqsTuaG9XaHByJG5HpgBYk7ITeeQ8snE4IO/bM2vRWQrzl93GIpTqL
         yE0AenOmkKTz+zuZSmiNHhITYoD9GhhK6oBg1K8I7/IWUOiAIzaqnBeKaNy/U6+ehELC
         pCMZTuQkX0ymZa1MoiF+yLMoBBnrirqYkdfRYJu6C1wM65IuLlSwCa4GinjYkjB9djeH
         AUrh48lH7BLeQcQcV1d8kUh4Sg0qCHH4qPTsdWaQ2Pdoav2nWA6aCBUg0x41Iyp5a757
         x9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781197018; x=1781801818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kKmdeMKzxWqzQstucDskHqpU9HjvDKOyP6XvOSBUQzI=;
        b=qeQSmirJ9pYQ5Q1bpws0PbMkRFNySHVAQI1DkyqafSCwvnQ5zITnQ3ncu4pMPOv7fZ
         To7nFigOleTPK02YQMEezGaBHJzkDbux4E3suKiaM8GIZitYDfGnHDhp1bmIXIMtWtZl
         2ani16MdQAWnvlfi6J6ghW2fJjL7pGCOS0ji2+QbZSlPT0x6tYGGUvgWAtD9SvnzluBJ
         4ZCaQobJ487709D5MTm/S5pJWM6hk3Mr2OlqJQ5/3YuUuRSgl/lvsP9U7dMUI1bFxy77
         XldiLwQEjY6Upj3eXHrzbB1T//xY9A4rMsp4twP4mn48KP4Lln/mGXAoIa6Sn2tmEClj
         EEbg==
X-Gm-Message-State: AOJu0YzrHVhoeYGdLbSs9SvrhszO2aDi7rsj2ufsCb6SaHoYLPOQGrTW
	t9/HAxcUsgBwkHbZXe1HEaszeFiWwB8fwNEcJ//AQ+tHcAnwBP1mAM+rCpQjvS93nsJ2I/79dqz
	yvuZNDk6tXbQGfyXxVNNQDYQBtvnuTNxZUQ==
X-Gm-Gg: Acq92OHjb9KhMozGFL5b9PEzCkLIJUVtvb2OUcRIrju3OukhsodP6J7fRj/AAa87GMp
	cBvZZ12R8BlOmVx9jthnxT5vCVSkKMPlB5i81E5Ohxlp4PXOhivmymXyffHMoqlmK/kRvXqaFZz
	2wYKzLDIJAuEAtIJiYh48NpSjZ/A72+9FU1N/mOXOdgw14oGuylv10gmcrTvZcJ+hZxW/e6o0B4
	N8KYr4g2J54S0NQVQkO90VdURR9aTSf25QLwb3mw2YqdKJ2yRmLNOzRwgkHmkl1fJRQhZ51SmwZ
	bvRYwu0=
X-Received: by 2002:a05:6300:6690:b0:3b3:fdb0:2295 with SMTP id
 adf61e73a8af0-3b5e316eb10mr4617952637.6.1781197017757; Thu, 11 Jun 2026
 09:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610151930.48676-1-kalevi@kolttonen.fi>
In-Reply-To: <20260610151930.48676-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Jun 2026 12:56:46 -0400
X-Gm-Features: AVVi8CdEznJw4jxX1YxRIQAEMBsjWcqEcR5Itwqc1jg1agenqqcY0q_VDT6_P94
Message-ID: <CAEjxPJ5BP-_QufaB1TXp2AwTL+udgsp-M66swqSsdyo05=uL0g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: use null character with strings
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:22=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/get_context_list.c     | 10 +++++-----
>  libselinux/src/get_default_type.c     |  2 +-
>  libselinux/src/is_customizable_type.c |  2 +-
>  libselinux/src/matchmediacon.c        |  2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
> index 01419b07..39d169dd 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -152,7 +152,7 @@ static int get_context_user(FILE *fp, context_t fromc=
on, const char *user,
>
>         while ((len =3D getline(&line, &line_len, fp)) > 0) {
>                 if (line[len - 1] =3D=3D '\n')
> -                       line[len - 1] =3D 0;
> +                       line[len - 1] =3D '\0';
>
>                 /* Skip leading whitespace. */
>                 start =3D line;
> @@ -175,14 +175,14 @@ static int get_context_user(FILE *fp, context_t fro=
mcon, const char *user,
>                         start++;
>                 if (*start !=3D ':')
>                         continue;
> -               *start =3D 0;
> +               *start =3D '\0';
>                 linetype =3D ++start;
>                 while (*start && !isspace((unsigned char)*start) &&
>                        *start !=3D ':')
>                         start++;
>                 if (!(*start))
>                         continue;
> -               *start =3D 0;
> +               *start =3D '\0';
>                 if (!strcmp(fromrole, linerole) &&
>                     !strcmp(fromtype, linetype)) {
>                         found =3D 1;
> @@ -209,7 +209,7 @@ static int get_context_user(FILE *fp, context_t fromc=
on, const char *user,
>                 while (*end && !isspace((unsigned char)*end))
>                         end++;
>                 if (*end)
> -                       *end++ =3D 0;
> +                       *end++ =3D '\0';
>
>                 /* Check whether a new context is valid */
>                 if (SIZE_MAX - user_len < strlen(start) + 2) {
> @@ -308,7 +308,7 @@ static int get_failsafe_context(const char *user, cha=
r **newcon)
>                 return -1;
>         plen =3D strlen(ptr);
>         if (plen && buf[plen - 1] =3D=3D '\n')
> -               buf[plen - 1] =3D 0;
> +               buf[plen - 1] =3D '\0';
>
>         nlen =3D strlen(user) + 1 + plen + 1;
>         *newcon =3D malloc(nlen);
> diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_defau=
lt_type.c
> index 8955c505..6a09ca22 100644
> --- a/libselinux/src/get_default_type.c
> +++ b/libselinux/src/get_default_type.c
> @@ -39,7 +39,7 @@ static int find_default_type(FILE *fp, const char *role=
, char **type)
>                         return -1;
>                 }
>                 if (buf[0] && buf[strlen(buf) - 1])
> -                       buf[strlen(buf) - 1] =3D 0;
> +                       buf[strlen(buf) - 1] =3D '\0';
>
>                 ptr =3D buf;
>                 while (*ptr && isspace((unsigned char)*ptr))
> diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_cu=
stomizable_type.c
> index 992747fb..4eac6cad 100644
> --- a/libselinux/src/is_customizable_type.c
> +++ b/libselinux/src/is_customizable_type.c
> @@ -45,7 +45,7 @@ static void customizable_init(void)
>                         while (fgets_unlocked(buf, selinux_page_size, fp)=
 &&
>                                i < ctr) {
>                                 if (buf[0])
> -                                       buf[strlen(buf) - 1] =3D 0;
> +                                       buf[strlen(buf) - 1] =3D '\0';
>                                 list[i] =3D strdup(buf);
>                                 if (!list[i]) {
>                                         unsigned int j;
> diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediaco=
n.c
> index ca3d7980..2bc0932e 100644
> --- a/libselinux/src/matchmediacon.c
> +++ b/libselinux/src/matchmediacon.c
> @@ -27,7 +27,7 @@ int matchmediacon(const char *media, char **con)
>                         return -1;
>                 }
>                 if (current_line[0] && current_line[strlen(current_line) =
- 1])
> -                       current_line[strlen(current_line) - 1] =3D 0;
> +                       current_line[strlen(current_line) - 1] =3D '\0';
>                 /* Skip leading whitespace before the partial context. */
>                 ptr =3D current_line;
>                 while (*ptr && isspace((unsigned char)*ptr))
> --
> 2.54.0
>
>
