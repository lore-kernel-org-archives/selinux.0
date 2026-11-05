Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914688;
	b=1p6+vwt3pn2wPk0lJOwcTjyKXXIut8G3axnssWaeLiAaNijYD/W8JxaCOwpjL/oHGcXm
	 3gLxfWyPOUNgm71nrROBV1ByibA+LD0D2pg1jvAie+Akk6tC/T7SoJ1pRhhSF8+r9w+CF
	 tj+1pzOd8mV+Uq6y9IrUE+6h5qSWcl3dIEIcvOQhvWg0GGmY2wh6mjc6c73710gHi3IDf
	 qehnw04CQRyh7MwGiliHnepbEYaq3rIP1DqIqDQyofkWlBpTNK8ZhsxmaXHmC2z1L8G35
	 76O85hGXxM6aX+1fqUnb4Th6mKHO5YexNCPpbyqu1IkorCm8UjxkPAW774q1IbSoZHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914688;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nfSyedN0O5FpP5MGMhhLrVCnObpbzoiGnuk4emST0B8=;
	b=1TjrfBAyBmZwoHw9ESx+IqcHDT3k+dDIs/irkDX1VqQRXLK6w1U8mq5AnaCD9TDL0rff
	 HvHuoquMqAJ+tR7vSgIQz4xV9o50uBTo+GTJgRAsfo3/jcClljS45XML7iWdxWhEdiDsI
	 LRZ+bhcYq658d63VhVcKAbhS9G5rSfuUAwA4L9x1Yd/12//2friCRXooXh13PQtjnpeUO
	 gd2fNqdbHAtSYoEjM7NX8sFC5bpsI3x79QHtzUyLpPlWjCRcsLAUnMha5l5UpuPNFkcKK
	 uXiFMQyrWuqB4vWIRVkxiy7HS9pVYXrmBXjfhvPWUooe/e2nL8dlw9bVj6B8jlvFCsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQStPF9x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E2606A326;
	Thu,  5 Nov 2026 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YQStPF9x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5D71F0089F;
	Thu,  5 Nov 2026 21:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914687;
	bh=nfSyedN0O5FpP5MGMhhLrVCnObpbzoiGnuk4emST0B8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YQStPF9xigtlNDe28OSauV9+braKvpmRa9wz8yZ8fHk0jTXBzZorjgTZ/eJ87lPtz
	 iVfQ1PjA9cCYlQqW97l7tPb17wSgulkoOgeVl7nIsEpIu23g7S5orYObrz1VhX1wvL
	 /MIDjM7/FZEGATwd2TASWWKXQP0vFr0b4rOJjlDssfJ1u+HhcIm40Fhn6IDXGyWD3Z
	 qO2dU5WZCbBgLc7rAOL5ESF3+SdK+V+xQXLyziRS1Kjq8b96MxGLqW4JVbth7zZ3e3
	 QGXUMBMg+jebKqKnY5DDlhvcOJoLGr4Vaj+DikJNi/uYWKKTKKMQwcapbMPNBJpB/4
	 YMEci+FrD3vjQ==
Message-ID: <sashiko-outbox-200245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] mm/gup: convert GUP code to use vma_flags_t
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:38:05 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Replace use of the legacy vm_flags_t flags with vma_flags_t values
> throughout the GUP logic, both for the MMU and nommu variants.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-late-2026-=
vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=3D1

