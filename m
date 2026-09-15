Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0142AF9C
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502724; cv=none; b=OCRM1pINUzcjldqnQbL8YDrUtHK0aPv15BV4SY/HfEYS4Q7v5AKFBvDSxJ8VG/oFmRg4efrY4WJp9tXSMEM3eM+C6wyUGVrZPMyRdGDt73mDc94O4EtRHd97kUTZ9WQ14dzpuu74S1wpLQNUUPiwy6ceVp0XDxzErjAuR92gLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502724; c=relaxed/simple;
	bh=sktQfREjFIIcXsbhCmwlaTb8YFVE+BHzu8bXiMzbMHQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p/92V6OUyG4ARdOi2yF0d4mMwTlqLf1MdgTwK0/4jDC3WKr8oWVRtdfOOKipg6ebM7Wcp51J5AbCVXMPrpzIUM1W0/QtP0FsBkwG19XgDgYpoZupMcw5HWWYq3JfziF2+qUyC66FKrMZhDRYaV8SPg90+KGybxYlE+OBeWfkHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTpZ3ceV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTpZ3ceV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC8A1F000FF
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 20:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789502722;
	bh=/UNfvTpUIxy00D1bR3RZyoIfoDCUosEhEN7f8gmPNfM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GTpZ3ceV4nFxxf6m2mXjb99w72+WAvj5Fx0uakeOIyX5Q028kPDUkn+3Crnugsbzh
	 aNL/1mJnNNYJrZmxnVGEgKGPSLxK6JMhDdH4gOZE5v6KBGUDw5Kwluwn0g9HxRD/qc
	 o+zoyZvfufn+7V2P+avs+/4Rz13W2u8nMSIWnHcAo/N3thM1xO8udFQon564PgwdOL
	 dJkwcpUQ0cgkqgEdm6iT9LtUmprVo9xemSxPP6kjvfN31b4jC44pf3rp0nuPniai2T
	 SeH5jDadCMEiU+HBQZsHH4C28YMh4VDiQNB0YJvqjktilfkG6iKa4qw7ENXTq1thEV
	 8e39aVYKq8x7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: use explicit 64-bit division
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260915195728.3519469-1-arnd@kernel.org>
References: <20260915195728.3519469-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 20:05:22 +0000
Message-Id: <20260915200522.BBC8A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selinux: unnecessary 64-bit division for 24-bit bounded value
--

commit 7622bbc45f42944796ad657eff450b2c4b7eb729
Author: Arnd Bergmann <arnd@arndb.de>

selinux: use explicit 64-bit division

The patch addresses a 32-bit build error where dividing a 64-bit integer
by 33 caused an undefined reference to __aeabi_uldivmod. It fixes this
by replacing standard division and modulo with explicit 64-bit division
helpers.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f60f92e2ac341..7894a2f480f74 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1573,7 +1573,7 @@ static inline u64 sel_class_to_ino(u16 class)
> =20
>  static inline u16 sel_ino_to_class(u64 ino)
>  {
> -	return (ino & SEL_INO_MASK) / (SEL_VEC_MAX + 1);
> +	return div_u64(ino & SEL_INO_MASK, SEL_VEC_MAX + 1);
>  }

[Severity: Low]
Since SEL_INO_MASK restricts the dividend to 24 bits, the masked value fits
comfortably in a standard 32-bit unsigned integer.

Would it be better to downcast the masked value to u32 before division?

This would avoid the 64-bit division overhead entirely and allow the
compiler to use fast 32-bit math or optimize the constant division into a
multiply-and-shift.

>  static inline u64 sel_perm_to_ino(u16 class, u32 perm)
> @@ -1583,7 +1583,11 @@ static inline u64 sel_perm_to_ino(u16 class, u32 p=
erm)
> =20
>  static inline u32 sel_ino_to_perm(u64 ino)
>  {
> -	return (ino & SEL_INO_MASK) % (SEL_VEC_MAX + 1);
> +	u32 rem;
> +
> +	div_u64_rem(ino & SEL_INO_MASK, SEL_VEC_MAX + 1, &rem);
> +
> +	return rem;
>  }

[Severity: Low]
Similar to sel_ino_to_class(), does this need a full 64-bit quotient and
remainder calculation?

Given the dividend is also bounded to 24 bits by SEL_INO_MASK here, could
this be replaced with a 32-bit downcast and a standard modulo operation to =
be
more efficient while remaining mathematically identical?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915195728.3519=
469-1-arnd@kernel.org?part=3D1
