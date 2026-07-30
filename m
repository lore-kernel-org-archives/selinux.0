Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F2379ED6
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432083; cv=pass; b=ITgZxNm0ywnH2Ph+P9JUagpMp7VyhbpVUCCX4BCE+0XH6Xp07ihP/ogULXZKsXFuzG3NKNGF60koRTvpYXx5XgnY14YMlMew0dSLlW75A922kUDO44L7uVBcTs8xgQPhNYA1SMxX69jWpBjREkcmOK8J9GEsYrdCoYbZLizILeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432083; c=relaxed/simple;
	bh=Pu8Cb3BPUf12suxwSYdHqvLfvqjX1OyxxbVhsHL8MgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUJlJrKBY0+c2Pl0SFzRRLy+sFs3XtyFpFJD0uG2rqNMiYqrdy0l9VFN+RY4Qh1pRpJW+khxUXT0GLidGam5eNQo+iWzh8mu7hLeBNq4+pd3nZzEB+xytKdQBQQ73m83fcdtxL9+J5elZD/6p74ZmQwtl1AECiPemWcFMtNSfWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMBxscve; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMBxscve"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4518ad44e83so113205fac.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785432081; cv=none;
        d=google.com; s=arc-20260327;
        b=A96YVYUycTNlcxQHFiYV3ZWkb6A6zMrtfsOYPchw6K1V2gIZvqKFWK/3h3RPW/qgrk
         dZ/pE5H3pnD4MZ78XKWd+dH34O8RDjISq7u+BQ+DTqTJ+9dJeSzjs2w2/Q+01DFfp70g
         AdeuV0klSobQX7JH6HxsJ8XXVFdSfmg+F/8t5sn0aSU2d+GVLYYsEdVAwBtd2c7g5dkc
         UdabjUa2tqssR4ijqMsQqHIm6mDTJzfPEG3CqbZO8S5/2QbcV1v3nuMAbzt9g13mXM9V
         OjanzmJyAhktPplkrmBb7jpQVazi2ILfL3XgY9ZyjoUNNTMk3QhlaXXUpf1eDgCHBIRN
         XcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pu8Cb3BPUf12suxwSYdHqvLfvqjX1OyxxbVhsHL8MgE=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=R+xQSBsEd6Tjcc9ApNAh0Yl2eObGkZcYy9mRe7PANc5DGmLGfuiZaqWhgCfkHO0MBi
         H51m8CerMZSdnLDn2EL9Q0vHK3qiVPq9J2JY9MvkGiILc4cm2+mN6whWDSBOxJSR+LHQ
         N20Ghj2WVCsSqiDcPwuoWr8lwGFsKKVWRUkEgSPMwMZVABe2ygfamXsadBJfyu7zXtxs
         QYMs4jZxTmY6kherevJoRD5AS5vz2IvxRYcQ9azQI/8UMB7vFDl0hlk0821HJo/YhNdY
         XgBvBrjAQbSxMYj93f8b5ED55C4WwIA/JbTKF/76Rj8XoNWutizjzI4uCJIHRlutUCDw
         L/vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785432081; x=1786036881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pu8Cb3BPUf12suxwSYdHqvLfvqjX1OyxxbVhsHL8MgE=;
        b=MMBxscvee10h908lnKMkh1I7+YmgdoBBpr31NIJETcC7knNW5y3kHp3cygyRHIF/PT
         NvMHEXDmU7I3aU8A0lBdCMhQH77AXJwE9Xay5p0dUD78BSaaywCterbAkm8j9yEjEK8U
         Fxe8usQlE3gatGnT0RzMoF6i2WTallvrfNgCM+1ANPel+utHMlkSunXWSJJ5GEZr4CZj
         GaDnJnZ4VIrnssk7kIzJ77HShigxGDkOdVVNBx6ZccCsy3V27bg83cuoPdC+bBKXul1n
         T4O/S1D/xiARxG58p1lec/+oRiiD8bPc9S5BPTohqyP5ww/sYxU08D98FZ4cLAjM7eIK
         OB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432081; x=1786036881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pu8Cb3BPUf12suxwSYdHqvLfvqjX1OyxxbVhsHL8MgE=;
        b=n4AC7qjfwM9rwpby3JHCtyabvbYtdvW5Kqo0FpE5P/caDox3xNzA83e3smNsJb1Ny/
         tOhPItFYsUwovH1GShnfU5FZ4ammhsEG32sTWEcVjXs2G+ocqi3S4aQXsFez0otRcAFn
         57eeW26c3+CBTtl/Y5+pj/ni429OmVSnDNsiVNshB3TdRwbh9GszOwT02NsjrYqWI2tk
         6pN0xsZu62Xlygkvq/nh42O+IRLFjJ9jyaWvtJd4HJruxz+c4Sk/M2ntLaR4K5NpNXqy
         /WiB/V2/OEDDZZJOoka4LRHohGpxt8IGq4LANvN6XcsCyy1ENlFYkSiS8Ge+RXPBJvtv
         +WVA==
X-Gm-Message-State: AOJu0Yyp9xwffFTJLiTUwnN8H4qQOlMFpOnzCENrTr6zpRkdph0GYPUD
	+Q5q8NvzXLrxSgclEwlFj9Iw0cfoJFq60FljPIJzHEEZRhIuhsOVXaGQ9WmmJn3Zc6FU7Imyg9w
	6tv7/T7jJh7ngPuPEC1WfL+6L+Ro6kA4=
X-Gm-Gg: AR+sD131dkXHMroM6hQ2zPns+poNmzkmpiToNmPonIh3G6q2Kc2GXMoSlBIBDdM6lI6
	8hRLqBWEpOe+MOHW2ep4EbgOzr9lS4HC1a+BaCVxHXLezi8bew9741gvCxITg57rNJw5tGz2j2k
	+/W/Z2rZeRz4s3FIIv293upHgwcOE911F0TOznARciMsus8Nth5Evash8RUk3RYiVb3d77wGBQD
	rDQd6yHoWOz7ROBLkFShONld2L0irCr9uwtfLKucQmSUT1cgOH+gdTzcO7ZrvS85cU8fuzFTWrT
	R4OAF9hVV6p0PjTz556BpTwVGreQcQqMr2mTgqHQuI7TTJ6IaefgK1g=
X-Received: by 2002:a05:6870:8271:b0:448:9d5b:6393 with SMTP id
 586e51a60fabf-458c0dc6a14mr2557079fac.14.1785432081400; Thu, 30 Jul 2026
 10:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730124253.3282686-1-akkohli@redhat.com>
In-Reply-To: <20260730124253.3282686-1-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 13:21:10 -0400
X-Gm-Features: AUfX_myKRt9xtcr_phUDiMYOA87ce3ao8crouJe7__FeDdx66enhq1cKkRdzzJk
Message-ID: <CAEjxPJ5sSW3fqQWF_BZO1VDSAjPu_jWoHUwJCp4MbSY62kz1TQ@mail.gmail.com>
Subject: Re: [PATCH] semodule-utils: add bad-data tests for link/expand neverallow
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 9:04=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> wr=
ote:
>
> Add link/expand bad-data tests for neverallow and neverallowxperm
> enforcement at semodule_expand: cross-module base violations, same-module
> neverallow conflicts, and checkmodule deferral document tests.
>
> Adapt same-module neverallowxperm for libsepol 3.11 (enforced at expand)
> while still passing on older userspace where enforcement is deferred.
> Refactor link/expand helpers through run_link_expand().
>
> Add a cross-module require test: link rejects a consumer module when a
> required type is only declared in a separate provider module.
>
> Signed-off-by: Akhil Kohli <akkohli@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
