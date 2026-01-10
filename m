Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6C50095B;
	Sat, 10 Jan 2026 04:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768020615; cv=none; b=mH7b2XUPiOn8/iSeBA4PNNiqYFglJ1eRQZbRN1qrChJDzt4DNATsNuKeMiCy5ZKfQMKWS5h1FHUY08fFTZDGUgsdOZBDEEGhs6EuVmTBl+J1gPMTDebTiggDN2+iQjgo71axqpZEYh5+HA3XesSw/GKIy2UtCclrntWnbLNHRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768020615; c=relaxed/simple;
	bh=a10ftqpzbvmGSVeWWTQB6gxfA7Vx120gSllM/nEde88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyKxzGdeFa9oc8EneoCdFnzoS1QO0te5vrhXfo50mnG7LSZIBwOEMjKosIqye8hXgmDjR2AYk/r/MbXtP8E6zJEjvLHdV1GFN9ssKgNgCgqzhHNfkBGePU4aBQfHoHSht91FwyzpvNjiHBxZgX4BLtNXNZ3evtvix08ruFeNO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=VFxUsARh; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="VFxUsARh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1768020605; bh=a10ftqpzbvmGSVeWWTQB6gxfA7Vx120gSllM/nEde88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFxUsARhBLIZDTJEyMRjO2xelN8/mLC35kIMJnip5zD+paxZJ/fOAvZvh7e5bVcQg
	 cn/uyicPFwf4Eg6hAMsS1FjorlGP4X47YJFO8HrGZ+icpd9ky3St3PcdIKNy08OO9T
	 /0JPrN5G6XkdtT3rZguBaXEcN3CWZXynyYW1OrUhq3uJL1UlRCRdOGL80sIMu/xIaU
	 yjqJD1fA42tlGKzyhBx/HPPze4LLBz7PeP1+3w+w0AfgWQGyoVR9+roajLiHgdG1Nm
	 jJNOXKDziAH6IgNdVDx9U2jbSMhuKHsa+Baih1w02qsnS7GJ7oCuFhGe1Z74HK/UD4
	 oXo9tzrLtefLQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 1D263708; Fri,  9 Jan 2026 22:50:05 -0600 (CST)
Date: Fri, 9 Jan 2026 22:50:05 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Ryan Foster <foster.ryan.r@gmail.com>
Cc: serge@hallyn.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	selinux@vger.kernel.org
Subject: Re: [PATCH v6] security: Add KUnit tests for kuid_root_in_ns and
 vfsuid_root_in_currentns
Message-ID: <aWHafb6DujTuEZ7l@mail.hallyn.com>
References: <aV15rKEt3rvW3hBK@mail.hallyn.com>
 <20260107215725.105822-1-foster.ryan.r@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107215725.105822-1-foster.ryan.r@gmail.com>

On Wed, Jan 07, 2026 at 01:51:28PM -0800, Ryan Foster wrote:
> 
> Here's v6 with both fixes combined. The Dec 29 version you have in caps-next 
> is correct for the namespace config - v6 keeps that and adds the KUNIT=y 
> dependency to fix the Intel CI build error.
> 
> Changes in v6:
> - Namespace config: all three namespaces are independent children of 
>   init_user_ns (same as Dec 29 you reviewed)
>   
> - Build fix: depends on KUNIT=y prevents link errors when KUNIT=m
> 
> The Dec 30 patch accidentally reverted the namespace fix when I was adding the 
> KUNIT=y part. This v6 has both fixes working together.
> 
> Thanks, Ryan
> 
> Add comprehensive KUnit tests for the namespace-related capability
> functions that Serge Hallyn refactored in commit 9891d2f79a9f
> ("Clarify the rootid_owns_currentns").
> 
> The tests verify:
> - Basic functionality: UID 0 in init namespace, invalid vfsuid,
>   non-zero UIDs
> - Actual namespace traversal: Creating user namespaces with different
>   UID mappings where uid 0 maps to different kuids (e.g., 1000, 2000,
>   3000)
> - Hierarchy traversal: Testing multiple nested namespaces to verify
>   correct namespace hierarchy traversal
> 
> This addresses the feedback to "test the actual functionality" by
> creating real user namespaces with different values for the
> namespace's uid 0, rather than just basic input validation.
> 
> The test file is included at the end of commoncap.c when
> CONFIG_SECURITY_COMMONCAP_KUNIT_TEST is enabled, following the
> standard kernel pattern (e.g., scsi_lib.c, ext4/mballoc.c). This
> allows tests to access static functions in the same compilation unit
> without modifying production code based on test configuration.
> 
> The tests require CONFIG_USER_NS to be enabled since they rely on user
> namespace mapping functionality. The Kconfig dependency ensures the
> tests only build when this requirement is met.
> 
> All 7 tests pass:
> - test_vfsuid_root_in_currentns_init_ns
> - test_vfsuid_root_in_currentns_invalid
> - test_vfsuid_root_in_currentns_nonzero
> - test_kuid_root_in_ns_init_ns_uid0
> - test_kuid_root_in_ns_init_ns_nonzero
> - test_kuid_root_in_ns_with_mapping
> - test_kuid_root_in_ns_with_different_mappings
> 
> Updated MAINTAINER capabilities to include commoncap test
> 
> Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>

Thanks, applied to git://git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git #caps-next

