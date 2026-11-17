Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927570;
	b=VvVDnb1yCLhyEQC8owHGJdgA1LTF/f/LR7+VBLBr7dWBgClcAAxfebIvUbG59EEuEY3J
	 oxE2l4lcSyxenigqL4hBafQNOH5AKTjDV5Pef14Rq/iRe1DisEph9GaiuV8j6ToNxTxM1
	 Q+LTbWvQiCSoTmLAR2z/sfaHGwOj8ipN911avyfnWjiSyJFo3FLQP71UJyne2+DiQbVix
	 3W8I/5q9IzDR9qCcFoF2qW5q+Msepuh0JxPvHcaszokBmyuUatGvS29D9hvHY2EOYpjQk
	 dBAlwF942TjK+uy7WHGlKA5qOB0colkz5LoFMKfay7ps6h5RMhXA33aIn7sH7KXdJhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927570;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9sFHjt4BtaLfL73WOaL9Wvn/S4UU4llVLvDxpLRGh1U=;
	b=P0R2KGnYo846weaZBvXhpJJ7GiR8qr0gXy3Pxoxq0wCeHAQLmgrrXzZK7BSkClsxICCT
	 b2BXLbUt9ETyByCu4NqzuU5GqWEKo/mnc7DxaNASP96liIb15Z7fqHD3A5vTm6GWin2K7
	 luJBGXijGDyBnjyWk1e/eBrl8mAeYrpibjY3vH93MvCHOyGQXBF3VDEebRa40FoSeNIQU
	 dRZXDG6jrNAWx5xcA5KRNcAlWJRhJCuDbMJC9KbnzC2+nA/xaBidJunwMPITcAvkBo9wu
	 k95Q1/APpUu0u1iXPMG7TDgydsw6hFIJGzr9uSHKsVXO/guZFU+UHVFmSJN0Z55U2VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adreW2jI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98A606A31C;
	Tue, 17 Nov 2026 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adreW2jI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1391F000C4;
	Tue, 17 Nov 2026 14:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927570;
	bh=9sFHjt4BtaLfL73WOaL9Wvn/S4UU4llVLvDxpLRGh1U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=adreW2jITJKMaY0GtMB6h9LgS1qiu3Twmst1GCIKM2dSbLwQzNCGhh7SiT9gc0cy7
	 fzsOOKkDCDrCeXvDQ4eSF1+ZTcF+++PWCcIYt9C6Ij+C7gSlCRCOsddoXQQs1nXrX2
	 T3vcF/QZ7rJnaTYPm1guviq1e6J8ipWhGsCAFqdunBLM3i8x3lme5UgLsURRVxsAAT
	 heZc2wpQdxFlW/EsiAkYoMTm30o+yfEU+BNz6SUj/5lkeY7EBW0vuz5DrHz+ZaLAXB
	 d+wxi86MzWDSvlbMbwzp3aEfAQYZiIAhJzdOl6H9QP1Dk5KndTqCwBJGM8DzjjeBgz
	 wvTIVqIrbJeUA==
Message-ID: <sashiko-outbox-219008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 13/17] LSM: rename inode_setsecctx to
 path_setsecctx
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117150542.1169451-14-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-14-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:59:30 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The inode_setsecctx hook receives a struct path, so rename it to
> path_setsecctx and rename security_inode_setsecctx() and the SELinux and
> Smack implementations accordingly.  The exported symbol is renamed as
> well, so out-of-tree modules calling security_inode_setsecctx() have to
> be updated.  Nothing under tools/ attaches to this hook.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D13

