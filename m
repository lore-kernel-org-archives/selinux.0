Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC643F08E
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512473; cv=none; b=jv6Vecq981n6BukYX8RR9VDXtZM5XAUKjAIyycFBsl+5RUlB9vTR5Y1CiVpdyLSfyEkue8kzlKWcbb7zv6BM6AtfhxMIZxlE7S8kRDXqDl6bXMn8QqhBmjdF/+3+LvwIzicKag0FZtIWuz1smzqp3lrV72Ea7PPSNunVOaX+MIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512473; c=relaxed/simple;
	bh=thvPK+x7fHCHCq7NADjTFiB7wL0CITRhj+5PSSMWE7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f3/l+je4gdyeVTS/aUTxglZtvG7+k8ykhEkKD/t+eBUZpRobFIJpOiHbZazAW0WNlzF6G8spwnabEeKtoj9m8U4CW/qKrcoQMrlDLDPEZAmyULysJdSNiNDwI09VcbQp3kZckXss+NiQTYs/uhNxP1O0/L7URYljz1yaMIhzgYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzOaVJjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzOaVJjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA4C1F00A3A;
	Mon, 20 Jul 2026 01:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784512472;
	bh=thvPK+x7fHCHCq7NADjTFiB7wL0CITRhj+5PSSMWE7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YzOaVJjD+u4460FwYyrC/MGPFQbDI5VP2e15tzfPm4Marz5ExHqXTfkW6dxh7QvYE
	 EYaTyvqV4NCZxNQlD6BZAFrGQQfkRATUUz3DVGBtgonDq990NnYNfJ/JV/i3cRe9O2
	 kePhxAEGGoqOJO/dy/mGAJGApkikbpxDzO6kNYhqP54Ezk5eppEzrxk16xoLR1EmwD
	 f0JjL9EnKunvTGDk308Ge08JyPxKkv8gwis7W0TKho/8upAh6JtFFHGT/WURK4XVcX
	 7INQ7qS6xhA9yzF1qHjh5obBs8ILKoN+UEMnLLvylJMn9gpVK6Iql2flCtqGd4G0tG
	 a3rL38hL1Prgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] security: Expand task_setscheduler LSM hook
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: mkoutny@suse.com, tj@kernel.org, selinux@vger.kernel.org, hannes@cmpxchg.org
In-Reply-To: <20260720014156.459386-1-atomlin@atomlin.com>
References: <20260720014156.459386-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 01:54:31 +0000
Message-Id: <20260720015432.4FA4C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> At present, the task_setscheduler LSM hook provides security modules
> with the opportunity to mediate changes to a task's scheduling policy by
> inspecting the requested sched_attr. However, when invoked via
> sched_setaffinity(), the hook lacks visibility into the actual CPU
> affinity mask being requested. Consequently, security modules are
> entirely blind to the target CPUs and cannot make granular access
> control decisions based on spatial isolation.
>=20
> In modern multi-tenant and real-time environments, CPU isolation is a
> critical boundary. The inability to audit or restrict specific CPU
> pinning requests limits the effectiveness of security policies,
> particularly when attempting to shield isolated or cryptographic cores
> from unprivileged or compromised tasks.
>=20
> This patch expands the security_task_setscheduler() hook signature to
> [ ... ]
> This change updates all in-tree security modules (SELinux and Smack) to
> accommodate the new parameter mechanically, while providing LSMs with
> the necessary context to enforce strict affinity policies.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720014156.4593=
86-1-atomlin@atomlin.com?part=3D1

