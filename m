Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991263;
	b=E0VpiwAWzcW0HM3i6XlKFl74lUnKxi01MppiiLMAEZP4Otw8Jeh6ZLjmXCHr2B//kAsl
	 L27HbgGVrT101iVoHlcV9uGMCrPY1/F+gz57xpILGkJyV4wcftXCzmwEkbOfauSZHnRLa
	 wyTNG1sRub+3xj6SlmGahu/lOC074zWpCJMGHxjOCveljM6HeJndim9BGjM/1NBSRPqaa
	 ZJ7sfGvjAuCH11juhfPmNipqoRjCPG3miRqnUKtW/X3liJ72vlJGnnSV+qwujaiK304sE
	 hCThyOGS5emNLbBuHbgHfp576KC6mJ9r1YgklMc5CaxEf+vGwc/uFJr8TYRFr6FfJdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991263;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Emx+SkipOPOtA0a6wMPY06ojavjqFBFneaUjsLt5K6Y=;
	b=JxTsHQ3a4F41ycyo6kibidAKY2+sGkm6yA/RyxhPgJcu5PX9Fc6Q3KJahlxpGFv4qFMI
	 laT5S+cPeLsncKSHA8G5F9f7/IGA8/7U63AYVlZn5/z/YrGeuI6BvspdA9z8ulBZxEVFH
	 +A/33dan57+TxkSbnA+mDmdrLSxGENhQ54dQi4/lgldf2/qr03pU3JVVlUdt7zaW2hdz7
	 N27fXxFHCx1Wmss351SzbHVwfhjDNroRqI0zniHrd9PeLkqqpnHXq6C5a3LWZh3/M+DT9
	 TnyEn2iLuflR8tOT+4fOCXh70MMiJTXvtoBu4KMeC2UEIZ6RHJX7lPc/jKvRjnVtWHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmTv4PR2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA57B606A334;
	Wed, 18 Nov 2026 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmTv4PR2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690B41F000C4;
	Wed, 18 Nov 2026 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991263;
	bh=Emx+SkipOPOtA0a6wMPY06ojavjqFBFneaUjsLt5K6Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fmTv4PR2Mh7iGSb3y4K8Ufw1+8/LalauZVlz67z7KR4dZ2Gihtc7y9Q+I4a7RRwD9
	 dTcIIzEfpMdBdCk/TO5d9AgjZoCUP1mszPu+2h++8Oirsk2v4jLXgMsOU8w5cxP0br
	 U5zC0738HZkfDx32MVx5ui0NLDOXVS/LTZl4ITksMVyJJR9dy0VQU2gBw63DS0BPT8
	 DG2NRTOGgc1juHLCyj7eX9LcI1ErJVoLHhpRLP1hE9rgoFJO8EfiCToYoz4eVPgtXj
	 5ujTxGD/EhZNm4vbtyvG0+oxGCRDO9Mo25buH/qD6RzguvdnbqqQyOo5+DnBPOrFrD
	 dIuSzWPRhyhAw==
Message-ID: <sashiko-outbox-220471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/8] lsm: Add memcg_charge_cgroup LSM hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-5-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <20261117-v2_20230123_tjmercier_google_com-v5-5-1ce975f2a9ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:41:02 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Similar to how security_memcg_charge_task adds an access-control
> point for pidfd for the charge_fd of a DMA_HEAP_IOCTL_ALLOC or
> DMA_BUF_IOCTL_XFER_CHARGE ioctl, we need a new access-control point
> for the case where charge_fd represents a cgroupfd.
>=20
> Add security_memcg_charge_cgroup(), called in get_obj_cgroup_from_fd()
> when charge_fd refers to a cgroup2. The hook receives the credentials
> of the requesting process (cred) and the open file of the cgroup
> directory to charge (file), giving security modules a controlled
> enforcement point for cross-cgroup memcg attribution policy.
>=20
> The file is passed instead of the cgroup so that a module can
> label-check the object the cgroupfd actually names.
> get_obj_cgroup_from_fd() resolves the memory css from that same file
> with css_tryget_online_from_dir(), so the fd cannot be swapped between
> the check and the charge.
>=20
> When CONFIG_SECURITY is not set the hook compiles to an inline
> returning 0, adding no overhead to the fast path.
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-v2_2023012=
3_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com?part=3D5

