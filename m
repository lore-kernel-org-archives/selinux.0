Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237C26F29B
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783390135; cv=none; b=oKf+dPInoB7SjHsXpFVXnfoFlOw6EbLOYv2BkIkUnz4UMupvsk/8uBCzC1D+18s6bzQWMv9Jn6AplX13i3rZ4oVKNP1gd2QOQ8+1X3sLlXw4XwKyKAMXwl+/8vgcr6Gx8As6NW69IrKWzDpO6tpqtspSHo5bStOuRjRT41n40hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783390135; c=relaxed/simple;
	bh=7SR1aL9Mm/8wtwC9vz/H7PcxMXHZcGuXjfg9zwFB4d4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j588scoJ4JhbJtlGx/I8KXTSIN6vb2LGatyHkmbyDxyL7gmPo+4lErjiLla68v+A5iCvjSJ8OkB5p/eY2p3SOPR0sAmHvVXWt2gDGmHClZN8dyZtShCt3sBa6oNAD4m1HSBnIdsUmWC0sm+CnEeFal6WhLpOCjh5sb9WYa9ttz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1k9z1Uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1k9z1Uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498BF1F000E9
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 02:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783390134;
	bh=U4562Aa2/koX/225Oa3gWM3NIdpH1AEGRg5JqGrHQO8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=h1k9z1UuqeR2DrogANxfwXbSI5IKNzf1RwzHN4nAyK3S51WMROO700sw1IrhZwx3q
	 RtviCH5SMQE8noeGwFsR0mFjQWfgoCkPKvhJuXiocYSLUUav/T/oTIIEVMJ5YwJ80Y
	 4xTa3Uprx4Fx3uEAuFBF7rj4q5fYxrB1ui70xlLjFlgF+l+LFOt4YndAPXOZ02LbCA
	 troXnFZFABz/FkoEqFwdCntiyzmBBFa0FnHGe34YP7+SGWDPNTMDkrkS8XfAB0QSzh
	 qRiaM6PJpZg9TqhPUTli2eJQyar1Nd9arJQhz8Foa6DmUI4rP3V3MdDvt7xAiDrwsC
	 Xurf6fjweqskw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] lsm: Remove security_sb_mount and
 security_move_mount
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260706235053.4104951-9-song@kernel.org>
References: <20260706235053.4104951-1-song@kernel.org>
 <20260706235053.4104951-9-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 02:08:53 +0000
Message-Id: <20260707020854.498BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Now that all LSMs have been converted to granular mount hooks and
> fs/namespace.c calls the new hooks, remove the old hooks:
>=20
> - security_sb_mount(): removed from lsm_hook_defs.h, security.h,
>   security.c.
> - security_move_mount(): removed from lsm_hook_defs.h, security.h,
>   security.c, and bpf_lsm.c.
>=20
> Code generated with the assistance of Claude, reviewed by human.
>=20
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux=
 only
> Signed-off-by: Song Liu <song@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706235053.4104=
951-1-song@kernel.org?part=3D8

