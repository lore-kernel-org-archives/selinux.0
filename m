Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16E42046F
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120741; cv=pass; b=rVfFaABO+Iyx00gPY0a2Ju1PlLy9vWRUYFvsK21X2pd3KL49o6ARp9OwHWQfMmwbDFCvQgUi5m+qx66X9+Nb3tI4thVkfLyAbDhMWOSwlze34Z6oyyRYeyqcZhZZ73N5SuM4NcucZAwbvg31kpdVWE6hR0ug9CeTC+1IzYQlFe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120741; c=relaxed/simple;
	bh=/5Rv6aiJac+Jt4ipXgvCqenkCw1qkSqYRnFUrfOYY8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhsJAYokVX8e68FvvsNLE8vvrgvRQlSP3ixc2fsLpVqbIzNA9IUB/MyzYQQOuRkxUGLCo9U5zwGOSy75RuhCfgTHZSTcUk26L2Hp4uJbqYy53Ja1rcLG6ghWjaqfV0EvrgGVf+V+anlmBH0cpn4DPD6AoNGPvflrqqQKIRsSDL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/j0Hk56; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/j0Hk56"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84847482584so1587460b3a.0
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 06:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784120738; cv=none;
        d=google.com; s=arc-20260327;
        b=UlSgUKsYnKBRuhV100JnQ1FA740bj6gVqt7AlKJkYJ8ImA/fqIItZz3Jo9NxZ3k3m0
         xEvA3szEMeTakCN0jIKkL6qBkE60ADjW5hcHEKUJlO19XUlYlDscpg3JLUVRKnpcidri
         nKM6Dhwt3gtjsbCtnAiFKBoaxtk9//AarGou+NqNj1LpjOmWMTufDQPH+g9Xnx/1ONyn
         spx05TWhEENAA9OITgVaCrYNmxXHPjnTLiFzeCvGWP+mS10w2aR0Ux/NfSurrloBLqab
         hqCm2K3PQLyhwrlyWrQpCrW/3dvEZnim3ric0aVcsQ1F97gPizJyITJqB56RwjcYVTAa
         58qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zUXfHJc6QSeiB/ct2sgnOWrqIjzYPbQ/vgoTIH+hgI=;
        fh=2ScO9gmp4RRAPtFsL+/8JnhbZGQ8h6GV+VgX9iOPR1M=;
        b=og+b2ErqFziDDzPwjBOt/+Dtf4rhaR3fuWokFftruXXSfYXMxKCiiBPUFY2y71VcxF
         Sks6vBEvae0e+VDc376yh+MG697qZcVSXevcTzKkQnAOSVc4mpCsdpmBNkcTYx/0vRzJ
         L7fT6tHsOAgOh6h51B/FkQBONFiwVDf2vEMqw7OkigEyU9nf925sEzfDdc6mB0KliktA
         r5eHV1c+n0A1sj22pQbPFqIHb1IS63YX1fOzG39EmB3kvybuBBNIt+6zyKbz/EcEsYxX
         mwWPcH+pNgZ3F3M6cpsXuMxvqKhNyqtdz2weWLrvICFv5U1aqeVjULGJ+6qVwMRgQQaz
         ukMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784120738; x=1784725538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+zUXfHJc6QSeiB/ct2sgnOWrqIjzYPbQ/vgoTIH+hgI=;
        b=Z/j0Hk56DjEn98GBY/ZuJRk2/P3OFJ9Ddoe5BWyCHNail2Q6rBulDjF4P8Yt6vnNYF
         jPt1n7va29YZ21J111LeO+DrTKl3sXBYWpmtkAJ9MwIK4PLxda6RaVisn3qAvN5D2APQ
         FStxNynThneQJVm0AcKTEsg3/RaKlJYdrDQtL0LbTCUnbJJYhH6M+qCHQc93txnVxLf1
         LMzfI3sscHNwQhCHKLohxjeOmiorZ/FDr24hdoBrhJ3ZBJPGSRgWlS0g3z4ULaH92aW7
         VbzD0zufkPBoLxtS5N4tvP5GUOaDPiu6U7G2sqbchUQqJ0+tSvvQONLCCfYB5Nrr3rn+
         yfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784120738; x=1784725538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+zUXfHJc6QSeiB/ct2sgnOWrqIjzYPbQ/vgoTIH+hgI=;
        b=Tdm7tLGF06ahkFUGoerbQeS+NH1VkcioBFKkQOsHyXr/CYMM9XV79IJozP1xCcfsKE
         0s87HvIp0HcDp06KBi7eutLmgQh9RXpQzSI0RipIwtWkEVjnz0TFGmjga9fQehLHT7xa
         plgqZOJOdOTLxW30UnbGGydTdiJx3FOah5leryrEfo28hAklg+cM0MuAJqQZEhj0+PEe
         cq8o+AYHvvO6GOClXzclPUtpiSN00/7v3cqVByFO7UGrSpM6k3OigvlpBp+3IgDajHko
         MkoPVPRp06DTUOQmhBDVWjvBAQV9+0OKD/SVNPLfBKIpfj4rQLdGozVYuVuwnk5yuafg
         g85Q==
X-Gm-Message-State: AOJu0YykjVKiEEJGHW0XwDUoulOgP1KSiBReXugnR/AbAo3sobXuuN0V
	QN0WR/iKbTT8Web8Ser4fRQasRpOpAIGf+S3H0U+2h0O4Aexy2d+kIWyfJiniBI/AiPkRcNz67e
	NLD0P/ZAn9rezfxIRS4IU+McJ8Dxrt2k=
X-Gm-Gg: AfdE7cnPsFNJjqdxsvuH4dytjoGc78CuYPgxJtJ4Y5ip1vupWOFw58HGyH70JdMQTBp
	p70+w89Mu3No2RN+WnND/qUvHi1Iwy/a2js7OZeWEYfbIkevoai+r4Ezf+17FLr9Nnq7DE+WkyZ
	vGpRUIuObTfh0N/D8uzTUGZ6yDi5tkBbgjcJLX019uivGq/PzAaZQGcXsyJbTlAa81iM++ShtY3
	Ad58Ez7O3f/mhzl4M41NCNpwiFogtKbsDUokRjjqz7rW0bP15tVJxrrsEGiiLesQN5viNcd
X-Received: by 2002:a05:6a00:e09:b0:842:3c77:5996 with SMTP id
 d2e1a72fcca58-8487034736fmr18726633b3a.1.1784120737243; Wed, 15 Jul 2026
 06:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714232511.2858868-1-tweek@google.com>
In-Reply-To: <20260714232511.2858868-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 15 Jul 2026 09:05:26 -0400
X-Gm-Features: AUfX_mygoP_dch80AVCOiBALATeDdn1KxpfFk-VZBcqsjidG2MauAafmneQAHOA
Message-ID: <CAEjxPJ6V62STmhacLbx4hD-+hu1hk4728xL=Qfp5=o0yBL-sgQ@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: use designated initializers for label initfuncs
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 7:25=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> Previously, the initfuncs array relied on implicit positional ordering
> to match backend context constants (e.g., SELABEL_CTX_FILE). If constants
> were reordered or added, array indexing could become misaligned.
>
> Use C99 designated initializers in initfuncs to explicitly bind each
> initialization function to its corresponding context constant.
>
> Additionally, define _SELABEL_CTX_NUM in include/selinux/label.h
> to count total backends, and add a compile-time static_assert ensuring
> initfuncs stays in sync with _SELABEL_CTX_NUM.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> ---
> v2: Rebase on selinux/main and format
>
>  libselinux/include/selinux/label.h |  5 +++++
>  libselinux/src/label.c             | 18 ++++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/seli=
nux/label.h
> index 748b0db0..bde2501f 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -37,6 +37,11 @@ struct selabel_handle;
>  #define SELABEL_CTX_ANDROID_PROP 4
>  /* Android service contexts */
>  #define SELABEL_CTX_ANDROID_SERVICE 5
> +/*
> + * Total number of context backends. When adding a new backend,
> + * please increase this value.
> + */
> +#define _SELABEL_CTX_NUM 6
>
>  /*
>   * Available options
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 1ccd1abe..991b9769 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -4,6 +4,7 @@
>   * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
>   */
>
> +#include <assert.h>
>  #include <sys/types.h>
>  #include <ctype.h>
>  #include <errno.h>
> @@ -45,14 +46,19 @@ typedef int (*selabel_initfunc)(struct selabel_handle=
 *rec,
>                                 const struct selinux_opt *opts, unsigned =
nopts);
>
>  static const selabel_initfunc initfuncs[] =3D {
> -       &selabel_file_init,
> -       CONFIG_MEDIA_BACKEND(selabel_media_init),
> -       CONFIG_X_BACKEND(selabel_x_init),
> -       CONFIG_DB_BACKEND(selabel_db_init),
> -       CONFIG_ANDROID_BACKEND(selabel_property_init),
> -       CONFIG_ANDROID_BACKEND(selabel_service_init),
> +       [SELABEL_CTX_FILE] =3D &selabel_file_init,
> +       [SELABEL_CTX_MEDIA] =3D CONFIG_MEDIA_BACKEND(selabel_media_init),
> +       [SELABEL_CTX_X] =3D CONFIG_X_BACKEND(selabel_x_init),
> +       [SELABEL_CTX_DB] =3D CONFIG_DB_BACKEND(selabel_db_init),
> +       [SELABEL_CTX_ANDROID_PROP] =3D
> +               CONFIG_ANDROID_BACKEND(selabel_property_init),
> +       [SELABEL_CTX_ANDROID_SERVICE] =3D
> +               CONFIG_ANDROID_BACKEND(selabel_service_init),
>  };
>
> +static_assert(ARRAY_SIZE(initfuncs) =3D=3D _SELABEL_CTX_NUM,
> +             "initfuncs array size does not match _SELABEL_CTX_NUM");
> +
>  static inline struct selabel_digest *
>  selabel_is_digest_set(const struct selinux_opt *opts, unsigned n)
>  {
> --
> 2.55.0.229.g6434b31f56-goog
>
