Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6FF36F8EF
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240984; cv=pass; b=UNyJSaHopYkglHkXhQG/UodbsOKWW9JO00V3xB7hSSO4u5VWFB7o0OqbFpyqSLoDMWNU1V34M6vX8u31hp7quJltjDq4t2Elu1L5n4BCRHS8ur0291+9jgd1tYH1Z5LtPe9DSiIS2KgSxOneuOSIAxJ0/QCJdvQGZuXE6UQCJrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240984; c=relaxed/simple;
	bh=sUF77fIvYxwLoIqQELxfr2crZ+CNF3vNY0T6A42Ycsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mx8zBbvmZ5bar96eP/fZhJ9o4BAut8fR4vFfTg7+9t3hAErXphXsPWtOiyQPSaCItlJWOaQx4NEW4u2fqC3wiqVfv0eXGK6mmOkOtqvKCat9XmyiOFWyyWfn+DeW1htWzZPZbAllmlUCoKU5acf5KiJ8Odrj+WxkdQ2Kw1LEAVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHml8AdE; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHml8AdE"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c86214eead7so90050a12.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 11:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782240982; cv=none;
        d=google.com; s=arc-20240605;
        b=JDIvfj0xAJjnE0n/iKuih9he0ozp7JbA4qLmRFn36+RMXFBXtlF/29Gh6p7iIUF2hT
         YTkdHhCBh4EdGkYfBTp6zqDE9efJZzYGIsAXXtCByDt/9dPbx+KsYzHxdP0Ujrj7mtBy
         1eGpZ4TDiRWmH847eFQZUmSF6q1IhuWaSHqCIzRXtGvgGxAlRXETDY2SxBmtSP4An2ar
         Qavt5aoQqkcdo39AeUjklc1ehD7meFlsoBbVNh72Uk6Ahj2aThmlojrASqKhqXqmyGVi
         1rgRpOULZlxZtlF5b2AdAWH9HDzOT9uMVbkWFkqH/4GYGzzu9ZybhuPkgy46oDDeA9+s
         Ouaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WiC4rrVmcZjJ1qoWrV69baA6GPmozALMTkxRWceZFQk=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=jLIniyZnqRHKBJoPhMPJlvGWg+7X8+k16ySRLi9nuAWDO6rMol390Vha1bdPS1Aehe
         RU9s8570I5uoYmFZiexdUSyLGRKs4U6YUwRPEw54Z9MrtMgzQgGcHePvYjaERjpWd87d
         lLXXWeNxAMlD6N8cRTzBV9uoekd5XhKy56eYv1V348pUNFRXxyWwlcgWiZ73TSR6Sqmi
         ZifiGWOzd6NVPS7VzeErBNboNZgqPdok4rG00030mfVOhQp7Gbmd6axticPEiPmuS09K
         1tCzG1GaRrO3bOfS4FliJFptfi8CMxr3DgwwOZhEcu5B4rt8WSHKjjpwMLmquUE5jVoC
         CUEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782240982; x=1782845782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiC4rrVmcZjJ1qoWrV69baA6GPmozALMTkxRWceZFQk=;
        b=pHml8AdElhzyQq2p14NSsFkuD/EdFZ/XWK747XRx2Siu5RHJQT3wCq8fZNVzdaE1L3
         8FzizAnxzqJQRsVTLkMF4mITKiJYW2aDizxr4nWYR+kTikzr1dXFBi3P9gQNiv6xm9+k
         Fx25rGSW2YAWPEfwmfuphZPfqiKMmDQNqok0mS9O7S6o4/uhuXqpDvqEzJRxduynKX5M
         twvjE1AAGv8otrawGUHA8CizoI8pR/WJJtEVXsHmG8ZgEzY3YmZnj4qohfCODc4es8K+
         W+9/gNt6ZhO/BBNiKxi5Q6MOxCC9MX5CWahVHx9jmlFIJtHjvMpGrOZJ1xmdl7j0vWnQ
         64IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240982; x=1782845782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WiC4rrVmcZjJ1qoWrV69baA6GPmozALMTkxRWceZFQk=;
        b=RzeOaW93sPeNesHfZVyNrwkit+/UCq7hs5tHuRHsdIB3x9d7xxGPXz3LkcSpoR6URG
         9sHuGyhXPnqhrqyYzJft6eauy4edWB876BQ5gb3DzO/MdQYhNoI4yOvy9SnDN3fxwsj/
         kH6QdNM1Abh1uf+Pv7cDmMMIP/FtImuyv11KT/mQ8fY1OV2AjFNOB+bNjO8UDGQTi7ce
         t2SsoNw0TvAk9ilyCbEfW4G7qmr2CqkiXjRAViPFM7UGrjyOp/ur44qbvW+CfrS3G+dJ
         hmJrTYSrGmodNKIhry9U2uS2b0+jgF96dsyubb6eaCoOJxhPXM+9ueXZpcubxgV07UAn
         N3+Q==
X-Gm-Message-State: AOJu0YwIY0308W/eU0QBJgj0/xArpP8oABcWtWSLmD52VRQ73fKbP+Ut
	AE8jyzLpirVeC2VPezaN1M/VsVs9EAIRPlYqB8UU5AfZ0qXDr3mtxx//AwlF7X0F6xuahDJrTED
	ELPk6RJp3QDK3UQppdqv9sqHRuo5r1mRPmw==
X-Gm-Gg: AfdE7clb27WZisHaltY2HU9xp1k6QRolu9AuvD8SE7tKEZmHtW71UxlKKv+yTPUrMlP
	M5TgvD2V0BmRTuVSykyYGNmq4WNfLc+GUwSWdqxoEFU7/qf5K8kbVERISSiPXQwMI1o5dDhXafN
	/CslD4ltH0KOKpkCDcV5A0zGAicF5NVWfsdZiYLY5cGLEUtzjpickef5pCGtgkAyg5X9nPpHN0q
	S/GAWZVoOqyXuKJSR60WSoF5xO3wfwqYVkC+mzgYoKfHFpqkjRKj02MJLti+fEC6tWwmh/2
X-Received: by 2002:a05:6a21:9992:b0:3b7:d98b:227b with SMTP id
 adf61e73a8af0-3bd10a16d4fmr4576794637.7.1782240982511; Tue, 23 Jun 2026
 11:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623174951.22074-1-jwcart2@gmail.com> <20260623174951.22074-5-jwcart2@gmail.com>
In-Reply-To: <20260623174951.22074-5-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 14:56:09 -0400
X-Gm-Features: AVVi8Ceo5hP9ICc8ugeh8-858cUJ_-Ysrz-s9ouNDqj9DHZsdsIS2vUvLOH4i-U
Message-ID: <CAEjxPJ7+tNa=eLOX68-Vi7ZA75MitQ0_u8eYYoEt1CBWg4FNkg@mail.gmail.com>
Subject: Re: [PATCH 5/6 v5] libsepol: Add overflow checks to strs_* family of functions
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 1:50=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The strs_* family of functions provide convenient functions for
> handling an array of strings which is used in kernel_to_conf and
> kernel_to_cil. It uses the common idiom of "*=3D 2" to grow the
> array without any checks for overflow. There is also the function
> strs_add_at_index() which can cause multiple iterations of the
> "*=3D 2" idiom.
>
> Use the __builtin_mul_overflow() function that will do the
> multiplication while checking for overflow.
>
> In addition, the function strs_len_items() adds up the lengths
> of all the strings in the array which can overflow.
>
> Use the __builtin_add_overflow() function that will do the addition
> while checking for overflow.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v5: Use new_size in the while loop conditional for strs_add_at_index()
>
>  libsepol/src/kernel_to_common.c | 29 ++++++++++++++++++++++-------
>  libsepol/src/kernel_to_conf.c   | 10 +++++++++-
>  2 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index adb7b661..17376f8d 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -117,13 +117,18 @@ int strs_add(struct strs *strs, char *s)
>         if (strs->num + 1 > strs->size) {
>                 char **new;
>                 size_t i =3D strs->size;
> -               strs->size *=3D 2;
> -               new =3D reallocarray(strs->list, strs->size, sizeof(char =
*));
> +               size_t new_size;
> +               if (__builtin_mul_overflow(strs->size, 2, &new_size)) {
> +                       ERR(NULL, "Overflow");
> +                       return -1;
> +               }
> +               new =3D reallocarray(strs->list, new_size, sizeof(char *)=
);
>                 if (!new) {
>                         ERR(NULL, "Out of memory");
>                         return -1;
>                 }
>                 strs->list =3D new;
> +               strs->size =3D new_size;
>                 memset(&strs->list[i], 0, sizeof(char *) * (strs->size - =
i));
>         }
>
> @@ -172,15 +177,20 @@ int strs_add_at_index(struct strs *strs, char *s, s=
ize_t index)
>         if (index >=3D strs->size) {
>                 char **new;
>                 size_t i =3D strs->size;
> -               while (index >=3D strs->size) {
> -                       strs->size *=3D 2;
> +               size_t new_size =3D strs->size;
> +               while (index >=3D new_size) {
> +                       if (__builtin_mul_overflow(strs->size, 2, &new_si=
ze)) {

This needs to be:
    if (__builtin_mul_overflow(new_size, 2, &new_size)) {


> +                               ERR(NULL, "Overflow");
> +                               return -1;
> +                       }
>                 }
> -               new =3D reallocarray(strs->list, strs->size, sizeof(char =
*));
> +               new =3D reallocarray(strs->list, new_size, sizeof(char *)=
);
>                 if (!new) {
>                         ERR(NULL, "Out of memory");
>                         return -1;
>                 }
>                 strs->list =3D new;
> +               strs->size =3D new_size;
>                 memset(&strs->list[i], 0, sizeof(char *) * (strs->size - =
i));
>         }
>
> @@ -229,7 +239,9 @@ size_t strs_len_items(const struct strs *strs)
>         for (i =3D 0; i < strs->num; i++) {
>                 if (!strs->list[i])
>                         continue;
> -               len +=3D strlen(strs->list[i]);
> +               if (__builtin_add_overflow(len, strlen(strs->list[i]), &l=
en)) {
> +                       return SIZE_MAX;
> +               }
>         }
>
>         return len;
> @@ -248,7 +260,10 @@ char *strs_to_str(const struct strs *strs)
>         }
>
>         /* strs->num added because either ' ' or '\0' follows each item *=
/
> -       len =3D strs_len_items(strs) + strs->num;
> +       if (__builtin_add_overflow(strs_len_items(strs), strs->num, &len)=
) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
>         str =3D malloc(len);
>         if (!str) {
>                 ERR(NULL, "Out of memory");
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 3e6bcb33..9bfe5b38 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1663,7 +1663,15 @@ static char *attr_strs_to_str(struct strs *strs)
>         }
>
>         /* 2*strs->num - 1 because ", " follows all but last attr (follow=
ed by '\0') */
> -       len =3D strs_len_items(strs) + 2 * strs->num - 1;
> +       if (__builtin_mul_overflow(strs->num, 2, &len)) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
> +       len -=3D 1;
> +       if (__builtin_add_overflow(len, strs_len_items(strs), &len)) {
> +               ERR(NULL, "Overflow");
> +               goto exit;
> +       }
>         str =3D malloc(len);
>         if (!str) {
>                 ERR(NULL, "Out of memory");
> --
> 2.54.0
>
