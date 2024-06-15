Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FECF33CD1
	for <selinux@vger.kernel.org>; Sat, 15 Jun 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718458190; cv=none; b=Hb7s88y5pKd9pd2Lfx6Qrx2yvh2Fa2IZPVGfz2IL3ZKr1TKsazq4JyFa8tPZbmHCqhpyGGwUXm2EVRKBm1CIHJIIfpk+kRtst3QqGYj83d3I9ZtauMi31N0QlkE/YRBXEaYrVHDRjiP7xnrtuLC+NFPRM+VYJBauDWOO0+lr3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718458190; c=relaxed/simple;
	bh=ATkmXbY5mqY3TFdl+0+47QAyY/avcKrWUQASCyUyI7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERr2bGq4oBLugNg1FbFeroO0agfSfPRrrvJeqSgBeRmWV5Ty/JOlQZP78T7Io8o3GSABwQObAD3d/R96i81J1N+sGm5G3z8BHfAbJ8Un8XdhWV3bS839X/eS+3XgP480eAt99Ml3EuR0BygMJJ+BlSfvfSkeUjpx3/8sV1KIZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=G3odb7LL; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="G3odb7LL"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dff2df7de4aso380955276.2
        for <selinux@vger.kernel.org>; Sat, 15 Jun 2024 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718458187; x=1719062987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO593oOXB7ZMAzm9Gx6HT5QTd1Fxu3ZiH4gIrfhDOm4=;
        b=G3odb7LLn4ENYRF9haU6uvVvx7w6aWMq5jnMAdX+f8RBQERu9xNoSaM63f9hBwvEni
         PCExu1yA0fs1iFo4UQ2Hy4eJaEN0lXC2K+zw6b5T/WpDuFVGdqIvvhX1/bRAtGMqeEJj
         BIBD5ILahZY05wN8BAZt0+1DnLwjBlx4NACEfJr+7BuFcTbPjOtcuXp+QDK59SpDIXEZ
         7XL1PknAOfl8tazqORLfxrLfQ8xdSE+0EMdyx3onHaV5NnS2uIUlEoCuHPJYjJTDiN4j
         uNO/s+wIeguDNRNdXsLaT7daaV71PF89dHlYaQBcmYHOmvqiqbjseDAZjqUFiMhN600i
         7Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718458187; x=1719062987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bO593oOXB7ZMAzm9Gx6HT5QTd1Fxu3ZiH4gIrfhDOm4=;
        b=mFFfXrzTW6EXaxSnbWuoiwta+W/XKBclOtPIK1/gXJfXFEeYsbrlAp5d2N6Z9krALz
         Lj7VqnnjMlsDSJwcJbbcv30iu9idCivuQnU4/j5RW7mH9Bqoievp4sPZxThsFohaFt8M
         QUjjaxxrdz5FKuR3/cMSUuln9iCSYjy+UhEiT6jRRLznShHTbTjU1yoLmJZQMliVowXg
         Iy89aHcSJVaRhr/mV3f1N13IBGUuYGM4WBX81uTXfKfMYZmqwGo/L+dEocbPrPAgPMos
         dzkHaFUVBMM7ckTLLYljSw6OoavBDWvb3i9Ay/JaQAH0DutxWlCazEdPa4iD27h1bxSn
         LJAw==
X-Gm-Message-State: AOJu0YycOix5dInV0bzcHF1kEqgSqhO6xbAj9Kgd4vPSeWVyyzsaPj4u
	qXDGoT9QEqHJ7lbewmVLZKqNKEyd3DNR6XkS5ZanHiQPBXO3MXOlfi/xpJmlJKmY2nNxoeyOYtc
	/85DiiSZNP5tMMkWX3nHMDllmBrwA+ir3
X-Google-Smtp-Source: AGHT+IF/Epe8vwKicYXn3LwMGy9vy/XZmn9lYHDA5z9AAwZqfM4Ob5goB8TBB19Wq0Eiel5P6rst3KzCurFb4fuITr4=
X-Received: by 2002:a25:b21d:0:b0:dfb:dc8:a0ac with SMTP id
 3f1490d57ef6-dff1544368amr4957923276.42.1718458187430; Sat, 15 Jun 2024
 06:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614194500.631810-1-jwcart2@gmail.com>
In-Reply-To: <20240614194500.631810-1-jwcart2@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sat, 15 Jun 2024 15:29:36 +0200
Message-ID: <CAJ2a_Dderor=tkxK9YDNN9r_xb-rpcSHXJcBiCf0nMuhakBUoQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Do not reject all type rules in conditionals
 when validating
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2024 at 21:45, James Carter <jwcart2@gmail.com> wrote:
>
> Commit 1c91bc84 ("libsepol: reject self flag in type rules in old
> policies") actually rejects all type rules in conditionals in modular
> policies prior to version 21 (MOD_POLICYDB_VERSION_SELF_TYPETRANS).
>
> The problem is because of fall-through in a switch statement when
> the avrule flags are 0. Instead, break rather than fall-through when
> avrule flags are 0.

Thanks for spotting this.
I'am probably going to look to enhance the downgrade unit test for the
next validate updates...

Reviewed-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

> ---
>  libsepol/src/policydb_validate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 9746f562..2043e437 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1076,6 +1076,7 @@ static int validate_avrules(sepol_handle_t *handle,=
 const avrule_t *avrule, int
>
>                 switch(avrule->flags) {
>                 case 0:
> +                       break;
>                 case RULE_SELF:
>                         if (p->policyvers !=3D POLICY_KERN &&
>                             p->policyvers < MOD_POLICYDB_VERSION_SELF_TYP=
ETRANS &&
> --
> 2.45.2
>
