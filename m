Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911091;
	b=CtwS+0pB3vou1eZNojtQqPHCC8tGTik2x2ozznXtf8qfLgrrwbwZ+1T9Ail4gARGC7KW
	 Njyfyleb5ljjiPG7P8lFNfEV9/3invRdu0Nz89pHuteSUAEg4QxMdDvulCozvyVZyyMcG
	 +Hq/g5Cqdqsmwi4hCIrnEj2OF1AQerkNXDoVOLDrmoAC7LT5g8LyusGXWg9Pqdcw/vGfH
	 jeWJN0OU+hIxlBv1vL+hfMsNdacOtnQxw8eNQQJVbGU7/tzaHWzcFosrEJyww2Wkb3nUt
	 gvjd50aVKm5WItpnh5Ie81UfRMGOMuMSK6fi23XHvE7HfWIHyi/dB2aRNnxH628AVDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911091;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fysx2BuVgzWGqCfM1RNCEOgN6TYGq0e3Vbu7oVm83u4=;
	b=NehiyLEtCRy3I0I5tzItlo0MeF2g4v2qMOIykNDXezOo2XpOTg6e1+xBMl0JPHmOZImS
	 AL215M8/4Y+lCwytOfgbgSgXiSXRLk/8Qgqa5tQdB+RXQwNKk0jjhcet+/aEJfSBjQVgw
	 DWfewuPunGgm88wHpUpGg7Dmn2ypn/mFQqwxZeGXxtghJywoyHjrztyBWAOrMPUVB+YVe
	 XWDkAyNnIcJsyc9Oxamd7irMd0vTr67ntUSZ3xxaAO2bS5Jy+OoOL5p+n3iNNGT3f/T7e
	 +CQWtEi6nKG3UulyKuvai/6K9wQp1jNNPL4qN5w/MbXaa70nK2umcIMrYxN/An17mlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTaxol9t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05421606A335;
	Tue, 17 Nov 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZTaxol9t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F6C1F000C4;
	Tue, 17 Nov 2026 10:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911090;
	bh=Fysx2BuVgzWGqCfM1RNCEOgN6TYGq0e3Vbu7oVm83u4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZTaxol9t+BLpOZ1O7sfzB3b30KrFsMaMxFy44vTjMiGH86XYUvLgmwZC5p7aIkx1K
	 6oSvESW6ugtqQW5hTMknCrGJrF3r/I/a/AZQAAuaYbCr6xCDvqKBQ3smqsw690e4XI
	 v+MMOQUjvsWJ+L3blROUdcJXXjc1e/roNnHRgj2t2D0DzsGbtji62llKu5HwfAD/aN
	 4prdYqKI8HZTU+5qHCdBUj/bluRyqFc3xBGFV1E0BK5Hg60FRJ5UMMq60pmUfQd1Gp
	 AAs0H9PfObWkuYRORI4fvVaE9hXtNBBw1j7Hgp1EU228Af7SbOiY/qKLCVx5TZBEr4
	 6/JXaAXuhFk/A==
Message-ID: <sashiko-outbox-218611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] lsm: Add a capable_lsm hook for capabilities
 guarding an LSM's policy
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117101845.2523770-2-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
 <20261117101845.2523770-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:24:50 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> AppArmor, Smack and SELinux check the capabilities that guard their own
> policy (e.g. CAP_MAC_ADMIN, CAP_MAC_OVERRIDE, or CAP_SYS_PTRACE for
> Smack's ptrace rule) with cap_capable(), usually followed by their own
> internal check.  They use cap_capable() instead of capable() on purpose:
> other stacked LSMs should not have to authorize these capabilities,
> which may mean something else for their security model.  This also hides
> these capability uses from LSMs that restrict capability use in general:
> a Landlock domain that denies CAP_MAC_ADMIN does not prevent a process
> from managing AppArmor policy.
>=20
> Add security_capable_lsm() for these checks, and a capable_lsm hook that
> it calls after cap_capable().  Only LSMs that implement this new hook
> see these checks, so LSMs that only implement the capable hook are still
> not asked about another LSM's policy, and the calling LSM's own capable
> hook is not called.  The hook gets the LSM_ID_* of the LSM whose policy
> [ ... ]
> Cc: Matt Bobrowski <matt@bobrowski.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101845.2523=
770-1-mic@digikod.net?part=3D1

