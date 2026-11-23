Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477531;
	b=L3nmBjytjm5kvNJ0yZOEbya7mLQOvUrBPd48oC0Nhl+3cwhVWl+cpuVRAzM7kYEZgT+T
	 WpXkGll0mbZMVF9n+z1Ztl3PShq04ni1UWO+hkJCwbxbP6+6gHPO5DgKf7aTZ7Wj7GyWy
	 uqwkuDzPOWxuVsEF/GJ8IHHi0FJrcvDbWIl9IEyHGX8TLPqmmEFHViG8F/+1wd+lCXBd5
	 yTEv+4BB/Mu7CDMMxgUU/FsXI/HE3Uu6CSOqYKEMEuc/VwcNdbY8IGnOmj4EYgzWKRamD
	 lOHi+JEQcuHXharNnZaMjz1C/g2QBJNhFb0PFCeReaNzZaBOmtIIme+UKizeFNhmsfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477531;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/ffWPisY6PKKUGSDKyqW9yELl1fTu8ljgICTJrY696U=;
	b=Aq80iC6CwkQhZcVcW/IcqOQieWs5WZhsPBar6JT1iMAhjW8q/Df7fWpqAkJM10yjZbM9
	 27EyKa5K67nieH9N9/pDkooLG1kXmh3zJsbUD2j9wT56EWuOmPsMImQLiMrhe7URBsuL0
	 Q0nF8M8MQiliWY7j7Ptvza9d3GJ5MMZdBVo3Yy6G+TqIpyMhwdQETTCnxb/JILbFeQIfa
	 ZOKd7QMLHuZ3RtP+rKWpLZX1SZwxGmP/yIyaGVZ3SmLjIXb1F5w3ZZJE2mdj5PtdaJt8U
	 4B4aBT+kPodZvY9r3nK8BtudZtxwlycpxCqkhUlnr50W/ZVmJr037N7emnCZ8ClIWwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fupEEcas;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB2606A31E
	for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fupEEcas
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3E51F000D0
	for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 23:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795477530;
	bh=/ffWPisY6PKKUGSDKyqW9yELl1fTu8ljgICTJrY696U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fupEEcasahqUtyyRZyyhLHnTXgCyiV5uFKl9+cxyUZBuf6olHpA3G6VSvyr603aHo
	 1OBqyVV/9FWr+8dJpnHkUHriIWqlxKUrQ/oS2VerrMyrl/UtM1/5KqmOftEun8qdiq
	 Azhe81BoE1+/IQxb8ucmkOlJC0HXuyRQkk/GQ+kCaRHcXqDfYn8iwp5xc6SWWH805a
	 5VFpbQ9BY5OBc1koyE+iojs7fX0qtstJh7YV1R5+llCGVq5VNVFznUqFEJLvYvI/ET
	 pIS3lU88Lt9a34JSr6tKVbypaEVH82A0p9MRRsfViYms3ASqF0qZntgRPW9ygvRgAp
	 ZZQ9F82BslPng==
Message-ID: <sashiko-outbox-230225@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: reject a 65535-byte xfrm context that ctx_len
 cannot hold
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20261124-dev-v1-1-00b99ee684ec@mbzuai.ac.ae>
References: <20261124-dev-v1-1-00b99ee684ec@mbzuai.ac.ae>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 23:45:30 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> From: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>
>=20
> Commit 86c8db86af43 ("selinux: fix selinux_xfrm_alloc_user() to set
> correct ctx_len") made ctx_len count the terminating NUL. ctx_len is a
> __u16 and selinux_xfrm_alloc_user() only rejects str_len >=3D PAGE_SIZE.
> With 64K pages, str_len =3D 65535 passes, and ctx_len =3D str_len + 1 wra=
ps
> to 0 (kmalloc_flex() stores the same truncated value first).
>=20
> ctx_str[] is __counted_by(ctx_len), so the following memcpy() of
> str_len bytes is checked against a buffer of size 0. With
> CONFIG_FORTIFY_SOURCE this ends in __fortify_panic():
>=20
>   memcpy: detected buffer overflow: 65535 byte write of buffer size 0
>   kernel BUG at lib/string_helpers.c:1044!
>   ...
> [ ... ]
> exercised.
>=20
> Fixes: 86c8db86af43 ("selinux: fix selinux_xfrm_alloc_user() to set corre=
ct ctx_len")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-dev-v1-1-0=
0b99ee684ec@mbzuai.ac.ae?part=3D1
