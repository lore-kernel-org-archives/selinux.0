Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C0471246
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936541; cv=pass; b=cFdlkvELuI9ELFRuZxConyenr28Qa2E6YF/YeVhkkIlUgRrgAa9q1lzMCtT1agJtpf7SbpM3njaogF4GmVDhUz+6Y58htbJMrrxYzX6vMkM9oZIUBLvS0/Crog3c15CjGv45PxkQ7ACFn00MJjTvjgGjOLsVJKv/32oTGnuLHf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936541; c=relaxed/simple;
	bh=rBEiQYNtlWAbASkfr2oM33NKsnG1UhLlle5jE60A5fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhEP6QWym6rb+E3fnOwCEumT6Z/mRdm6ahsBdtn4xMP4C3RkF7cv4w/Xv+FPbmct3XD424pSYYRDNT/72wxf28TZztqUc4vDxJVBbJhZxwqO9jXmCYx+d2tFKYkmjWkKfCSVGmScKhNkfoHFCAAEVl1QNsub4G9CBgtOmJseg6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXX4XGmK; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXX4XGmK"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-44cf70de986so389969fac.0
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 06:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785936539; cv=none;
        d=google.com; s=arc-20260327;
        b=DwjnzBs8dtUxPd/KAZgnP3ZzHm3MVQqWC1Hc+CUMqD+eRx71WmnD+NB4X6ivzBXdyd
         fk264oSCnND1h8c3UCGtKPUzAz70KSOndFTAbKyHDhU0453kox2HvxUwc4ef3gFIwZmp
         uxHL84uvFBhhWEThEcFTdMHqJMHeb+WkZAobjQ+WFu7eTfor/K8V5NG3wsWZ/ztIBgvy
         n1IFWc4qm99gydMym42OISsDxftoIig8vmW8Ed4FqGMd+zR/L1v1Y7Nshrp4ySTwApSU
         GQY4dxXvNFKlyws8r7tO3jGH17NTtF9lJSvHrkFuxnlOFJmU+I8p6dMEJcfmutVBx14m
         RTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rBEiQYNtlWAbASkfr2oM33NKsnG1UhLlle5jE60A5fQ=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=gB4wx80nNwgcc9VqxnMCfyhTHDw4ogNsxVm1g1mxQ0XO3XbZS+CPO4GDQNpzAKS0AN
         YaTKaVFtBCB3sZWfcTTmlN3Wjmp2EFi2by5LPc+w4xIVPqdoaauQBMk4vCk7cFGwuPfM
         5q0Y1yKQnsTU+HbYf1VRcDEnqDi9ryM1gc9bgTLyKk1oeSAY8rIwDFa8kX8gyxDvSu+i
         u/fv7DvFNpHLxJq/s5EFe7ViaPn9G+Nlj1GHEEHqyJJ9XZVWIqQTq46OZAVEZhTMYGoi
         zMkUcP3NCOJX9VMgMsMrOMBkab2pTmnGRQM0UN5veGe8t2/t6LBYBEuel4DB9cT7GpRb
         ryyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785936539; x=1786541339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rBEiQYNtlWAbASkfr2oM33NKsnG1UhLlle5jE60A5fQ=;
        b=oXX4XGmKNvAGsJ6BpJwEf8gDWScvmjXL0l3iZBWehDKeB50u3nibJLUUx4GuHJ+tmN
         wLVP1/0H8PQ7Mb2DcISqZSNjtouixt3gND/ZHdkSJ26o9EpG3BrDagDJ73rI5C2XtWHj
         otd4vf+68uXVA2fLeA09zbGZlZdv9XgE9TAsnHuHMd+Km5SoOOmDzaZEnm6VqZGeDq0x
         HFqkwdkyesTTmMjKui4Y9P77A4lPb/3YkU90iWUde/IFfzGTJCV0RnD1LZyvsTrj8ODz
         1SkjMjxr8blrzrtWuUgYLvb9MS11z/JGI3fI6DrnfLwFObQmCVhCsNBHIXJZiGKR6wUm
         btdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785936539; x=1786541339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBEiQYNtlWAbASkfr2oM33NKsnG1UhLlle5jE60A5fQ=;
        b=XtGIKU8vHQpgzfPao02oaVvS7wpcN0u3LHt1sIXzAjeoU6Su45kEqcEj7iRroI2lSe
         GXn/UzTKayq7aFq8ceQ+ddCVp+XY2HHzp+Mq1NCP/BKCdDJyZo5dUNKQ8npPf1D2Cl8/
         pYVx2l4xWn/oHxnc25fPZaStK+6Rke3L35AGNhyvnO4jwF5djxN5LhlioH01/WdbPz9G
         +jer9clLV1dj23HF3uxEx8ILRC2pNr80CJrfVEIK5LZGMc6aupS0vRByyRKhYPr6oDuk
         QgJjGDIr89mwBTrY/bzFrTmmLyyLRhOnrxB4SoDwfx8b9c8gdcRLLRE8uezanWAPp3zb
         Ztnw==
X-Gm-Message-State: AOJu0YzkaEywp7l6MfUC8sGbUFoHc8dzi/oGUhFI+RP3F95/yJk/K73l
	i+XImm/EN0EnXo8l1HfUHXEaqLDAx1Q6o4EmsAKX0JjxR5kSYbu/KPAFDp0Z1AWf11EjaRGms1a
	cjL4X5bIvrc+ZcUm9Rc7WathNxoIiD/CWUQ==
X-Gm-Gg: AR+sD12epk9opVvpaQg1DMJibGRpKfgaaHyqVWHbyX2DoETrnZXbmqmdgzEoaDDHR+k
	9P+JB4/P+bh7FlA0s/SJNM1iMdYlog/ZI1vMxbx/WBTVuyyYqynApXntcfo634T/FaLp9RxHT5j
	lv3Gd10kfvKOZiVRcxNRVqrcHMLpdh5110DJqr86nFQBiZdz9IXiOtWKhmQuTGNYBmD5Ytmv38M
	nIPEvV+0vnvPbPaGmAgLZi6g7hRAWUkaHz6p/qb/xFiX+T7RHudk3Y8lEh0pZj4eo1tJp2Q8phE
	AGzKgeyIBx8RcXZBJT2PZXvTSUsShiA0UOaUO82J1B7N
X-Received: by 2002:a05:6871:646:b0:43d:8b5:933c with SMTP id
 586e51a60fabf-4599ec95e92mr3295989fac.8.1785936538812; Wed, 05 Aug 2026
 06:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805110714.17403-1-omosnace@redhat.com>
In-Reply-To: <20260805110714.17403-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 5 Aug 2026 09:28:48 -0400
X-Gm-Features: AUfX_mzYHwUf8nRRPwnKvFv7lB8zhevk_plecTiKFDgRuD56Cpmxz851sWyG4RA
Message-ID: <CAEjxPJ7wZcydOM1RWAYinmQ_AgJLg+75U0ZSFnGwHNtc_5ZORg@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/io_uring/iouring.c: bump
 RLIMIT_MEMLOCK up to hard limit
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:21=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> Test domains may get their soft resource limits lowered on transition
> due to the typically denied rlimitinh permission. However, the resulting
> RLIMIT_MEMLOCK limit may not be enough to run the io_uring test program
> in some cases (low init task's limit + large page size, for example).
> Ensure that io_uring tests can run successfully in such environments as
> well by bumping the soft limit to the hard limit (which should be
> sufficient everywhere) in iouring.c.
>
> The issue can be observed for example on CentOS Stream 9 on aarch64 or
> ppc64le.
>
> Fixes: 3b4e44eb3243 ("Add tests for io_uring")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
