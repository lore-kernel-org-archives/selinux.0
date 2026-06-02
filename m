Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220321B191
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407585; cv=pass; b=kbljPDYy2YfhGWDy6/NCcZLoqhfNRw81fqE9eADYJ3UYogvB/XgzT0cruWpGREIZeFnZIp70C7NcifRBIQhHs+Ulq3OK0W17S+yr8u50Z66Ca6ifjg/5JDRyNQwMV/AWxmufr/dRAswij77QDUstubxikI0DY2iWl45CO5+FL7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407585; c=relaxed/simple;
	bh=TYOLBuqoir6i3Fbn/c15efwGbRZADjvbkjiCkSAyFLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHWKfMwMTTh02/zKqzBgZLMOj1F/Qthdt71Tl11zxBQus7a29TrGJNTQJSbbkyqZ1st4eQMNw321tQQ+q/GaVHyNU586OSQq68JD9lLM6Qd6d98KKwJASrjq6+zWDJXvYk92Owu4+rRbrcs4hh3qn10YdQqnEVnuv/t61EuCqS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDet1KYg; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDet1KYg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf3781ca51so32545755ad.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 06:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780407583; cv=none;
        d=google.com; s=arc-20240605;
        b=cutVC6b9dwLrec3DtIT78NRFWT0fCkQLqtY89Y66NxKfTJeJwAYECtrUsZwO/g7VPW
         3p9kU4lpNDUDiExQORopLlMilNly8Dgve7fmGyoHCwc53yg41I4M4VMiT3pU5TWjNyFn
         HkikU1Nk0KPnAIVeQw8wTpC90jWt9gSkbtrO2j9uo+bMaSfo9PuI1KUDk7MTwiC+grFH
         /ia5wq2UvEGwfXdmdfSqQbykMuoUfiNibzoD27JsA18KO/PXuXcZRFrOx786khyxp3p7
         3vh3kPtE7qwrI2VyxpEErzWUL8+Q+YQqh5b94wK83ppIkbSm4MjM5vQ2n4QqlT9Mf+di
         WPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZYbPHY8L1pw9K3Xqf1JMKq3N/mhloiR9X19Hty12TQE=;
        fh=+SOaqlllj/x9oPTKUNrw3U6f73KzX4NDehXGGqjpy64=;
        b=IwqDmPpjJzXdM83+PAGVnjYDxygTu1BH9xRiEJsEUjY8wlySz/0nzqAJsJilSBXrcN
         8id1p/wI744jtUJJ2XGGsRUT4HTO5uLdk1ATO7XahSFHJZrIuV45MigJJgqgTBLFnyFx
         CiRL0tDVUPuKKnz1B4jCBmzhmRjziMcJ2OkmrlGXBgav+85Y9Di4i4XOehzs+5n7I4kF
         TkzNJWhtUIb3+6GVH1xb9tKEnGZ7/+7rEJq7Bfca2s/dK0iIyAAt3ra2rfs0J0BfOfv8
         N+ayPg1UBmi8AVlA7vB75Vd9tV1fHo9HK5KSpCBBMgKFceHSTlI97g3nTPOY4Od4vKiZ
         SqNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407583; x=1781012383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYbPHY8L1pw9K3Xqf1JMKq3N/mhloiR9X19Hty12TQE=;
        b=RDet1KYgNioSBJ+hh+UfOwEEe6jo3bO9Qx/AfTX/9ipkbW8CDhN2GnjgnZRg+OJVvE
         /6R57r4R6Jm01GCZQG6io6Yd9sXA21r+/3zFeH+8397VHL9vOB+QqRQY62ZObyrJRhn8
         K30tmZJOHk2ZhVgUdDmWgaTC6tPNytfDzR3jkXMMXVq7d8NamTKFcvYUhbwwnwhdwb7x
         ezzF2xNSlk+ykaK9GzxhKk9tRg2GQ+fcZjDcyfTGZ80SIGxg6sxiv6jaJop6b9bygGkg
         n5jIzoZA3lbWDR8wBn82XVPFwxgzXJGpmXC19pyluKHEE7pt2PcCUtBOYzvnONcL8h4y
         x8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407583; x=1781012383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZYbPHY8L1pw9K3Xqf1JMKq3N/mhloiR9X19Hty12TQE=;
        b=OxAz1AvgTv7FIm7ihd4jBmDOGidVsAY7S1UziAgyqphVVNLlU8W724/Bo5qBBKRajF
         O03sTP2B1H2S3VPJ6eA969MaPOvAyzfVUDUudn+7OjQr4j7HGhQWkEBWwW8NSZeCGRxF
         ZjY9dLxUBMYH2tKPwlUcqZEwCNTLXx+0Bc7wk8QO7CMt+oDcqOCHxpvZvH86PFw4+hNb
         PEk4NApdyzcZCpJnRH4Vv1A1F0CS3kvgpRK+KqG04hnGHvFwf/65Fytg4rUUXFfxUpL4
         RDwcb1K76ImAQftmHzrMvQoivRY1ylOEMOQnZn0r7w0pe7bLbu5aTiLxRWJEaki5SDzG
         /Fqw==
X-Gm-Message-State: AOJu0YyFctPX7Y65UNRO8Y6VmEl3mZCI8AL2CDjDHfiV4tNTGoZN0njY
	nHXfFvohMcCvDPgRl0KV2tdBs7hcdCXLdDubS9IxJyVQlrjiWbeNCILyeIeO3g5tUlzokNlqBTN
	LV/6tDMxrwpLKM5qr0eCP2G5YtEsGK3M=
X-Gm-Gg: Acq92OGqCUKj66wyWgdw3AFx8yRHmzQ/PPpTCQoW5t/wqZFUscaPCrGzBMa41cmiVHX
	MkhG9/UKx+CM246IwO0CuHSYPEYoOcpudQP0BIDtjO9Tvp6xHPAGreGSFnwJG4WAUstvu1pwa2U
	MhZ39eMkQUsnWEsgKnt70fMCJZyzWAdUoKgoIvlfddAq4aTvCcQUTqff73ZsaOW7bubiLaSKlAW
	1XsJjafBZLXe65zqi6lLgCtagP3ElwqyFeLUxysB2HvKY6DMwc/MTQJLAWioKnIb8JitGBivU2q
	lpYmyVtbISXqIsoUPlv2ozWOy7FS
X-Received: by 2002:a17:902:c406:b0:2c0:db23:4a7 with SMTP id
 d9443c01a7336-2c0db2307b0mr98726145ad.6.1780407582860; Tue, 02 Jun 2026
 06:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602095844.115761-3-cahu@suse.de>
In-Reply-To: <20260602095844.115761-3-cahu@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 09:39:30 -0400
X-Gm-Features: AVHnY4KFAZWLZHjnShHHTaMN1if0OJov3fJTmvCvwb6zJZ-DtbX4YTFBh6rHTKY
Message-ID: <CAEjxPJ79SKgcRt5rqpkP0_KYvVoWKyNiJ2V7rUDEnvV6S=GDaA@mail.gmail.com>
Subject: Re: [PATCH v4] libsemanage: Require LIBSO before SWIGSO and
 SWIGRUBYSO (bsc#1266385)
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, lautrbach@redhat.com, fvogt@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 6:00=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> We encountered race conditions where the built order was:
> 1. libsemanage.a
> 2. python-3.13_semanage.so
> 3. libsemanage.so.*
>
> That happened when make was called with `-j2`.
>
> In this case, python-3.13_semanage.so tries to use libsemanage.a and
> - on s390x: succeeds and builds an incorrect python-3.13_semanage.so
>   (that one was found during product testing)
> - on x86: fails (manually reproduced, never encountered IRL)
>   Reproducer:
>   ```
>   cd selinux/libsemanage/src
>   make clean
>   make pywrap
>   find . -wholename "*libsemanage.so*" -delete
>   find . -wholename "*python*.so" -delete
>   make python-3.13_semanage.so
>   -> fails
>   ```
>
> Therefor hard-require "all" when DISABLE_SHARED=3Dn
> so that LIBSO is present before SWIGSO and
> probably also SWIGRUBYSO.
>
> For SWIGRUBYSO switch to using the first requisite only
> ($< instead of $^), as it should not include "all" and
> $(SWIGRUBYLOBJ) evaluates to one item only.
>
> Signed-off-by: Cathy Hu <cahu@suse.de>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsemanage/src/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index f870dc68..9199bd39 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -82,11 +82,11 @@ $(SWIGLOBJ): $(SWIGCOUT)
>  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHA=
RED -c -o $@ $<
>
> -$(SWIGSO): $(SWIGLOBJ)
> +$(SWIGSO): $(SWIGLOBJ) all
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $<=
 -lsemanage $(PYLIBS)
>
> -$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> -       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $^=
 -lsemanage $(RUBYLIBS)
> +$(SWIGRUBYSO): $(SWIGRUBYLOBJ) all
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $<=
 -lsemanage $(RUBYLIBS)
>
>  $(LIBA): $(OBJS)
>         $(AR) rcs $@ $^
> --
> 2.54.0
>
