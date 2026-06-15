Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10529BDBB
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554144; cv=pass; b=Z91kdmj3es7gNU+scDIkmFqWUHqaCmLdRDWDVV23/qkdcLs7COyueejn5+DQf3NtOVtv3fUz9HtseAoHlRyO1Yb1STnmYvXW/kbwtiNxNAadfeCUrf5k2Q78v57X+EI9b36kNrOVYBzc22m9HuyNN5xEGG0r0s4XHnq47wgERCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554144; c=relaxed/simple;
	bh=rFM+BRmbVGQ7ieGf8L5E1ygl3UY3ZMxVz2a5G2jRSOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGmROoHgbs5Hk1aBgPnTJ73izHxNuyxnrxvnUQ+eMnKfMT99JloK1SvxH+LVvLybNdODZCtzjsB0+QjJOSvhO7Yr5DfMUrPD9Q7c4nuqoChsLNU711Z17oFkDcDAf3Ql5Ygyo1MUiw2YuMAusf9yo9AU8owG1vFQaMnTuC3PTOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AILVWAv0; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AILVWAv0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so2412321a91.3
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 13:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781554143; cv=none;
        d=google.com; s=arc-20240605;
        b=YC2kuEt71KaBIxGTj61oSgz4XJNGs0zD1OrQvLlNEvOmXXTQu8yDrU4hoIIQqnnDK3
         YEpVq7YBqGcj/it1qD3ToMHuhMdh9D/Cn2VjybNkIRKaakg16OmD+m77kwL8npXfpRHz
         de0oN0Qa9QWmyUCRPXoJB5mVW7sOyBcj1mN2qp7gPTVRrvg2ESNqKVi9R6MmZo7BiaGN
         fwudSOvoUSw8m6DlIcXNzV6y+OiABStC7WZ5kTmLEuzdEBqq08KX3nDhsQYfl4AMTrBP
         9MftSTGYxdaKb/Bgw6Efai8eF4yE/AVVmbu9vMRERaj4glNOWjHnSSbW3bk+ojFWFMds
         FhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AAy1uMkVTzQd9xqCiK78JZCMgO1+9BIBfeH9PEwSODo=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=gtihSOrlNIASWVou4gcBApCnsiedIFMfiFnNCp8Vwkiq3yUSIOFTgqTAzShNFLCs61
         SWgcofadlBAGwouAinsQ9f2wfoRxNJicWI4pcD8IkOa7FAae36FTmZrO9ROVg1m228JB
         Gk+wZLTMm7RNd+psoJ9Ql271rB7uNHCV7W4FNbOrpMTDUPXnFoi0xpijrCuXS/nVtl8W
         TC1oF2jG0q3Ume0UfeLVji/Gj6+gEF1nXFFKCwCgAwG4dS4nZTtlDGHyaxxfr+qPP5/G
         KRXKz25DBCXQm4eVogHFpLLY8sYjTTbvMBw8JDbhE2uMsbZt5IzevJIW1nHK+3Cnr6Gm
         RCRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781554143; x=1782158943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAy1uMkVTzQd9xqCiK78JZCMgO1+9BIBfeH9PEwSODo=;
        b=AILVWAv0xQw1NCG5DN1v2ekfVoC8st3uw1mV2hdawzQDsUrgX6rLoxtW9UeveUWhm0
         70cjclNBXFFkphk1Fs14ovV0836kfpXk5p2Ei4ok1ITtvZOUb+6/iTw55hVm732E3GkV
         gBg9tIyV3BudmJ8/dSmbi2HL96hBH5XXU+zoRA/7rU+A3dx1YMTzt4ntFxz6uyJ65rfq
         3cwuiLsaJ3KOXith5w/ImEIXQnHtOuaXWGkNLnglS6mwfh4n/Tvx8X6y9hMLdVFkD22w
         93A7i/rqI3FHHyBn1YRl1QlVvOzFqgA98dlmHOR1KdFBAz/Y/HCXF3ejLTl3NwKpSB3a
         I+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781554143; x=1782158943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AAy1uMkVTzQd9xqCiK78JZCMgO1+9BIBfeH9PEwSODo=;
        b=g4T2nqh1tT3ZSV2ssflINIFtPG3Euu2L741zochSArgIY3CeEbNSWPyLW2+HqBOjwx
         US/E8QWwdNyhQ4M8JNSeUnYMuQzJG058BHzcFExsnM3o9TsSWt984FgrQBgK3J0c3E5Z
         J4bZtnyZSftShDm0WiDdCtdhWJnMAVBmhv4/YwOqD84X5VM4xz6OF+FyRe4EmR8HRXtF
         uvFnEP0eJ/DcjYZSUj2bpZppdpzwY81dTbTy+Y4oX5bhnEMy6XbGV6w9RjcO+RkEXc/G
         q3Czk8X0GM9vo9yt+70c8qDyFo91saD9QNE4dvTPSIp2pr54Bn9yvf0z8W/nzIZY486C
         BuTA==
X-Gm-Message-State: AOJu0YzN5E6zpq2CErJkuJ4UbRigM2pYv61lvKWBcHmp+CIqbwHbRjyV
	DkPFFUSw5hPHqBNFAKdzI5eJn+hDyoBEHolYJ+LpVnPq9+YbRM9r6g5kCT7yA6any6m1rPjAwyc
	SHH2Mjb5NKF9C5FJsVEwMNjeWM0U7yev06A==
X-Gm-Gg: Acq92OFHc7mr76MgQrrMXj/usReQhgkb48VOWkho3v4o5MhjeipBCsRmRqqnlP3YJkR
	tfqxAdyJ+sIntZ3r8vFq3WOlkkltT0pBuwEP/Dwp8nloNSEhePIx0deca8bQFQuCwCWF98DalgA
	dDeqPq2GMCZy+fVqpPUHiZdDcq3sibpB+OykCtdmzscVIobSPeN0BOzh8AyS0jMTBpqc94jO4Eb
	BDfIn1+udvXzEzS8najG3rx/u7lqMdkfLTClnQgHCVTNky5UJNvaH+4r+xiTEWK1uRvDogwTsox
	fCJrHDpuW9iPCuNq7w==
X-Received: by 2002:a17:903:38c4:b0:2c0:c0fa:1659 with SMTP id
 d9443c01a7336-2c69a1be61cmr6777155ad.33.1781554142566; Mon, 15 Jun 2026
 13:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajBWRXiVfNj3T_Dl@AA-94-54-42-0F-E2>
In-Reply-To: <ajBWRXiVfNj3T_Dl@AA-94-54-42-0F-E2>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 16:08:51 -0400
X-Gm-Features: AVVi8Cc03OCCJ1dalL889p9LxG1Y65IoQ-7PFSWi3dJ_rrQab_gYG6DIHpsuPFI
Message-ID: <CAEjxPJ5yNn4qM70xb6csRENrLBEk=y+hHamGe6zc5ZXv1cdmsQ@mail.gmail.com>
Subject: Re: Should verify_shell() be in a library?
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 3:48=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Hello!
>
> While going through SELinux userspace sources, I found out
> that verify_shell() is defined as a static function for
> both newrole and seunshare. To avoid code duplication, should
> this function be in a library instead?
>
> Maybe in:
>
>   libselinux/src/selinux_internal.c
>   libselinux/src/selinux_internal.h

It would have to be exported by the shared library (i.e. added to
libselinux.map, not merely an internal symbol) in order to be usable
by those programs.
Since it isn't providing anything SELinux-specific, it doesn't belong
in libselinux.
It's simple enough that the duplication isn't significant.
