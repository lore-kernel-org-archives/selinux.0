Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3B22EEF
	for <selinux@vger.kernel.org>; Mon, 10 Jun 2024 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043262; cv=none; b=AoxrvCqU8RsdbXDI8dOyG/Er2AtBW7f9rpuYO7K08pHzhV+dTCl6qKBIYOzw45DWEO/IiGpyMd+6CdwlO1TEwrPiL2mcDy0BWucLldc6AgaOkiQ9LL6dkPMQeaJ3Xr8D7LYqVLl4HgPfWN5x4ArGyYqir0blDOT/OX8CWjy4DVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043262; c=relaxed/simple;
	bh=8leRe8Mpm3gw4yv6n6mivDP0cGB+FrxXAiji3lTIXEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJ7OfwtXJpkAnwjimh+q5SPTVrmcKlCdJEq5ZAnacwaTomSY2jbC0Hjx+wpwwsI63/5E6uG+fKx9TZCV7iWp8bjxgv8Li1SvgVgPJWBvhWgX8LwlXF3e0e1GluBanXkHG0SUe1dJ8JpnyYMYEf2GA5rQvvZHIJw+uDaOIIKqXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQBT4zDq; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQBT4zDq"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f8d0a1e500so3457703a34.3
        for <selinux@vger.kernel.org>; Mon, 10 Jun 2024 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718043260; x=1718648060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOK6unOytaZV5IOBcr9JmA0k+OAO0pOD12cvM2kfOAQ=;
        b=AQBT4zDqlMTMtM4JyNyyVQYyAvQQ4I3qJscg6OfSUaDfvNskxQVATh+jp09X5hfLR0
         sGEwWXuZ/tQFUcqh6km9U02pE1Xc+u1jjQlLeVZXn3DCE+qhfG3Rr4cNguqXbzcOKgfV
         2rbKeC59X/ydjY2wNBhi/F8aEsme7/KcdA4gRZFle47vKaCc4v3zOUMUbItJUJPw6kzy
         P0GaoPcSbUB2ZlEU4NWi4SXwerBv5MPAlFM/M0w/flGXnN62whaLlgnhmrNBXUZdJgdF
         AIra/afOFXTjEJLUP8EL+bPljiv+QwqP2+NIs/xYaheBFAosEeBb8K9l3bSDFoveM2QE
         ggvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043260; x=1718648060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOK6unOytaZV5IOBcr9JmA0k+OAO0pOD12cvM2kfOAQ=;
        b=qAxJLxuR1HAbzvMl03vHsCYZWgLWnpvNBSCfKuBX2lAWPH/oM5UR8Ybfm0IWyEUJco
         65tguFFNsel8EnORCEM2n1WeIbnnQRvvLHDttv9VcK22LgwhPBwnYURsMh/Az4biYF8I
         jY0W78RvuM3xveGL/afO9zZ2SpETwhOMKMs0CaeL1PS4Yym/FcQOdTDv19yYV4iIPQpg
         CUkMyOo1CPxDeHIDwhgHmzeNqbGkD2b18d/wzRfwVoPHTdXRKuNBeUYKF1PXGQqcy+Ij
         BHDsLfw5MFRGZ/9tPqD6fy9FuT1nGZpwhxScdeR1fhDW89Dq68FRGwTOiQc2KvoefZ9e
         b27g==
X-Gm-Message-State: AOJu0YzsgJiin3j21DYdzcaUeHaz+T/PB88el+UbVoWpsBUwQFWrb6YW
	tLZneMXPQzkXb58vw6rrraoIes3weo3z6syBLazg5npcnYycB+ScE75l/RSsJySAqYJvgFErVbv
	XOlM1bXy7LuJr9IFI/QFKjEk8pZQ=
X-Google-Smtp-Source: AGHT+IFUrp2TJYd1zeOoJZvwig3bvWsY7dSdWHMUIoTwGWR/1Q41d7JPbq3LYVgW6S1FEr5THhmYJ2uqpUrid4y1WXI=
X-Received: by 2002:a05:6808:1b1f:b0:3d2:2e33:9a63 with SMTP id
 5614622812f47-3d22e33a94amr2554540b6e.46.1718043260133; Mon, 10 Jun 2024
 11:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606095039.50456-1-lautrbach@redhat.com>
In-Reply-To: <20240606095039.50456-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 10 Jun 2024 14:14:09 -0400
Message-ID: <CAP+JOzQLqRBsnssdHwUJK8===J5sQ67hEpfE5i4z8BJCKgn65g@mail.gmail.com>
Subject: Re: [PATCH] fixfiles: drop unnecessary \ line endings
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:51=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> See https://github.com/koalaman/shellcheck/issues/2769
>
> Fixes:
>     $ shellcheck -S error fixfiles
>
>     In fixfiles line 189:
>             # These two sorts need to be separate commands \
>                                                             ^-- SC1143 (e=
rror): This backslash is part of a comment and does not continue the line.
>
>     For more information:
>       https://www.shellcheck.net/wiki/SC1143 -- This backslash is part of=
 a comme...
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/scripts/fixfiles | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/f=
ixfiles
> index 166af6f360a2..cb50fef3ca65 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -173,10 +173,10 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
>         test -z "$TEMPFILE" && exit
>         PREFCTEMPFILE=3D`mktemp ${PREFC}.XXXXXXXXXX`
>         sed -r -e 's,:s0, ,g' $PREFC | sort -u > ${PREFCTEMPFILE}
> -       sed -r -e 's,:s0, ,g' $FC | sort -u | \
> -       /usr/bin/diff -b ${PREFCTEMPFILE} - | \
> -           grep '^[<>]'|cut -c3-| grep ^/ | \
> -           grep -Ev '(^/home|^/root|^/tmp)' |\
> +       sed -r -e 's,:s0, ,g' $FC | sort -u |
> +       /usr/bin/diff -b ${PREFCTEMPFILE} - |
> +           grep '^[<>]'|cut -c3-| grep ^/ |
> +           grep -Ev '(^/home|^/root|^/tmp)' |
>         sed -r -e 's,[[:blank:]].*,,g' \
>                -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
>                -e 's|([/[:alnum:]])\?|{\1,}|g' \
> @@ -185,19 +185,19 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
>                -e 's|\(.*|*|g' \
>                -e 's|\[.*|*|g' \
>                -e 's|\.\*.*|*|g' \
> -              -e 's|\.\+.*|*|g' | \
> -           # These two sorts need to be separate commands \
> -       sort -u | \
> -       sort -d | \
> -       while read pattern ; \
> -           do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null;=
 then \
> -                 echo "$pattern"; \
> -                 case "$pattern" in *"*") \
> +              -e 's|\.\+.*|*|g' |
> +           # These two sorts need to be separate commands
> +       sort -u |
> +       sort -d |
> +       while read pattern ;
> +           do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null;=
 then
> +                 echo "$pattern";
> +                 case "$pattern" in *"*")
>                        echo "$pattern" | sed -e 's,^,^,' -e 's,\*$,,g' >>=
 ${TEMPFILE};;
> -                 esac; \
> -              fi; \
> -           done | \
> -       ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $=
* -i -R -f -; \
> +                 esac;
> +              fi;
> +           done |
> +       ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $=
* -i -R -f -;
>         rm -f ${TEMPFILE} ${PREFCTEMPFILE}
>  fi
>  }
> --
> 2.45.2
>
>
