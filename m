Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576633;
	b=fWaTsyXC3wEuLNQCz1IH1z9qyL8oPvmh1DoX4hblfdtHYCbs3GliJersuPUPJMRAopUN
	 bCYCi5ZFDosPfakZzaC7aFF4CiGTP65V+Ktn1cv/zZquXzgMu/W5CG39zUB3JhDTQUEkn
	 mSc5wd7UMjuOfhHWgfvEfJ7ZwzqdAXpyxrn5fBFwMapzmo9Is9joFrXxQtRtOd9CIDL3a
	 k8V4WQSk6/meTctqSG71j+ud2ylRmxsCxM5PFwIZ9r0V64gD35lAByN/YXVOykyKJ+41H
	 QcZ0qdYyqz2G7HEAmW72+3n+4K4EQIKwY358cpjLbVVmXvFCj0rjjQFbEoSb/80Zxow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576633;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1uk6USsWA2IofzIWSsfDZAzk40HoXm3PcfmnOx6iArk=;
	b=nPORfGSkvnFzzZdnDFv3eARIM08gFSQQr2RFZ4D9CE7TxwmU8sygWlY9x4D015LUyA1d
	 wmnxwgqA8PAHaxRluYD3BNTSSLnT/FwI/yPOdUeEuMhuRoBYZBNU+VFf9jDgIUZ1AODfh
	 8YfOICwVglfY1mdtQb4P0cB//yXlpejq02QMReEwhaXeCOMepMqPdv2m0H8G2CDv64b30
	 lQnPMHj9sqtl35JZlqzTiMOefB5rrkMZG1VjlGRfORTVW4qaHkqOqH3CpKvNYf2vmvSP0
	 8dSCYYxOXX9r36K0R314XfZXAtM/iPhx4EaxveygmAPOFZRvTDw/QteJvs/SMr/BDMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+X9oqD0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FDE606A33B
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+X9oqD0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205101F000C4
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794576633;
	bh=1uk6USsWA2IofzIWSsfDZAzk40HoXm3PcfmnOx6iArk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=J+X9oqD0NbgIChouBiygdCfAjWSzt/zuxPKnqxnWv5hV+bzzOYTcCdd03ufq/xBFl
	 hMUkn7VZNG+Ss8BRlcmBXMO6pCMhXacld22DOZfjxRDsp4sBTCtONbfRpneuB1Ouor
	 0sJLNi9fv6lIllD0x1iXNv0rj/YoUO/nSMRIeDuFhTscY2L+L6Gfb8JHahPlD9MyNZ
	 yLhQvVyFj39kT08vx1eHY1mqjZZm3oSIwfs6t3JDiHVukzgNMOkHEMCkC8bcn/spQU
	 wAUmXG0fzG6QNqhU88a4syhYT13EhIWeK8PeuYdpWOS+Dw45SdmArWnZ9ufb9V+1aq
	 GVGBkVaxy/ZBQ==
Message-ID: <sashiko-outbox-212867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] projects/selinux: enroll the SELinux userspace
 project
Reply-To: sashiko-reviews@lists.linux.dev
To: selinux@vger.kernel.org
In-Reply-To: <20261113132417.87823-3-stephen.smalley.work@gmail.com>
References: <20261113132417.87823-3-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:30:32 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> This is a RFC patch to enroll selinux in
> https://github.com/anthropics/oss-scanner
>=20
> See also https://red.anthropic.com/oss-scanner/
>=20
> Note that instead of adding the Dockerfile and .md files to
> oss-scanner, we could instead add them under a new .oss-scanner
> directory in the selinux repo and then just point to those from the
> oss-scanner project.yaml file.
>=20
> Enroll the SELinux userspace project in oss-scanner similar to how we
> are already enrolled in the oss-fuzz project. I may later migrate the
> Dockerfile and .md files to our repo and point to them from
> project.yaml to ease future updates but this seems reasonable for now.
>=20
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132417.8782=
3-3-stephen.smalley.work@gmail.com?part=3D1

