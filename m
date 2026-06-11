Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108030DEDD
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206379; cv=pass; b=g5vFUBw8wQznga2ADR4VPT+i4dYfgsCX5qdrd2CWKBj6FE344u3OUx7xRZlqBkkySbuZmn9WC/tXMjiDkefYHJuJqypC5PH+6qh+Epe1O87AS0W2g5AA7tYjNAPu0p750ouJe23WF2j/08e/AZg8YIqjOZEUVzY/oT67RrUr1Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206379; c=relaxed/simple;
	bh=cHCz4NCvd9pooiO+N8pTKToXNmJegdS+z3BQRI4gLG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZitSfgKkf05fIMh35ICPhQlEBbQeffaCQiSfY0UvCIdv1VaHKBEcM9R66xWr0WWRRb45SN2SAT43xvLy+pfBb5dHTeA9ERvq/mSZy4weP8uxW3Fo6TZ5yVp9shOSx/XvAj4TA05k8qOBIgTyUmqk9aJsUlxQuKp7Um+YR3fj98w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gH4cHPis; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gH4cHPis"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36da8439078so264034a91.2
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 12:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781206377; cv=none;
        d=google.com; s=arc-20240605;
        b=jgI33iAOORpphYWCM4uhOPtMx1vpRr1045VchXw66uW97eQuyRDSVBGYnPFHebXbxD
         hxOrFnPaM/XOQLu94OQFGypIF3dT1N1uR/bTL7kjsAi9t4rlpv05KxOEh7Z54+nsv2pZ
         d8XvrV1/VvqfGjR+eljSlmp/jJDYxkTlsDfpRLARxTF9lgKiVvOlZlV5BIjCpB/UsGLc
         VRiqsc+43BF7a7sG/0uGurwKI2YiHFDuD2B8Xv+2g21V7O7Gp4JRISyqiuK/5oS5u4m2
         OjLrV0jZ0VNvC8ho3RwSuDAvupNRjkfsJmUYjSOZzb8a83m9YAmal9ab/9r98xpBRDyk
         JZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cHCz4NCvd9pooiO+N8pTKToXNmJegdS+z3BQRI4gLG4=;
        fh=szNbHvrZ9tgD7IbBK4eiQiwR6NVxN0is2sKK6qohdqk=;
        b=EUGQ/ScBptxMLhQFohCXViVmboTrlhpVHSLxAZerosrH/CHlpJfk7le3x1c4uhr/+X
         wrlpVd7NB6h4ueSPPt/hlULXfi4knLfVjbiH7dCdhxYpp333Bju0/aFOt/PDDI2FTYJq
         hhI/OdhuTn1urWersTDUan4GB935ITeXJaTCk4Gs2+nWtkb6YNU2H+WTQXQRdVq3LoH4
         yWkPqM+QYVvIcQkWQIx9hTYscoR19cIUdBji6U5k3Kq2u26m7v8qEcpjHPdC1HnJPFH+
         1E2DBeRIadHVaoG5TmmmZHXI+7bxZdgF284Mu0EyGg10DUwzAxWOWszbCzX6cAYFVys4
         aR/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781206377; x=1781811177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHCz4NCvd9pooiO+N8pTKToXNmJegdS+z3BQRI4gLG4=;
        b=gH4cHPis15Uds2fYyars/GfsRfcqJUPtOPY8QurADacXzxNBT0QKcXSClU8OBJgGAk
         5DwAlwGmumBUN0KF5Ecn7o0iDTrs7yKYnEi7OlyrP2r8YxRRIG9Gbzx1jTkWFjl/dO+R
         G3dTziamyzVM9x17BB1OqgKwpDGy3aMQVuPedpUwyM3Npy6AZVWR1br3sr+w1pkhyF5L
         InOuIr0e8BHMsRxXKDCPaoRIwoujgm++dhOBOtPzEFjqBwQ+ehKY4hkmBhuNpo3g/ni3
         1QB3YxV8p8KuhSb52G+7ZFQ7L/KQZg6WQhPuHobYx6XFMSeiOH/ciw6o3G+99G9OV6WW
         XTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781206377; x=1781811177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cHCz4NCvd9pooiO+N8pTKToXNmJegdS+z3BQRI4gLG4=;
        b=Fp4igxnJh6a2SLbBekDbQILKR9zsCm0jI23KkbD4JxhC9ci8pmlHMRaY2ayVETyk/m
         2C/OTwMVOBuMHyDjslRNvw8EyvWwSd3zSHmbvnNg3TvdGKGaNm7sWgqC/tuaKLuq8ghW
         u6q4ptcKdW3Nml1Fqw+H8tAzum1xk8b1t0yZd4Iuy045F5bTgwNHGcJKYjAQxPSWLyH3
         thmmlvITsSARbSTWWoZHUhU8o/y+2kPnBKeedGvPB7xJkMdL/roRCLnVwKgBnPMsbdTF
         HaMueZhbcyJRfqW6afdHEk+uPUISBjmh/USmuzyYKhgoSfLTNHYYPcz9Np79X0FubP2a
         x4WQ==
X-Gm-Message-State: AOJu0YxZ9eyhLWUH5Aa7rAf0WTizfoeVH7ENaA3eB5mq5L6rR107kxZx
	ejl5IEWztYT7i8Wrx+E0vlJvzfeVMPcnAO4T8hySAUyFTCPU00Auu0o+gErNbZ3jK8IOIieaSUE
	YlJG8kqy/ISiT6ZmP2rSbHpIi1XjcDi43nv+cfQKBL+l1i7MPYOHmFQ==
X-Gm-Gg: Acq92OH+5YUo86JLIjp+kGkdCMauBPG4fC3Xkq9LQYW/FKnIzH1q63fSNcjEmtGHMbT
	NzWJwh8mnkfxcsol6+OW48836Kcsu3AA4FoXuzZCYoVUPKgRAG30YiK7FvjFab0/5YlETOysv3K
	0R7iKeC0ZfHoevbp7i3gDVMKNdtdJTuNpXnzwNPGsbTuErMS6yGaOlKYru5Wso3IdbQ30VDoyHV
	UAcm02C3n7rhnrmYOZrIup35n7jH7DIOlTuQLB9aN1aLYbNFW44yBGg8fpYEwdWkiKXbnsM1+9B
	QlSiI5E=
X-Received: by 2002:a17:90b:540f:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-3779eaced54mr4834239a91.1.1781206376925; Thu, 11 Jun 2026
 12:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhcyzmaCLaRmK2anDfThnhy3M_EFRgpk7Aajd+uctvYr27WZg@mail.gmail.com>
 <CAHC9VhSf-ph9D63=J-AemOZfvb9HXLFguCRFWkU4y1DvDsKr9w@mail.gmail.com>
 <CAAhcyzmUS0QkOL9_HReHD76fNTknPpJUui67-mLW-Dx_BPFzZQ@mail.gmail.com>
 <CAHC9VhQbfSV6gt5QncQKmgjbyNCWb5TP1WsheER+JLaV3oqoMw@mail.gmail.com>
 <CAAhcyzmHqJwcWqSZ+Crv=+z1fHvT3n-XJomO=iqB07wRO33SfA@mail.gmail.com>
 <CAHC9VhQHe2AvKOSqFC9FzAR45CjExPVNM7+F8j69mzALB10kSA@mail.gmail.com> <CAAhcyzk8JmDMtjzAzO0R_Pd9A6027NT1ZCdRqFjFiwkYwu-iAQ@mail.gmail.com>
In-Reply-To: <CAAhcyzk8JmDMtjzAzO0R_Pd9A6027NT1ZCdRqFjFiwkYwu-iAQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jun 2026 15:32:44 -0400
X-Gm-Features: AVVi8CctEMKITu5JQ44Ez1Mv6_WzdzNWsS9YlfvtWrRiG-QBKak5HhLYWrwh4QE
Message-ID: <CAHC9VhQfcyQuHoo6Obd8F_hx3Rq7NjEfsyCOfu3C14Hi=hznJQ@mail.gmail.com>
Subject: Re: [REGRESSION] LSM/VFS: startup latency spike during rapid library
 lookups (ENOENT) on x86_64 between 6.6 and 6.18
To: muneendra kumar <muneendra737@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 6:24=E2=80=AFAM muneendra kumar <muneendra737@gmail=
.com> wrote:
>
> Hi Paul,
>
> I will work on narrowing the gap between v6.6 and v6.12 as you suggested.
>
> Regarding the static call conversion, I agree it should generally
> improve performance. However, I have a quick question: could
> performance be negatively affected specifically in failure cases?
> We=E2=80=99ve observed that the degradation scales linearly with the dens=
ity
> of path resolution failures (ENOENT) encountered by the dynamic linker
> (ld.so) during its library search fallback loops.

Off the top of my head I wouldn't expect the failure case to be made
worse by the static calls, but without any profiling data it would be
hard to say for certain.

--=20
paul-moore.com
