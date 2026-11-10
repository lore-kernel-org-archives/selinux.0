Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794309075;
	b=psxCA/Pz5WMRC8kLFYOt1FvYZu59Zw8WBdM9ni1pq3FjmiJhjzzbL07LMWtLznPYksv4
	 9CSjOlFR4O5TqSd+P4K1G3kCMHq4Lf1HKYshBrjMDCJAWwgghhNuEN9UZwkjgk6Cp9Vqz
	 gNUuWqoTwHxv6nr5HKgboNj5MNyfe2fr3rOjkVkzUTNk/bO6ml1KMez1cNRfvHOARvWPp
	 urm6IWCZ1oeMkZJL4yhnsLQEkqGuqK+SQxyDwjP7oKik3MzTymnSfgFnQ/2DEkslvHgtm
	 bEchvKnB4kizOB9VxOReOGOdpy6D58CTub5H5NPRqdiJTLZhkFBM+OXGoIM3/tRYQFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=v2Y69AZ4DfBzehDnc7cMThQ6uONNFd5ZHo6Kl6Q8Ta8=;
	b=ow1u5sKeQAMhfSA9aJS2IOoBvYURwJJTKQNZKZBOBykrgsBNfG63N6Fb+Kn6GFGpd4M0
	 Nnj+EPFZkxqNCC32fJv9mmStPMMS0hftBD8Ip1uC2Upn7oeTcycBEumRHRtk3scr6ni4s
	 auBBPOkZT2cmXVu3n2LjpPoWbQ9838LtqhhsWO26S+11s4+aAMAU2UMmgRMjPFGaimsbj
	 l0NxzK6jVzbAYy6fGzruev4TMB+/tQVNJLOt4S/VtB5wbsFDtWzjri52m6XOKOSbUyEec
	 JmFZOADr0+0aZb4HJVCLV0czj02USmpOMAxah+NmATH3+9/AEpM91dR2Y2NV1CdkuSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=WLp4eZqq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76C606A31C
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 11:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB76C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=WLp4eZqq
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-497614c95f0so904281f8f.1
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 03:11:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794309073; cv=none;
        d=google.com; s=arc-20260327;
        b=k3fPoIBGvb7NwC4esuF57lCV0QjrncpputBGu2jJ7FcSs6Qtgb6CVyD+f8IJfHsKAi
         GHEgIogoPDA2sG0HKvbdtY9ON9mPknRgVLzyWfuI8Yy5+NypAqNw9z2D3Q/0JVjC3MZI
         uE8HOTC/sxNdU8nb/edrtzExCnQzTy+FPhjy+QkOK0/03KjqY9Ykw/koL+4mmtcOt7GT
         2dRI0EfywWLz71eCoOGY0Uf115SMFWUFOAm6cN66kSrca9fOeTSgmVNrtiisH6qh0ZgI
         Ns5nTJEUoDgeHw5shNjOPDkngSJxdkdCB21xl5OsPhyY/1eq7o0O2bJry4tqfAZ7pe4W
         8ltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v2Y69AZ4DfBzehDnc7cMThQ6uONNFd5ZHo6Kl6Q8Ta8=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=dgNh5xlSpzjs/PnKTu5hy6dkRNt9f8fVB0kXdIcsxWcgtjVqKJzjNy47U0r1lWK2E2
         nJw82NaCCmki1NiTV0Z2S4plFnnJJr7kbVUNvtnjp0fekPPE06i+ZFgrON0xxPesqAx8
         rBkmEws1uROZiT8APJGNZqEaXEl2w69nGtHPj/JO4EwF8/EPt6J1YDXF4J0ah+JAa5ez
         +qDbWot2QigI2sqYcxNVJc+ENcSr2ZFiA32iwjJJXFWAE4QCwNPvELG+7ZfiC8wJ0l5q
         7oEGMNGGNtlQsLudhtiqaxjbmRfKjnth9OBU1TuFhLj6Iqi8xWJebe+ba1hW4MOQOKwm
         A2iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794309073; x=1794913873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v2Y69AZ4DfBzehDnc7cMThQ6uONNFd5ZHo6Kl6Q8Ta8=;
        b=WLp4eZqqz401G1npaSBV6hSncVyP/uQO0LS8Alrh7fH1/5qec+5eYkijPENWeiIFGs
         FuU+Oe2Z0DMd2yZW597+hGGrMQotbGpVcugufunggmfuGKeuU42s2bpFsOVgb++JrUXi
         pnALAMU5KnG7I4RgKaiA7mHXLZQhFa1o/21cBJStprjqV9XtFa1dab4w4+CyPlVFU7xW
         qopMRhOhiElP9/a1/m8UjQW0tsrrPXnCqkAoVpGp9TXs+GZrTc3upxa+rJt/ljYREnQw
         pVA1x29Xhsw/SrqSPoxQefKOWyUVE1mo412yfn/43yAtqc7alSyws0OX1wobZtSv/Dte
         91yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309073; x=1794913873;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2Y69AZ4DfBzehDnc7cMThQ6uONNFd5ZHo6Kl6Q8Ta8=;
        b=OrvLcqxcHKzsljBfRpx0cspddak96pvNhH9FVyJQNqq3z8ugjoGAE1/gAtJ3qRqy3M
         36AfeeniBNSo2YCTGWocT2kEBukJqrI/xuMyF1MJkXCuxQhQnEnstiulMq1qLsNPXW6v
         xnXoEk2qYvTbSVs3ivoip0Xvx5nMGLBrtEBf6jQyDFFdTy3HBhWXp9OW439KkFrLTbdN
         cYu9cakEhiE6R1sbDXjKynuF7cYC1Ww4Bisrhi7wlgyNzoHHFYQ+/RMu6udFj0eHfZVC
         4vg8O1WKJ//FsrBcEL6iXqP/ep3xyUSZPUgYeV00GFs0kMswNeoK2+NMRlnvnHuj71Er
         zmZw==
X-Gm-Message-State: APuU4Z+8JjCnHp2ErPa9Mk6sCpTJENB+xMBKUxSLvCeyKWTi95e2w/r/
	/tM6rv3LRWaA3k036q7v7WSTnETdMyM9O8YvqvRZ+BVOeG7BDzjBbIfyFRK/0+056M7WqUr/saX
	RFveM4VwhiMVyF/n/L3NJxYhanY9VMtM=
X-Gm-Gg: AYBFou2Vi+Gk4u7RBNgRMtabA8Duq7hoXsbKMWW8yqudei1t/xD4h9u1uWMK315QtHw
	+8Rqx75jLsUDRcZRBxCseNd9qql1vhZYIe+memJT8m6PMLuMq2uroWzP9+VXAVi1XJNwRnPFm12
	JEYomysXWEW8KywHIyiIjtRV5IzJ9+k0qDyG4h8opJaHNhaF00+il5hFwnmRuL+jEP9WNADIFyE
	kh3/gt9e7pTrq+Ikq4x3eoIT5IAhYtB43PD4cR4YfWeguLnb2vX+TAceG2s/EvT9+6h9g86TDNy
	+5ME/DK9gVnU62agJQNTkrwoKWXxNLiT07bGsQypzWiNk4qRfnpmLIg5brUNg28udUb7nuW+Pd1
	HC2SqoRbcVa0JxzOJ1TtZIHyGNNh1sAXtnf4i5BCMIZYzWLaaRr4=
X-Received: by 2002:a05:6000:230f:b0:48d:f7f9:6a29 with SMTP id
 ffacd0b85a97d-4982fb52467mr4122686f8f.20.1794309072754; Tue, 10 Nov 2026
 03:11:12 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110105906.58509-1-cgoettsche@seltendoof.de>
In-Reply-To: <20261110105906.58509-1-cgoettsche@seltendoof.de>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 10 Nov 2026 12:11:01 +0100
X-Gm-Features: AclHuK9Zd-ig1ws9j9rDovJiUNnGbeaVoQ0Y3N890IvSuOjBgNiZIXEm75n4-Co
Message-ID: <CAJ2a_Dd0KGEaPnGRhdMqLvMJB8eo+-_4BoAneW5CoixvT5CtAg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: avoid quadratic removal of redundant
 conditional rules
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026 at 11:59, Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> optimize_cond_avtab() collects the redundant conditional rules in a list
> and then, for every entry of the conditional avtab, scans that list
> linearly to check whether the entry is to be deleted. The cost is the
> product of both sizes; on a modular Reference Policy build this single
> loop accounted for about 12% of the runtime of `semodule -B`.
>
> Sort the addresses of the nodes to delete once and look up each avtab
> entry with bsearch(3). Addresses are stored as uintptr_t, so no pointer
> to a freed node is read after its deletion. Should the allocation fail,
> fall back to the previous linear scan, so the function stays infallible
> and policydb_optimize() keeps its behavior.
>
> Also free the list entries left over after the scan, which were leaked
> before if a collected node was not found in the table.
>
> The resulting policy is unchanged.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Please disregard this patch, send by accident.
