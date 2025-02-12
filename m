Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E952046A1
	for <selinux@vger.kernel.org>; Wed, 12 Feb 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351795; cv=none; b=rW1wQPdusM3/NpELsEXclnhAwHgKSqv982cXeuhwsoYN4EPWsO0lNUKoUwFF/o5QpLELvukZbZzQAivcthsv4oz/H0C7Y05tRZJ5U32eigEB3Yr/C3/vCPnV4Qw8/z3KkZsRQ79T/kCBEDLk6lsYrMuiTLwwU2O4QTrDN6FU51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351795; c=relaxed/simple;
	bh=SE9KJABwWErFVZodW0B/w3YxEwD/9fZAqMViK+2A35k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RsoedOhMHUjMLLVBzOqvlWUyI2FlfdCeIp+dOUiAmOyNgxwWpcF5edjWh43EuhfMd1C5aFXmvHY3bL69xBbkjRU5jEB8CxdB8D6s7ic4oK4lqFLvfI83TEI1DPh1F65Lb5zEhRY3V0YK3RF0k8G21t2dHWshGqwN3I2zBl2EfP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=ekUQLY2t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u/7tm4pv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="ekUQLY2t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u/7tm4pv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 60B451380238;
	Wed, 12 Feb 2025 04:16:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 12 Feb 2025 04:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739351791; x=1739438191; bh=Js/7RyeZ5B
	6aHvlVJ9y7FS8JrjbRRrbd8xnzg0N1uhw=; b=ekUQLY2t7klyadxwtwVim2l+sK
	0yGHeokBBnunSKeGeHQWLkOTfFYDMXC6ceejE+YjZgmXYo3i55sAj+jnnTZBzcif
	tcZZmN3wgnElvEMx1+ePZzds1wVZ7RO5yHErG9zJ4QlY4JGnBnYT2vh47FP+vFEu
	1iNkx941WiGDbfve8vy6vE2Osln3620SjCFjIooc/oCbpzFaizRIe2cWXBpTHjzz
	4v8NlIH7J1E3Ogvgsz0ym25l8+y1EfdcyZnXup8K06/0ilD5aBYvte2DLEsGP1eR
	yEWBn/6iiVOtHt0W+pevkpRJH5Zb8Lu24k/TYD3WVhd2duDIExd/x6fc92hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739351791; x=1739438191; bh=Js/7RyeZ5B6aHvlVJ9y7FS8JrjbRRrbd8xn
	zg0N1uhw=; b=u/7tm4pvM+vlzwDJu2tWDaceAage06poXlzoxIW8/4yPhXwyj09
	2fKJ6ZqZ38fBwHEQAobvLf+MdsRYUVIvwOYUJXem2+U6wzX81Gx+vgkK6WqJM2lh
	ve/Kmp/7boB0gJWALy+T6bJIng43KBjS6PubiNLLDd0h64HVHt41Dr9ot5Bwjei5
	0I+D9qT1Kspcj2bFxMz0B/g9b2kaw+tvHOFbL4UlSJnd5aPHUIqWUcdweTSVLF3w
	aSrgfnIfK8HVh9vg7zezw9vzPWhxDQyb+Tczq/gvPUuypHotufEiXlkaEkzQq6Iy
	jTXJiAoKqQXEwqQsqeMYYYy7ZVaS29oineg==
X-ME-Sender: <xms:7masZ-V6MtpaEUWIS_QXQXIMuMtadzODxu21vXQswJZ7KyHyIyLgZQ>
    <xme:7masZ6kt-moGvvSQH8oC8aA_TBVW3atE4mJs2hNlmxbVw1FUFVA8aV2ulvAiJY9Uk
    SvWWKgftanQ7euWzg>
X-ME-Received: <xmr:7masZyaft-6FXzxObs6gKLW1ZW2mvUG7_IPcxP7hfp4npQ7djpFXhfx8ugS3MVVJ43iCj5TsG3wgjwgX2ygMcJ9Vyq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgesghdtreertddttden
    ucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecugg
    ftrfgrthhtvghrnhepgfeiudetvdfgueekuedvuefglefggeefjeffgeekueevgeelgeej
    leehffetkeeunecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhs
    rgdrihhspdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegusghurhhgvghnvghrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghp
    thhtohepnhhitgholhgrshdrihhoohhsshesmheggidrohhrghdprhgtphhtthhopehsvg
    hlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7masZ1VTFo3L8B26fp6bnr94xb9w6djSowcULLLBaDF7TLSBvWThlg>
    <xmx:7masZ4md_-X6IMdMNUGclisrFFfztayLEe1uMbV58EQGDEo6c-mZ9w>
    <xmx:7masZ6fFkR4Zq3_6xv5nk5FoTCPHyH47NtZ929b7BT95_RxbF_6OCA>
    <xmx:7masZ6HDNnbYKZ3ghGylKhZs_vuweTq3zwJKtIVamwq5MFZcYPL1nQ>
    <xmx:72asZyiZWKp93xxFVSv2tahQEX5zY_U_p_0PXAAQUJfN9VV1OPUK7IC9>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 04:16:30 -0500 (EST)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id 8CDD44C33081; Wed, 12 Feb 2025 10:16:29 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] Support static-only builds
In-Reply-To: <9316b48f-64f0-469b-8dde-1386aa13d384@linux.microsoft.com>
References: <20250211211651.1297357-3-hi@alyssa.is>
 <9316b48f-64f0-469b-8dde-1386aa13d384@linux.microsoft.com>
Date: Wed, 12 Feb 2025 10:16:27 +0100
Message-ID: <87a5aro74k.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Daniel Burgener <dburgener@linux.microsoft.com> writes:

> On 2/11/2025 4:16 PM, Alyssa Ross wrote:
>> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
>> index 32ad0201..7acd51dd 100644
>> --- a/policycoreutils/Makefile
>> +++ b/policycoreutils/Makefile
>> @@ -1,5 +1,10 @@
>>   SUBDIRS =3D setfiles load_policy newrole run_init secon sestatus semod=
ule setsebool scripts po man hll unsetfiles
>>=20=20=20
>> +PKG_CONFIG ?=3D pkg-config
>> +
>> +LIBSELINUX_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libselinux)
>> +export LIBSELINUX_LDLIBS
>> +
>
> I think that in the DISABLE_SHARED case, the pkg-config command needs=20
> --static as well.  I tried your patch, and I get errors that the=20
> downstream users of libselinux have undefined references to libpcre2,=20
> and they are being build without -lpcre2-8.  Based on the pkg-config man=
=20
> page, it looks like Requires.private libraries are only included if the=20
> --static flag is passed.

I think it's generally expected that the user set
PKG_CONFIG=3D"pkg-config --static" when they want static linking.  See
e.g. <https://bugs.freedesktop.org/show_bug.cgi?id=3D19541#c3>.

> I also see that restorecond is not including -lpcre2-8.  It probably=20
> needs the same treatment as policycoreutils/*.

Does it fail to build for you?  It builds DISABLE_SHARED=3Dy for me

> Finally, I was unable to get the install-rubywrap and install-pywrap=20
> targets to build with DISABLE_SHARED=3Dy.  I wasn't able to figure out th=
e=20
> ultimate issue there.

I think Ruby and Python bindings need to be shared libraries, so it
doesn't make sense to build them with DISABLE_SHARED=3Dy.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCZ6xm6wAKCRBbRZGEIw/w
oh/WAPwNmTWwTG3qK5x9GlpNoW+q8oqqxKUi15TwzZP1DzZ3uQEAtDoO6Bom9NEC
MXR7leQ1s6YRpIc8DqUjr9o5+bhMhgg=
=L8e5
-----END PGP SIGNATURE-----
--=-=-=--
