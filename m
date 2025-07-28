Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A61A23AC
	for <selinux@vger.kernel.org>; Mon, 28 Jul 2025 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753739379; cv=none; b=U2YSPYrhpSkSNujj+UpsgQ1u1HVoMHPjvjBqh7JJ3tNoYKtrAI+hcU4r3jki+jBD+7c5pMen3bg+IVHwOhTIJCqDWSuxja2SDuxA+DEugZZRgiM6/wDcqp+ZrP4g4etOZuJ/Z7o8krRVJzJZgQooleFXfA5zOGQW8VcKIvRaMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753739379; c=relaxed/simple;
	bh=tTCJWGUp62X7xORqgRT8/m9obaHcnwzTRIbKZR7RuOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPdLzVzy0kt7NkAnPOYn9kmOzLJQfS/m71GMGSKSZz9PKEYz4SgKala/tLQbAtUQWTG3GBDJ9HJdFsJXnQN9oiaJav3QlbhG+znxc6jHe8Tzg/vvXTTbhfTYoHva/SACWVR8NeMpTmuMXSPkHwjC/HV6pHbvxebZ8YVBitR2Sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nh+KwAhg; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nh+KwAhg"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8dfa47af2aso1900550276.3
        for <selinux@vger.kernel.org>; Mon, 28 Jul 2025 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753739376; x=1754344176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poaEelBg7a7OcoaRwgyEnvu3ww/B0f0meFimZvf+Ksc=;
        b=Nh+KwAhg220CV5ri5tPFw7EWzAPu7j3V3OA15Ypm2cfmtWCJMJZwB4uQP5llEDBiUj
         0WMw5a1JT6p1AKSg0PPTclQVO8PXh/xLaBHvROZ+R8XWT5IDqAMozM23xfekNFXtrv7Y
         yMwNWnGjUlXJI7RK/ZrbojjGkDLpnwj/Wems67wS9YR2OQERVE9VHF5x/vBvrsw1uP22
         jjuBdb3nJLh511EJvJHtLnUH4TAM+HfZv+5C74Z3DMtrDdVR7se/NalkW0GD6u1Vx4M3
         2Q64lV9GbNNNuui/PlCznV3zYeXxzIks9ASQGBVG/0r3JtxkTCIoWz+xRnt6bdDuR7fL
         IG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753739376; x=1754344176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poaEelBg7a7OcoaRwgyEnvu3ww/B0f0meFimZvf+Ksc=;
        b=g1LzrqaLKjdmkelbZih/HraLuhFRoIff3PqM4H5yN5wDToeMPwsHfrIgYA+ejOK2Sp
         YSctIsII80z1zQx23ILLGQWC9RpgxGYdcr7z+EQrBWLdMiLuWLFprNsUZg5NAITeFhX2
         85Oco/fZ232wPhyvDg5LdsPtsJcdnJ8ImhwjZGvNTRl8zd3GRKNXyXm2xe0UFiVGgUM4
         QbYzT2TECeCtotjFNueMDUP+xTu5rokEqV8Mi3FZm1W0/Y1m1qPJ6IjtQC7OPEEXzUPc
         3pmlV2mw067YrlNuf8T1Zof8hz/0yr8Y1gZ7baKzOEF0mE8I97Qt2AiYH7IeLufICtxG
         9SJA==
X-Forwarded-Encrypted: i=1; AJvYcCVSNYRWADMtjTgvf8m8SqNu9Dz9HEZmfdTxB0IO48HXVtENqHrL2uFv96Iyaew12XKeofEhp/AC@vger.kernel.org
X-Gm-Message-State: AOJu0YwvdWjAyN5hZmNn3S9IHUlqzuubi3Iw/zyQ51RN+vovNZNmO24C
	ACDDossldy8gpejDH4TXWxthwmpwmgR54hu9SgEPHEOsLvayZnr5sa0KLU4YEe2GdfN058nouAb
	ntPo7inq5X/KqaSpod/zRychW40kAeQJ2JGFIPdKt
X-Gm-Gg: ASbGncuOdbzPhaO0lCKvooFT/DTMNXq5rEhjn3xdS7+sauNubWm4Y8sLNoszbt5pjon
	rlW41f8OjqRTE32Qps2Le7FGHPFVXoWfjmN1jce5pHAieggLN+MzZm5Oi1HSybjjV7pjpa/QZzR
	ba4UfJ+n0f5hCuZ+bf541CrAPXMACHEcN8p3KqY8VUN+jDnQ3vMCDrQaiTFX/ocGdminzFfFKiQ
	im3nouCDatyMKXWzQ==
X-Google-Smtp-Source: AGHT+IGDWEdUVk8nOAd3eyXAgRoqbzWehDC/nmyeD5iRJSvY5Vw/y940r4iuZWMM9Zl9+esWYILkX9fMDQfg5o7B9Hc=
X-Received: by 2002:a05:6902:1501:b0:e8e:25db:be33 with SMTP id
 3f1490d57ef6-e8e25dbc361mr1013358276.28.1753739375979; Mon, 28 Jul 2025
 14:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-66-paul@paul-moore.com>
 <3101077d-a5e2-d08b-03c2-2ed064a35b54@huaweicloud.com> <CAHC9VhR_24Zv7u0Btz8pSk420Totnx2uRyVdoHU1tXevWKw5mA@mail.gmail.com>
 <68025cd0-e55a-066e-954e-a398feedc34b@huawei.com>
In-Reply-To: <68025cd0-e55a-066e-954e-a398feedc34b@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Jul 2025 17:49:25 -0400
X-Gm-Features: Ac12FXyHnpkhjuUV-tiMUv0zwfhXi7dvEqfqeEj1riNPGNByZhk8N5Ld8lteEnw
Message-ID: <CAHC9VhSp0cfSf1aeuWU3ZGt45v-vyoR9L2LtAMLpE+yB39ThPw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 30/34] lockdown: move initcalls to the LSM framework
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 5:38=E2=80=AFAM xiujianfeng <xiujianfeng@huawei.com=
> wrote:
> On 2025/7/26 0:51, Paul Moore wrote:
> > On Fri, Jul 25, 2025 at 4:12=E2=80=AFAM Xiu Jianfeng
> > <xiujianfeng@huaweicloud.com> wrote:
> >> On 2025/7/22 7:21, Paul Moore wrote:
> >>> Reviewed-by: Kees Cook <kees@kernel.org>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>
> >> Reviewed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> >
> > Thank you for reviewing this patch.  As you are a Lockdown maintainer,
> > can I change your reviewed-by into an acked-by tag?
>
> Yes, absolutely! Thanks for checking!

Done, thanks!

--=20
paul-moore.com
