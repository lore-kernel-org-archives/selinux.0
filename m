Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795062144;
	b=Xw+lJZ4ytjkj9LIf+p0MLLDe3mZ4/DRMrwlB1oW5DGMK3lhNveCD5Ry7Z9y/LtluRigS
	 wkj6YPMy+MSaKLxKSwmLCILPTzKqs3zNd4/SE2efIKsBWinkXHucGJGDfCxh+3/p3FOSL
	 8X6RI0f+ZI8ZV4q+vWlVOP/NfT92CmCPMKeWruiS72huM26IKRZaIBBzXhrzMI2X3CLrL
	 dBE/UwYk7RomfaLWX4ZpvV56ULLsLPmIu/7cyqcOEgZKs+gIOzzqgCgG8UfSZWpfS9/yU
	 OyEPB5lIJJ1GhIz3QMivURL9m/75jW6zIhJ3qdIhBU7aTsOPfYJA5nBALgzTTjiQXaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062144;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GJm/IpPNaDtnO5UeEJkPPWMxrnS195AxvlFHwaq9VP8=;
	b=oMWtAWSpwLlgJxUIOSY3+YgHDdRJAlvz6D27DYUYp3Kj+zobpg4+7o2ZQMEfRNu9f/t5
	 O3u2CIt9Q0qL60lgazdXq80ku1/JWoiVBUl8ZPyjAPtuUgJcNs9UMxilmrUhktveF9r0T
	 wYa4r3pLHDW+yfKDJvwEKjAGrlAqaqSD/wtUjCJVKBNqa6XkdvZlnGqnYxd6NHA1J+Rmu
	 6qcek5TbRQAriSSYY31dGzsdDk1iuafOmBBVFtIkiEg2u+084inJHnAwKSMRUl7SPrjt9
	 DBsylbuvq1NmszkeSP+B5aSS5motAFINplzXbWy+qrlaVFjT0nHuVuV2vU1mo/toFlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lq/B7igy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9E606A330;
	Thu, 19 Nov 2026 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq/B7igy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE2F1F000C5;
	Thu, 19 Nov 2026 04:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795062143;
	bh=GJm/IpPNaDtnO5UeEJkPPWMxrnS195AxvlFHwaq9VP8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lq/B7igy8jcNQmxXY1trXPAAkOLqv44VsY0fYtKCSHWM3EHPx+l65GPD3EWLTaEzH
	 w+JYQHCajEjt+Pm5opk1Dm6qXuLuzNMl6cKk0f7yJKB84OU/OLlKcqU3ONiQP6dFXO
	 jjATVkH7WUNtoYVgHvQTRyj7376F8Pzewod5GAB42zWAiQOhYSvQRDXjkvRMNk3mn6
	 uhQzV5L3X0Qy1Wi9+PRWOpgzyN9Dmig1AcZ64sZVZeV/5pd0SyiNtwe30yJft7oU87
	 hd467JD0dJj+mhemk/rDs7lB99zYaR8PfAeHMQkeqLRjDy766CsRwULeYUbnDz0CCV
	 oeioHvGRYCDhw==
Message-ID: <sashiko-outbox-222442@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] security: Expand task_setscheduler LSM hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261119040705.684987-2-atomlin@atomlin.com>
References: <20261119040705.684987-1-atomlin@atomlin.com>
 <20261119040705.684987-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 04:22:23 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> At present, the task_setscheduler LSM hook only accepts the target
> task_struct pointer. It lacks visibility into the requested scheduling
> attributes (sched_attr) and the CPU affinity or cpuset mask (cpumask).
> Consequently, security modules cannot inspect the target scheduling
> parameters or CPU mask passed through the hook.
>=20
> For CPU affinity requests via sched_setaffinity(), auditing or
> filtering the raw mask requested by userspace requires inspecting the
> mask before __sched_setaffinity() intersects it with the task's allowed
> cpuset CPUs. Seccomp filters cannot perform this inspection because the
> affinity mask and scheduling attribute structures are passed behind
> user pointers, and scheduler tracepoints only observe the effective
> mask after intersection with the cpuset configuration.
>=20
> This patch expands the security_task_setscheduler() hook signature to
> [ ... ]
> mediation of explicit scheduling policy and parameter updates,
> sched_setaffinity() requests, and cpuset task migrations.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com> # Smack
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119040705.6849=
87-1-atomlin@atomlin.com?part=3D1

