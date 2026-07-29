Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C748B376
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331487; cv=pass; b=KuWUdpm+rClo7HJE2PDckfknT2LLoFZC1udMDO525CRVCsDGZDcC8HuNad+EvLnzpSNb02+iTGrtf2LCrjnPJwVzMXKulUXBYYaCjMGztFoYBvw0/Dy/4ZyF4pOA2sv0lH4ELKkAVQJZ95vCvtIjXiYP8k5XGq+fx4htt8tw/HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331487; c=relaxed/simple;
	bh=LddVwVpNygCGpXB1IMlHdcL5i9ztqh6V2Z/CRGfxF2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1q/ze1jUnAwNFxZYkNCPKC6eu4csrS8Ur0S/IS+icjhSkKY3dG1bLQzWEzKECbdHNFmPfAmev+SWDW8InUlOeZUzqDSUVDSvLZgNvnTKaW+khCcVFjx0w0j1auM1ysSSpgYkiq01qPb+gla1qb2syeiTi+/hyuLAa5dFxtPXCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pX6hb6cE; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX6hb6cE"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44cf70de986so389233fac.0
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 06:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785331484; cv=none;
        d=google.com; s=arc-20260327;
        b=B3jkD0vneoe6m6G7Ar26qkQQa1vLwUBBQrCyoLrMOuF2Blit+U2fftoX2ZUBCFmn4v
         sHAKm+igIrDuW6prsK8NovAO3xVC75ZCgBJLuIDlMbO4OsxpF/Kwtp6gawN5PIwgfLtm
         vySfBb5Rr8AFipPwqL7OJh9vOW3pM58K5E+7pxQJm4x9VuxJSi+8Ke6rilyi+oDQlZVv
         vltzvjJung4bGp8etJCmJwg/sOel1cl6QyDrH56IoRYw9IiedGs5bj93edGsKtgKIU+E
         d+9yqfWcZqMAfv/b68Mn33VDLVWbGt2HBDpbIBsrBF+tyHccVMTjD3MIzm9kB6D8PL+F
         hA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jcBquC+DKMB+tnXMr0wICVar+/HeR+H/Q50hJr0ofcY=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=TC+Ets16PqnR83hKhyUu2QbT9mpX/LxH8dJ5WF8luxPhFiFlQ1SIDyEnf2XHaBNyFr
         Y4DUDWb98HAgux+J0gKHq8IdDy4mRV3gck0ZiAD4xUKCngGwYmtIVo8xSKrELYAWMbWq
         qKfhBd4RnUZ6aH2J7h/uYSy7dma0CWb3vuSpsxjC+FyORSrIr94E8KDGPf5zIvl+PJCf
         AwnHUeZlCc+hakQ94ttOfSdvdtLfZYAc6pVsSvpp++3JmiKuTnhmO8dc+LW62TLzHhfR
         aCLRWuFVU/3c6jBEUmUs5mbuE+iGKalVHzxEpFb0BFEnUAWPvYNjT/yfJkxLj6Keym9g
         hUDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785331484; x=1785936284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jcBquC+DKMB+tnXMr0wICVar+/HeR+H/Q50hJr0ofcY=;
        b=pX6hb6cE3hYWJN7i3ygQJbRLpXjHhDQhGkd7Earzk9r7fqAe4iP7CZIc8v5gwZM60c
         WbGE0CuLYEEU1IwBxE7plAUmisau0AhR7Tlze/hZZ/HmLMQ2dL3wUdfI0cyZ7tOeEAcl
         fIPq58xVnrcuv7L/M+aIK8ejoqO+g8OvL7QUqmfHBaMAcwLzjvaTKFpQ5cMcdC7pzQZ1
         sfUcgf73If3jH7VtgwBw7pqXH006mwWbAjowQp5MTnmPMxwdPrdheCB1FAUHoRyrDxEK
         OvcMpJ3amY/SKwIEhKtbNQm2FB6TV3RJH85oCqvi/NDfWCr/3FMe17YQLxTQmLhjOzmV
         TQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331484; x=1785936284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jcBquC+DKMB+tnXMr0wICVar+/HeR+H/Q50hJr0ofcY=;
        b=V9zZX5TkMo1Xv7fEXVDUjQoi746S06ov7HtxMf+rt9ISg5jWYT4cTEsxw6ODmDm90W
         1AUI64UfWC0fwwPZQef+HcI7abcV2wr1pdnET3qN/04AGr7Om34aRh4Ugrf6uw4Q0qW/
         hrSObdmiHCecj+ITULAOpu2AFFmzQRv/saYGf15oF+eWWRqEodYr/zLIlBKM4AvoW2zs
         nLIrqtaEeXXFjnTavOxW+PUQbpkUd6lrH/pXT9VeeOOlNXBMFz8OZetrv4xz2To24Kws
         sBkeQQ1G5qu7h3EoiCotsIy1Y5mhSXG4lGJAGZXGMofLVc6E7QdJCy9PfNsW5k8KM7w7
         Ly9g==
X-Gm-Message-State: AOJu0YyXOW7PUJ7OXPib2AhUYTG9eRaxw4nzcumBp4gKV2L25+2Bpj/R
	/G9TIdP2L8TB6A1pQNMUxlzxdJ7bAWYFBWdZjB6hrP4GfVdM1/v0MMQ1jP72ZNTTRABigvtPeom
	Rv4eZVC23Ijf5dW51RghMH42IICXdVxVwlQ==
X-Gm-Gg: AR+sD11rTuyJB+r2Xw/FrI6+GVODV5UFTlCl+aVgJKujG8O/a7YDHmdIpdQaRj8yF9i
	FUGFrkFRrCyiBkfaidgdQ5XC5x4uiPWexKNWYekvDArI782CZ6AdcpyPqaCuBB9Fr8LibreS5RQ
	+2QqFSQZGtf+L4gTGVBTeIIj93HFqR5WsTfhxRrwNZCZNeQk/6wTZbdgOii/Xbr+IzcwggCvbsX
	NLuPR7WuX6YPZjFN4gSj/v5bp1xdFYIRy4KtC8cuTyuofAf8FKdDJkDEkI+bLwvRdfDq4f1lFY2
	aiC05OEY8sXiUnwbCgFxPBYusa9qSWLcl1G2pCx9x0aX
X-Received: by 2002:a05:6870:8893:b0:447:9474:df1c with SMTP id
 586e51a60fabf-4586cc5a2e5mr3838626fac.14.1785331484237; Wed, 29 Jul 2026
 06:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728164552.2646227-1-akkohli@redhat.com> <20260728164552.2646227-2-akkohli@redhat.com>
In-Reply-To: <20260728164552.2646227-2-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 09:24:32 -0400
X-Gm-Features: AUfX_mwd8HUlwnDy1-i8mCDvvo40jWuuSWc17JOa8GcwR7i6l86ho0TRJwvcRvs
Message-ID: <CAEjxPJ5Ddd=-X2vKA7oHzDF-ZZ-_GZyfc_z_XEwXuxePZWb29A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] checkpolicy: extend bad-data tests for type, role,
 and user errors
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 12:47=E2=80=AFPM Akhil Kohli <akkohli@redhat.com> w=
rote:
>
> Add negative .te fixtures for duplicate type/attribute declarations,
> type/attribute name conflicts, invalid type names, and malformed role
> and user stanzas. Run checkmodule negative tests as non-root in CI so
> the unreadable .te case is exercised outside root-only skips.
>
> Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> ---

> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_test=
s.yml
> index 4322ddff..fd78969f 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -94,6 +94,17 @@ jobs:
>            sudo userdel -r bad-data-test 2>/dev/null || true
>            echo "::endgroup::"
>          fi
> +

Trailing whitespace here, git should have warned you about it.
