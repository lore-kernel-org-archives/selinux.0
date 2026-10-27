Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110350;
	b=VoaMxp21nCyu8Jr5x7/cjo1rHQCRm24VMH9kHmLEO90MgDxs79yoAMsvK5mrv4fdmBuJ
	 C6RTfM5XCFwpUmPDd9zgwWV35APeJvRB+IR5hIzRPjMluKQEVX9aD2lGEkt4zl5EUOnFW
	 ZmApLg2B3YeJUh4RBtWo1B9msLaQabBF0RVIbRoZ6hkIdKaUBge1YpOWk4oTicRIb1GpX
	 i3pVhkOzZCDN4ap0RMCJ7DAcIsQ0DPYsV47k+aaw1DKKI/vvrUm4p0QAWPzKjdkMO9h2e
	 AYP8ARxMWiK5IBPUoaqZr0HTMySh+9aXJFlZNccpY8n7FWwPTPL9Lhz1aagIOGg8a3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110350;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hurx8aQ/ra07iOnfz65HKWkUPP2CrV6K5QXOihiTWP4=;
	b=bl+SumyclBf0zI1HF7UUg/ZrXlif+hugmYoiHgHApm6yK3CiMlSA5u52GGg8zvpe8aR0
	 nCpz8Y9eIkdt/JEeWQuOxaEIdVeDdNaw5BiG6euRL9EeldiOLbqej/rHcV7u8kjZRaSsd
	 z+TORH6j8A1Q6hmvjYXIDJd5aJ5nQ4vXmrxjsyUf1Q0f2VL2x//7BhV9cQQZFX4jUCJqS
	 uybTKA7jZhSbPfX6dLfbdFzywHg65QZB+LNzYd9+XUkKpLr/NBMJYlkEDqqqMb/vUfXW3
	 374AK9HqVB2WA5Y8JuUEgblm7O3iGQE/9BJ8kMvNcQFl0FLTXMyBF3h5U/hOl2a7uoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpgJso5Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C6606A335;
	Tue, 27 Oct 2026 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpgJso5Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C35E1F031E1;
	Tue, 27 Oct 2026 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110349;
	bh=hurx8aQ/ra07iOnfz65HKWkUPP2CrV6K5QXOihiTWP4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=kpgJso5YbUTf2UjAh66LvVHqOtKNH9PToV8JjLXI6FhmLpWsi4M9Pvbya2rdYeiVq
	 ST7tQ2Q6r1H0ZymM823StjrtQJwjvjNQXdjxECoiP1QPTBPKsSePELmZu27fRPsuxF
	 Bx0gIZZaExiWmhoYnywuDC5G0qlrjJV6+d0H+zRqDwONpAZPXa+CD3jxlJLhEKzqWg
	 F7Zczuipe3BMM1UelDGpv9EdClkJCPq9vsBBSrTXpqn7xS0suLhJWKu2Sf729OMznP
	 83x95Hw/EHW00xZWoT1vZvUtmG/AlZ0ZCgpY+h6j6R0bwPaBOkv563gH3/gs97GWR1
	 Sy2i9gJXvxGkQ==
Message-ID: <sashiko-outbox-186713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 13/18] LSM: rename the inode fileattr hooks to
 path_file_* hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-14-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-14-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:12:29 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The inode_file_getattr and inode_file_setattr hooks receive a struct
> path, so rename them to path_file_getattr and path_file_setattr to
> follow the path_* naming convention used for the other hooks that
> take a struct path (path_chmod, path_chown, ...).  Rename the
> security_inode_file_getattr() and security_inode_file_setattr()
> inline wrappers and the SELinux implementations
> accordingly.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D13

