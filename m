Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989998;
	b=jhb8EOqicacnELlTCMhDYhvqE5GSlcc8GFQngLxlbyR0I7+LZVpENfdEEuoZIvOdIPDm
	 mdK377iTIPnc6/yr/KWy33WLeMGM9WGfQ1aMQeXjawy46Jjmq4VpBhtmu8b9tWMwAM1nR
	 AC/c1NdTC/xAOH8M5mVpcqIf9Vj/pIEY3nwXG/HBa/Jw1x7yrtCupp815303xGTYK0fxG
	 4zIU8O+5NhWFPyXPmHcICDlBjBzSwSO8URgiPHsiBR2kGa86uc1IXYRK9QSxmnCm4xwGx
	 dLI2Z3Lv2CRmgcWMQC9V15HBYwnAPa+YFR7K4TJSSI3xap07H6Tzx5kH7QQL4B+eMFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989998;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zEmGBRJgH33hReTblPh7Qv4wxxJA4VMfnHHQCFnRr7A=;
	b=GmyMEmqfHUPzdTwZrI5fGFqnOAvn6Ybd3cx/NzRHLEV9G+MrMXo8fN04zHH+/1PZfdM5
	 9BmpiDtzP6+Ac9FrRc+c42YV3bvRojZgtRgIBjK/4O6MWgvSa0EaIF0j2fq2hwGxrKRbp
	 npyKdoEeaid3Iv3VJqyYLteAdPNotQ0drTWNePsdMwNyQoYks/yn0hkUm0ouxixMlW/yj
	 Tsrhh84Ph9CnfOhlY5C4ElxDraQvBn3iRYDWI5Q+FUCs3cOD0Zs9rgAVw94cI/6HdYGp/
	 quHGlo6hL9r5AeFmqQM8hGp51EtYlW9CBOriJ6RatQnNeoiC1kvH8CX7Yc9VhRBFUnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ResnxrT+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D70606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ResnxrT+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7771F0089F
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989997;
	bh=zEmGBRJgH33hReTblPh7Qv4wxxJA4VMfnHHQCFnRr7A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ResnxrT+DyyKKCiJGLQjm6Yghb+YHWUclHfzZalJvg+K8MEAGS4M/J9ZRwE4Hjc9z
	 K1wKcIFOYP/S8HUhn026eSzme8iV2vMKhuwunybf0PRVWlfLIWjm8/TFp6NSawlrxa
	 64Wl1T9Es2O1L4Iay1CCRYMEXJSC27oFVNtxe+s7awD2isOAswy8nWzMsk7SIaO/NL
	 Ga27oHG716nKaVNBIfaUon+FSb2syoxoirY25ZQxnktccudwmsQs0gQpfAl7vcppRX
	 DXyMzAt6VDPaT2av1mJKJ8DKL6tRV5PHXAZvTiDoOxWDl9osIXSlW4H1Ftfm+KNDum
	 W/QdMjbradhSg==
Message-ID: <sashiko-outbox-202042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: check MAP_SHARED_VALIDATE mappings as shared
Reply-To: sashiko-reviews@lists.linux.dev
To: selinux@vger.kernel.org
In-Reply-To: <20261106182913.15233-1-stephen.smalley.work@gmail.com>
References: <20261106182913.15233-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:33:16 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> selinux_mmap_file() only recognizes MAP_SHARED as a shared mapping,
> but MAP_SHARED_VALIDATE is also a shared mapping type. The mmap flags
> reach this hook before the mm code processes the mapping type.
>=20
> Consequently, a writable MAP_SHARED_VALIDATE mapping was failing to
> check the file write permission at mmap time, and a writable
> executable file mapping was wrongly checking process execmem
> permission as if it were private.
>=20
> Link: https://github.com/SELinuxProject/selinux-kernel/issues/78
> Fixes: 1c9725974074 ("mm: introduce MAP_SHARED_VALIDATE, a mechanism to s=
afely define new mmap flags")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106182913.1523=
3-1-stephen.smalley.work@gmail.com?part=3D1

