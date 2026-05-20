Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CE92367DF
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307331; cv=pass; b=YHay1WzTtwQdUu65SpfXwOIAO6cRr5dadk6ozvlGPd6sV6kbv6FmVrxMB5fY0kncjBj8yVpp19j1D8hD7nNGilKVhQZ5AClh9TcTunGpcd5SOYwhevoGnpt31aInEOAFhi5bXdMD6pdjZpskGEn7l7/Xqi75UxxrgMgigKOnw50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307331; c=relaxed/simple;
	bh=RlTXmlu7Dk//TEBKPYg4q8EGkPTv0SO897RDnkYBzgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2Ma1zmoZRUHjb/9h1LwYGAsUwSYuIrIpU2xr4x9hUMHCPRF9WT7W197w0wi9gPEsQCvUEXmoVFRve9RzUvpDJVbKvOVt2dL6jilayVKo4GIrAgARZQkmQ78Se63+Gf8ViUNdkGb05OOexdxCtXMcs9OC5w9ZRxrMPc1wF4IhiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWxl5ONK; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWxl5ONK"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39393c1b5aaso202511fa.3
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779307328; cv=none;
        d=google.com; s=arc-20240605;
        b=exxOHqz55wxOGto9TWaC5EyZ5kUdSZ7Fxu6LxYTwob3gRDnn7JLaGH5Ny5d5IFzlFa
         //Gh6EuXU+KBSuUBXa8wpofd+uKkSArN5xog2jmTsgqJtbHX4qCowEJV6WnqkPpNyu18
         lXyijaH1xf8aBzdbezLNtBP2R5shpIavubk/Hkbu6khr0bMViwG0NrD6NaV4oagxNfSP
         z4ROYsuVkdkX1oL1eqRPHYfXXdrC9SRKKnhuFwjy5fOOsKRtDYuyIvXO1dndZUZr1lXu
         RucMsRNxZ/LsqTlotoh4FVz20bIG5sLxFJNIeifkE+sdDSh9DemnUCMVkSpYmeW4OMf8
         AyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9lXT+AAYxqIeXTzPLbKFJ+jJg4j83nqrnX7Ocf5+iQ=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=CHN5U91OFYyzUntbD8ABNgylYbo6Ec5gZ4oF69e6o/x+u+isEBXaex02JWW0zyLfG6
         otSKVLtH4F8DwZzuLb6WwE9IFzMRGPAbYnBlE6xiwHBcaIuKQviPfvi1BrMFWpnU/dIK
         08Sgb+NZVDBp2/fVCekc9Z08EPLANuXXie6muehkDs4QZkhC5JVnfZTZxcbT1TkDNgpi
         xnsWtX8I1BI1DNSbqmoBjvcQ1S/k2dcdD9t0ttnRTCitySRxPogL/bIApUwZpKB/3aNN
         vn5LqTgbjhSKgv03abwKQ3lOPHYFxzKkko2aD78uvhP0S7dUNjr4fiTjxxVhmdDDpxqo
         wSTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307328; x=1779912128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9lXT+AAYxqIeXTzPLbKFJ+jJg4j83nqrnX7Ocf5+iQ=;
        b=dWxl5ONK7W1D+URh6IP+AVqK3kyw6wIr4sV+Ig3/aX73JYO3HYKDPCoNE4pAZ9GLI5
         tKpylyXDwgBwXRgXqUFzYI4qxWRDK5KxtjD5v5o/uXIT1WHzzY0L7gZ3VnfCRj91A5xj
         6EHdv6z5cP7mF+Auyw8eLeZsb/u3lT31huEHhtjzgap8CP93J9nx4Va0nS9KHf9VoZPI
         49ftfVYYhid94Ge0pLkxVLzlkU14lOt/jl6JgX67f9AaCkup5xYMdzQ6wahE5SzW3Bvr
         efTlem4EH28X4w6EM7QBEdVKKcygAh+gDBL1LVxyA2XaeOudwvFobcM3V6MAzbHxWZh8
         Yz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307328; x=1779912128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9lXT+AAYxqIeXTzPLbKFJ+jJg4j83nqrnX7Ocf5+iQ=;
        b=g+hoIn/S/aYqNYvpZ+uOGHZzGk9u1pKPxA8UusIH9nnDS2slJCqp0U+F/WYSg1DGTu
         2rnOn1lSX7flBVV+J0yDb34hPN5NN3zmz9urEgyacAi5Y/FZzNR5JY4hNvDhTQu0iJzj
         Uf+wpcGigtdKqqT4QRy4LJwlmdhUln6PCrCO2rK9HZww8BsC5ZatQVev9T/yreZ8XHnF
         faIU+75t5bf2bUJpTY4x0rmQovzHH69f/i5VYf9sOJLqaT1mIVnVXEdpkyyC0/VVTNaA
         6pcbbT/u7Dwr7YLbfetZKPdPRt6DG9xkEbi1KZhActLu47oYZSxAJrOZPP3paFlLC0R5
         rgPw==
X-Gm-Message-State: AOJu0YyrQMLpoHW52SY1bq2UC1+zpLlierOA8O0kIgLyz8Gb1G35eYIA
	KRxa567Vr4l5ycpU11N9jgj7Ckq94wexWsH3G7tgO0lIRwiunKJSfm1OFEcFUIE5sCoBOY23dnA
	x8ZJ5oyCxX0GAAFi7bQpxTtWYacS2EFQ=
X-Gm-Gg: Acq92OHgrAr1eB7Od0nEA+nzSEnqunAnbCrFn6gW4Dpny9VFzScPQAZz2r7pzoXj3iR
	HoZKid7ZPibkyafO9kBjiZ33iA/00Mmuyn0C8eyH4GHOrNU2I2Z62PLTudCOWkf+syBfz1VCyzX
	lHhko//nNWIBWZd99Bw3JKPLtlVmADwmkF/C+vJ6NJHWQ2JLS1MwKxppg7stABH676ATbb4AP0O
	aY1isLBM3gjcuN6YIy0z2gJDCQGcsu0xFB2moO0TsAyz/LmVRLPVwM4uDms0Aq7MFAxAbZKbkdS
	uZpO
X-Received: by 2002:a05:6512:114c:b0:5a3:fd83:13f7 with SMTP id
 2adb3069b0e04-5aa0e601254mr7801283e87.6.1779307328061; Wed, 20 May 2026
 13:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514205631.76858-1-kalevi@kolttonen.fi>
In-Reply-To: <20260514205631.76858-1-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 16:01:56 -0400
X-Gm-Features: AVHnY4Jn0gOqk73_h_28YMmNcvOMRhHZ_tsgnzMN6DSLMAuxC0Dr9c0j2Z4QF3c
Message-ID: <CAP+JOzRfnG-fS3Ef=-DZf81Y6YvBKfE8uWB9PpC8nu=yDqqd+Q@mail.gmail.com>
Subject: Re: [PATCH v3] libsemanage: make expand-check a proper boolean option
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 4:56=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Make expand-check configuration option accept values
> 'true' and 'false' for consistency with the rest of
> the boolean options. Preserve backwards compatibility
> with old configuration file settings by still accepting
> the values "1" and "0". Edit man page to reflect the changes.
>
> Add missing <stdbool.h> include.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/man/man5/semanage.conf.5 |  2 +-
>  libsemanage/src/conf-parse.y         | 22 +++++++++++++---------
>  libsemanage/src/semanage_conf.h      |  3 ++-
>  3 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/=
semanage.conf.5
> index b22e65bd..74f0d34f 100644
> --- a/libsemanage/man/man5/semanage.conf.5
> +++ b/libsemanage/man/man5/semanage.conf.5
> @@ -59,7 +59,7 @@ The target platform to generate policies for. Valid val=
ues are "selinux" and "xe
>  .B expand-check
>  Whether or not to check "neverallow" rules when executing all
>  .BR semanage
> -command. It can be set to either "0" (disabled) or "1" (enabled) and by =
default it is enabled. There might be a large
> +command. It can be set to either "0" / "false" (disabled) or "1" / "true=
" (enabled) and by default it is enabled. There might be a large
>  penalty in execution time if this option is enabled.
>
>  .TP
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index b69ac75b..70691fa5 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -29,6 +29,7 @@
>
>  #include <errno.h>
>  #include <unistd.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -168,15 +169,18 @@ target_platform: TARGET_PLATFORM '=3D' ARG  {
>          ;
>
>  expand_check:   EXPAND_CHECK '=3D' ARG  {
> -                        char *endptr;
> -                        long value;
> -                        errno =3D 0;
> -                        value =3D strtol($3, &endptr, 10);
> -                        if (*endptr !=3D '\0' || errno !=3D 0 || (value =
!=3D 0 && value !=3D 1))
> -                                yyerror("expand-check can only be '1' or=
 '0'");
> -                        else
> -                                current_conf->expand_check =3D value;
> -                        free($3);
> +                       if (strcasecmp($3, "true") =3D=3D 0)
> +                               current_conf->expand_check =3D true;
> +                       else if (strcmp($3, "1") =3D=3D 0)
> +                               current_conf->expand_check =3D true;
> +                       else if (strcasecmp($3, "false") =3D=3D 0)
> +                               current_conf->expand_check =3D false;
> +                       else if (strcmp($3, "0") =3D=3D 0)
> +                               current_conf->expand_check =3D false;
> +                       else {
> +                               yyerror("expand-check can only be 'true',=
 '1', 'false' or '0'");
> +                       }
> +                       free($3);
>                  }
>          ;
>
> diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_c=
onf.h
> index 2388faad..f9e330b7 100644
> --- a/libsemanage/src/semanage_conf.h
> +++ b/libsemanage/src/semanage_conf.h
> @@ -21,6 +21,7 @@
>  #define SEMANAGE_CONF_H
>
>  #include <semanage/handle.h>
> +#include <stdbool.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>
> @@ -36,7 +37,7 @@ typedef struct semanage_conf {
>         int server_port;
>         int policyvers;         /* version for server generated policies =
*/
>         int target_platform;
> -       int expand_check;
> +       bool expand_check;
>         int save_previous;
>         int save_linked;
>         int disable_genhomedircon;
> --
> 2.54.0
>
>
