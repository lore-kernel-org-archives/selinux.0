Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E354F95
	for <selinux@vger.kernel.org>; Fri, 22 Nov 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732310429; cv=none; b=J1/Nc/65iZUsKzzVDLAj8TfGDo4X3RDB8Ic41/CxbwTw2EmcN1msA3luJYykLN/cHZ0jH1kbIfgj0ieMYOU+euUUuE8CLF5afv6kIz8JE3ZdXDzeoHd/XmFP2fNcJEBgtV0raXxFf9/m4AAAoAMVWrQUI8naMZ5Lu0WltBPyX8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732310429; c=relaxed/simple;
	bh=lMSfu1Vj8Tib5ENuloEnm+tN/U1jPrpVsPnXJVE5WDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCT1q+WdfY/ocmwjze91bCQhEGN22KC4fHMLFnOPqAj2hK1Ndp9U8f7CXhmLB4PjhTD1GY6V8dRnreBy2UG1zmFre2UkEv2/JeenBVe6l6ZttzpUTtAcFh3Y8m1En7yjlMZjtEMG5G4XiWK1uY1GTFPMFirPPzpPAAvbFeD1Dmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb02vSlX; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb02vSlX"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-296994dd3bfso1713060fac.0
        for <selinux@vger.kernel.org>; Fri, 22 Nov 2024 13:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732310427; x=1732915227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgvxxZEcvg1zQK7iLkwrupGxTcEjCWO3CE5ATHyy9S8=;
        b=Xb02vSlXpP8ftyYYdgEZSnVnpxVKLho30qGkmGNmlfT1A2YckWoq9J5lpwAkAyc/ck
         U26I+Be1RbjCBinyvzGAf8gLI/2c5XBa4qzKcGhG8FQwoof25KMkNCVw4HldSLDN+OnL
         zmlUlojknlp+h5hVfgexPqkBYKPIYzGMsTq9Gwsy1Z122JaSkWhakxmBGSthgbs2p62q
         Nyl+2+ritaFJiBzswCKIS4xLg9F+tcYcVQ86GOmYx8dPkdsh/LZn0/AY8hjtZAzmBh4s
         9/WqAue7UPfnJV5KDMUX/rEI7AFIR25albwQ0cvdgbRe4IP132nlnX+TgMkOldkh9xBc
         V4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732310427; x=1732915227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgvxxZEcvg1zQK7iLkwrupGxTcEjCWO3CE5ATHyy9S8=;
        b=t7Dao2um48kX/GIY1oOwlEY2DuilfyILACBMYrhM25n3f2jgBnzUeTwd1C0LibRtcJ
         5BYkvbQzIThY5cpdJODos7g01PPE1Pg7j785kxpMrgXUN01d13tj/3nqAm3hwmEDNBr7
         McT79rG7+6AytFLNrbob4zMhg2/xgxZ3LvfFYBBEnQDkpCWE2VKoWCNvEChqF4SLB6Fr
         X6A/MOetTqSbVB/Vn6O1ngrNepH97jaUbQiLxHFa59OB7EuyUV5zgDQezz5EPjqLdsLL
         6fhTCVBafVnHDiFJ7pm7/C1+r9eZ0s4D91csfBRqVDn3KxOmqsmQdztr/lfKWBp8gQ2E
         TqQA==
X-Gm-Message-State: AOJu0YwwTfBX45W9miOT6g6OJq12UDwNAx9mRxm95obe5Jl92NuP9FIV
	BbIGs9pB3G3JKPB/RPiP0C480GrDOM71He4L2hZ/qU/o5AF1rwnGXVDudoVsLrIuZLk41GDb1UP
	f0uMXxk0VNz+c1hXGmFaOlryvgEw=
X-Gm-Gg: ASbGncu2zWwYNnbhGLeMh+Czu04w1fgQwy8p9VwFHal/69XdVXzyC8gKaUiRubbAcAj
	zhYdjbVE08pGIDy5s69cipc5eVvx6ttU=
X-Google-Smtp-Source: AGHT+IFzHA8ZU0ClTw9PWtuGUuXrSUn5CSWIV1zAbZNkab9CV2JYvOAB38GvLorxR0H3t3BCUf8jgh0YcqsV8yDSmL0=
X-Received: by 2002:a05:6359:101b:b0:1c6:45:c682 with SMTP id
 e5c5f4694b2df-1ca797bb638mr498121555d.23.1732310427097; Fri, 22 Nov 2024
 13:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120131004.58662-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241120131004.58662-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 22 Nov 2024 16:20:16 -0500
Message-ID: <CAP+JOzQR2c0rCseuNNjxY8Eo3fKwa-7i01V1YXkHy1F81brrkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: harden availability check against user CFLAGS
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:10=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> If CFLAGS set by the user contains the warnings override
> `-Wno-error=3Dimplicit-function-declaration` the availability check does
> not work properly.  Explicitly enable and treat this warnings as failure
> by appending the appropriate flag.
>
> Also include CPPFLAGS in the check.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 7b0e8446..71fa3ed7 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -31,7 +31,7 @@ endif
>
>  # check for reallocarray(3) availability
>  H :=3D \#
> -ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return =
reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /d=
ev/null - >/dev/null 2>&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return =
reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS=
) -Werror=3Dimplicit-function-declaration -x c -o /dev/null - >/dev/null 2>=
&1 && echo yes))
>  override CFLAGS +=3D -DHAVE_REALLOCARRAY
>  endif
>
> --
> 2.45.2
>
>
