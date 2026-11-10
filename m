Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344554;
	b=oAn1hM16Bm6QNelgSPrLboRLpwIRIF0wbvCM9dYUu7DshRFYPOQYzMPEaTW+tBwo898v
	 mjlzRRrQJ7Qvb9kwfyg2AMpEoVHWw1+O0k8vkOS+F4d4YzpRwddZcRxYBOvijXs1IySow
	 Cu51uumFak6PvjAkHqBIZOqIeTdu25N3VXyuSeQrixb8Nge+aaSBmLWP8smteP9VO2pX9
	 NMFkLs5TVrY4BAJx7sAmg59o3VWlafr21jkoFWKi46Inj4xQG+aVpJ7xk6PXVCsFbi+44
	 2x1ZsCpbZN7Tz7JWqtGVKgKj1D/Ni5s+nYRH3tPBueCxW0yb/30ahXn9bk8tb1/7J6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344554;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4UELyMN+egwkqi4+h1uopj37GrqBlJgxQd/MGkoSSAk=;
	b=j5C/0n10dErQdrUHeWo/dxBD9QGsIdkjXr60Ws/BtbdemGr6LRKLX+Ds4ZiuxWrJlQK4
	 hwq+aSO++tRkgZWmAuudbF/4QYNrQEquMryaH6GE36WLesnGdDwvrm84qonTOxUuLvWyd
	 t0VzKbOwvUZ3ER0Q4bhvKqQXklsW/lLSnuPcCA2BUVcARg3dEuLoQxp7eZ8j9p8Z/oM+8
	 Ls87QOTX0oen91db6TpsDFvW7rcre2r2l9N2uh3Y+c91j/QmN0b2v9k8usD69dut0yyD4
	 18cYLgnfnuZzbEzC9LrbpEdwAKzCta09nN6FOLnS6Bk9WxOuEZZxoxZA/x8YB0jET4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIFweq4W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9B606A31C;
	Tue, 10 Nov 2026 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIFweq4W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAABA1F0089F;
	Tue, 10 Nov 2026 21:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344554;
	bh=4UELyMN+egwkqi4+h1uopj37GrqBlJgxQd/MGkoSSAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UIFweq4W2ri1jxRcfOJKg5ZmdzmEOQrGrEsZbdNmyGr0UtcosyTUVzd22ZA/rEyu7
	 KS6BCZAbfGjjc//5/BLGFU96uo/aVTWyHLwGMLiZbew5h9XY42CNE5QbsMXyuZdMNr
	 WyIay3TNN4CZHsXPrxfpuo0KtfkBf00ODkoCOIkv+I9O74qvzaBs0PnyK9Emhr5UjM
	 OwMXbcs/G5Efwsjw7KMeU3A2Al6HKhlZqc//puKPjavBsZ9LTc3wsuumXcWcBymlO1
	 5b4mLD67PaKNu763DE5OUYHup6EIRYm+vsnOXJHrCDsQAiZCSUsc8/uqdj0kjW30Av
	 970OL0AbtcAiQ==
Message-ID: <sashiko-outbox-207760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] selftests/landlock: Test capabilities guarding
 other LSMs' policies
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261110203042.2410140-7-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
 <20261110203042.2410140-7-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 21:02:33 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/landlock: missing set_root_euid() in
  apparmor_policy_load()
--

commit 04d94a6e7f98554d70c200b902dd42758c1ea088
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

selftests/landlock: Test capabilities guarding other LSMs' policies

This commit adds selftests verifying that Landlock capability restrictions
on CAP_MAC_ADMIN and CAP_MAC_OVERRIDE apply to Smack label operations and
AppArmor policy loading, along with an audit test for Smack capability
denials.

> diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/=
selftests/landlock/cap_test.c
> index 741567c5ab417..7f9b7fb2bade8 100644
> --- a/tools/testing/selftests/landlock/cap_test.c
> +++ b/tools/testing/selftests/landlock/cap_test.c
[ ... ]
> @@ -969,6 +974,180 @@ TEST_F(cap_other_hooks, capset_inheritable)
[ ... ]
> +/* AppArmor requires CAP_MAC_ADMIN to load policy. */
> +TEST_F(cap_other_hooks, apparmor_policy_load)
> +{
> +	if (!is_lsm_active(_metadata, LSM_ID_APPARMOR))
> +		SKIP(return, "AppArmor is not active");
> +
> +	if (access(APPARMOR_LOAD_PATH, F_OK)) {
> +		set_cap(_metadata, CAP_SYS_ADMIN);
> +		ASSERT_EQ(0, unshare(CLONE_NEWNS));
> +		ASSERT_EQ(0, mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL));
> +		ASSERT_EQ(0, mount("securityfs", "/sys/kernel/security",
> +				   "securityfs", 0, NULL));
> +		clear_cap(_metadata, CAP_SYS_ADMIN);
> +	}
> +	ASSERT_EQ(0, access(APPARMOR_LOAD_PATH, F_OK));
> +
> +	enforce_cap_variant(_metadata, variant, CAP_MAC_ADMIN);
> +
> +	EXPECT_EQ(EACCES, write_apparmor_load(_metadata));
> +
> +	set_cap(_metadata, CAP_MAC_ADMIN);
> +	if (variant->is_allowed) {
> +		EXPECT_EQ(EPROTONOSUPPORT, write_apparmor_load(_metadata));
> +	} else {
> +		EXPECT_EQ(EACCES, write_apparmor_load(_metadata));
> +	}
> +	clear_cap(_metadata, CAP_MAC_ADMIN);
> +}

[Severity: Low]
Does apparmor_policy_load need to call set_root_euid(_metadata) before
testing write_apparmor_load()?

Writing to /sys/kernel/security/apparmor/.load reaches
aa_may_manage_policy() -> aa_policy_admin_capable() ->
aa_policy_view_capable():

security/apparmor/policy.c:aa_policy_view_capable() {
	...
	bool root_in_user_ns =3D uid_eq(current_euid(), make_kuid(user_ns, 0)) ||
			       in_egroup_p(make_kgid(user_ns, 0));
	...
}

When cap_test is run as a non-root user with file capabilities,
root_in_user_ns is false, so write_apparmor_load() returns EACCES instead
of EPROTONOSUPPORT in the allowed variants even when CAP_MAC_ADMIN is
effective.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110203042.2410=
140-1-mic@digikod.net?part=3D6
