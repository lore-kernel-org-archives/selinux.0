Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296E3BF2EA
	for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502400; cv=none; b=aeVr7Vqt0QVi+7u6ktLMC1rK9Oao4dCZiPokBqPRv9Dqs/c6Ijg/sDKUx4lA3PCv6VKBljJ8NKLiSOmMymtutyigqniDHWUbc1B0MacB4zoNWRFOxZu2FKQRXXLsB1IhgyOIb70tL/ydtZIPrX/bbu8inAn6VQlijXTSQTnIhBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502400; c=relaxed/simple;
	bh=KyFsoF1oOJItKNApSnYKJl2XEtIEKxloROitWjCp2EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/CsKRFDHxzdqSAX4tQB0gj5iQClopd2tK4QmqgGHrFoeh3JuAFQryenBljOe7MFpBvSzG8jSUHWuPt9c+eKWfTlfCL4Swb0pu9LJgQnYh0peINcBBkpdXQ6ZHRsc6+67VFfAvuNo6u6wa2B+M2+lege0tEMwg1/evAeo4a85DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d9/XG8WT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d9/XG8WT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c565b888dso1007762a91.0
        for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 10:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768502398; x=1769107198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvRnvlMP2UK6/12EmJ+FAU4NVVheG/gJGv3vtUMNxY8=;
        b=d9/XG8WTRF/dYi4cU9l11urcZ/GXUgK0hCAMvGYV7JBD5Om80fvzEh+yhri952M5cm
         EqbG40uNkTkqDi9EgVvaQUjZVemCPPkrTALU09JT7t4WqqcVaF7fztXXLvGs9ARcnxoF
         7U9mtCDTB5MiQHRUMyWGI7emuz5d9qB18A6ak9j7kpymp+po0y2hxVwANXCvU8DCdr0B
         9rlCaPahGU4HCoK+8U4kgIYeMsM8HTEweo1H0JBmhmZ26XnLVoBpP1gwMM128Zvsrnbg
         6soeQ0TdcBXHj1ZvJiu3ZIenmAfmAqO5T1cvt1Yb3daxm1ruSnbz0Wfnw5cPvZaO9Ebr
         6mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502398; x=1769107198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nvRnvlMP2UK6/12EmJ+FAU4NVVheG/gJGv3vtUMNxY8=;
        b=wobtVcbR/UUGHk9fcYOxCxK0A5m1yxal8AkqkboUGNCDYS/1v11RBwOGzGZ/gM69Z8
         jNgTfN59G9We5tYcXM2BDIkavpBAIyrDMpN7mrybNqsbmxvjfC1rzrSERWPUmlnCjTnS
         ZGpqwTHRIWsAGzgJirzlOOXopKKUbP2z8BBHl0VcPGnm1hFS6z3JFmL0TIIrd6S7dxkd
         UY5vPYUhhjEV2KAnMY2hFXDIdSsGeD6A75ya4p0n7KaqDPLt1WtBYUhgz1gr5IXyqM1K
         xm0Vi7mH0jk8Jyuj8Ac1Pc3yAXCel0SoEJ2XUd1xFxv3HYG74qq7wKH2AwxRbjD9nqvt
         KB/w==
X-Gm-Message-State: AOJu0Yyne44xlYTE9Rq+IKWI7rrGaB13haDHyjL+lMqQQkjCrhzhX9Rb
	p57et/5AC87j3Lp+cQt2dQSW3/kOB6lJPl0xINKkYcnPrE748iLMGRlfGmM9HVY07y49DDRCobl
	nKGjqo2KecUS7TQYG+AS9oeexdiVxCheQjI0eHKkQ2aTFtZ2/+AM=
X-Gm-Gg: AY/fxX7+9XK1sjsG3fhqvvU9npBOc35bSm1GaxBwMFX0iPdGZIJnTDp1LFc9FpbqSRn
	uepZYuxAXDDNv8fKR6TUJjuGuw2ZKVQgBcmClX0XNxETAwiBkleSsGtD7Ky9JKty7KBjDGxJeEi
	HXmNQ/dh2bN6Omw3jJzks5d5Ayjhsd61csb/o/c9PLDliY9YrPTIJw6vHej5LX0wj19hW3bzGow
	XiGBeX0Ndo+drQ52C+rELUuI/E4AJgfnxmsO+3UNnrkvo1cvNeIUyVhDSH41AdUJoMT4LM=
X-Received: by 2002:a17:90b:3508:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-35272edb087mr292860a91.8.1768502397927; Thu, 15 Jan 2026
 10:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114212308.291762-2-paul@paul-moore.com>
In-Reply-To: <20260114212308.291762-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Jan 2026 13:39:45 -0500
X-Gm-Features: AZwV_Qi253RnNu6geeBLVKvKzdukufqd6Xpv88wIvJKBPj1-eoP-kI0jN-WkQBM
Message-ID: <CAHC9VhRBbkNpF+Nvenng40gBDtcCRzpzk72ShSnG4=ktADkMgA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a capabilities parsing typo in selinux_bpf_token_capable()
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 4:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> There was a typo, likely a cut-n-paste bug, where we were checking for
> SECCLASS_CAPABILITY instead of SECCLASS_CAPABILITY2.
>
> Fixes: 5473a722f782 ("selinux: add support for BPF token access control")
> Reported-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/dev.

--=20
paul-moore.com
