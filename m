Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A125F7A9
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548973; cv=pass; b=sdw+TKd68F3/uTRHvmUqMyODgF26qjhAKZCLS+qFM0nxIJRX+ZmGe/7IxxMOzivuqsPJ4W09emLa/Jz9PmagU3Q/o6ZQjecc0exL1eRj44mKWYxh7bx2rB3vF0o7/57KB+/TqPrU6RMVc8NVo9WFXYAgNSZXcajaoBTdahTfQMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548973; c=relaxed/simple;
	bh=lHihtZ767hxGBCaevmlbFNZ81ypiIblA8wcc8xzcRig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4pUsQNpXnQlp2yWh0mbW7lwyCY6pe2RW8FnqJy4ipzdAdOr3p3YzQhMKTHhMYhb9QQ4NPvHSrTffXMtFAuHS/7NZOqJwPH915E0unKqsqFgCCUJPS/8A+FnPqa4xhaXamTZOjnGkalmFkdrNNXpX/uIcY6cMpt0kK2y5rr5JfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh9DHbO0; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh9DHbO0"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4560d6f82edso677603fac.3
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 08:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786548969; cv=none;
        d=google.com; s=arc-20260327;
        b=RLasxvTScsYqsC3HFIy1HnW1oLJAFrVEePGHVxDRzS2wnLoJaT6E5HxFj1+vYt8Yfb
         qMb5n2xqEc8wn+QyCEWhv731dmg5LO6kZv/wMPZYvE5TKF9tOBkJ6q2st8kAzpJqTLMW
         W+AZrNR9IrLNnM3awfvTlBp3zf/qK/DOLvWLVSNVIagpmwYeSRuliwOZUW9cGibngX/e
         AqPBMBTWSPBGLiFYPMRl5Zfum6XuHlzzUu85dPpgrVm3UUEa9pMaYxg0Jl7XYeS6aq0I
         FSlTDt97/0iV77CY6ohZknLwg5OO7fDljXpFx3pVmR6RVKYIDX0th8+E/UhH4YbEzFu5
         y9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lHihtZ767hxGBCaevmlbFNZ81ypiIblA8wcc8xzcRig=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=bj5vvahd/Oh3eHFe2mTh3Bw8n84zUtKYwOU59aNGOCX3IWDMHEqdxs70XY32SKolqX
         CfIw9TtY+63aVIC5ota8pNT4iw9ODhQveQ9MBc8ma9C5h+Y/PEabOy2Q6HBwlM3w6SSN
         zHOdLW3Sq5/JIpjUPAyEVbIw6vn5cVAxUk5rg/+FdjygBNgx2Sn4XC9ygCtqTU20wMQt
         Un7F2J38xA9OL3RG19kA/Pb3PFP/7fjxFnQOtPOnoG/GLzhqeYj4ckqLhSAzUPP298Ij
         LcG5dzVjs3cKlGTFY/9x0JnqoErlY7xs7qrf1unxE21s7S5H+/3Y2vek2xORzZO8sYzl
         uDrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786548969; x=1787153769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lHihtZ767hxGBCaevmlbFNZ81ypiIblA8wcc8xzcRig=;
        b=hh9DHbO0YyFkPj+nrKTRtwuCW3ctFUuXUIsmRrXMiPpUC6AgcojrFcPDuBEDgO1FFW
         18ZuLSYq4FT4UbJH9sf53RuZWLVqIQXLMP1VGq7bYUhZK0ZQmeVw4LDWbS7e0Xzypxa8
         p6Z9S46BQtDDTKxgqPyVGzU10Q03ICBkaqYIqCzYg7aLKz3mPYz52NIDt+U047ddSzfy
         0CrRXkF82swyEAzy0GmTW/XDB7odXtSfXVNWb36bwUYdsQaRnVlBPu/fpDczYoYqcaQ9
         pSmjUDNcb0lPt6cWY9kVpJuOaqLOQDRa/oWav4HxrMJI+cgV8RRFRvW8TjJhTD5znU+4
         Exeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548969; x=1787153769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lHihtZ767hxGBCaevmlbFNZ81ypiIblA8wcc8xzcRig=;
        b=IbNkYMf5PVYO62j5alvyWSP8upHVhGd3fa6rI/n9WTaCe+aME1BX0Ef0ytAyzCDqnu
         dLyOBgUzZgxs1Zl2LN54NzDCy6peUpEfrhlFgV0EAMipnTrn9rq3+SxZtUriNEBlI6WP
         mYQ8k1r3dW9KomcV2fbgvM+Xmd55cq2VKJTEJreHSSJeqPjPuegYstmMiBYy78oEzYTy
         VGumSP8zB3PhobCni074CxB6nTP6oNjlRHvYmfXePRFq86w41TmVO4O3MIsu1x8K8YUE
         CgdSHnOKBVac7VhNb8RY6aIro6+RJTXyC2WTVeLmjPx12u5PKzHOdEBUDy9BHagJbb+r
         8Img==
X-Gm-Message-State: AOJu0YzKS6WbdUDKtL1YgBcRyUjjb/AYIihGKcKqijs1bwvp6oNdyRis
	MYinB7TlMuH4c3wkiATnAtMv6c6zGW+5eyp2eVNh3Z2Xi4W+If+smIJ7V5PwSHwYmILbBflRy7a
	PIusa/jQ6G62PYZ6FMrZOd5M0R4r2PHE=
X-Gm-Gg: AR+sD10akCjZhrlF7nmiHwbNkmv2TGuYJr3JegFA5qBkiQCOgEu4sT5w5/zL4iQqTNs
	ZKEDhtYTTBfAxHT5RIHJTUvamGWmuh0M7a0YZD9sXJWXf63PeHZEFr7CzZj9liEjQ2+C7G33zTQ
	UDSwZGFAIAMYCWusvLUDtmRCND0i7MkzmJMGN3007r0aD7xIExAEz0QUFaPXHaN1eI+uQZ3zZ2i
	zOn8jtGFntLViybrxBWq58eri09zPnvZfVZJtb6l/YfvZ32fIaZguXimvS/kXCYNwFVPJUg0PNG
	c4KJ5U421ZP98WM2LOawCHi9eMTMHA5IXPUheWmlFy/R
X-Received: by 2002:a05:6871:2e91:b0:441:f3f6:622b with SMTP id
 586e51a60fabf-45e3e904f38mr4511065fac.5.1786548969357; Wed, 12 Aug 2026
 08:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812152836.11250-1-jwcart2@gmail.com>
In-Reply-To: <20260812152836.11250-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Aug 2026 11:35:57 -0400
X-Gm-Features: AUfX_mzIfXukmlz3cArHc4jusJN5LELp33t3zXwXuvC-tCdXrB0l5KYcjyMusDI
Message-ID: <CAEjxPJ43HEdfnOanWke_yZujwCynRs+q=2mRmG5+QVgf0CAu_A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Skip aliases when creating the type_attr_map
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:28=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> Aliases that have primary =3D=3D 0 share the same value as their
> primary, so there is no need to process them when creating the
> type_attr_map.
>
> Skip aliases with primary =3D=3D 0 when creating the type_attr_map.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
