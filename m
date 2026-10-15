Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399565304B8
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073703; cv=pass; b=u2Gv2JLDKdftkZIjTmmVKEZWLf6MG8WD/YO3zskjlkA3TRKzKRfujDCaKNheRlo9mW1npVlbDCWxq8Gp9Tu8Bu2L6cxLvrHA2t0Arqk8j0RPsf9WI0lZeADv0VyKBPJkpFodlxL5/DmvqT8TwTxZbEbjLxODVILTlmZhJutmRMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073703; c=relaxed/simple;
	bh=39IRj5W28ImdxzeQ4C2An/kNWPrH3OS64mKDpHY/054=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCOCkXtizJjV4YbsZE+lWguYu7eJ2Riny5yiAOIcCL1gSCUnrVBqqAgFvtpHxjuoM9tA0r7Tqx8hT66RK2O3XzEXZ4/YeeoCTz9/0kSZJznxMrFNB2XiP/OX49KyR6QYDbKi/TQc6D1CFT5h8uSCg9b4Wy8RWvIxt4vT16A0MII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjmRax40; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjmRax40"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6798eb0d13fso1295630d50.0
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073701; cv=none;
        d=google.com; s=arc-20260327;
        b=m4SHIy1XIyTmGqwTQebADyrYQo7+eUNoPCTh/DXgOISk1UVlOsIU0E8eItlY07NHzM
         2Rh4I1JKHmCpNSwsedn1k65MLwzfyosc3GPZX8jN3bBKDe9GrG7DZijRstiukITTn7Ru
         8YKA1msdgx5XzZEreklTcUYV8YeMHvbW+jQiKYmoDVr33fKY3PfhbgZnCdOOlYGSMDo+
         o4JG5o/u7fHtSYioqMfcMSvj5xa0HWsnWwspNri8WxdpX6zKLTElFUqa5EZReXH9Mzbe
         sOn3eyYAvkq1lbMI0SZtGLt1EBzLWxSZeICqq2NpOd/n+4R89kJD+CaE2HattQOA9Mwy
         tr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=39IRj5W28ImdxzeQ4C2An/kNWPrH3OS64mKDpHY/054=;
        fh=/ylro2kycojNQMvnSHIUFC32boeLWx2LWGPJCNKw/TA=;
        b=h71BoJRfiPeukmef3NuVlKcb7FjCjOmtSe0uI//z84iCOZfgd6b1BBNIFqZcXX4uq5
         KV81N0naXAteUkzusFPFb36/hoGh9pj9xdTbQOwOx0VwTjEjnfSiMQSXQGL+Y8tkSP9L
         NAZXaVYZRT1i5cX0fONw2ALQl6z3yvPkvFTI9W811d6XYyLAPQFPQ7Dy3Ko1q/geJb2r
         kXiNAYv4cynoObrrk6ZDqeE5y6FlTdT6p1qy1e5gJOdBswNNzJZeh+Dx8iqU7eJBofRC
         Is7OaRH7XbzrQ0n4nW0wDofFJkloxJqq8f1gQfff9mdGJaN+GeyuKb000ibSklaKqfsV
         CNDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073701; x=1792678501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=39IRj5W28ImdxzeQ4C2An/kNWPrH3OS64mKDpHY/054=;
        b=VjmRax40jLIW015RErWNikJTOqCHe8PlykSSDU1LK8a8oT/wSh/KfPndzDEa8tWJVz
         P5pPsu8/sov1dcf7Wnf7JxiorO6YhgNDPZDGFtPJ9X5efoWirlbphhVAF6YHI/vOi0BC
         NWXOr+uEj070IENwpS9s8TherdktJ7AzxhiDGekr/VsDXfxFqcp5wu3Ebr1diXZSTmVE
         QOQH2u/XSd9Vwii6PtmgFE7zpiC/REZ8g1DMrAySuUjGX5VxKhcyrXfc2/FcygQCVyxw
         4vn6ywjZ073yE+TJbFaqPKsfVGfby8HKczOOLHTZbH5tgI/1ARxkRm+FqG5h2q/+ASkW
         SMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073701; x=1792678501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39IRj5W28ImdxzeQ4C2An/kNWPrH3OS64mKDpHY/054=;
        b=Uaj9S/3c5+tw9ey6Qe0d2BCSwQrvhU+BUkwvSpl1xkXJGnNYCVHqMpKMQsjACbjPIO
         sMWas9/seFxTBMQIUCQlPNxbkYfaEvJ5eJJ/1/So/yxuww7mXzQRDD/cXmVGxgSSogdY
         Fc//Jo6dFYapa0+5uwFeZm9nH/2WUDgJRP3gvtHrHVL37eRmq6/Bz9v7pR5MW9fSjCe2
         KPB7lpoRV8eS5uxP4RU2JJx8gVxJ0qKUDfIA4YimWXaTINwcZ4P+bucctbtTGrzoMnuz
         pWBrpWv+g3lOAk+2TDPoQCY9Y7xLrhv9yRNIMXn7n8B/wDY2qOT7uPc4sZj1/TZu+PAf
         xEpA==
X-Gm-Message-State: AFq9FYL+jBmKc9LaWWJLuwFZ79tBjxyGcn4U8rWMAflZf43pOV+eLecE
	H6i6N5B64PZiGqkOZNcb2SJMvOSrgjsHW8E3mSQRhS8cesmMZfXm0AP4bAoifX+I06LRYgrTP8u
	VmljVG1Zyh2POSrzz1TEXkajhXiAUDlUwRY2/dyk=
X-Gm-Gg: AYBFou3mTf+HcjuOUCfLLrn4Cm0qJXyAIG7W/BzTRZK/+OfPgyShx3gNHvN3d0YNRck
	7I20+hfl8V55wLEhgSYtqBN7hCqcw8R9ygf7EsaO8lct06rGwQo9q6N3+og8+qxIw1a1nN/KOdN
	W7Vg2ZaYAoV4dcJXdN3n5y7RCSZH2dEK0GNsd6cD2BpPWnRkOmxtcwUjCP2dmI+RS+nLOTGvJQG
	LhVrEt/epp+4C1Gl1XwQvGBRKDHVV/1btL1LTmBGHikD16kAozc0xZ61hRguhQEFoTogtY6Omj8
	6jB+7ViKHAYBhtsUToZq4K8h1+C5XDPQwHaur2lr7sOwWz30SQzpAko=
X-Received: by 2002:a05:690e:4801:b0:677:bdd7:d31c with SMTP id
 956f58d0204a3-6793602f671mr3414970d50.33.1792073700880; Thu, 15 Oct 2026
 07:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054932.845406-1-omosnacek@gmail.com> <20261015054932.845406-5-omosnacek@gmail.com>
In-Reply-To: <20261015054932.845406-5-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:14:49 -0400
X-Gm-Features: AclHuK9LssssXEmmWqBRSuPXWrcZ6pyt4fH9LEat34Jmv-eUhQ5_c-pXutF06y8
Message-ID: <CAEjxPJ4Dy4_T6Cso1qzJSTErn3TTkzyy4mqSMWcVab2=0LRKNw@mail.gmail.com>
Subject: Re: [PATCH testsuite 4/4] tmt,ci: add a mutli-arch compile test
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:49=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> Test that the testsuite builds on all architectures supported by Fedora
> in a mock chroot. The test runs on an x86_64 machine, with x86_64 build
> ran natively, while transparent QEMU emulation is used for the other
> arches (that is slow, but better than having no coverage).
>
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

typo in the subject (mutli->multi) but otherwise:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
