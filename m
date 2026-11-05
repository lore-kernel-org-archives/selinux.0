Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900141;
	b=MAe5EL8VdZ2EaFfjdT43HblJ3zOkBJHe5Kz5z9jW6ex8PFIbVOspJUlSWTTuQmqk9mlb
	 Dga/CSkrP0KFHDj+MJKBFxT2TvKaF6UlID8DcBfGvx6jlXJDkN7v0yGAXvONJMcGFnMvs
	 LtLtG1I/QBRfDzOLK7mLCsj4XnzGkCbgvIq4J83ty4H6DIGcGy1r4bcd6xkoB7+V6dNRe
	 xjA2tMYzVvNM34jyhY9owZu2h9wx2JMUrr13hni/bOZsUOU4sC2XYQ3Aa/cUlpsxaRtZw
	 73AAoaFvO6nKqlReuRbT9H8SuiQnhHiqP0zzbyaIcZ+ZgRt8WKwS1ws9BWBnLdC4Row==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900141;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CoRf3B7nBHcbguGtoznhvjHA9vTlMblUYwqXo/68q6g=;
	b=lbbRmWgnON10hJL5KXZCJjru9kbLHRFfdd4IZfTmCVOfq7toX/9c/gL2NZotMax/mSQK
	 Zyfgh+07kpa02I8htqc/rQ/UqAvxKX8LNSkEeM/Z57kU4kMDBp559jDZj4BUm+chpXYUP
	 /f7KnONXzT3xLi8k6STFdI8lKiGDaUEDQMmHhG59gySkBeJCt3GrflD87NggEa+jIZRZW
	 RfKFhlmpNOIaZLlN7QF3ebc4Q5sIzHkz2vco5UYLXbiHhdoERxxWYXfm19TSlRip4LG1z
	 BT9tNxPYRmLAnJm/qTVEqvrtIAkeXJbgzoWVRM/J7U4iWie7vzQHzZGrX6IcOSp9wfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QE3qcSYB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1439606A330;
	Thu,  5 Nov 2026 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QE3qcSYB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813961F000C1;
	Thu,  5 Nov 2026 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900140;
	bh=CoRf3B7nBHcbguGtoznhvjHA9vTlMblUYwqXo/68q6g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QE3qcSYBeLdJ+wU4P5kwdUHInzj/VgrOdyFTfQtycYPwR5UxLWJpb8N0w8CV8GDRa
	 cbwVzQT11uLnYhQ3ek1SM0VOogkco/D5xU09E/4tLUKIkr3eThq3swr7VJBrfIynQq
	 4YEmE6VlgrQj9xmZySJzzHWtnBC0VLCHZTyyL9c2xRyzSMb4ShkpOr2V5fcv0Y8D1N
	 NhkHCuwv46ZdI5d2pw3NOJu0gtrjHKQ64ZpZqPJKThKgYI2Pb2CuJwNNGgI99CH5k9
	 jUwhlC3qXgdn4HmrwG6QiP3u9pZ0lhfQhXqtR7HFoVJSm2qsu0MqzvAggD4gU6eW82
	 AZjS5eTC/LfOg==
Message-ID: <sashiko-outbox-199638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] security: Expand task_setscheduler LSM hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105172210.76706-1-atomlin@atomlin.com>
References: <20261105172210.76706-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:35:40 +0000
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
> attributes (sched_attr) and the requested CPU affinity mask (cpumask).
> Consequently, security modules are blind to both the target scheduling
> parameters and target CPUs, preventing granular access control decisions
> based on scheduling policy or spatial isolation.
>=20
> In modern multi-tenant and real-time environments, CPU and scheduling
> isolation are critical boundaries. The inability to audit or restrict
> specific scheduling policy changes or CPU pinning requests limits the
> effectiveness of security policies, particularly when attempting to
> shield isolated or cryptographic cores from unprivileged or compromised
> tasks.
>=20
> This patch expands the security_task_setscheduler() hook signature to
> [ ... ]
> providing LSMs with the necessary context to enforce strict scheduling
> and affinity policies.
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105172210.7670=
6-1-atomlin@atomlin.com?part=3D1

