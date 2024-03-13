Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361B5B20F
	for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370343; cv=none; b=EanfIakNlHso5ERsxEr/hEfOa9LfBE4gMa3vxUQgHELLc5BV2+goOZBnsWNnyIwgReb6KjeRfnMJuWJi01ctf9SzU0yyuyI74YHB7YX4hLx4PZ+Yckb3SSzbM+MAs0xPuA7iX6x/zCeajySbKWHkouaiMSBhL9t6Q+fxFXE1hPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370343; c=relaxed/simple;
	bh=gwccbfhnAcKiCf/TWrB5dzkQRnNWT0W42H/DreCzlm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVat516WTQXJb3kQgs7G9wE26gOS3zOG7jFszzktAcA3vwuudqvR3FurAPC01tPxi1VvzDinRypmsEBzz28twb0N621dxDMToaDc/bpDqW6IW7to6th7skOdKeio9RmL0hQKgalwy0zdLelUdLE4LtHIFc+He/7iRbA7x2gz7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBNTWtUP; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBNTWtUP"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so239074241.3
        for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710370340; x=1710975140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo4zQLcjGs/1cQrGh2gi+kezjnDbLcnxbVoJeKyq3b4=;
        b=TBNTWtUPrts4CDrRUxFhL2VJrkpCqe62t1cqF+lVsubWUhf4NQTqCOUQm8dQZUoVgu
         HFoI2kqlRApsigYuM5MsErJqk0f7IBlGL1JZFkOS6G2BgeO9AFWy1ogdEdv+5Z/cc5vl
         AabzKb7wzRXeIXZeVAczZNrQnr3Vh2HSOtHAsSHqx13eNitNstVPTk6BqpS+cERLfs+8
         xHLlXM9B+8j3MlYVD2iRlo3fxifOGWj7Qy+jrHZSiP7nOtOCDyuK4aJJb5HWrFRbtPKq
         jfGdV5DCReYZYC1qhQ3H5UdsBgUxHxK1aXqDEYbjJjtk9K6F3bCaqc8weSM8g5Nbz7lJ
         w/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710370340; x=1710975140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mo4zQLcjGs/1cQrGh2gi+kezjnDbLcnxbVoJeKyq3b4=;
        b=CnHXR+SzziDXPUMUpgK7FrMgZZI5QuzpBrH9kzjyITj0FNDEEBPPBfiSjqzkEa1sAz
         YbzDkuqhd/CskJaQZMZYjKI76wbhH+v+vd5FLXysd8GY9WZB2yEAQ6pQ4WVPU2DK2dJN
         8xnWlLwLoH+3nViujTsnoB8zfbxnedF7wOHMy+TuhdOGxw5U8WsddJMdJ1xCwNMmpW0D
         aSRfefPOqHBCDPqHh6CSsx7cBFI0rNo20VSE4iMTMYdWaxq7351L6yNt/1FFVItvy5qu
         0oMydKxHuTsyP8E1WFS5BkqGcZEVeenEzfMEG3CnjKF6I8x44KKTfppdY+DlAi6cIFtk
         y9tg==
X-Gm-Message-State: AOJu0Yw/B9y8XSeA1TiE7fNdvLagx2kksrzxgp/JOnpLvdiu/y9StL+L
	NOdZytAoyOalHcoWa02xWgGeVcavtbjaxCzzzUOoabOlfFuzCrw3zPGKz/tRWDUDbILepS4lDpL
	YeWm9zfYMI7XWpypvUG5KGqDQuPk=
X-Google-Smtp-Source: AGHT+IHoz/3D9TKyhaE7em/hPeIZyKc1CCt4AXgaqj9ObpdkudY1NfSbLX7s57PeHYdGZt89UJc6aTjpNHQwGCzLAPU=
X-Received: by 2002:a05:6102:19cb:b0:473:ac7f:8663 with SMTP id
 jn11-20020a05610219cb00b00473ac7f8663mr381440vsb.1.1710370340449; Wed, 13 Mar
 2024 15:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5120a64-04f3-444d-aaf8-3cfc6c1d9953@jwillikers.com>
In-Reply-To: <d5120a64-04f3-444d-aaf8-3cfc6c1d9953@jwillikers.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 Mar 2024 18:52:09 -0400
Message-ID: <CAP+JOzQ1iE7QZZAKoLy-BN9n=Hm-MfejdxtKzu1O+EtgH-mU8A@mail.gmail.com>
Subject: Re: [PATCH] libselinux/src/Makefile: fix reallocarray strlcpy detection
To: Jordan Williams <jordan@jwillikers.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:03=E2=80=AFPM Jordan Williams <jordan@jwillikers.=
com> wrote:
>
> Pass CFLAGS and LDFLAGS when checking for realocarray and strlcpy.
> This brings things inline with the fixes for libsepol/src/Makefile.
> This better supports cross-compiling scenarios.
> There, flags like -sysroot need to included when running these checks.
>
> Signed-off-by: Jordan Williams <jordan@jwillikers.com>
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index d3b981fc..3a9b5300 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -104,13 +104,13 @@ override CFLAGS +=3D -I../include -D_GNU_SOURCE
> $(DISABLE_FLAGS) $(PCRE_CFLAGS)
>
>   # check for strlcpy(3) availability
>   H :=3D \#
> -ifeq (yes,$(shell printf '${H}include <string.h>\nint
> main(void){char*d,*s;strlcpy(d, s, 0);return 0;}' | $(CC) -x c -o
> /dev/null - >/dev/null 2>&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}include <string.h>\nint
> main(void){char*d,*s;strlcpy(d, s, 0);return 0;}' | $(CC) $(CFLAGS)
> $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
>   override CFLAGS +=3D -DHAVE_STRLCPY
>   endif
>
>   # check for reallocarray(3) availability
>   H :=3D \#
> -ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint
> main(void){reallocarray(NULL, 0, 0);return 0;}' | $(CC) -x c -o
> /dev/null - >/dev/null 2>&1 && echo yes))
> +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint
> main(void){reallocarray(NULL, 0, 0);return 0;}' | $(CC) $(CFLAGS)
> $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
>   override CFLAGS +=3D -DHAVE_REALLOCARRAY
>   endif
>

The default CFLAGS causes the compilation to fail even if strlcpy() or
reallocarray() exist.
See if the patch I sent to the list works for you.
Thanks,
Jim


> --
> 2.44.0
>
>
