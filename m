Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE04483BF6
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788286132; cv=pass; b=OAFFuyU/+FQGKAj2xbyj7SEzoXjiPT8laWMECjQgfVJGCmUTnUNAFG7G6SLXHfTgxjKT8rNO6lVA0pwt7JW7OzKS+UQEJaBNIAo+u7b4pdzUa81ThEhYyofvho+8x5AaXpT5J1RppLR5g15a+keK7t9ZEpr22qrLBMnhyHgJEKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788286132; c=relaxed/simple;
	bh=4Ma597fJ7ed3BqOsQ7b5cPShtVUdx/dRv2SpXDW+2+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6hgmsEF74Uxxyk84MNDzYu2Elskg+vJxqYJXJ0fd3DTH7Ylbx+2/Wi92H2R47mIpaQbft+cCVPy0nn3I31iiNWHHQ1+8RgghJhg/Z9MOpnsRzlKC6LT6NdI9uDphNJciEgYlZaPF4ypoZHHMh7olo3g4Sd8C44s+ZwZHtzISsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNP2HtPb; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNP2HtPb"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-46a3a8001cfso89475fac.0
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 11:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788286130; cv=none;
        d=google.com; s=arc-20260327;
        b=HNUq4jD3CyZyUwGPESdZ8k/hzSD0wyp7vA0afk2LzCmudSG6Cxn4zfiktQRLbM79IJ
         IRDLMN44Q06SRZzqtrwIRDLp507fjCmHIJkOpQY5i2EjZOpVJSlSqCXaD7A/yOoc3hmM
         NOsiPw9zRipldyDpobCSxgjYw0PaOqlO6y3Xt6dNfQ3w9FdT8DUPwv9ZZWWPizDVXLHM
         6wjchxJSlSmdCL5smKDidDbmHdqicd2nU6cNj1nI/yR75lSKBbr+syZd3FEUFZMn2Rvg
         S+J224f3Nm31lOWaOYZ+Aiixr7SrISrZqaMP2FdDgRe2ERMVEJdwjodw3vsu01KJcug3
         VCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Ma597fJ7ed3BqOsQ7b5cPShtVUdx/dRv2SpXDW+2+g=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=l8nZYEAzerZvM0OIGQxOrd7sHztwE7Gf17KHW0whhaNNEyZRewruIRzWCnP5B+mV8w
         FM0f/9bP/eYEK/Egkcvbm/VmgXcHSAH++58wOB9drsVdfmcn3MuoXn4H1Q5SAfi/zBjk
         SGDQnVPqZqVMqF19gct3komMyIe6wcfrvhpLgnuRa6KcPm2mTMHuDycLW1Jg/JSpdO5R
         kPlb/WKXI5Kw1AiXy3GFBbrCTQi8naX8qs1neNxNYDUsWsQqLYkv8+ONktGyvT28wQKm
         E8CsDJdJGXeVxMg1WzgX8ueiIKnTZvZOGcPgpIpJN81/i+/Hx2lb7YDFXvtBY5rR0yQk
         Nx3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788286130; x=1788890930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Ma597fJ7ed3BqOsQ7b5cPShtVUdx/dRv2SpXDW+2+g=;
        b=NNP2HtPb0Dy5SrepIKV1oewjcul8cPtK9dU5U5qSWd6weX8PACGsDX3GeBXhLQYw0e
         3hPqyDKXi9oxzV2NOQvh2B6gFr+m+pePisaLRD0+Xyl5ah20qbr37JYOKnAaU0qvO5Uj
         kZ9AK9poCGP5wmACPuJza7jDazIEiGD2ef8vy8SRohUgVPmEkF5IYf2H6IeSSrSr2M9S
         gpmvf3VI2MIKB2CDLhbcLgGl+n4CKh9AAWWL7fsaN6xK+UNpTYnfRYFYLrkGUa5//VxG
         Nw6unqldU+APhWJXoevCRGQ7O0fwYNyd9u05kYr31b4nPhwg8/UGBJ3P+Avb9sC4P1Pu
         MJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788286130; x=1788890930;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Ma597fJ7ed3BqOsQ7b5cPShtVUdx/dRv2SpXDW+2+g=;
        b=f6CQgxLODl0FvF2QoYB75t2fDkoVMYlGaJBL56+n761KmCoiVZNFO1ka4MRheuOfAd
         y9ecVeJdWiI0HlokOeOtExe+u++gC3Uld2ZTB02W0SQlbcx7gA7cqxFsVTiN0p1oi2fg
         QFRMvbxyR/dWhTQoPmEpoFNvVWlzU84LYpZXnoiuj23hiAiGYA6U5W2ESaF5n8/re2Uv
         u8gHW9CXczgVRwV2M1KD2m7XBFXT4JXgSIFlz+FsGWEBCnkb17gnayxoMhYyXCpki+ST
         qCyYJ4YtWZh0bWWHijWSBvkEh4/uVHBsDahILpeV+2IFZZeBns2FvxFhnH4iuAz9tsYX
         xr+A==
X-Gm-Message-State: AFuF++lNxd+7651i96NcMxJi44OjfY0k+oegJYSnsXUcMbje+aOYLPfv
	n2bfRoPGpWTUrRptXyRKmAylCQ23eKZLuM99istrSHTj3iNXb00gPIae8onIEFRqJgP1nKVSrZt
	btLNf+sDXzN8NzHYnSbQ5oQsVvy+TBtbReg==
X-Gm-Gg: AR+sD10QmGvBXPebyFHHYcTbNWZSAuA80uhaDWp8nHAL7n7v3FeHnbpmhVB1dUUInwv
	vskzfKhEUTMJgpI/C0FhDNXeYhU88uf1zd8upG7t08TbJqIXkpo8/c8btD0wracqjadXQkETyFx
	FRaTUuX0X2uEtlKkBt9KsD8Q0l1VgUX3O0/onSpbrry5wvBUpGuoEop3gBB5eiBMGN7R34aM1gg
	uKIzINhncU6/GUvM3ZAMMU4h4irnuRzRGD8IMLgb+yVvoMu8Rk6xx7qoicZq8muToeqEn9Z8DdL
	keus+Jakobqb2y/d1kdJFAiz3DbWorN/7L3tBIjgUNz2
X-Received: by 2002:a05:6870:4795:b0:456:9fdc:a86 with SMTP id
 586e51a60fabf-46f4dfea79emr76403fac.10.1788286130326; Tue, 01 Sep 2026
 11:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901172127.12583-1-jwcart2@gmail.com>
In-Reply-To: <20260901172127.12583-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 1 Sep 2026 14:08:39 -0400
X-Gm-Features: AcwNN1XJ1AwOBVctIJ2-nLUjh-uXXMew7tZFLKxy63VPa9c4FaRXt2cs5ookCGk
Message-ID: <CAEjxPJ5z7BQaQNjwGkKiPTFbUSeTz8UK1kpg5HgEfQP-mzF40A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Validate the genfs file type class
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 1:21=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> Like file contexts, genfscon rules can have an optional file type.
> These file types are mapped to the value of the corresponding
> security class. If no file type is given, then the value is set to
> 0. During validation the value is verified to be either 0 or a valid
> value for a class, but not all security classes correspond to a file
> type.
>
> When validating a policy, verify that the value is either 0 or the
> name of the class with that value corresponds to a file type.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
