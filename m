Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69846D091
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858430; cv=pass; b=GKcoHTYzVHoZFetLZmeelCqk4lrIqWCGpmZ9o3jyLaVRZpcBOkjDU4nBUUrhtReLKwjoPVWABAxSF2hLPftbU65brNi3TpE1YtwbcZ30x7ci7bKJB2oLzPUCS6MIszQXd8VDd7IToLEDS7sc3pBXb9bDCavOMwdfE1P51sjR6Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858430; c=relaxed/simple;
	bh=pdBZx6+9QcV0X3Pp+DYbF/oxkBZKZeaRoIrBQCHMg5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=js4nSc9tfo5VW8qBr5WTrsZ754+hzheoUVNbswN7YID1JSMETqAFJf3/Cn08g/9dpuF0mzcQlQmDlTEtWncpNRpqR1rwtjETfOLsnss/AUJnsoXvg8s5XPEGRvXFu35nzXIRnQEuyZiqZvdBMPGKLD3BJQWY1Sujset4LAmTBCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgdhvBKK; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgdhvBKK"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6ae8c4b9822so18091eaf.1
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 08:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785858428; cv=none;
        d=google.com; s=arc-20260327;
        b=mtfgOwGyELaaeBkXVT/HHZ67V7FyA97WPszLgjva9oeEH5rAq0/tdjeuDajRcF0LbA
         ZuBdbebsOGb7ZEd8CopX9v2QGp+fBtMC0NU8PCtA3EkqoCnJwN3YiorTnEsKCm1XgJX5
         a9UytRYCw51G1Rt4LDjR/qqpctFVN10vR6pVeybr8OJWBMC0ed6AYiJtrxALo3klsxEU
         Mz86SdTQswm0hVwQO7MNQM0aWO1VwxNLeIcjRe0C85MUjSZ/6ojOUdQK7+XPkLvIeYCT
         oC7B/xv9TB32h3I6+v9GVq7uyl7QUaTG4GFCLQeMBigYl02HPAsP6IC/Y+H/QvHaTR5Q
         UWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmiarcRCMXfyNmPQ+MRxEiZPqZWtgra9MYD5EhvYB+4=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=nUu2He2emVIgAOxrq0OQaWhKAX4JS/3a2atnOUuYcfWrCdTryguevjibSoyy0VvoWr
         di1zrtZndYZ8luatunTbmGPl5yKsYucfvnDLmM3blYyxORE096FRTF8vnhU36Atm52Xf
         f+sqnBwomFGvyVsNhAbcz6y3gpAt8aUOa5SImyGgVbF/kMret+XAiPDmlyFE8VtH3w/H
         LvHujvnVNoANDBdRqiwksuVfNJj34ytSUZIC7K+nGDvWb03NabjrqisCmrAlpWylnQEW
         GNLp9Ebm7Fnk/AZZeov2C7pdmSt+LK9Mp9UcpgSpZc8XMoOZlKPU4WEFkmVh2ygcENt9
         GI4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785858428; x=1786463228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FmiarcRCMXfyNmPQ+MRxEiZPqZWtgra9MYD5EhvYB+4=;
        b=qgdhvBKKYDJnDRMm1hf+z1F89fuSy1gd2FiuGV1kECGdiEPwsI9lPh5OqLvpMSm/ZH
         Bg7ebgjodDFFQ/IpBcSNmzibH7y+LmZeHoumtpW5RhrEM6Qh71ycx/8zmRhV2OLloGqZ
         +DevSKMhVQ0H+yv8DAM/oy++D4bwoErVbqdLoLCHfiTip00V6VTJoRABaBgeUm8u7Xbw
         /lO/Yj20MZq/+FmVDSv2lRijVP2S2p2xVkrluEoEn+nFzm2PTO62UrLY2sRmOWj9n7rC
         IVXaMNDhzSGaZ/5LYzUw1KcK9mKfMBKEZFJdevnO+34b2I9duk2RpREJZInUvliaxo44
         iUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785858428; x=1786463228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmiarcRCMXfyNmPQ+MRxEiZPqZWtgra9MYD5EhvYB+4=;
        b=r2ZNjCQQYmyWyjowpMoHVmAzx1rGIlDmXUTV8Kj2fWEtRlELyYDDx0x2Qv5zpmIahX
         H6Mw3+Xd7dA3ISb8Jt2/Kzv0Y51NxdSYPGgPFdD+6++tB8Fixrz8C07Wvm6ezWx/ahbe
         8c9q4E95NB54ot68wryJC/SfbkF+VUAafQrkmuiN9dp8BVy0Q1yIfNbQciekH8Yf3BnO
         9LAWEbxX51H5Qu9sS15aYIOKKFV27HRGiKvJmJcSl3qWaAXpTy7kOc5iAdbL1trJATCC
         hP9K87+NCZafhiEC8W4J6trbUQqQ+RL3pJVKjKNUCGrRs6WTtlDLNlhyyUqEaE4V/9Ho
         44FQ==
X-Gm-Message-State: AOJu0Yybe+AOpCJvd0GgqfOMzlKDxKzWkY7C41ovHblIqx0sordsvlzq
	FBxsfOZ38dqkpBYvxeIeLBPfdYjjn96+jDB0Lt1uCP4VSIZJQxYaNuBOV4NVp2TCINXw7nFMcCq
	1m3BwzVgQ53dnRLNXdNdSmEA6fSUNYQ6qsA==
X-Gm-Gg: AR+sD11DMcml5zh9tAStOhGiGfoPaNPB5mGrjvg1S0xik9XAMzQtrD4fK684Iv+MeKg
	gU/7Bh5Spn/NXeQ5Wd4/JHpOxgptVrG35nvVbt9oFzyXChcuJqTftuFS7c7DR1OSDsi4zhidz7N
	ER9X4BVsNoys+nA6yIyu8ZiFwmxYjoGatHbTNV+LhnGstvEquX6eyNqqNAznAmw+zT3o+IrZWrr
	dwpEfQ+pS8I3rrZbnwWYzu0g1T8xpN0ncN/CGurA5HHQcXNqzIa4GP/b3+ldnewVviJfQN8HMG6
	f6BqKV4dgXTXru+2WHIITK/oDyCMKc0nZLgYTsiTvo9a
X-Received: by 2002:a05:6820:4182:b0:6aa:e524:fd82 with SMTP id
 006d021491bc7-6ae4333dd53mr16538175eaf.25.1785858427803; Tue, 04 Aug 2026
 08:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804150419.20254-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260804150419.20254-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 11:46:56 -0400
X-Gm-Features: AUfX_mw_ieK9b2Dpk_rAtBiyuqAy-NW-N8lB6eal47_KVtd8sCcZWd4ur1hRd-E
Message-ID: <CAEjxPJ42hQhx66icUnDzhgHhe62xbKKEzNRNAoCBHpRouyixeg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: reject policies with no avtab entries in expand_module()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 11:04=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> avtab_read() already rejects policies that have no avtab entries in
> both libsepol and the kernel, but expand_module() can produce a
> policydb that has none. Check and reject such policies in
> expand_module() so that checkpolicy (and its fuzzer) will fail rather
> than writing out an invalid binary policy.
>
> Reported-by: oss-fuzz (issue 541553475)
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This breaks test-expander in libsepol; apparently some of the test
policies there lack any avrules.
Should I fix the test policies, or is this change incorrect?
Also seems to run afoul of sanitizers due to memory leak on failed
expand_modules().

> ---
>  libsepol/src/expand.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 8cb62d82..466d5bc1 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -3494,6 +3494,11 @@ int expand_module(sepol_handle_t *handle, policydb=
_t *base, policydb_t *out,
>                 goto cleanup;
>         }
>
> +       if (out->te_avtab.nel =3D=3D 0) {
> +               ERR(handle, "avtab must contain at least one entry");
> +               goto cleanup;
> +       }
> +
>         /* copy constraints */
>         if (hashtab_map(state.base->p_classes.table, constraint_copy_call=
back,
>                         &state)) {
> --
> 2.55.0
>
