Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA02277C9D
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498230; cv=pass; b=GQWUxTTUbPWknA1gFWKiYFM5TZkEKxrH1HnY86b6Mzfa4/FdQGhjDj8y7ZTK48mYKBKbrTIKwIK/V+gKiNJVkDkiLmI3kLd2SoZYY9YAShQdfdbQOpUCPdySDPSNM/yjwmZGERqZ9rSGj3GDU2IOpWrymonYSaBPZn1PKyXiioQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498230; c=relaxed/simple;
	bh=Lws4CDGTu6nqMNiQIuyXjQ1EEXJp1bcj3PDFAIkdRpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXumCGnHS32fcoUUVrsLLNbHin+3vDQwaPbIUbi8hD3gPmZnWa6QZvbhnmGk4feWY8q1fr8Oq9j+0Gy2Rmf5cl/ICKu+qqcpjeJOUmFCWuhrgUL6npgVrwbzh/zVUxAPMHqUoJszPHNXFo6w9/VCtdqq1ZGoPdWaBBF2WPYgD0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N2IjEPFZ; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N2IjEPFZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3614826eca4so178793a91.1
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 14:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777498228; cv=none;
        d=google.com; s=arc-20240605;
        b=a0x0rqIZ2CS+10GWuqIWcZzp6VJBMc4xMMW0pd+RgHrRfM+CFHu8JkvujjoeMgChLw
         1KiaP5UL5VsIDsvR0gUjPsmzx26+Wv6xnPfz74Fo6UlZGl5jlB/6Wx11dWBuUeg5e5Gm
         HCbzWWboBPF0Wy1F8DWkNywABj++60B9lsPDuOATeVrXApLV/pWEYQle/APeKi6nsPJW
         bYrzapFFRkth9vWIwxVHGAL/oGBMuu5CEPjdIFOscIznF28PZM2CxQN25zGGL4KlMS8/
         WZ4UezBZOk3UE4jtf3I1M9it+biKY7kLZPwiK3ylZpruu0zqkjT9ni6pswuXWWIW9zFu
         lVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qRTNQuUyjyeZ6dbq3SmAK2mE3mPknwDxnABQRi26dIg=;
        fh=lOev/QwE9DXSi83P/KluQ9UjJBSvfLYOVkCl5H1rM0Y=;
        b=EixzqumJp9oyeiOXtVqmjcK53KLG3yoSCAxKR95YhgIB2dB6ED5SIfioI9giwxUEWM
         aYkcyje6NAIA7BM5QQg4r3jDuQfu2FCKwOtTYVTZUabCe0JXUjJP8rnQVU14d0zi5h6g
         MVV0GySKxzXHWbmR3QzAKurMQN3pKIgZoYV0c63i18Ngz42RlSqTd2ahgNK5IDJntTXa
         /l1LpHGhrCdmx1szE4txhl3oaseqkZ5ZXNud2iU6rNUlGHjltSvH73323nXPGabVZIzi
         3XtjLO/U4hqwFpS/vBW3cYZnKEUGg4PKKeuOVsgNzbtgAsFOY3gWWBH4fu9TxLegv2dk
         jgjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777498228; x=1778103028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRTNQuUyjyeZ6dbq3SmAK2mE3mPknwDxnABQRi26dIg=;
        b=N2IjEPFZrltCiJaesBR3DfBwCJczH9xrYIylFa8GSvOHuexoR5dSj4xfkYzUCBrNRF
         Md8H/MgOn1A+dpz76uDJzDIcVRBGzTJcvNtj4gceljP6obvC5LVTPTAQWFUwaWfr4MC2
         4lGLUPALq9eeO3Dfh6qvju9PtFvaNMB+5k6Tju6BubC2Rd2fNSkfnGH7KAMEqc3zBQqW
         Uo6FK1kOXrmFM27f2bZqnVmgHmnYAXIghzgVJERx5VqW62lHm02KMCgtZxK0fNMfbuVy
         L0k47TYMq6Y8bDRRk5go2/NmmY5IaMjlgpWAlsmrLTd5aCI988OjTSdPGkff7riWjYGV
         dFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777498228; x=1778103028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qRTNQuUyjyeZ6dbq3SmAK2mE3mPknwDxnABQRi26dIg=;
        b=AsI7owifNougz72ZF1zg836906cpRuHabI0nHUONfk6fkzo8+yADSOgs64SxfXp7/9
         rJE9iiPaEq0Fl6jCnz+8S3q/ILSf87ARFnF7SjPRmGMYVdYEO1piq1Xzsmlc8Z02NSP+
         KlIp4o7QQUEoXS9IhTgWlq58ftOc609NG645O/E2XJSOq7WxVu6m4Hknnlrarx5b88CL
         2AuAcNrm8mzRWEYLmO1ux+ZXQZHjcMOgKj/geO/pWz3oaPa1PxISjJCJxeyipFo930dB
         8nsa5O65eduTd+3yT8LDRDUprlg4lQhxouFrW6YrIDAozr0hnKAzBvcy5iIOi5Y0PFHm
         /qHg==
X-Gm-Message-State: AOJu0YxfOCu8o1twZRkLppkVYNpMY/cmPSzi7sRZEq1qgxa07lXM+Wu+
	Nw2IQqhny/Ammso6xbh1t3WvnbjG5smPt/G5Xnp28ESabxDWvMYS48SH0WYCTHRcQ3EQ6+5nlc2
	/v6knrtfOF5EjOAI7F0yc8sef6ddMSN+HiIkW0FyrbhUnvkDiaA0=
X-Gm-Gg: AeBDietm2bzsFWVHdaCQiwX1awBONzzx6opx49M5UxFfX2vGllAyGhSvSSNe8DpKv0p
	gD6K3oHtvkMmEY/Kmz36XxywYi4GzpIES55OUF6g1abkZXEKo8N033KWGKu+MRkpXa4IkhF+ZR3
	IfazHnNx9VaQNbmfJtZTuUOKiihg7LgHk4LmNaXdi675RwYGAoRw5rUqjDVeywUeWxMik4LTL5f
	p5zjUR/Mnj+5FTD57S3QzkLjeVwD9GwTS5SVQ4OWuG31tVIw9mr5ffNjuWFTZmMBMfLR04Xotz8
	P2ypbiIozzBQVYn4YQ==
X-Received: by 2002:a17:90a:fc4f:b0:362:ef2e:5ff6 with SMTP id
 98e67ed59e1d1-364c3462ab4mr7844a91.27.1777498228499; Wed, 29 Apr 2026
 14:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429211229.3750-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260429211229.3750-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Apr 2026 17:30:16 -0400
X-Gm-Features: AVHnY4IQ9zqh0CkebWCT0w1Y_ASft3S3CPnh_QMF12ObRvmeHv3IeinmOX3sfhY
Message-ID: <CAHC9VhRZ6Y5BvzUd_D+oeqRnaYk1NdfK-FpXELK00VkpHZBzGA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] selinux: prune deprecated interfaces
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 5:12=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> *** BLURB HERE ***

*** REPLY HERE ***

> Stephen Smalley (3):
>   selinux: prune /sys/fs/selinux/checkreqprot
>   selinux: prune /sys/fs/selinux/disable
>   selinux: prune /sys/fs/selinux/user
>
>  .../{obsolete =3D> removed}/sysfs-selinux-user  |   0
>  security/selinux/include/security.h           |   2 -
>  security/selinux/selinuxfs.c                  | 145 ++----------------
>  security/selinux/ss/services.c                | 125 ---------------
>  4 files changed, 13 insertions(+), 259 deletions(-)
>  rename Documentation/ABI/{obsolete =3D> removed}/sysfs-selinux-user (100=
%)
>
> --
> 2.54.0

--=20
paul-moore.com
