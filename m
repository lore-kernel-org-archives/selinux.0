Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794329757;
	b=F4RBNPFhHTin9p1laNCSU7Aurt2UXSCWTvnHA3lnIzHm6bvWhXrYpbOPOfUiVkyAB1M8
	 QBuukLjfFEfhB8ITQ1GVJtnYfYftNOegQGSlBk3HvIIk0KLP1VwwqgPRpYU4DdtdAha0U
	 dgVWWGvEQRqw9Nxs9rMGoXN8tqmL7bHmo/S1CtadN1She6Z/Duac+/2ffrZH86GfVzE5q
	 eiXD6uWJ3a0jkxTjb9M1z58s7tTERfw2xBH3J/yrAVk74knp1NCGKQrcdnY3iaUj+Z9AW
	 +A/uCvzL8ubuYSPxWSJPdLLBdbI2OtPCkoNHmElmiAhTFrbAYFn+LLvCs6wq39QNa+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=u9pGhV7pNZuIXrI2ndTUA9p6H/yFfeN8shTQsogY+Ow=;
	b=qF83reuEu/3psBGmjIK/dsEO6pgn0CKpGWXhzrWZHdMAp6oAxGRqkmq+A437O+8cENdh
	 CPChxoqkZQxZKyUfn9yO4skI8KsfWFEQif+gj4YjIWU9i24F2quAj5XCyPpMmkE6KSHM0
	 Y8s+UjSxv9HkLr+F2NtjTesMkC6K+k+AWM6Yo4ihAMIf8CRMQIMryvsme+owXmFj0C8WN
	 AK7q60dWNmm4762Kz+WaqeSwqET7vmTz/PZutmPIvpDgk0G0pVbk786nul4ZNMd3o+mkX
	 /b9DNm2JgQDvZzA2RjxQn+ka7zc0YQJwZ0golSocK8W6NpLEF7tVBiCxjx+Lr6Vmavg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=drAT9jy+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904BA606A9D1
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 16:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 904BA606A9D1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=drAT9jy+
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b32b2e691aso21883767b3.0
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 08:55:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794329756; cv=none;
        d=google.com; s=arc-20260327;
        b=LubGCkaHt7sOk5AfzDs/d4JXzH9oSG9HGJV3iV0MpU5emez3scESYND6n0yCiuHze7
         wf6ZQRbs47TtbTPflu0MM3Esbx68DnGnuF81o5FAYaVxxrckERXw17Lv/x6fYPYL5HJF
         fCCIrsLwLCYtaRB2Wq+8YLCjn6RzZehQYCmrwxhE8b6judyP+nLymN0KonoRpPdQxN7g
         mgwE5GaLZeVGbkAqS+phQFIsmvQXu5ZbjlhXDnLcVMXnmJcw5QiS4oEf0CrBWXrz8OtT
         OBrtgHmn3D9mmNRrXl1rAV9kUhGja99u+CWnei69gvScDC7MiKmKXtmDVINmLI9w4cZJ
         7YMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u9pGhV7pNZuIXrI2ndTUA9p6H/yFfeN8shTQsogY+Ow=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=ic/cqhJwqJFOOmGGktUkb8sl6Dd6MOqmhj1R+gsrHiXjLmIKzwUuqird8vl+SGr31h
         0fPtX0S3OV85ToyBnCpbR7TZFg+7cQcleQ81z9RD3BGOru0IfH90MxRymoP5QVCculs5
         WcBqhzMccyhqfQ1/4mM2TyGqomt8DyYfIlopEnYtAo/2Tbm6oEiHXD5FAr9MpdR7fftq
         PjB9xnDJ0395vxF5tquF8CT/3S3Wx7nKzeHaf6riqlxq2JXOn+LTHnVrmxmxhqG3ONd6
         h4nu3hf/esEngCd2hGtVRh5AodBwgVKcJ7fHxxrKSPhuD4O50aqyl9HM8zh2wxmOQdvM
         LRPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329756; x=1794934556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u9pGhV7pNZuIXrI2ndTUA9p6H/yFfeN8shTQsogY+Ow=;
        b=drAT9jy+cCqHxMiEHIPbj6E4L4tdvR+ZSQDbaQjXR1jlsX7Xft6/UQhaZXbtm8nN1f
         1ylHKFDTBOTFoWhYs2BbDX2PSKMFjgOtBoPXlJEgNVfi4iRvFNe2Pg3B69xSYxOlBSWj
         iCMSoAEZ/Cc5BZA8IFFohEE/nY23xkIHqJ+7DnGtx83sxa8L68RmdjKSPfZjBPFFJgvo
         4Saos4EdsSL8aDO7z+PRI2wrH6wPh3UQeFRroSWMihJiUo9mPQYPDdSpyFlNkvmw2p4x
         tBIx5szbT7lvI3lqZyi3sKDM1BcrsBKp3T4wejZOAvVXAe/V6wAOJpihjkluY2hKqvq5
         8jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329756; x=1794934556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9pGhV7pNZuIXrI2ndTUA9p6H/yFfeN8shTQsogY+Ow=;
        b=D7BeLPG+n0PpU3c+O9Po2PaijKo/6cKCgVtptxjSDOmqEfLdaMOu3Xbg41NdRCRw1s
         ZdFG9pfWYJNmanifphIyUEfSwnSLJ7sY7VmV5QcD6Cn2qs/EqgOZ3moXqTfJM9TDbuyo
         fIfictEPWC0Cyi71mZKK9ALlfEqDLum1N50twYUsaIGn+rKlo9UcAR4EZ1ljBEFBxP9s
         0OkeoN1+XECxfYGuGpIk7oWzhLA347mok0LYPvHS7J0BXJ2DBxPE/KASwSkCtrldOSGc
         duGEY51G4jnTdc05dUk8rdT8NN0yNqnXxdX8LTaQbbI3+/B5HOcnJUNx1ou1IXh5ijj5
         OsBA==
X-Gm-Message-State: APuU4Z/Ia+e/k7wmbRDC6tpTf8BwYhj7th3JzMFKrpR4PeRDV0UXetuT
	MlMT6dR3RGFpUbocNF6BJ+HvTj/l9oG0Aw0O1goc1tXi9ZQ8njyqoXU3al064nWTo+WGiLlcmuc
	EK7nxjDOa2yq/UhZJ1JKSvyDUhHypqD9o+VpP
X-Gm-Gg: AYBFou2YCY+y2pm/NFRi9DSfDl6gPaeyAD/t7i/uFL2yFx0CYLUI015/zXQFXkAS0KP
	v3iYoDd3oVVhzeZK9XRRKrHL2RW1XeZMrnV7iyCS2cchB2FgOmEKYGz9vbyt7lEf66s90Lj1eOy
	Hohek2WY1hjYcMMa5vzI/0nWos4G5SdETOo7N25fFiXtCR53SS4VK0YZTIUREMuhC2Rmry4DRyQ
	cSqONfrdpuHDYEa6hnPMz14BOQuZsHJWJ9e6VEGy/iu/Xj9Bj9C1Juruk+O2Xs+Cm16oCORnphf
	uhOr8fyhW1NF2au3kKegokgfgrF0tGdYNdNYL1Kk+S6T4c9vUGfED/fDQWjX4aKIKAbLb6++gmf
	Rz4f+1PxPzdbwiOiSTKn4DkTV6AHebxaytlnzXU+6a9bfMyYkps7TiSiAtM0ocepixTkAGnDDfV
	sy+P2lCKrB0GUbEbWqacyiV9XGZt7zHsEnd9+goxfki/J+jSKB006VpyKwJw==
X-Received: by 2002:a05:690e:4507:20b0:677:c281:d685 with SMTP id
 956f58d0204a3-67c56fc9785mr1205000d50.34.1794329756610; Tue, 10 Nov 2026
 08:55:56 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110105906.58509-1-cgoettsche@seltendoof.de> <20261110105906.58509-3-cgoettsche@seltendoof.de>
In-Reply-To: <20261110105906.58509-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Nov 2026 11:55:45 -0500
X-Gm-Features: AclHuK-mpUXxVK6dJDXuypkNC9Ooz7sx3VHRlvM7vTyi-kcqZnuVdZq1DtRhB9g
Message-ID: <CAEjxPJ5b7fDYJ_PdAVU6tRwdUjRpr7VfQ7=g7wSD7mNp33-bNw@mail.gmail.com>
Subject: Re: [PATCH 3/7] libselinux: set errno on matchmediacon() failure
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 6:04=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The not-found and empty-context paths returned -1 without touching
> errno, unlike the sibling context lookups. Set ENOENT there.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/matchmediacon.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediaco=
n.c
> index 6ef3a217..38311413 100644
> --- a/libselinux/src/matchmediacon.c
> +++ b/libselinux/src/matchmediacon.c
> @@ -24,6 +24,7 @@ int matchmediacon(const char *media, char **con)
>                 if (!fgets_unlocked(current_line, sizeof(current_line),
>                                     infile)) {
>                         fclose(infile);
> +                       errno =3D ENOENT;

This will treat every fgets failure as EOF and return ENOENT in all
cases. Preserve the read error and use ENOENT only for actual EOF.
