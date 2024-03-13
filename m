Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB15A10F
	for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370256; cv=none; b=VSPngP531xYBoMFll41/VBWiesDd5wXDoRsTeNdDXfckT4IngmSyvji7taF9fA6exBqc1P6iX7vuezC05t7kapTORhlpJw6xq1bU/AV/8KBQ+GNH3yV9ndHKjxIJFTHI9A/a/rDLMJ5vwyBmzzY4N+/ga+Sc1H67kBdZBJUVonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370256; c=relaxed/simple;
	bh=GcKDAAfJf3beZXXRGW8RLaXzDrrLrRjXiG73YBVKScI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXx9+kGxlf1Y+EsYIZlcqUiJ7uMbvVqGQxP1ap36uAq2USJnDPx5Pj2rMlJMicszpTIch6LQcNyYzD2TzmPUW7zdkGs+2MuANB1LIoqkOsuCtNLZ5PzP/nc1dTtjFr0UNa+DRicduQ29qvX4WMvtgrC1Iu2cSr/U2b75fRBD11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUjHHJJ2; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUjHHJJ2"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7db44846727so144003241.0
        for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 15:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710370253; x=1710975053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqjvSeNDmzODzXqNAUhavPBW9aeqjXOHes/p2bsMPMA=;
        b=mUjHHJJ2bSNLKUevv9SzwLNsMfeE1dsS7LwCMAA10IlyvyheFiSIx9oJr1NtnLFlcd
         s2RLTR85SBr8O5NZMk9+vb6t9cAAzND5ZJVtez/To6XsBg+y8Tx5yFAynVGvZq24lFz2
         uOpNLsrL1+/e7N4AfbSPssC+YUbtzEnFNqxRJ0QyF2WefLyUajYzA7D3x8RWtoi3qK48
         dGKVSzIh3x+lDxW2eFPpkXfcWHZ+yc4U6g/tOw/WpHpBY3Jm1Ov7mGyEJ7ki3z97aCV0
         J9cZthzjrF5+NJlJKKkeJG5uXmMj3lDpFZamQSNEE4bNxSeaPJm/BEA79i9YIJCXaPZc
         x1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710370253; x=1710975053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqjvSeNDmzODzXqNAUhavPBW9aeqjXOHes/p2bsMPMA=;
        b=YRnDGD0OoR30/grq31DnV3w6JoHWpPlwwuS7d2dvwjDurSmJcyvvjgb9TGfB9v5orz
         VKp3LNcdIC+Z+JnlMW6cAqhNyjYeTi03k+vgRBDJd34F3XgYv2uOS8pPU45FQ+0J+cUF
         i/RxF1y/iM8NSo/R/tiefu4kGWSHYDScvlqD9STDavJbfYkInPQvxhfbA90z+MTyQTuv
         EvFurqZTcZNk57WPJjHZQI9t/EKGmowJf7NNJL1pAA/7GZy9r6J7C+b5zETTagiK6MNH
         l6qzc5cBssZK22PaGGYftxY+Pdb9sVjD1KizQ6p8AblClaQvbRDD3zx0jx7tdPR4NDCw
         C/iw==
X-Gm-Message-State: AOJu0YzDSjRZBgW7X3uWKfvijn3UmyYpvw4WJ5IXmZoUITfRs/M1QAM8
	s/V83Yz1ZIvlHIhpJVNTbToTjhQYG+wOcVf/di2O6losUofkkhVHu0nnZGV/iSQO+F9MYS9HhU4
	/ViQOK2fL7h5T0ZEc21GaOAaKihFzAh8s
X-Google-Smtp-Source: AGHT+IHM+QzBNiqE3YX3UgztIjJMZsKsdzD+sES3if/XNEzegW9NZiCHI1P7ra9Xu4AeLlLC7wNXThyjz2Dfo0Nuqys=
X-Received: by 2002:a67:f5d9:0:b0:473:3431:4f78 with SMTP id
 t25-20020a67f5d9000000b0047334314f78mr328611vso.10.1710370253335; Wed, 13 Mar
 2024 15:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229164439.20521-1-winfried_mb2@xmsnet.nl>
In-Reply-To: <20240229164439.20521-1-winfried_mb2@xmsnet.nl>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 Mar 2024 18:50:42 -0400
Message-ID: <CAP+JOzQMATOACnaC=WMT5PS+YdGaJtCFzWy2nPVwSmFmuZABzg@mail.gmail.com>
Subject: Re: [PATCH] libsepoll/src/Makefile: Fix reallocarray detection when cross-compiling
To: Winfried Dobbe <winfried_mb2@xmsnet.nl>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:45=E2=80=AFAM Winfried Dobbe <winfried_mb2@xmsne=
t.nl> wrote:
>
> In addition to commit 3e3661f602fe7d7dc972bf695fd178370bbd7e54, CFLAGS
> are also needed for the reallocarray detection when cross-compiling
> libsepoll.
>
> For example when cross-compiling for Arm Cortex-A9 the compiler finds
> stdlib.h (after the addition of LDFLAGS in above mentioned 3e3661f).
> But then tries to include soft-float stubs because gcc options
> -mfpu=3Dneon -mfloat-abi=3Dhard are missing. See output of detection:
>
> In file included from /home/wdobbe/.conan2/p/b/swpt_fb08c05e04578/p/sysro=
ots/cortexa9hf-neon-poky-linux-gnueabi/usr/include/gnu/stubs.h:40,
>                  from /home/wdobbe/.conan2/p/b/swpt_fb08c05e04578/p/sysro=
ots/cortexa9hf-neon-poky-linux-gnueabi/usr/include/features.h:474,
>                  from /home/wdobbe/.conan2/p/b/swpt_fb08c05e04578/p/sysro=
ots/cortexa9hf-neon-poky-linux-gnueabi/usr/include/bits/libc-header-start.h=
:33,
>                  from /home/wdobbe/.conan2/p/b/swpt_fb08c05e04578/p/sysro=
ots/cortexa9hf-neon-poky-linux-gnueabi/usr/include/stdlib.h:25,
>                  from <stdin>:2:
> /home/wdobbe/.conan2/p/b/swpt_fb08c05e04578/p/sysroots/cortexa9hf-neon-po=
ky-linux-gnueabi/usr/include/gnu/stubs-32.h:7:11: fatal error: gnu/stubs-so=
ft.h: No such file or directory
>     7 | # include <gnu/stubs-soft.h>
>       |           ^~~~~~~~~~~~~~~~~~
> compilation terminated.
>
> Signed-off-by: Winfried Dobbe <winfried_mb2@xmsnet.nl>
> ---
>  libsepol/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 16b9bd5e..fd6329d4 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -31,7 +31,7 @@ endif
>
>  # check for reallocarray(3) availability
>  H :=3D \#
> -ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>=
\nint main(void){void*p=3Dreallocarray(NULL, 1, sizeof(char));return 0;}' |=
 $(CC) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>=
\nint main(void){void*p=3Dreallocarray(NULL, 1, sizeof(char));return 0;}' |=
 $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes=
))

The default CFLAGS causes the compilation to fail even if reallocarray
exists on the system.
See if the patch I sent to the list works for you.
Thanks,
Jim

>  override CFLAGS +=3D -DHAVE_REALLOCARRAY
>  endif
>
> --
> 2.35.3
>
>
