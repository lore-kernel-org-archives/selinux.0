Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D724F880
	for <selinux@vger.kernel.org>; Wed, 10 Jan 2024 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlVczgKA"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ccb923c4d2so50828371fa.1
        for <selinux@vger.kernel.org>; Wed, 10 Jan 2024 13:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704922457; x=1705527257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XaXzCqKOfGgyxU5hJmpOi825nyIS+intLGC7pbTDa8=;
        b=LlVczgKAVkqk9u1smsEPhpCSph+fvCkbdcIk1UyjGbY0hfWRWvgr3ET9VrJctMMiXY
         0c248vAFT1pNHOfTQ8WMpVUJmRx65HIcLmjBCGArF4x5P2p+IGuhQ1uNVauR+92WlW8u
         LDCh07rO+mC3brAcOoR91cMqmmBvFeXzDIAqIMAzN7O6zELmt9C6mDK5hOpJjFXTsIO0
         batH+xOpPmJ6zcy7lS+h0BMm8Aw3rWTqgPZ1wyBsbLcbN61GPw3XqTQkLVx/akk6jWQt
         Uk96gDEsaxvXy+J0cWLQhKcl6LtddHRR5EX+CiNi9bC6NvssUlYWhyaYGcTlZV57OMxt
         H2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704922457; x=1705527257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XaXzCqKOfGgyxU5hJmpOi825nyIS+intLGC7pbTDa8=;
        b=SzwphiShnLG+l0i1zpNh7u9DL8dkH4dOwkPZK24yNM885ppbiP2dCuPl1ulrJTCHeW
         u1nO7vRad4qibVO1zFisV1zYQj6754eafmHI8lC/8+CYzYCCdCK5f6OPaw2DkyFaQ7gK
         EIJa/dDdUbsMLp7Bd9NL78o0JZCyZ62hp/0PM8GvGt9DKPxuqDsYOO9j1TciN5B4sHw7
         ZfzTCtdtbHIERmiQYjn0wFDOoaUk+hmONVXdLD4D/b3Yk+/S8GtoBocjf5R2q56FBW0n
         edoO/YueO1bmPSD8+uF2dhqzKj9fI9XS+O/C2RAT+4Y5JrrbktahcKmZAMnqgVdWT55b
         pGaw==
X-Gm-Message-State: AOJu0YwMtzu8ZaPpU2/EK2ThjQk8Jw3HyPzVx0Bp9GU1REjy6vVJufCa
	378D5ENHbV8VQbFVQtD+P1GlYYkA74aKI55N9dXD+xXknrw=
X-Google-Smtp-Source: AGHT+IFHAzB4ZpyDBKOfeEHL/YxMSn/etK7Yx6uTxSPprtmqeqyy459xFBNcGmN+gXgUH51kWnNMFWMJjkJK0ly2B68=
X-Received: by 2002:a05:651c:1038:b0:2cc:d4cd:18a1 with SMTP id
 w24-20020a05651c103800b002ccd4cd18a1mr61659ljm.54.1704922456439; Wed, 10 Jan
 2024 13:34:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108210314.339682-1-fontaine.fabrice@gmail.com>
In-Reply-To: <20240108210314.339682-1-fontaine.fabrice@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 10 Jan 2024 16:34:05 -0500
Message-ID: <CAP+JOzQ_UgiN=jxrMM+7wpprn+GrY=6yq_=6oN=KbVOX2-P9+A@mail.gmail.com>
Subject: Re: [PATCH] libsepol/src/Makefile: fix reallocarray detection
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:03=E2=80=AFPM Fabrice Fontaine
<fontaine.fabrice@gmail.com> wrote:
>
> Pass LDFLAGS when checking for reallocarray to avoid the following
> static build failure with musl raised since version 3.4 and
> https://github.com/SELinuxProject/selinux/commit/f0a5f6e33084bd83d409bb7c=
932256139f471e71
> because -static is not passed when checking for reallocarray:
>
> /home/autobuild/autobuild/instance-9/output-1/host/bin/armeb-buildroot-li=
nux-musleabi-gcc -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_B=
ITS=3D64  -O0 -g0  -static -I. -I../include -D_GNU_SOURCE -I../cil/include =
-fPIC -c -o assertion.o assertion.c
> In file included from assertion.c:28:
> private.h:88:21: error: static declaration of 'reallocarray' follows non-=
static declaration
>    88 | static inline void* reallocarray(void *ptr, size_t nmemb, size_t =
size) {
>       |                     ^~~~~~~~~~~~
> In file included from ../include/sepol/policydb/mls_types.h:35,
>                  from ../include/sepol/policydb/context.h:23,
>                  from ../include/sepol/policydb/policydb.h:62,
>                  from assertion.c:24:
> /home/autobuild/autobuild/instance-9/output-1/host/armeb-buildroot-linux-=
musleabi/sysroot/usr/include/stdlib.h:150:7: note: previous declaration of =
'reallocarray' with type 'void *(void *, size_t,  size_t)' {aka 'void *(voi=
d *, unsigned int,  unsigned int)'}
>   150 | void *reallocarray (void *, size_t, size_t);
>       |       ^~~~~~~~~~~~
>
> Fixes:
>  - http://autobuild.buildroot.org/results/0170032548a38e2c991d62dc5823808=
458ad03b3
>
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index d80a941f..16b9bd5e 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -31,7 +31,7 @@ endif
>
>  # check for reallocarray(3) availability
>  H :=3D \#
> -ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>=
\nint main(void){void*p=3Dreallocarray(NULL, 1, sizeof(char));return 0;}' |=
 $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>=
\nint main(void){void*p=3Dreallocarray(NULL, 1, sizeof(char));return 0;}' |=
 $(CC) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
>  override CFLAGS +=3D -DHAVE_REALLOCARRAY
>  endif
>
> --
> 2.43.0
>
>
