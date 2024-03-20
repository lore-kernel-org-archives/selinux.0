Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8285637
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965248; cv=none; b=ktfMaWcZ46LE3y9JPtXy6yzyPNnJkc+EUXP0Vb9h52O3SRXL/AXlHVwxp2MFeOfqWPigclM1wkpetyzuCBGQNnBJ3x5AkqAAhzx+duvevxzbMmyPyo5RljLSvY+wgBgzO/EkvpwwqHTFKcpg6cYjZgGg0oWhWM8oYeCPNt3KL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965248; c=relaxed/simple;
	bh=FIXd/fWN5BnB4g1Muz+H39L1bEiHMghZnwGbFLqC+rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoO272BMaa5Dw0Fe43r7gmI6DXcO2Q2zAsYKxmaklTxmxIa056L/Ec7htv53VMXDqJir4KH8bSllh7QyYMkT3Qrk/0R/mfFmUp5QQgn9LTwSpyf8i3L8IxYK1KPiTjBoaDroXQOY2KJtBAoYXogdHLGEdiDd5p+sLRvTKIwhK/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHk9kKTE; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHk9kKTE"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4767bcb4ebdso57793137.0
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710965245; x=1711570045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE5KZZoAjCSmZLx5w/nfkpFzaGdPoo1JZPk4uI4thQQ=;
        b=jHk9kKTEAqkLRbg6JygBcYWOKuU43TRYDGudjvEOKCcn0Acn6k9swvfD2xzwxDIOgh
         fB9BXNPb4XkkFvAo7dWuyh5Kn+ap1d0wdDROAuyoyRenmPiC5ks+t/NpFWG588Gs2lCD
         TwQ8e4VbhecXsZmXzISCWc6iKz0/ns/l0TWAz80LBrPbGnnnbO+ZFX2kVpsIvo93BqaR
         2LCgJqJTSVM3Id+S/lqCLg3AUGKGAPJCeWj1f9vd0J/tHQSiED2U24fH7N1eQB03CVbi
         VUX2m8HtSihrIckjKfeYv2+OzfXGvh4EVfgNPKvjfS+tUoKukY1gQlCghciv3diUPAD6
         UpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965245; x=1711570045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE5KZZoAjCSmZLx5w/nfkpFzaGdPoo1JZPk4uI4thQQ=;
        b=T+kc7Qokca9ka5PPhf5ETeRL7VckGwbNS8KmnuzXxJ5k1pIcmYALCe42fzLpo+zdYQ
         CMZsmwfP/azfxXI7n8wITwswaVufCvAm0VqSNSUp9IuTUa/j4jN8vZvk5JxIZpXe70i3
         8wKPYydsrsfql9ZsC5uOYX0A+m2iQf9hdlF0q1ISfKkrinfiWOojhpQeiloQT8oTDgPw
         2kiEHvG/QoExtZb1mDlbk6JMnUh+sVbd1FczwXdel0p+ZH9u99BuBiRiYsy4k109Kzzd
         bsUgkUU5E6hmxXd3zEHnMUoc8CYdUc9B18y4nE5aC58bg1nHsW+lpJeKjBl8w3stllbC
         NxEw==
X-Gm-Message-State: AOJu0Yzzt9iM83XCWSnQ2N1+74vWveiS/ffeT1Q5qn7808PbgCkscBsN
	629ip56MYme9WIebl9BI49IsdAXyj1S/nEd686bP3FWBhlgSQFpS1hyCYty/eko60P7SvbYaJtj
	zPOfuEGBMXdnWItolsL9voRRNZJpXEaq6
X-Google-Smtp-Source: AGHT+IEJAg6CN6Qe5eOMDqdSXStQF8VOqh94VvUw/UkqHFOAOuOA4hA2k9ojDB9NEM4BP8f6ZMYvojk/Y21t761yhtw=
X-Received: by 2002:a05:6102:2454:b0:474:d2a8:d61 with SMTP id
 g20-20020a056102245400b00474d2a80d61mr15858465vss.31.1710965245419; Wed, 20
 Mar 2024 13:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313224806.2859045-1-jwcart2@gmail.com>
In-Reply-To: <20240313224806.2859045-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 Mar 2024 16:07:14 -0400
Message-ID: <CAP+JOzRtHQbB0G_95ODmz3c1U5ZxmQaoA6jnNpFHMCaWRgCwwg@mail.gmail.com>
Subject: Re: [PATCH] libselinux, libsepol: Add CFLAGS and LDFLAGS to Makefile checks
To: selinux@vger.kernel.org
Cc: jordan@jwillikers.com, winfried_mb2@xmsnet.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 6:48=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> In libselinux there is an availability check for strlcpy() and
> in both libselinux and libsepol there are availability checks for
> reallocarray() in the src Makfiles. CFLAGS and LDFLAGS are needed
> for cross-compiling, but, unfortunately, the default CFLAGS cause
> all of these availability checks to fail to compile because of
> compilationerrors (rather than just the function not being available).
>
> Add CFLAGS and LDFLAGS to the availibility checks, update the checks
> so that a compilation error will only happen if the function being
> checked for is not available, and make checks for the same function
> the same in both libselinux and libsepol.
>
> Suggested-by: Jordan Williams <jordan@jwillikers.com>
> Suggested-by: Winfried Dobbe <winfried_mb2@xmsnet.nl>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This patch has been merged.
Jim

> ---
>  libselinux/src/Makefile | 4 ++--
>  libsepol/src/Makefile   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index d3b981fc..41cfbdca 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -104,13 +104,13 @@ override CFLAGS +=3D -I../include -D_GNU_SOURCE $(D=
ISABLE_FLAGS) $(PCRE_CFLAGS)
>
>  # check for strlcpy(3) availability
>  H :=3D \#
> -ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char*d,=
*s;strlcpy(d, s, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1=
 && echo yes))
> +ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char d[=
2];const char *s=3D"a";return (size_t)strlcpy(d,s,sizeof(d))>=3Dsizeof(d);}=
' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo =
yes))
>  override CFLAGS +=3D -DHAVE_STRLCPY
>  endif
>
>  # check for reallocarray(3) availability
>  H :=3D \#
> -ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){realloc=
array(NULL, 0, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 &=
& echo yes))
> +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return =
reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /d=
ev/null - >/dev/null 2>&1 && echo yes))
>  override CFLAGS +=3D -DHAVE_REALLOCARRAY
>  endif
>
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 16b9bd5e..7b0e8446 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -31,7 +31,7 @@ endif
>
>  # check for reallocarray(3) availability
>  H :=3D \#
> -ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>=
\nint main(void){void*p=3Dreallocarray(NULL, 1, sizeof(char));return 0;}' |=
 $(CC) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return =
reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /d=
ev/null - >/dev/null 2>&1 && echo yes))
>  override CFLAGS +=3D -DHAVE_REALLOCARRAY
>  endif
>
> --
> 2.44.0
>
