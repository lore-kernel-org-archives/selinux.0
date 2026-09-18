Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013D4FD792;
	Fri, 18 Sep 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739742; cv=none; b=kqR3ayE3ctJb2GnVnv3xony7vHLvOx7E317rTC0b48DDyjmuGrJQfK5Oo5xEHAtFlItPQSuidSV/99iocZy1InOFfpCQ5AXuX5jdY7MA0kPpAILT6D38KxLwG/8j8qZ6vOhclzo+CqxjRwFousLQgTyT67yR1VryiAou1iSxnrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739742; c=relaxed/simple;
	bh=hZzQbBSILrFnPGHGDgbZEM1qMQQxGpSVCDK9a09Cfko=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQwvpu2qenOjMGum45N8CDVmbHTsM+15UAwpK89U0JVYvJAxWYjTRS+p+2SD3auMbRo4hBeRexaIi9gWstgxrCm6ZTcxAUzdy+IhQadrW3/LBYWgPGCxthfvr6CJc23qiGKlfDqdFEYQ46R0QeERXq59UlR3EyjN5EIvEvj+oCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFDVpMbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFDVpMbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0341F00899;
	Fri, 18 Sep 2026 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789739735;
	bh=hZzQbBSILrFnPGHGDgbZEM1qMQQxGpSVCDK9a09Cfko=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TFDVpMbsFu3kK1eMXYQR1yRlevQLk+MoWnJe96d8ZY0+8/LbSZdhzY/orM3dzgnPB
	 cfde3CmlpSESQJoiqNB2wLgCnyvfyaiNnkfnSc8RN6d4i/oJYu4v+gAJM4uid7MtQA
	 bLV5rIGWjfGIZ0DNkFSBH5DUDylvfrryoXp4L6klmfQIyRCRHXos/5psYVGZEgJ6GE
	 D36NbmVvtf0niQ8JEC/WMTZ7h7MtSmFTK0TdJhxbjOCAHVBrx40iC6P1etQhyAbBic
	 zP0CzSDbEz4ThQRqyt9+MGAMtxEm1LWY9vM0PhgWQMWNDgB+jAW4Ya/J3CiEN1aWql
	 K7DFj9eq3kWbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] lsm,nscommon: initialize the security blob for the
 initial namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260918134422.17053-2-stephen.smalley.work@gmail.com>
References: <20260918134422.17053-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 13:55:35 +0000
Message-Id: <20260918135535.8D0341F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> added a security blob to struct ns_common and allocates it from
> __ns_common_init(). Most initial namespaces (init_user_ns,
> init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> however set up statically via NS_COMMON_INIT() and never pass through
> __ns_common_init(), so their ns_security pointer is left NULL for the
> lifetime of the system. Any LSM that registers an lbs_ns blob and
> dereferences its slice on one of those namespaces (for example from
> the namespace_install hook when a task setns()'s back into an initial
> namespace) will fault.
>=20
> Allocate the blob and run the namespace_init hook for each of these
> namespaces at the end of security_init(), after all ordered LSMs have
> registered their hooks, so every LSM sees the initial namespaces the
> same way it sees init_net (which is initialized at runtime via
> ns_common_init(&init_net) from net_ns_init() immediately after
> security_init()) and does not need to special-case them in its own
> ->init() callback.
>=20
> Provide a ns_common_init_security() helper in kernel/nscommon.c so
> that the list of statically-defined initial namespaces and their
> Kconfig guards live next to the rest of the ns_common
> infrastructure. init_net is intentionally excluded: pre-initializing
> it here would leak once __ns_common_init() clears ns_security and
> re-allocates.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918134422.1705=
3-2-stephen.smalley.work@gmail.com?part=3D1

