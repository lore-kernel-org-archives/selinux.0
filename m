Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E13FB2E
	for <selinux@vger.kernel.org>; Mon, 12 Feb 2024 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777030; cv=none; b=SInV0+5NYaT9yhDQYiSNubtwlTvaIpae9LHuUD127KoSQZGcvM31yd6kZ1OVU4eC6jXNGhhxEEYS2JreQ1R7smYnNi1SrAVkheh5adzWWRpPVmqBM3w+E27LTzZsL+ZMt3S4dUl7C9+XAoIFrzZYTPQXKhQZwE568MSna46VE90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777030; c=relaxed/simple;
	bh=a9il1Vhu93eqlQ5+HkMwL82HT6AXoPS4anMQR9TI+QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmIhvpG07HE4S5UnAOJ9WcVd4Rh6XB8gAVfXx9SReVVi7EI2YyVV6T6HpkOEALtvJIKA4huD+qkFVNuqPCMyUFs8ULZSB4qQJVy8RT7WJcpcfWkjIb0kD2DiVcOaCf0bRo0a9HZkIg7mVxaiUH6QQGitq6wn7EYvgoNiLVLMqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfi/HI3g; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfi/HI3g"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d625a3ace6so2773368241.0
        for <selinux@vger.kernel.org>; Mon, 12 Feb 2024 14:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707777028; x=1708381828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkN3AtfmCflnQXNcyjve620mHSt4WrIwTL6cd3dZKMI=;
        b=Bfi/HI3g1AD2+v384hc4IrNpAw6VOaLUH18piqRBg3V0n0O0z+1yXlqaBBKOtAsDMS
         M32v4s15UeRBHsZqHG1y7N7zPz6vq6Y+Jt0cwlWLXp1YFXUrikHFOvEsClQu/lHatxUB
         EWnObNDrojjQGlpIuEPWVEx2ATTxQ1USvHTiQ7qJz/2qDBVuFWn6QwjHyoCs4saxUe9t
         M9b8RJPCG3NSM8MMI2tr2JHcuc8mOFNDFxSE9tj1XsyTK7L/5L8ZyizYiqZrB5PIy+kY
         LdQGDA9XYYDcs/+ZWimoHV5GQ9kGZkE5lcoiCWnnX+WADlrg3HAAmNYFd8FH7h9CNIWz
         fm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777028; x=1708381828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkN3AtfmCflnQXNcyjve620mHSt4WrIwTL6cd3dZKMI=;
        b=OpTlfS99gHeNVWsyRLgK7T6jEGv6MR3eLBXEGlzFeqfyCXYpQUKpxZ/yOAO4TAF46a
         3aHh4Kp+ZZHN2SXqeHEPXfBXmu7BfuC8z+mQS7cS+PQTpnanE/dyCjOkVd4fvHLcjifr
         mx44vVhHv0OYSwL7Z7dqKjXX1eXEiRmGa7omHlFwX5fC9XwX8lJxoM1HfRpNRva1oy97
         3MENGyXBkIt4mDmeRHwLsRWDxpU+xyVwzDN0Yglw2ZPOiHFvT4h7DiLbDY6+KlGlIsr+
         Fm7RuDJtDR+f48/i+lMgvDTDGoRLegNre3Ug3c2g/kyb9R3qPnXjGHry+tHM3gYO9ycG
         ICXw==
X-Gm-Message-State: AOJu0Yy03dCA6QE1uub0K6orYWXfO7CGkQ2hPyWBA1XpQAcFdeUryrcQ
	NcUdH4bI95OeXwlR+Qi/VCphnXe5DeffjitNZtQfG2qIq9zgQjej7q7KC5aJqTwCqLQkx917ipf
	V0NQNrlJh5zrE3uZaJWGPpvI9hmjYhxnTbCM=
X-Google-Smtp-Source: AGHT+IG33TgwGigcgx8+OHajqqlcnE8wr/Dvl3wAWT6yzSjUpZuU2ges7lwpDUv4VvTe2517kuQ2nMiYMvbbAhYf+Ho=
X-Received: by 2002:a05:6102:94b:b0:46e:c4dd:2986 with SMTP id
 a11-20020a056102094b00b0046ec4dd2986mr1148574vsi.4.1707777027795; Mon, 12 Feb
 2024 14:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-10-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-10-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 12 Feb 2024 17:30:16 -0500
Message-ID: <CAP+JOzR6ph5pN_yLyvVh2+0deknKOmD_MZs39sd0ZbEnfL3O+A@mail.gmail.com>
Subject: Re: [PATCH 10/15] libsepol: add copy member to level_datum
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a new member to the struct level_datum to indicate whether the
> member `level` is owned by the current instance, and free it on cleanup
> only then.
>
> This helps to implement a fix for a use-after-free issue in the
> checkpolicy(8) compiler.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/include/sepol/policydb/policydb.h | 1 +
>  libsepol/src/policydb.c                    | 6 ++++--
>  libsepol/src/policydb_validate.c           | 3 +++
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 6682069e..06231574 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -218,6 +218,7 @@ typedef struct level_datum {
>         mls_level_t *level;     /* sensitivity and associated categories =
*/
>         unsigned char isalias;  /* is this sensitivity an alias for anoth=
er? */
>         unsigned char defined;
> +       unsigned char copy;     /* whether the level is a non-owned copy =
(compile time only) */
>  } level_datum_t;
>

I don't think this field needs to be added. See below.

>  /* Category attributes */
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index f10a8a95..322ab745 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1390,8 +1390,10 @@ static int sens_destroy(hashtab_key_t key, hashtab=
_datum_t datum, void *p
>         if (key)
>                 free(key);
>         levdatum =3D (level_datum_t *) datum;
> -       mls_level_destroy(levdatum->level);
> -       free(levdatum->level);
> +       if (!levdatum->copy) {

I believe that the following can be made to work:
if (!levdatum->isalias || levdatum->defined) {

To work, clone_level() and define_level() will need to be modified, so
that defined is not set until right before finishing the call.

Jim


> +               mls_level_destroy(levdatum->level);
> +               free(levdatum->level);
> +       }
>         level_datum_destroy(levdatum);
>         free(levdatum);
>         return 0;
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index d86f885e..e3af7ccd 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -623,6 +623,9 @@ static int validate_level_datum(__attribute__ ((unuse=
d)) hashtab_key_t k, hashta
>         level_datum_t *level =3D d;
>         validate_t *flavors =3D args;
>
> +       if (level->copy)
> +               return -1;
> +
>         return validate_mls_level(level->level, &flavors[SYM_LEVELS], &fl=
avors[SYM_CATS]);
>  }
>
> --
> 2.43.0
>
>
