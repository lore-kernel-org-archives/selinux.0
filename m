Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A384A5C46;
	Thu, 10 Sep 2026 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052190; cv=none; b=KfdwoNdsocUwAznotIjj7uJ8LBc5zgamXyJ6iK0UWcEZPN7dKkZOhzsq+qX4W2f413tiNurpadblei4Hra7LAFXjiw1FLA29KOPCxVGo7E3XRoD5AxltHKQpIn1dtBnk6SR4IOrxoNLYFZpF9DPjL2KKqgNF91Bdmc/ydP5l9Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052190; c=relaxed/simple;
	bh=0pUYtRp+pM18dDAxa4bQ2fRwlyVlsEFL2je8jUJCxys=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ljwGddMFeUiArWFOLxVP5wh/LMUifHH9aib+l3i+8w2Mo9HUu4epdiEVggNFy2GSwfDIRX8GWZVSoURnlUUWjIm16/7HTcOqiW5QPc8QSvA9tpV7eNvWJw1rXshpFX4EqmLDIQ+Ja2XvX4Tvt1Yx2N3iwoom5PS6nISRMD2wFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNlDZ922; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNlDZ922"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04EC1F000FF;
	Thu, 10 Sep 2026 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052189;
	bh=MvNHyev7SRTvBYUJxdzf/DazxihAQ73jeT0XMNLGSJA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QNlDZ922+QtY45wce6OD7aQlS6Kowh7fMjCOfYDMKTh/+LBkE4oTErcFBeVONrBWK
	 Xf75ZCWWUkrp61T3lKkDwLrVIVhrpxfDDy1F2iQFKd0Aw8i3CrEJwm27kWJYZ/Qiq4
	 ww4xuMu7ph8BLRyRnu3mv1twRlVMKLuuQm79zB1cAh9RhvPrLkU1rnm1lbxiR/gCd+
	 +FqElqjsvj4CEPAos46YzrsP2g8Cz7HnG3Kg6dRhUVI42rXu+9wBoIzrh3v2pqhjDb
	 Rh8421UnynJlXE7VDPH23BJ7V3j8rF1yPHAY4d+fp1EpvZddRf2zijUuC7idLkYAgM
	 gkIk3BxNvebKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] lsm: Preserve full ioctl commands in audit
 records
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <20260910144837.381855-2-mic@digikod.net>
References: <20260910144837.381855-1-mic@digikod.net>
 <20260910144837.381855-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:56:28 +0000
Message-Id: <20260910145628.F04EC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Ioctl commands are unsigned int values, with their encoded direction and
> size in the upper 16 bits.  However, struct lsm_ioctlop_audit keeps only
> a u16, and the common audit formatter uses %hx.  This logs 0xc00ffeee as
> 0xfeee and makes distinct commands with matching low 16 bits
> indistinguishable.
>=20
> Change cmd to unsigned int and use %x.  Pass the full command through
> ioctl_has_perm() as well.  Its driver and xperm values remain u8 values
> derived from the same low 16 bits, so SELinux enforcement does not
> change.  Commands that fit in 16 bits keep the same audit text.
>=20
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: stable@vger.kernel.org
> Fixes: 671a2781ff01 ("security: add ioctl specific auditing to lsm_audit")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910144837.3818=
55-1-mic@digikod.net?part=3D1

