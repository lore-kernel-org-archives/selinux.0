Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35C3A6B98
	for <selinux@vger.kernel.org>; Fri, 13 Mar 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413089; cv=pass; b=CS8CxN+0oTurDVhAFPKEyiz/CFNkRABP9pQgaYTNSEblFJmFpgmRiRQJ5P1sRdt4Pca5z3LhFNv8y0ZN74PZTPBIHZUfwRntGC8ESmrtOgBGkrgZkIPJwoPohUT1Lds7PLixBA8wevwBdCyY6UP8yhY9EgsmAenftjeomTwLbM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413089; c=relaxed/simple;
	bh=j6rn98kjyMKEoMTPmohJWrQzoYXXwcQ+CFgE6/0HVwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uw/r6jWInthW5XOIJzqhrAyr1/z+UrlHS63wvfShPA+suFNeMcV6SonBxS3lTi3Xz/DyUBJvhPp4uYne2cNnJpQJpA5YGa+gbVNZ1kT0zW75GJJpJf4yXLWG0cfwKS+53ybwP80JEwq1zLELgrcLGwjqjylaTH5f0cDvWKo0YZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNuPvLYc; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNuPvLYc"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so1390935a91.0
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2026 07:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773413087; cv=none;
        d=google.com; s=arc-20240605;
        b=Gv/7qnRa4j4HJChL1n6u4shNWKwogGVYm7sUhb+IZniXrpWYpcel7kfkFT5o4S1pqQ
         HXBc7/Ma6tU2GOUR/uGTH/XcQpg5KCXHuEn4uFwWzuJBhFPSBfwcOa0+IltsNkqKqGGM
         J0drlTNC2/ur0g0+HhqUevhT7U1EFmnnzTJxpxCAxna6FDRkR8j+Vg3BrJuzXLzRI4Z8
         DuxDdI53UzpIYSKAYxwfunS+F3fpQEItmi10h9AEtsEGzeRuDH95Tw31va8xY/8pFySk
         jojCmEXauiukmhlE75wRJR7csa6KK9F4ZY4d6UEBuyeJIWhu0SFKr0WDgJt2/9IeCnwp
         EtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tpq7oUCn9PkQZKnj5seTOklv0xwcVVh6U6qddgtu5Nk=;
        fh=sXdb0gVTfuKVJKSNaJAL9xou5sEp9/jgLUGUq4udpdc=;
        b=HWaAkXV0J3LAyzxKZuXUWKGKyJg7Cgc+237YS/lDCo2wen3n5uaFt/1DfN70wyas3H
         YpbhjOmNyRcp/+x6Aw8hk63yz7JXljEHYEkz2ZmpMrVzR8yZFD+0usF7dWlKDjcuc1Ok
         LLZmWWMf+JnlprUaaB8s+YVqo/mp1xyRvmce4A+5UTnwsaVCrWpJBw8NLS8UTGk+toof
         zn5FyfWgMEuKfksul3X24tC+KNLKlhJwsNqnS7PdUH6sGyCCuyKTTa4ldWZZIDSZGdsN
         QuKwLxTU5p7ocJvclK2ItADy+dhg2z2en9hWySPbUwwIQB7ikyKQ4Y7lmUQNpWrwqFpI
         QOXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773413087; x=1774017887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpq7oUCn9PkQZKnj5seTOklv0xwcVVh6U6qddgtu5Nk=;
        b=KNuPvLYccLaulSFEEcMg4XOcrzI25OnqxWtxwXOtP1zycZi7V2coieX1a/rVKJJFdW
         oXm8VQ+ys+oGa0/1Usj2sgtLqmjNkTWOromSUgq9ayWuwlbXKH6YCta38/hFbSibTkEz
         n4/AgDXzsbx1Owglr7WX5WWw7MgRcKiFiMXa0/YTknLEiejYM87snlzSflAQAM3SX2sM
         4nc3ZxHZyFhxLYQdfoT6u66FJdnuR+3w5M/WcaWkk6CtX2d4hYMJ02/fmx2aHSr+iTWt
         WonZ7h0n0jwS0lM+8rQYNYJblSpapn61TeYAC820nDWaZ9rLkTwViCCef8sFKa+J3o+6
         Irrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413087; x=1774017887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tpq7oUCn9PkQZKnj5seTOklv0xwcVVh6U6qddgtu5Nk=;
        b=UvUnzTWrUgjF71j5bljBj+N7qpW2ncYS4bb+cY8bg7W/DLDYozPQaweBH8TPKsKkYu
         vRoMJu49Utrc79bwn5qw38T5hyLpYiABV3NIlqeFEyXDbRORrhmpfDZjr95qpcd/tT72
         3iVnbsGlDstnrEnub60nJFWaEZnOZWEQKA7SsKxpmOYzVBFwEiL9ozmHJ36GpqOrJksY
         HuspTb6yE1dyZpIxqzgP3GiFOjEyTEsvFZHOlI0hUbYtxsAvVRVpfQNbSHzSaRl6Zu43
         TQJQlz+hbT9En1hpDvuKt6e+MX8lg4tX2Im46IkDr/2wtol+dsJzn7423DWlL6cqt9Y3
         5utQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuOho9jcZSsKnCtpdX4xd/9JzJJoEVIdwnZ4r9OPpvutrWk4G7t8w+9qE5IvR9LsLKg2kxwf6O@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHR3Zr1SiKJiTZxQfrlbRsXtU7Htfkdr/VSLbvwvHHU523Eor
	EjO7WS/K3OHquTLVz/hxEMgzyFIr53rzJkc0tgfl6U5HXdGxeJYZDy+WbNmioGy2yrIrYr1K0Ct
	zMUx9auDS3do14WZ5zoAtecDZzil232A=
X-Gm-Gg: ATEYQzwjKAIF2KjD/XQ1TJf43XIs4jQ7gJbtAkBfuWtw1s66XymK6OqikmW/b7RoSaJ
	fZz5pPWSaftdlBmfidWH6eoeCCKJQQRGDtVnjKrgBewM7KxcXsLz681R7DOwNoypB22ML7vDOaP
	gB+xNMiypvuLp7xNFTg7pFGV0kPx1iIJHmEVd+4b61ACQ4yBI6oS5VY7HrewgKSB5PR4jnDKUeS
	WJwbYDr6LF2V8ABP6rGqC23f521akKKZ1Z3eO9Q2aKYchmovzrVj9Xp0WtqXgaf3GRm4Gsea8iS
	1LSPLWs=
X-Received: by 2002:a17:90b:3d0f:b0:358:f0d0:1a19 with SMTP id
 98e67ed59e1d1-35a21f075c7mr3475756a91.12.1773413087136; Fri, 13 Mar 2026
 07:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313061235.9552-1-marwanmhks@gmail.com>
In-Reply-To: <20260313061235.9552-1-marwanmhks@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Mar 2026 10:44:35 -0400
X-Gm-Features: AaiRm525Ah27pSqRsmB1Ank1l6yUkwaNgeMrdDHu-l3ql_NAe32zGwkl0SUJwrI
Message-ID: <CAEjxPJ6Xft+Y1Nj=b_kSnBFdSVZO0h_MugObhvUD0x_WcybGRw@mail.gmail.com>
Subject: Re: [RFC] selinux: add selinux=2 boot parameter for permissive mode
 through kernel cmdline
To: Marwan Seliem <marwanmhks@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 2:12=E2=80=AFAM Marwan Seliem <marwanmhks@gmail.com=
> wrote:
>
> Hi Paul, Stephen, Ondrej,
>
> I wanted to reach out to ask whether a change like the following would be=
 considered useful or acceptable upstream, before investing more time polis=
hing it.
>
> Background
> ----------
> On a platform with the following Kconfig:
>
>   CONFIG_SECURITY_SELINUX_DEVELOP is not set
>   CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
>
> The only runtime options for the selinux=3D boot parameter are:
>
>   selinux=3D0  ->  SELinux disabled entirely
>   selinux=3D1  ->  SELinux enforcing, non-switchable
>
> There is no way to boot into permissive mode without either enabling
> CONFIG_SECURITY_SELINUX_DEVELOP (which also enables setenforce and is
> not desirable in production) or disabling SELinux entirely.

Android handles this by neverallow'ing setenforce permission in their polic=
y.
Hence, they can enable CONFIG_SECURITY_SELINUX_DEVELOP but prohibit
any userspace setenforce beyond the initial setenforce(1) by the init
program.

> Proposal
> --------
> Introduce selinux=3D2 as a new boot parameter value that boots SELinux
> in a permanently permissive mode:

This seems very unintuitive; would just use enforcing=3D0 as with the
DEVELOP case.

>
>   - SELinux is fully initialized and policy is loaded normally
>   - All AVC denials are logged but never enforced
>   - The permissive state is non-switchable at runtime
>
> Implementation
> --------------
> The change is minimal, touching only two files:
>
>   security/selinux/hooks.c:
>     - Introduce selinux_permissive_boot __ro_after_init
>     - Parse selinux=3D2 in selinux_enabled_setup(), set the flag
>
>   security/selinux/include/security.h:
>     - In the non-DEVELOP enforcing_enabled() path, return
>       !(selinux_permissive_boot && state->initialized)
>       instead of hardcoded true
>
> The initialized gate is intentional since, enforcing_enabled()
> returns false before policy is loaded, which causes systemd to observe
> a permissive+no-policy state and stall boot.

I'm a bit confused here. Why wouldn't policy be loaded, even if
booting permissive?
Regardless, I'm not sure how this is an improvement; a kernel write
vulnerability would still allow one to flip state->initialized at
runtime.

> Use case
> ---------
> The primary use case is embedded platforms shipping with
> enforcing locked at build time, where the ABL needs a mechanism to
> boot into permissive for debugging SELinux policy issues in the field,
> and without enabling DEVELOP in production builds.
>
> Note that the ABL will be protected by secure boot in production.
>
> Would a change like this be of interest upstream, or is there an
> existing mechanism I have missed that already covers this use case?
>
> Happy to send a proper patch if there is interest.
>
> Thanks,
> Marwan Seliem
