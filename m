Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17E2BE7A7
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979332; cv=pass; b=TQinp/g1q7BJUjM/AmzeOaA5XisyW1dfan8S8pyCy0wudRrViMAwd5C2Xql/BMaXG37BEGOtziirdRERhCYumEtOCryO85iIsAZwszdMbvgvuhMdwg/MxqdhEWgfspMQslP4FCut97sMZTnYJsEI/2S5jMVepLjvdDwViD2oms8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979332; c=relaxed/simple;
	bh=AbMMEdaLzvavz4ifv4EdVhqxIF7pOr6g20zcJwvZLyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMSMls16Rc+S1AvWQmtQLGcWxPIvDBNrW80r6T7PG+h/ke99nhXFgQDEe9MljfMpAVA6kJ1Thrw3ZeJfAo8vbXXVY0tO/v+iuKU/jLlCMLxp659hpiBgbW0dRXC5oiPq9IYtx6LSCmN3QLwkF9yQRM2KC4APilgzDzmsmpYkbMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSL7/0V3; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSL7/0V3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so8961890b3a.1
        for <selinux@vger.kernel.org>; Thu, 28 May 2026 07:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779979331; cv=none;
        d=google.com; s=arc-20240605;
        b=XzyZr52iji2v2Mf8l3qg2EViZ6JLyOKO7yxq4DW64zVP+NxdXUEiPzNlpMB5QzsFzv
         xyfOdUt0EEK+axYEXyVgEAmzNNmfOvTcy3vVOU+sSfCKGUTR3LlKXxakFcJZF9UpWyF3
         z3v8sJBxXUdvDq2eKZO/+dBZ+YmqYg2qAsT38KhAS3UE/6ghxBUiGEGijouoe47Gwm/a
         sNwQlTF+SrugtwBIyrgUa6zq9fDJafYfWmw0IksqGHs8/o9WLrqG0x9zqldVXZXNGZJg
         AQKz45cehzUksJC18imf07DrcVTEhsVOLurrZ5Yyv9zHUwTF3XvTql+op0lv6P8wOwz0
         NLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mOo+8k9V+yfRU4E6bIm8d5gEm4LIAZp+reWfzc22Sn4=;
        fh=7OQpntt0QOhySdZ0nM2b99cMazMUXPQ2Hl1d1h7aoXs=;
        b=VqpxUS64fFv6V2B0ooY/0amLXcXW110C6saWE7Z7MMn9rgFl48//FtZlKZa1mrstpg
         w13srx2BMCc+SqnN/CjSiQoSVwkSug2mJm2Byj4zwXAoXSZo4qGwtqxwixq+aBZTWDFd
         +xSMVzLc1Kb/ZY/GlkRU3MwgXhPiSR9YKREUX7fRVU8isnx9CMD3hRFKpMDXysYUdzzp
         HvN2AMjsGtzt4m0eU/TpVbFaBddzm4uNSgTaF+FpCN5tiq2GmKF07hGyiuz8RcPJDWmu
         up0c5zrz9SxyFqR/aZ+Tgwp4cFrT2Z7boy3LqCZbhEWO9FbFHFuhzO3PuhlgplRJDfvR
         Jvrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779979331; x=1780584131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOo+8k9V+yfRU4E6bIm8d5gEm4LIAZp+reWfzc22Sn4=;
        b=jSL7/0V3WB64H9aSyd+nHPSpzk6Mi+ghcH45nvWXqTdC28IC1De2LmnIW2LG/YHwIj
         FZArmMGA3FlAnL1PGXewwaTOy+vps5d8ZZhl329cHr3n4p1GVw6h5/hagx7ZWWtpymzf
         n3IxQRh1r8jHDlFobYXPhY1O45NEymqOtAhz9NqEP2Wr464BZh5AXFvOBnZ0fc+Yserq
         IIh9jKNx1SCTGePh1U6tvHW2lAXJyKu9zN1+6yN7hjzQTEqdFeU8j8vd4nAaLlkOSUPF
         1+vFpo5FvrRZa+cFqsbwHwmstXi9UjSA/zXivymP39WQJ6UIE+gEqiQZrOBYCd2QPvjF
         RB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779979331; x=1780584131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mOo+8k9V+yfRU4E6bIm8d5gEm4LIAZp+reWfzc22Sn4=;
        b=GvDhggR1C+XLXet77v9wmE394hG4KpCp9AWjnXtXpxU0htxy9IAqfDA1gIyuzRlS5q
         KD0KpahtcCgcPjYj55oBQQqHuYBI1Wk7XOd0ljfYMj683n2QP3gal8W43b1uENyFlBKy
         jYXi4yte6bQHLbPN9U7ooa0IzqK43ERHATJUjLBESZIlDvz1e3sLmB0mczz/3OlK0SyP
         +A8yZQ5mar6gA1ahqzGy9LRP2B7QNAC4abTFBq0WnrE4lE4cSbJksxtkkG+NADUyf1vL
         nIH6bLrTe8boGz4Hjg6lXKpHg3/VwdSgH3iNzRDoe6e16z2kpMOcS6HVugQzMioay6XV
         e2wg==
X-Gm-Message-State: AOJu0YxyraIPSHkneGLiw796HfB86Fsa/AhMCrR9J2owHysaxvtyIB2h
	A0PJQoHL6Fv5ygPRpJWD2hGKs6fWNvZL6XMG+H85Zq2OcD0sfWTb+B9NIiqClLzbLoGk0hI0vfp
	zAoztzz0Apm1EHyRcWMYo1R/trllXqGw=
X-Gm-Gg: Acq92OHdOfrOmz3oPIv1063LA+T36/d9PvwiY7KA8w9zCTTCP/Dfmt6aI0sUxiwWpF/
	DEnJeXmbBMssSILy06EE+09JeZvIeUfV7ruS4RMFhXx1X3s4ZqrFP6K6BWV1aU63e1I1vN2HvNe
	6HRkd7tjYayW/Nt6vjQmHb4EpkDuDjHey4RLspBlKcu0lkNZ1EISUlKdfYKh7ST1WEFNT9lVVuC
	RBrXp8RR8/dn/+nNxc4tJM+a0Ovwmw2hKA5ceb7gHppdN5Nry+pMIu0hAfrak0/72ilFX1HkLne
	7OYlXcpnOP5PPM8hmQ==
X-Received: by 2002:a05:6a00:2d0a:b0:83e:2eb5:b196 with SMTP id
 d2e1a72fcca58-8415f5de711mr28099035b3a.26.1779979330686; Thu, 28 May 2026
 07:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHLDejyMAktQhBkfJrvz5OrS=d7WSSe4pFA33qKJALtH_nWafw@mail.gmail.com>
 <20260528141117.1265999-1-lautrbach@redhat.com>
In-Reply-To: <20260528141117.1265999-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 28 May 2026 10:41:59 -0400
X-Gm-Features: AVHnY4JLCv2WIi3UeUu0i5gwU5-JKqqzi27eR0aH2DYkiDbtCZV4ObaQSQA0ET0
Message-ID: <CAEjxPJ7bB9NrcTEKZgqLmAPamu=mdrZeH8Yq2YjLPLHESny5OQ@mail.gmail.com>
Subject: Re: [PATCH] expose alias for stat64 and lstat64 on musl
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 10:20=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>
> From: Pepper Gray <hello@peppergray.xyz>
>
> fix: 477
> Signed-off-by: Pepper Gray <hello@peppergray.xyz>
> ---
>
> This is resent of the originally mangled patch. This time taken from http=
s://github.com/SELinuxProject/selinux/commit/0471d76499aae8f44cb21c7faa1609=
e0387abafb
> and sent with `git send-email`
>
>
>  libselinux/src/selinux_restorecon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 69a535032221..1a4cc7d12b76 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -20,7 +20,6 @@
>  #include <limits.h>
>  #include <stdint.h>
>  #include <sys/types.h>
> -#include <sys/stat.h>
>  #include <sys/xattr.h>
>  #include <sys/vfs.h>
>  #include <sys/statvfs.h>
> @@ -30,6 +29,10 @@
>  #include <syslog.h>
>  #include <assert.h>
>
> +// expose alias for stat64 and lstat64 on musl
> +#define _LARGEFILE64_SOURCE 1
> +#include <sys/stat.h>
> +
>  #include <selinux/selinux.h>
>  #include <selinux/context.h>
>  #include <selinux/label.h>
> --
> 2.54.0

Defining _LARGEFILE64_SOURCE must occur before any system headers are
included, including indirectly included ones, to guarantee consistent
symbol exposure.
In the patch, the macro is added after several system headers
(<limits.h>, <stdint.h>, <sys/types.h>, <sys/xattr.h>, etc.).
If any of these headers conditionally depend on large-file
feature-test macros, this may not produce the intended outcome and can
cause subtle ABI mismatches.

Recommendation:

Move _LARGEFILE64_SOURCE into the global feature macros block at the
top of the file, before any includes.
Alternatively, add it to compiler flags where appropriate
(CFLAGS+=3D-D_LARGEFILE64_SOURCE), which is what glibc=E2=80=99s docs recom=
mend
for feature-test macros.

Portability implications

_LARGEFILE64_SOURCE is musl-specific nowadays; glibc largely ignores
it because 64=E2=80=91bit off_t is the default on modern architectures.
If this file is built on systems like Android, BSD, or older glibc,
feature-test macros may have different effects.

Recommendation:

Before adopting this patch as-is, consider guarding it: #ifdef musl
#define _LARGEFILE64_SOURCE 1 #endif

This ensures the macro is only used where required.

Commit message / context

The commit message =E2=80=9Cfix: 477=E2=80=9D is minimal. For upstream SELi=
nux
projects, a more complete explanation of the musl build issue is
usually expected.
The email explanation provides context, but most of it should be in
the commit message body rather than outside it.
