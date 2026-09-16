Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E443D4E9
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588711; cv=none; b=PEPjZs/7YqBy9Gw3lp4uB0tjvAZiNhXK1HvJVpT/YWhHCEYvdnQyRXXP/pN+Yv1/l0S3jOMG2dvwFwnJ1sxPH0Uo74xSNhmF4pot+gNn6J6xZYxm5QxgBTlKvfw7/ezoh7aHPVNvEgZpr5vywbASB5LRIGKrZS+pgP32Z/Ntafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588711; c=relaxed/simple;
	bh=TH40plX9r3Xo6uMi4PT0nbAr/FOYYsvbyqDuFQBIQOM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KtI8rqPvKLg0HwJkCSoTcF3/dhXgUfHRaB5ysBE9lJzgizLzms34Np7eE+M/KVOHNT6RD6WQyi8fS1MF0IWPtHGug5u7H9xQnhe3bI6SCtTzzSVBSOTyaFnVp0KykC2pYbWCxtdQ14vbYL5uVMHMV/HdxqpZFuSNlEQg9AynV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/PGG+Qr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/PGG+Qr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71451F000FF
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 19:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588696;
	bh=TH40plX9r3Xo6uMi4PT0nbAr/FOYYsvbyqDuFQBIQOM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=X/PGG+Qr6sNLDpXaXJo3qA69Bo3XA/oXe7nKqi3Seg/CkYGlAEOv4Co+GzXHHUO9d
	 QP3CkZQrDzMNJJ7FBvbjVqvDL0aQ7F08XlGipCDAP/PZsT4I7cXPBjjF+BKoq9ArPs
	 4GKmOjs+TyloWhbXbRqgpWe7GgHhvzzEmFmuAOZhBw3B8P5CG1eEAOfOxsm285IkZD
	 d2d5jLZmqArb2CF4eizMtlDoRL/Z158EWlA22gS4uQqeixt9rxo0thskoi3LbD0AU7
	 JTGro9COAwwz8gZO2C9KOgL+n+V6+QksHwhi71mX8et2ZNDSBcdHtsenZWqAD5NVuK
	 RAGMTW3RjnXnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] lsm: initialize the security blob for the initial
 namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260916194824.37332-1-stephen.smalley.work@gmail.com>
References: <20260916194824.37332-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 19:58:16 +0000
Message-Id: <20260916195816.C71451F000FF@smtp.kernel.org>
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
> Provide an init_ns_common_for_each() iterator in kernel/nscommon.c so
> the list of statically-defined initial namespaces and their Kconfig
> guards live next to the rest of the ns_common infrastructure. init_net
> is intentionally excluded: pre-initializing it here would leak once
> __ns_common_init() clears ns_security and re-allocates.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916194824.3733=
2-1-stephen.smalley.work@gmail.com?part=3D1

