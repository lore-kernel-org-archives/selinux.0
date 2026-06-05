Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935F2F7EE1
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674658; cv=pass; b=T09nREOAR+Pn7LCD4l0AP0LZPhC5AfTyMbpOtLVRS3Wbww4WeYVLOnNbM/8y7rFrMvZk8+CLn+ATJQnbDLivwfeXQ/KzNIZR/ebHwyNSsC/2peAAw7jCnAhv717ICTmEG3MVy7trP5fggp9qunwnhl5tuOKM2G8Si2UW2IbClcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674658; c=relaxed/simple;
	bh=L96ECPFDwPlzteISiCpwRbxwnF4kb43rA3kgA+s83g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSeCeqXGQTd9BW1hde0cWLrBs3MuUV2GwZLcKBCbf2tupkoc1sfD6ut5HIsbVo7iN6gmvLlPYd1XfTw4FEmnleYIrClo16KBfZnTMqoRWr1V7qZ263Ui+A3Vm9GbYto51WqWEsLDm6wn5o61kUCjjl/elb8kRamvdKfoRUa2Psk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWwaihqB; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWwaihqB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c3315c5dso21850755ad.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 08:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780674656; cv=none;
        d=google.com; s=arc-20240605;
        b=gT8HVij+4MbpeBn/rA3dzf8lVllzYns9TlXMXrbH055W/PM8G/iSlbrDGbzm70F5sG
         7HYIj2mQrb1tk9wzhAE7gTjULwEbVhogoxzW7H9ZVIiclJQkgbj+D6Zcpa04V7VL/M3s
         jXL9a5VMb2AgJlEo6P8EvowEhXJ8M9nWlmE+I7MaR2uQfTv86IXQYuaqUK5JB6T6SJsC
         fWbw4ztMnAYaiy8veTpdIN/NT6cF8i1bwfMz1rAAiEgWk7atkSrSvEp4Jd4yGISFepA5
         ID7pHxDEVvZ5jgz4eNIymzgLpJkyN4qZFN26yDsvt+gFWeUzx3xN17AX2Z1rjvoN45Xy
         hM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=km3xSuVJPM0NPiAIKjVrFhXfZsu/ZJz2CDQTE8FGi+g=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=OazGWdzoZNUzsOaoHHBnGb6hmL3iBUhnzyLUjqy9bjETGI7CE036NwOTo475s0Yabo
         xtOJmKUn6NXakApJcr1j3aPgSEcw1bEOA2GfnyBT1ZjQEOjRcRQ3w/3tkI+fuLUSequ6
         5B643SPNkl+M44MRAtO7jsy78fRjdkxkVwTB+KiOwpTgSDBVMzldjrO9xub2KGOPlmxO
         unw+hKtCKOO+5GsseCm3FRNDgiIBmxmZ+4QfCs0KaDgD29nsbXjbeCK2bJsHpAjxFqml
         I41AQy4kRzyvF7zdUZL8btFhYnQPZb/2ZC7R6hHyugT7yJsL9F81OBcYiRzzl4/S2gSg
         dlww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674656; x=1781279456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=km3xSuVJPM0NPiAIKjVrFhXfZsu/ZJz2CDQTE8FGi+g=;
        b=KWwaihqBNslVugcvM5pk6nJ52M4drKpqAt22ATeO66/R67j6RQiCPajegbLMqs4z9l
         a3O6J1Y9pLFdWgH1wdkC43LODtM4DcOM9QzaeaG58whuOLVgu4EU+LcMitMO4Yj6ouTN
         +T6sNr/WpK7YYxsbzdXECWx0kUwD8CbgKU6yn8deiUzrVj0ffAQXYSCu6md2cANu+PMF
         baSwIJyBToPeE5mLmmChh6FXrDyRBFcz04DwGJMzzjE8wTZvOIYT4xHMGuhk8Hs8AvCd
         Rrmm4sfL+yG21uFaGrABsX1xIidbtbdt1udl9+MGNESW5/kVyyV60HhIaYdKtBQdCGFb
         YZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674656; x=1781279456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=km3xSuVJPM0NPiAIKjVrFhXfZsu/ZJz2CDQTE8FGi+g=;
        b=QTP4MVq/duOAoayiJxw/JIpzCpwSADW2owLzoxFV87yE2xTKLf8BGFZZYLGkwjvaBO
         9mmXFjRnjH5h4nD+dWq2i5QeH5pt4Gc4+zSzFsN/F9tiaq3UuArPcwvM04PQrL//Z0fE
         Mpwbl+IIkuyD1Kl1+whJBex10ImVG8lQkxCNWqCulafGlTXxRhJpL+mk+Uqqy21HEDQz
         xfYbqs6XMW/516oEnv0u0VxDoRoYsZFrHzijz1bxpFR14oAlgI6xHn3MJVEA/WELLKGn
         5xb22EaQbD3xG1DPQYqA343SgHv8676D8plDVHY4n1EcSESGmuxxtxku9GPXAivpwiMw
         phjw==
X-Gm-Message-State: AOJu0YwwStzoMCtTmeH554g7kIMUgeGtHb4xPWYHlH92cfIaXNfxgQ4v
	c8GLxXPO697qI1efgZefkiC3s8T+YmYQwXkHRMIsjvEmMfpVLlUSEONCjNw/YSL4H+TcdkFVDMT
	3DlJS12zQWYVlLliFbmVm+wyJx+KOADYSTaVY
X-Gm-Gg: Acq92OHr4tWJQsFzBxjwYdaF6cos8p13g1IIb5JnKAzyfclEXF+PaJqilQEkDdYtplM
	P0TAyGHlyNmJXwmToRr5F9uF5P6FbAnJ8AE9B7qmL6f2Mhc2vY0ZisWxsjITuXStfI/4ZHggyUQ
	18E7Coq3ldk6nL+KisXqj9IlEuJ5dd89mLbIVL5uNj9Dpm/DF3Sb6KzkQQoVoW0zr/24xQ59G9T
	SWP+ScNGuyDfuiq0JAV4eKBBKHUhoyiyd4LN6Kg7ndqtwY7eR1Mn7WKKQsYlErPGECK5f8tSGt9
	Cf+6fIFWMn5Xol2wbQ==
X-Received: by 2002:a17:902:e5c9:b0:2c1:1aa7:b17e with SMTP id
 d9443c01a7336-2c1e85abd67mr44353495ad.30.1780674656471; Fri, 05 Jun 2026
 08:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605140203.76848-1-cgoettsche@seltendoof.de> <20260605140203.76848-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260605140203.76848-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 11:50:45 -0400
X-Gm-Features: AVHnY4LUXJK2naHvpxKMP0Aw5gvVUu58iNYyHPIx7zkiosEJWMjUEFSLeI_7dtE
Message-ID: <CAEjxPJ5xAEUPH9_ALk-byvuVg8DF6eYHiTxBnq5P9C7LktLvgg@mail.gmail.com>
Subject: Re: [PATCH 3/4] libselinux: avoid out-of-bounds read on empty
 failsafe_context line
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> get_failsafe_context() computed plen =3D strlen(ptr) from the first line
> of the failsafe context file and then dereferenced buf[plen - 1] to
> strip a trailing newline.  If that line started with a NUL byte, plen
> is 0 and buf[plen - 1] indexes buf[(size_t)-1], a wild read.
>
> The file is root-owned so this is a robustness issue rather than a
> privilege boundary, but the guard is trivial: only inspect the last
> byte when the line is non-empty.
>
> Assisted-by: Claude:claude-4.7-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/get_context_list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
> index dcdef5d8..bad93fa1 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -307,7 +307,7 @@ static int get_failsafe_context(const char *user, cha=
r **newcon)
>         if (!ptr)
>                 return -1;
>         plen =3D strlen(ptr);
> -       if (buf[plen - 1] =3D=3D '\n')
> +       if (plen && buf[plen - 1] =3D=3D '\n')
>                 buf[plen - 1] =3D 0;
>
>         nlen =3D strlen(user) + 1 + plen + 1;
> --
> 2.53.0
>
>
