Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B2440653
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362176; cv=pass; b=nkl97FDBVCivoIlOrKE9RirvJl1gyBpM3gTzbbIK+mMj8SvVk6GojDN+LemcNGeOGtC7pFThjSgZRW2uUjnBx3IMn4uADEi/QWL/fhQJd6wDr+0II2wHQceoJ1iW4AezwjIMrIlku+JKTfa0ZOjDQ/dHxz2UR7/lK2AhQ+nTo9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362176; c=relaxed/simple;
	bh=dm6PdSkj4d5BFntkm9+1UXyBPzcBMSh5qz0p/3xyt3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I49qffDosMeNaeHFRgQqK9WHnKTNomz65TvYF8YzCffXmKqLMKfZv6uns/Bv4nQS0eXK9d3avN0bjO1N8le97LwnZM570PT1LeVTaoGbnFeBamrXUGve+8xS8fV5KyOG5RSHBUd8TNuqtOjwYByk3jeO8+spLUgZ/icq3FKYl2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWW5fTcB; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWW5fTcB"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505824so10758657b3.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 11:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790362172; cv=none;
        d=google.com; s=arc-20260327;
        b=ALvbeSNVZpoZt9qikIeIBgk0kVz2aJzca7cEPX4vL+qFoy8bcYGbiNgrEDAiqBXSK2
         Q1KxDjadJA0Tz4LZ0adqIPW/RWoF0aHsrlnTDHTNDqVtMm/ZrIZBD6Vwd5ma2wHEaAdJ
         X4t/iIObKLhSh1ouoGkqAIij6MIoJk0nsGd0+/ofJwkLInlR8qin1HZFLKkb2eMGvaJb
         kJrSrmyhd7PAASlT7QS7WhFdwqxOqyGSsIYMRazEq1rHBZNJZONeShkU79PK0tftflkF
         zk3zQRbz1SnAfqwPQ28f3HWEHxCpvxWDVk+BgRhExjJgngxsqyoBqJLFkKGx+0ME7B7/
         R1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=18EPEASEUoeNw2Sh7dtgk/H1WNYJ5FXXN9vbVt+YPFY=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=LC7FPkyr9+jyruTBbYD1MakNn3z6auIvb51pSvsOjynnP0PRlw10+SCYZDMYXZ7fRv
         xPEv10EEa2xORb/3Xzrlic5a0wMSucL8SNmnlJaRM4jevqUfJaq9SezCW/E2qxLeYN40
         0p+7l7njXB83YD3bVedNlqk5fT8n2JwpM1D74AhCg7hOujUUH5o99Gp1Ut/yrfSREt91
         2Axi/3rSk56xDmN7RbezgmT2xRg2YwSKAFtp+s0LuSFxfOPXeLw6m3bqBjijvQ4dzld4
         sbYJpEYuoKwmFecMo9xKhsieeRr4nWecYPQQffRvDsnSGMqGE9y4I8dGyu6kiObkd9nk
         Xe5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790362172; x=1790966972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=18EPEASEUoeNw2Sh7dtgk/H1WNYJ5FXXN9vbVt+YPFY=;
        b=ZWW5fTcBbL5KaE1VAJCEZSgtTFGsuWmk9x22jyjckpQxdsc+Q2Du+pc1oTn0QT8xAz
         eAhhRG93qKxSYmoiRWIDgU0TYq8rgocAHlfICrLSP8+X+usU1u9acmrdOls7lEW1PaMk
         6Ca+ReT5E3FAStxCA1oIArDt/W0awJQq6ht5KgCPJEUy6ynN0vGkpEohTvqV7SrYHE2z
         PswGXi64Pe3gdCpRBXRFpBoNc1aq/gfCSoYZ86gQf5NvOvyNSlNwJcj3BKOSWVZOWHTW
         fQPo9MgAGT/j+B7kOb1wGYXRGapC7eJRIMPfDiOYD2Lihu5zSklFSkbWb0feXEddAQ8H
         HFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362172; x=1790966972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=18EPEASEUoeNw2Sh7dtgk/H1WNYJ5FXXN9vbVt+YPFY=;
        b=sKkq6+Zf3qzDnBRzY3uBi3dW+875oojIethUDfZtzLl8P+kczMUZCMPMq7MI4fbdAD
         Ln8YcHxLcl/mhj8qF6uT1Ju88l6scLuZjL4QYP1QgoxjYk4p7VgyWjn1k6Ywzw87fN7i
         EuR3Wot5kvHn4tPj9RhfIKPNx2sT1jB7F4GLqFNFP4i0xSKysYelUekS9Ed0ezqn4cQR
         Rn6/f0Yw354VtWZkf93s5YIbjyXn8bAvWRxiqJYIpwnU14vzRh/nUp6lVd106BKvYBoC
         j5PAiSUA+J5F+4LtDGycC3rPd81BB/ot8mWkzc/FLbuJksO1F/Tpkpdbl32GDKuORx5D
         13Hg==
X-Gm-Message-State: AFuF++mOeGpV5mzKjbVjYgeFkDx53jC6IyxDGP1U7QAEEAhD+2Il/QO9
	O/uO0kJ8kfPzMY6/wmUbs3d0jS6CORAbg9Pnatwe305HEpeKXlg0FwiTPjQnNCc6sigmC84+ZB2
	71A5NSuV71i5t4OTLZEl+NCYaRUhB+dQ=
X-Gm-Gg: AYBFou3t80vsPIss4PXpxfKnydQhFb/WhkcBV1TxcdrtQPqy5G8l9zLlM84gYlPi6Dx
	wx+bMfO01R2v5fP1dtAU0/ueNRcaIjzliVQv0EpGM34afa0vceBCcW46pYedfbD0RtMSMm8Hw+w
	tfvPPrnsoUKc8UCUU451102RUXeS/z9f9FztGkC1A7su6dy/YiGrBN9yMtkBJgcOIH1zKLzoMDF
	wi1aDpriWpbGHdeZblDqWIr34i7JBRln4qZiJ9QMIp7hQhR96oGqEzfEfB50IIcfpXtsQ4I107+
	J931JIQ3T/kSxWiqrb222mnZTYqzJBh9Y0X1Ih1LBdoLM49Sb4pOk+A=
X-Received: by 2002:a05:690c:a582:b0:87e:2480:df7e with SMTP id
 00721157ae682-8a64c3519e3mr24249697b3.49.1790362171714; Fri, 25 Sep 2026
 11:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 14:49:19 -0400
X-Gm-Features: AclHuK-iN3gYl6E7qhWaZTF7LDC5pShA5HH-RT8psabb5fdahglE_H5FgpKrsFA
Message-ID: <CAEjxPJ5oAD0NJFsL5XaZZktM8xsnkt71T=j9fmVXB_qsRkLnYg@mail.gmail.com>
Subject: Re: [PATCH 03/21] policy/test_cap_userns.te: allow searching /proc/sys/kernel
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:20=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> With Reference Policy, the checkpoint_restore test in cap_userns fails,
> because test_cap2_userns_t cannot reach /proc/sys/kernel/ns_last_pid:
>
>   avc:  denied  { search } for  comm=3Dsh name=3Dkernel dev=3D"proc"
>     scontext=3Dunconfined_u:unconfined_r:test_cap2_userns_t:s0-s0:c0.c102=
3
>     tcontext=3Dsystem_u:object_r:sysctl_kernel_t:s0 tclass=3Ddir
>
> Reference Policy's kernel_rw_kernel_ns_lastpid_sysctl() only allows
> searching proc_t and sysctl_t, but not the sysctl_kernel_t directory
> containing the file.  Also allow reading the kernel sysctls, which
> includes searching that directory.

Isn't that a bug in refpolicy that should be fixed?

>
> Fixes: f24939e ("Add tests for checkpoint_restore in cap2_userns")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Otherwise,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
