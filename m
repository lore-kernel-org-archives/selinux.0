Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4593CB2D2;
	Fri, 18 Sep 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742843; cv=none; b=GqCGTt1Ia1UX2GMxPqOXnblFrrwDX1Ld/9ZHJS0hHC14me4S30MTQkYd0DFYVFSA2TrBy9+9uJy0rD3XuDuRvC7fg6BleuPxFdmzYLKKcq89lMq7XZvjtUCVb7dAO6RTPA9Bo0W/t0uA0ml4wR6LgMBt5fHXcgQQp83hgfSUmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742843; c=relaxed/simple;
	bh=QpwRiPmHlhJ9ahZI4XZjKSrKRbstyNAq1TwlXU8jVT8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDIxWI1GfM+Y5Ngbb+D8hw4qH+tftrhp8wNPp69mn4WAo1DDsopfzWdVOx+1pcD5OxReItdHXc+FhSKfZRa4P4W86mV+fjPkmuW9za9b3tOCCtOnhOg9q2qSiyCr3cg62rW5V880oGArcOyQDatvKGJ5uZ8fOc4sYk1JHoiC3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoGv+A8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoGv+A8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D46E1F000FF;
	Fri, 18 Sep 2026 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742841;
	bh=QpwRiPmHlhJ9ahZI4XZjKSrKRbstyNAq1TwlXU8jVT8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hoGv+A8qf5e//fKyDSmlvt0TLXIAlkonKBZ/bwpFikVjAzaZDLOMzXWTJJlR6OyJk
	 2pPET3CzNb5188h+zHuYFfUDzzXxvFCPO/BOlg59V0uriSVre4o9P5dJoiQIYKNr91
	 PprDMqKx08Jq6GIc6tfTwYfQl2rtmhmGo7vGPYvpMH8ZOtHBScmnIwOmbsd4u+bYCl
	 2SMsFYugmIEEyzo1a/8bzDPereP2t49345PV1+SiJHhVyqC5Nnx39OQwP77ug/562J
	 bAlIRVO5lp/z3EtB1c+YbFWz9cKNMqYEhe2t9e2ylOhkieUX32aBXk9zxzyTmDOwoO
	 mcZWAfhgs0/Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] lsm,nscommon: initialize the security blob for the
 initial namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260918143142.19435-2-stephen.smalley.work@gmail.com>
References: <20260918143142.19435-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:47:21 +0000
Message-Id: <20260918144721.9D46E1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918143142.1943=
5-2-stephen.smalley.work@gmail.com?part=3D1

