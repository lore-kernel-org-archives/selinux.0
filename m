Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE2395AC3
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681874; cv=pass; b=VAzn51VZf02HDMJoNgLVZbfb5Aex/CEZiwmee1Nj4/tPWDlQ7WqQkpwBbBCLQErebjGZIJNgfdiurbuwuTqgw4tbcxQCy+jo54g4qiwBCgXt8w0eMe9oWl9GsxOxfoUum9tbdRE9KYGXp3dLMe4YETylgzP7bWvarAzrij1YTUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681874; c=relaxed/simple;
	bh=oi4r+CTxNXFvmk6nyyzZhs0aIHZCDrKJs8f4idO7nDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXeYxkKNR6soiesE1kI7TMkWUgWOXb0TX4TOxhes0vSPjjCOBJUha55PetuCfFIP2fn/Sa8xLvV99LO0ZcVCo6uuf5ItEO+8j1aFaxCuCqRcbO8p9nvtwKjzTHx/aKaTSvyYjLZZiNyB5JKhn03unN+L93POV4NmrA4yJSiRKfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWVCRphO; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWVCRphO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf2247e38eso23079095ad.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 10:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780681868; cv=none;
        d=google.com; s=arc-20240605;
        b=igKyLvMvnc86kxPPKPeJUeZJLhMrLfoPOTvxTP9WJirGuboTkbpP4fnPZHTgTKIt92
         Fo0e17dFzd/Dfldb5OFKJjr4c5oEmra6/9OrVW2Bncs6YgBKeGlZTpb4uS586MmVoW7E
         JKHTyEAAU0K/Ey9Uqiok7/m9mRoT/QLASEr45XQiJQ1+ccGl1TdeuTCNq+cwJERKpFlC
         X16JyZngTZ684OkOKPkM3XrcLaIcb4UuyDbJmHr0CEfMH0bbhrY1xjzeSrn2MTOoui2U
         01c/2fBGhyoatZQhyH47ADK7U9x5WoMqhfrnX5NIw4W1AfyLt5mxSBrw4wFZRFaQO1xB
         wEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WiWvq4R0ZHW+00FmQSgwE20K+5Uxw4p37+BBEHdaVQo=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=GUVkZXnWN52S7hsaWYChsuoehnTs/4hvSK5bTNIv6zkRdbysRiCIxKu5aMEjrXEPQ6
         NZVFCULugnOA8SlEP/jq7wRsaPtfK9WRYh7JXWOqbPDSaGtWThQdOQZjvB8eGAqh+/du
         EV90GqG03QW8v5pFzgS6dHNupULTWnSuvFdLVrBYBttI/5ZsbfaLJ5Y4W8HBi7a9Bv7U
         x32jGqRiWAd1epbrBjLFsk+aCyuScyn2KILtRELpimqMuSVUXoSGKFrzt4qILjQ8M7ee
         9pt0dpWHudk/xIVetsIOQ7DlQzvx++k/RHj8FYVC0iP+DN/hXc7pjR9xS9gQ6G4hMUY8
         pmDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681868; x=1781286668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiWvq4R0ZHW+00FmQSgwE20K+5Uxw4p37+BBEHdaVQo=;
        b=EWVCRphOp3AjUp0MQ5IAVCa/a3i9tP1uILOCOnDnctJCp5HFE2N3bkwreG1LsM2ff2
         cJQjUX+ej4XWOjSAKvEofB11zZRTWqlx9SesyuCOV+4b2HKR609bESDod+CE6Y6fR0F8
         8yPCjP8SLCdQHcbHES97WLGfZFQF1Q1Auk2mtBQjHtr917nUU52bNOpG9i31cK/tFmub
         LivE7rhuW9xGHayN4/SNElEkLJe9EaVKBtirBMG91Dhamvw7BVq6SX+RtckZRut3OvcQ
         34xpH5j6EbBg3sK+3MxBONULjubNby+49tpSwVaE4Dn8Wwt/i9cvZe/cDOLdh9XnEnG7
         wFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681868; x=1781286668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WiWvq4R0ZHW+00FmQSgwE20K+5Uxw4p37+BBEHdaVQo=;
        b=M5jQJuEzWrSVzXHrJz6ZqML1GF62YwZdlntR/xSa6kbjksgfJw9QfL+OtjwldcdtBf
         W0SoZ4+/AT0kTpyaoH7Cf40ZDePDtzSNX1AeKZOMrmGjIiKxcw0MecDfLc1oeyFPOP8K
         cE4F4P34UQJ9KS+pchhHJ6zeLslUWF1YPvJJPfyO9iulPB778vPWs7oyw4zitx6WDvAq
         JB4tpaKWnZE6ObsA4N5udtC4xyvO9W/XtrMT555wmU8cQeof9x4uS8e92RiEKfiviU3n
         GD7R3OV6JBRvFgQBnBGnW2wQQsjdTJV+4KcLoC3dkhvpdJr59APKrdgHCKPjngtUSnUd
         Jz2A==
X-Gm-Message-State: AOJu0Yzea0qWlzmj5YaskdWU8e3BuoL1mfWShN0dx84C3NpuCwtedmZ1
	HI18oz3bHzrw987BcdrkX0Q1eKUnSTSyCTa2KooLIjCW6XxP60l3IuseNfKKPWkIGNLVIvky/Sp
	PV9ES67VzOggfPvLdJ0J4ryiFBTMpixM=
X-Gm-Gg: Acq92OEFTadiwonhAg4YxQCFXUzLiJB0sZR+y1mr6q2I3oLkxmPcoF8djT/mvJuf5zK
	enQ3TaGav/ByDYd/nooYVRJ+1GO1Dr+zpX0OQKV9YpP2yGUY0Ivai7tKVuubmLW0e2y6DlBU05D
	IxsI+lw6dAoHIkp5epD3kcCwIvWessP4jHrE+z8feKIxjdo0t0v+KV9oQfFcNgA3PLWTjNrGbLp
	WmEggT6NizfjEC2ahylU/vBWeFgMB5r3wkuI7TKPTz/IWzGNP7C5cQ/qsxreZVgSmt+78Gu8NYN
	LiaWmFWjLC8ANqMStQ==
X-Received: by 2002:a17:903:1205:b0:2c0:b6c7:2271 with SMTP id
 d9443c01a7336-2c1e80e3bc0mr52052155ad.4.1780681867767; Fri, 05 Jun 2026
 10:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605172207.222382-1-cgoettsche@seltendoof.de> <20260605172207.222382-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 13:50:56 -0400
X-Gm-Features: AVHnY4JBqcnHlSkYI3SoQBpOrdISXm2PpyOMLbXt-wvR8UPHBUPespxwbQUcBZs
Message-ID: <CAEjxPJ4hYW1H=ALc82NKibKXY07d2Y+a==tKEEgYc=gi-TVmNg@mail.gmail.com>
Subject: Re: [PATCH 03/11] sandbox: drop unused macro
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:29=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
>     seunshare.c:55:9: error: macro is not used [-Werror,-Wunused-macros]
>     #define BUF_SIZE 1024
>             ^
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  sandbox/seunshare.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index f9da3644..0e046398 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -52,7 +52,6 @@
>         "policycoreutils" /* the name of this package lang translation */
>  #endif
>
> -#define BUF_SIZE 1024
>  #define DEFAULT_PATH "/usr/bin:/bin"
>  #define USAGE_STRING \
>         _("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homed=
ir ] \
> --
> 2.53.0
>
>
