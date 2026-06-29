Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657C2E0914;
	Mon, 29 Jun 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715866; cv=none; b=rwjWKB7PBZv3qEYmeCwFtj0UprAVLsui323JTJodKLJJI+yItQmBmoy0RsKBaHIlSMbmhHJU7RnUbZ3l/ovRvaXSZEUOz5gm3o7gmm2crGlYc2xFcM413bJzK2XV6Z2K6BqaMDqPSEgXINxoxhgXUbfhmMi2F37YZ14/Gmir1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715866; c=relaxed/simple;
	bh=7NvjHoVGfw8oLL9WPKUiB7c4AiynMGLhdjZQLzfWt/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gmsaqID8Lb9O/1OygjLHEieaz/rakiELQpnzn5MuTgtz2DpNSqFs9qfk9vpqaXBhGevLEsGU7Bf+hlauFLWYTxXsnREwvlV3cA7Kng6jnRPVwm3VsIAEFUt2ss8g16RDaWkKYb881b80nS9dkyxcuZnCElbbA2ih4+P3w0/2Xm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwu2Qv0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwu2Qv0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262E91F000E9;
	Mon, 29 Jun 2026 06:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782715865;
	bh=7NvjHoVGfw8oLL9WPKUiB7c4AiynMGLhdjZQLzfWt/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mwu2Qv0IDqa34QyqeAIQQeNQznl6z5Ipb7aMOH1fPQyARadffj2YYXsDiJgBzmh8O
	 WM1TajRiLkJmj427+zCSBC8QQN5gFnYl3h2VJBishUcAf/5HENM75tkBDkLiNzwNiR
	 wyjmo2dVE/4V56VCuXpmIOBDenDinWxdVFiG8boOV31K4tobt9PIMYA1PbxZKS5AJb
	 tIz5If2cxI+gCT3ZqpKgPlDjty0tRiQ+2r8uB1vhRDtqYi91bDaP5w87QdYEGN00if
	 48CgCTQfeUYYjjG7nXo9bavuf8YiiRxTc/0tlp9XIQb90MyrCGoBo9vDRGC8wKKk5c
	 QZMlugjE7S3CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable/linux-5.10.y 4/7] lsm: constify the 'file'
 parameter in security_binder_transfer_file()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260629070653.580879-5-caixinchen1@huawei.com>
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <20260629070653.580879-5-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:51:00 +0000
Message-Id: <20260629065105.262E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Khadija Kamran <kamrankhadijadj@gmail.com>
>=20
> [ Upstream commit 8e4672d6f902d5c4db1e87e8aa9f530149d85bc6 ]
>=20
> SELinux registers the implementation for the "binder_transfer_file"
> hook. Looking at the function implementation we observe that the
> parameter "file" is not changing.
>=20
> Mark the "file" parameter of LSM hook security_binder_transfer_file() as
> "const" since it will not be changing in the LSM hook.
>=20
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> [PM: subject line whitespace fix]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629070653.5808=
79-1-caixinchen1@huawei.com?part=3D4

