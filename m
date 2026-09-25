Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72EA433051
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362278; cv=pass; b=LtmzcNpcX0j9oc3/YDppxNqFLOQGaaJ0hw95pex1TbowrEJykdbWlHKOAc6eQT2vCNDX4CH6Vu8SzSDmhSaDT7dzXv8rgFbdUTHJmtpezff9sMw+mT+M4ootuqmVSOTyrKP0IbuLQMO+ZKLcO/6+5cVxBkivWbshNK95+DocFmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362278; c=relaxed/simple;
	bh=VXijItP7Lo6/mPeO8DOFNe8Qz45ht55hj4IQ6f3lr1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKZpaT8+tnCdgoPJJ2AKqeckC3lSXK5FF+v1+PrAukQAc1sgsG65TWG4vXZ9J81FsBHzmo9fbdwjB4Dol9k5Xzk6JFCpPtn/9a/S29vE5YXRlifRLUbaeEcpx70vxJ4EyGjRln+YkoPApHBA2kRw1ne/YJdQvo4eXRF3r8SRMw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8ZL1sEf; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8ZL1sEf"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a886df36f6so4782407b3.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 11:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790362276; cv=none;
        d=google.com; s=arc-20260327;
        b=Mj99DS6R9KPvX/7+UThTsi9m1gfr2QuUsqvKsMyBNUt/qEW5aaqbmQn6QmyvUcIFbN
         EKHSAACqd96Vo7rlgZehRoBlYovbwWEPZK95QQStcqL39NJsJDGKaXvAnXD6Zk8S9HMt
         SSxZriVJRHQs84DadSL7Ov2jfn312uUiArXLQZDNI6YE0PE+nFUJn0Oge8jSdFuGM9z7
         uRbnPuxvlqCazYkhfKaCFQicZdKLKzJYnS9lOfQKW9O3coPHPiETflkZA12Uebp/JrxR
         qGAcPy+9vEMprZSuLSFPHkNzo78x+hxIddZXYxwTVVfJGKbh08GU2DUiiX82ipDmUMfn
         v+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fHWdPauVx3CjjcyTtL1/XhUHe6BQlkqlPYUOq1+lXMw=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=jT/xH9rMX+vxW1lSBsIPkHUCtBWLqfrc1no9ackF+OVA8FFeTIsYpcw1TZBprelmfx
         cOGP7LKhzEEvJ9T//hE+G3g/pkVR68jmXx5XcO4jHzlYxtkPzDyAQpTIfsbIn+QAQ+yO
         sb6NxArMGQcWPEMewXmEAwTi3x8NqsWnmB4Cs8emHccL2uQ55RndPV97tumGPHfQGXps
         zbu4A2gFZR7jND9VMiFwa1IEiloZ/Kh4UAlJWCIrEi9cHErbdDCSHjzhoJHrIhHdqJTu
         q1JyaPC++k/5QCXPklARPO1U6oLNPUfc3uBHe/ZjDikesVnepHIegsS78a0HfqBNJWUs
         jDJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790362276; x=1790967076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fHWdPauVx3CjjcyTtL1/XhUHe6BQlkqlPYUOq1+lXMw=;
        b=i8ZL1sEfKRMElM3wh9s/TJ0GRLubtkDNHHvMc/00EZICnWgziRpUOF3oywNGZNaEkE
         X2mEsH/V07nkaJ4AMM/Rz2lv1NH1BQ3jGSukJbu2Y0H+yCD41SrTQdHuYEe4NuYL/yG5
         FhqcsbKVKAd1Ig3I006DpLO/dVXirEo6oMLmrqpfgqF6+I7gqr9/mBx1HDUoIkCgGtj7
         IhCU5PNpXYiLGkSlJ1DLlaa8rLxX21H/eWf+/cyauRJ/5iUJZ7RVgBexnBWoLGQOcgV5
         u69qlQpZn5DF8xaXo4aDsaeA1e5HYZB3Sn1Yz90F5+rf+ehWICneE5Eftq8dia9h39xh
         p+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362276; x=1790967076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fHWdPauVx3CjjcyTtL1/XhUHe6BQlkqlPYUOq1+lXMw=;
        b=hliELBSWLjgXC7Pv1u2lVOMJs5uLUxgxpkT2RqXG0HL5IsAzoLfZvi6BUPZwNNkpNg
         nJHiBCZ1UWnt0A+XgGKdkgA19vV2gjZZL6SsDUqab/E31SLZRfMKYNDpTFfN1yaAl/9S
         KoPrsjl53gTC7ZRi1KEywECZ7h4ROEs+EZNunWok266PWWkqNZFtnftZMuhI8ANwmufV
         opc80J1iROFlCZv9NZGuA89rnf1p8sXES6RgbUAPEbnef0x6dcSb6Cnhg+oeOWszwhvK
         X4aLpyfLWH4YdhqwPw8TH2SBA8uwKJBcQrolXGxtCdIy/BXUhpkqjCbTrv1OtNEVIVoz
         slnA==
X-Gm-Message-State: AFuF++luBCCbn6ioFz/X/V7j8f3HL5aYR6QcsrOZrO5tRLH3mdhFZWxU
	kyGvS8vzxVDaNYgAdWkSM5XfnYpV7EX4ySSeu6i000WvxTfFY131NK7TJfccij8lvFBaCMgNMUP
	uj9GNpqY14vBqxK0hFd3M77u9IiKE0FgX4TU5
X-Gm-Gg: AYBFou1H7kxQSQz1FbNyOmbuClRmByE0cG7QQTfUfXGIx1BG7m94/c4RA8ypIZ2A/Mk
	1TTunR2UFAoJb1r2L8dXGJBaqXfqIESCsAVALA8RdG8e+QZsy2Jmkk9HtFMwBnsULwoqj3m/3GM
	qgmWyQ12CWLkI/WAcn1q4CpklZmPntkBPsJK+joZGO//ImUbWkwNK7GO7tWJvQpmKlv5bADrJU5
	mvRXcAf0/GFeU2JAC34piJTXuRN5ISDoRZ3SChveYC/+IPFsdcONt5KWzMdIz09sVGnVQNmj/RX
	bxE4cc7vmE8QksUNOkUvqCcsdYMGUfLRwQTNicdxcivhbWyFnX9v07A6gJpozRx9MQ==
X-Received: by 2002:a05:690c:c058:b0:8a8:1333:9925 with SMTP id
 00721157ae682-8a81333a845mr19217967b3.21.1790362275743; Fri, 25 Sep 2026
 11:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 14:51:05 -0400
X-Gm-Features: AclHuK8ygJAb8Jqk9gRzUe6bMco_5IZ4D_55vfhjjsaScs2KNjVHTEBeYWu09gs
Message-ID: <CAEjxPJ5yqPbfgu1bHpDh0mqPrn5gORfnOTsTVLQ=52PeQwg10A@mail.gmail.com>
Subject: Re: [PATCH 04/21] tests: skip module_load tests without a kernel
 build directory
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:18=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The module_load tests build kernel modules against
> /lib/modules/$(uname -r)/build.  If the headers for the running kernel
> are not installed, e.g. when testing a custom kernel, the build fails
> and aborts the whole testsuite.
>
> Skip the tests with a warning in that case, like other tests are skipped
> if their requirements are not met.  Check for the Makefile within the
> build directory, since distributions may ship the build symlink with the
> kernel image and only install its target with the kernel headers.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
