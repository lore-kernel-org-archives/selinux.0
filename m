Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205941E6A7
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875825; cv=pass; b=l022vbQTp+6vfLwUlc8cPyhzOZZoxCXvy0oT13nHs2EfI6WfOF/BojJ6jyourrwci15urLnnUOsBFgFqXuFQKNI2/xyYHA2oaAVV8R6UxpSedlfPRrix7Kz/BwCPMlgI6XGyJe5RfPK8DyOYH99ZMHHY3cqvm6MfW3FlBZKJoF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875825; c=relaxed/simple;
	bh=bbFKvQaKs/ZIEOEob2SF+H2XJ1+f/hHMOw6xfYd5xP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exyWMJvKbv+zZObPnw4UPIXW0FY32WlR1ImNVv/97EYpWSATDovg1oVeQDBzUZUVIBiKmanOdIdPQreB+lYIAbe9QGM4A1YbCgudWEBeaMsHnLQbeKjPu2fohrq9udpeFkqGbvCdAN87FkxTrSypYM0WknDZ3iNn+5yKpY1mg8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRE4k23f; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRE4k23f"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aa9606ddadso258597eaf.0
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 13:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785875823; cv=none;
        d=google.com; s=arc-20260327;
        b=X6wrBA88UMxWw2nWKdrZQLMGmkG/dW4MsSeR8cNIz1qb538WyKoIDHgrFVhY0I0M8F
         ZdFA+irD6t35eBc3lf6FCLzEluHCeiMA/r8UhK1CFJ5R56ge/5SEzKNt9NSZmVT/Iriv
         hW55Kwu2laYDMVD+bVjZ/Du9lF8YxQutxDQ/IrCQUQe/gnoczr1uIfDL2lT6Ef0S7Y3h
         i8XGtuDZ0sC3QncJj/kDwotSTa6g+SvHeOvsWFFtmj2BdWkZnC2aGFUZPsQ+vH8rvhWH
         d4N5pukK8vY8CEs6uSx4MVi0WJv7l2UKMa9IIAfveomlBvYnIEgJl8ldwIpBYGxqsWU3
         LcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bbFKvQaKs/ZIEOEob2SF+H2XJ1+f/hHMOw6xfYd5xP0=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=BYy1FNOR/S70kjTtFC5yQlRVq5Mf86ivj96UgElGvT9Tqf5W1PBS+2eN3SQmhpUN/O
         YICIx3L8iMWSWcDMv+e3CWlQklCS/VUC0P6a7MvxXLKPHIK8CytWYTH7+a7/ER/42my9
         /sxYteFBQn2VRjjYWxXsIpq3fm7UMen7sLWDJtAgiOhU3e4tCsnLyLh+1gQCbnM20Tsa
         TeMgnxhuxi4FMAqVE1rRd++MTfbR9N2ZG+b7es1cbsQX34h/x0JZ54px0dIgJN09kniT
         qKbZmeR9SJA+m7jvgGzS7P2yLe801EWNX/bHtZNf566hlgs9mJhKxAb7k++Uemw0FM79
         J7JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875823; x=1786480623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bbFKvQaKs/ZIEOEob2SF+H2XJ1+f/hHMOw6xfYd5xP0=;
        b=KRE4k23fqTBy4nESCHktOf1d2VgezDEhyaEd/W+XPN9ONXA/6CytTgHhdSOOPvmI+U
         K2zWZMGVddSrSmZwoV/qCylkqSX1FvMoOEk2oTEhRhNa1jXMsQmiNWF4QPFuaQTtGb+K
         mombCMZJDnb4GYIOzO0WuhVv/FO4+egv6AkgN3IlZap95rXZ6ZR+sU5Q8xZat1fmGAG0
         eO9UsV9xapDESDFIOQWtNN7gMrPdzxaTgxFRFoMuQ7IgUXmGikvGEwB9DxB4ps56unic
         cxBh00okafwFhPtTHuPwm4EVwZFEjYq0UcWMtH0LcQzdFsG9GqvI3POqPH8qUkYC2mzh
         PeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875823; x=1786480623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbFKvQaKs/ZIEOEob2SF+H2XJ1+f/hHMOw6xfYd5xP0=;
        b=alyvNuENUZwcSjD6TlRYpG5FgpB9eigJFpwKKBOx5nrY8dcsBacj6BITz2cGUVIsV7
         wqBfIYP1DsyqNq76vZ3bBpljYV5HhV1Cm1tqd/RcoXtfUbjlNcgq9UGqcjaVdyVggH6F
         JF+59sbI/J/xJ8Jq+7LU44xyObYoDc8e4rHiBr2yPmBDBXAdl8s3h21tfWWg03UK7o//
         Wo7WF1QWuvSHpiPV/TBui+5MVVQCPEfU9w1JKj6WLP4/nlxTp6wT3MYkUyGKJZyHjNKq
         MUQUsIAiCUo1rG0LO1c1P3lwRM0CN7iUeWG25UtLcp3tXNLZBKYZau86QcyUOU4rSKKz
         yHGQ==
X-Gm-Message-State: AOJu0Yxn0ntnvTAL9Jl9BPRC0FuISokKCn/KunaU8LWd8ZTWSv6TWIAz
	dEHTykCbT4CRKKS28TfDqaUUaWVuGeDEMtbB0DsNMV7klxsk3DrWbfvO175XowRnze77sdr487w
	mfOKiv+RsGwwLpbDD4LM5dcPLfAfrzGIAPw==
X-Gm-Gg: AR+sD12APD8aE5yksUbGbPw+SenbwIIlH5WzfAoTEny0WhJrmCru1nDsG77keHc7318
	ZEcREIkBIkIeKhKtB1p4CCYhIdX9sdpCJQRaQH86EwXAwC8QkpM58FzQruHzqcd6zFkxvSvgQND
	VLs6Sb0rIEPtXBGVw4Zzk2eMG2wc5QxUsGN0vDU+KAC8ER8dHtYfLOwyJE3ItGrrgVc17Di4MAG
	BrEKhMgcusSxkJMTe7s7GyoK8JFUvqCFqDnqnJ3+qjtBciGxFULIvB8sTJSjJ+oRcTanf7ltv3Z
	ZkW6X3J0LINNo4aIL166C1SxN2UuDpipq7F9F06sHpKR
X-Received: by 2002:a05:6820:1626:b0:6ae:7e3d:b9c8 with SMTP id
 006d021491bc7-6ae96c8488dmr999941eaf.9.1785875823245; Tue, 04 Aug 2026
 13:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804165318.22973-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260804165318.22973-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 16:36:51 -0400
X-Gm-Features: AUfX_my2MBi3exeAZ8ald7IRPGNpE7B2_iKWlVlFIjRAd0l7yg_Q9_V4-UizSEw
Message-ID: <CAEjxPJ5u5CMjRPOK0UnsGief=+JEaKj-m7MS4Ta7pz4ny2y5Ug@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: reject policies with no avtab entries in expand_module()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 12:53=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> avtab_read() already rejects policies that have no avtab entries in
> both libsepol and the kernel, but expand_module() can produce a
> policydb that has none. Check and reject such policies in
> expand_module() so that checkpolicy (and its fuzzer) will fail rather
> than writing out an invalid binary policy.
>
> Update the libsepol test-expander policies to include at least one av
> rule so that they produce at least one avtab entry.
>
> Reported-by: oss-fuzz (issue 541553475)
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
