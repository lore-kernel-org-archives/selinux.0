Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911684;
	b=sS30N7czxmzaarrWCoz4ctfXo7TpDnXbBmMLtuMUyR3BmJVtI7fmupVZ7rDmBrDmGzlu
	 hdvdrS0OsmqvXZnG6GYEdMaNzDdMHdS2Xl455sNxAiBDSvSpHyaIOCc2HmGRYzIEBzfAB
	 BF/fsPp8Ok35oGprjsWcJifidpWZDkcE/Es2lX69dAReNqT+T09EsjeOihpXSlTsEnxdj
	 3uLhqJBG/t/Cr9OSk/a0zr/heAom2DCGgYSyRYNnOBoNeAUkakbJm+uiO3b4wV6n0e0iU
	 WILJ88/pf8AWdkJNNslJFoaI5e0L3jvrJWGBHdUbt3B2OwZoMaYlT+WHA5GoYyANaYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uTE9HGuiJs/pdFIYPlb9oroSkrikm8myDKTAGHEzrxo=;
	b=BdY9iCqMXw5wHEmlQV8R0RTvyolPRage6T6021PS/WwKC1cqeK9su5JvIN8c03ywrl1U
	 4upybFeWtvKBFQKBVrzh5cKiL3x1FWt6q6y1mdDNochNwoWZmBQICPoiPrJUsenEXoBxN
	 TFERWLB6kRvmpu6vzqeBAn6lARNKCKumHMdMHBpqS0zEKKBLwF5Sq/fh6eNvFlEayLu6H
	 IaqB2iClsWnZIJG3h593bGzakbsjkODwL8EcXGJLxiP5Dmv0Lt3wBgvbktSkbEE0rLCYx
	 NwzOXgyN+JXk6ETAzAaGJzfyLTcLw2Y3N+iyCTR2/zQNPh7UhEQ+78T4ajAGYBZTWTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9uAggOQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E1760A3838;
	Tue, 17 Nov 2026 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9uAggOQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1651F01574;
	Tue, 17 Nov 2026 10:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911683;
	bh=uTE9HGuiJs/pdFIYPlb9oroSkrikm8myDKTAGHEzrxo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=M9uAggOQyd+ApXu1aag/KcncLWBA6QxLBF67aEaD238WjG7jfLRTH6LVCLIdgW5Va
	 wvBiPgKR0cugIVYlvK6/jRSpUgG9+JmAQQoHA3kbTzzl7Li9Cp5Dvpxuph+BaPB2w9
	 R5FalM9Pkzx4W8AeO8Z/HBYRQTm2MVd2NCHKMiLP/3CFKJCkb9zkZpqP2DEot8SPOY
	 pRFMeZbMjQliPooOwNXnjd21s9lroKKOE5EzqM+qem4Q5HmQwqa2d7JxY2umnAueT+
	 h0srrZMmUw5+4weFJPRSslSlVRS7rdUtKKCja2ja/CTcgWjhnReDrlmHIncI+ix6Ay
	 ZoJFIx7/XOMgw==
Message-ID: <sashiko-outbox-218627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] smack: Use security_capable_lsm() for privilege
 checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117101845.2523770-5-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
 <20261117101845.2523770-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:34:43 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> smack_privileged_cred() checks the capabilities that guard Smack policy
> (CAP_MAC_ADMIN to change it, CAP_MAC_OVERRIDE to bypass it, and
> CAP_SYS_PTRACE for the ptrace rule) with cap_capable() instead of
> capable(), so that other stacked LSMs are not asked (see commit
> f28e783ff668 ("Smack: Use cap_capable in privilege check")).  This also
> lets a process in a Landlock domain that denies these capabilities
> manage or bypass Smack policy.
>=20
> Switch this check to security_capable_lsm(), as for AppArmor in the
> previous commit.  The onlycap rule still applies.
> smack_privileged_cred() may check another task's credentials (the
> tracer's for the ptrace rule, the SIGIO recipient's), and may run in
> interrupt context for SIGIO delivery, which the capable_lsm hook allows.
>=20
> Smack passes CAP_OPT_NONE everywhere, so Landlock logs every denial of
> these capabilities like any other capability denial.  This includes the
> checks that some Smack hooks make before their label rules (e.g.
> smack_syslog(), smack_unix_may_send()): the override is denied, and the
> label rules then decide.
>=20
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101845.2523=
770-1-mic@digikod.net?part=3D4

