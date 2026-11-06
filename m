Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994459;
	b=kvC5v5T2mJJr68kPMZD3H3/gyiasVTnJppW4BPGJSPdGSlov+RsNlJZoS/ANcdLnJQ5P
	 URrRWrc98UbZXOQMZrHWe0geotNFwPH3yoFPCn0mZGIDz1JR8eR3H+L2CJo1SA+wxe6Qo
	 rVMBcVgIfsPL88bHEv8RfwbenR76RBMmO4bj7kXcRSHyX0XHa3TAI/bDV1t4T4fCmKPMr
	 3x/x3ZrDBvTaba5FmU4IzzB1z2mFegM3iBeLQOwEFs6MJlZNqwIjYPG0z8+2GjnPfZ3TP
	 zMuht97ZSc7MQ5LjJVKqQ5UCqWZ5juVMyrdmfWQzMAnN1p7C58nYmnyxfwpbilkyQHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=AJPPC1qEwxIH4pyQturAE4OFdHVwjxyvCmSsD1GHYw8=;
	b=ZsQOorAEh0Q5kW8b4iXYo+SXSSr7qCtw3rRHXEAUHnozDTYPVKBPtJ0Hf8hUrwMph4om
	 egzAFpFz9cgCHvtRkJS0In2/z4Z9yTUvVLyTSybC4xI/0l3XpR0OC4MkXzlLvlQsE6GDs
	 2fQpW6uJUbqmOgBVf+DYJwQBxWyk1Qe9gfRxXCyllLjejQeiBY87Dbr03FSxFdl9DOHYF
	 ByKKsQWNVOKLN0E5w+6i/SSLNkUFOfiH3x5CqLWK2h3UpGEUhlK9qGIT/bl9OSSNSqyQj
	 ZJVvsGYhL+lBuPd905+sl48lm4htfmHLhVa6ugewKyqoUjkBBFoUANkmLLIAtMj6yqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bKg3lmsB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128E606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1128E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bKg3lmsB
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6798af41644so869877d50.2
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994457; cv=none;
        d=google.com; s=arc-20260327;
        b=iRxj6xW4TDPMLlPfyQ2e3tIipt1yv6av97uTIuuoXYYTOWjyw5pBvjFkQRyLTb3+Zq
         DGX2OoiYbDauBpRhIsgNCvVwLtgtSj9mCHbI7/9f9Ftm/+Lkfgr/48jyTzH/zl5k1lLF
         OLOCPNqCqlj8gOC+sdCH9XBTf3nNScM8Dtyd7VEeK+Q7AT4F3vhsMuvF/1BvTXijJ/FB
         FYfwrMrmeGgNBm2CVqq9tFyEDDXCppCSGUgS8jCXHENT+bHEsBAe2JPWmfriCVD00ksk
         6+KgEnBG0iAv+eZYs0rx88ySSkHIas6mvDesiYPoZyJ/UD3Ds5BDHlbvEdeth9m55GKn
         gEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AJPPC1qEwxIH4pyQturAE4OFdHVwjxyvCmSsD1GHYw8=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=No21jnjy/qDb/rB6qExlc32XDmuWfCfBM1QscASZ5ZkOP2K9rTYZp0sjnhqtGXpqVS
         7oq/1s5QuR/cd7i1FB4YnJF0I6+aE3oZrDQHQ5arLXD98zrnLlrjb84bzqD3uCDtDaRX
         k3sJq9Rnv9/kSxbMh60NYWHwCJQriSiyiGEKypUlVVbBY/mcvAIl8i+nZ6i76syKKF0m
         hA0C7NHnzrSPd34q3m45l04QOa8zl4M7ZL89aXj7J96ZOouU9fd3+bf6Dyeru4Jg3Ksh
         XAi9Lv/dioxNTyr5jrtX+aJmxldcfMgM9sMHI3B2hbjOywcxpoukKUdU/+RmahHHX00j
         O1jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994457; x=1794599257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AJPPC1qEwxIH4pyQturAE4OFdHVwjxyvCmSsD1GHYw8=;
        b=bKg3lmsBfxfdLea4hzGeQVIOYsc2hLEaQ4Vbl8QVWuysbixtWy+3/D5EArMj7jHgps
         6brpmSIyRNM12DZjvK1klCkiUhZsiGvtws8RnKs2T9B8jSbCra9rzR1tOtlkgjWKYL5/
         K6m5i0VPlW1shcH7HPAy184T+/oUFxXXEEhyFVSvQAC9z5jIB1j/YEu6VmLSNgw9ryIV
         N/QAbZU6ZJcfFBfKYgOHrJs85egUOuzJpqvdrwUx8ku4B6SfYDLGe1KvSaPQepano7NJ
         8z0xTiHSYuUPjavzQRsKZX3UznA8mnsvpe7E/a7VLIe6QJ82N7cDdVE+jybXIEyrp1G1
         rSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994457; x=1794599257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJPPC1qEwxIH4pyQturAE4OFdHVwjxyvCmSsD1GHYw8=;
        b=ZIbiSfWRNnTN1V2TgtZOMgnMyVS1+eXeqKWqrnSSvMnMl4vhHHCetG1SKLg34jvNLD
         eU54zSns5TcvJRFf9/RpUNWvauk1/WqgWJXAE6hIFjWDcvCHtgaZQlBQZBqBT9Z+ti2W
         QQJWeTV4g29H7lZ3xMif0LYz2/LsCAGBpqZ37DyaUmbuf1oD9grEd+ZW5/vt+6i+XUqX
         TPjkFq6Gq1OrGI2j4S7G4IiF/eUMG1dQ66soC+209gcyUOlmGXeaFc3M9Zh0a2Bg3t3j
         mtn2QRtiE2OOBKJ+h0GNx4c/hkDAYkptw6+sclqbCth5xDkhsNBqHPiAH/iwprFlJzvf
         ILqQ==
X-Gm-Message-State: APuU4Z9uK+X401qLZx46dRGMtOmnwsynEf7j8B4dNGBS/SEyRSXHU1NE
	RP96TsESxbMCc5KJLD7u1iMYi3ElS0WcLuo7MhEpRd5y36OQCQ72AhOLaN/+oIs9pRDIf+WS5ll
	331ubloL5IinvwHzXpfhWn6DWjCI5pCyuCbMRVik=
X-Gm-Gg: AYBFou2VxrzxufFqEVT3m7Oydn7mgk1GSrMBkWBETugCBrhXG4CK1V9C4P56ctd+PzR
	tlZj8+MZnfrmTjLV1y4yKnJYggqa5RObZpXpd1yra3IbZXBa0HziyYXry7WwvhqPqCPfiI0EAiK
	fOAhPMBARpD7M1K1cquv5/NALdFQughm/2GTLcmqZFpUdbqGSCWAxEpTO94zwInxFhBr/6DPY4h
	A8yfQzC4Od++WfQ0/L7zNSkoYLHs4AJJlfPCMgnjWZ3HwGZSso7dgc5sZG9uY/vu43gLQtdQe5h
	jP5+DO8rptH/NZ9QUmtCIu4vpW7XCNVGTOZg43KzWmCnZTGm14QJATnJAA4Zmz99CrrynMkC5Ab
	YeDW2Xk3cYeSGT1oh/I7F0rw7d2D0XlHMYwLSml9NYrDZBqYGVTZloxBn1FkTK+xMBw6y9rSlOr
	RCY8/+bA+ioQgjsuxiwcb3iz011ro/z86EL5//pv6qay6DeIKGKd4X9MeuFA==
X-Received: by 2002:a05:690e:408e:b0:67c:24b3:393c with SMTP id
 956f58d0204a3-67c24b3414amr863993d50.90.1793994457056; Fri, 06 Nov 2026
 11:47:37 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-5-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-5-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:47:25 -0500
X-Gm-Features: AclHuK9eO2gQmrooD6ytTrmOg_G1nRfUsVUyn1Xmtj58xBHowhBHz7nHT7ruy30
Message-ID: <CAEjxPJ4E7ZfPTKpjzuvo=kr-7Ab8wtqxLL69tjNnWvg63Np=Mg@mail.gmail.com>
Subject: Re: [PATCH 06/16] libsepol: reject conflicting type aliases when linking
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:35=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> alias_copy_callback() asserts that an alias already present in the base
> as TYPE_ALIAS refers to the same primary as the alias being copied. Two
> modules can however alias one name to different types, e.g. a base
> that only requires x_t in an optional block, one module declaring
> "typealias m_t alias x_t;" and another "typealias m2_t alias x_t;".
> Linking them with semodule_link aborts:
>
>     link.c:948: alias_copy_callback: Assertion
>     `base_type->primary =3D=3D target_type->s.value' failed.
>
> Report the conflict as a link error instead and add a regression test.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
