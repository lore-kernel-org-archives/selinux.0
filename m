Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928360;
	b=w4svE3iuAvlPt/Itct9qyA6WUOpqDkZPFTcF3hUh+gc1gKCPhpAi8V52o1aCJj7fyqi0
	 cbDZ1M/NJ7VXWYFVAcdA6SC3QGRgZw8Pl2bzStTHZ1RGH3nStVEvIg1FBEEqy+djU8BCj
	 PaPC0Hb/tftYpj6hZdN/01rT8lauSCeXmDUMeCw69Y+nf6dXGxmYoh1pkJupdNYW4GnPq
	 4EfbyOhqj5Rgiv4CyRsRXHaXah4kod3Wak1S07utn5Tfd3ySJyFWt5cOrThRNVER5KCX/
	 4yvfIW4Wps/5zEPbqMo3fNPWLt7EcJnO4IuakWmbmAHg7cQjqbZGj177sitEHJWYYDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928360;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o2aVQzzisEWd87z6KaSb862RqKdVox+S/dYlgtvizfI=;
	b=N+Q6U7BY6+mvR9XXdOBz5kzZXMngrv4e8hwS5xs2GHCQvc+BWNfdzVF6LwQf6RhKpy48
	 bat0SuznG6xsMGJKpFqFyPqS4DJgPLwkX2sqk9lUW2w5QCw8YuOeDvJkMnRMAR7sLhr2U
	 zS20mcCzOt37HKkzbr+apA1HP3+b0fsuS8UiK8IEWoXDCv1d2H7mo5Eanfivp+gSYXGPe
	 q+ytQbwefxXLCt6hjhTce2In/jisaXsgmfw73+DEDuYCTWDOQ1C4h/YFM9XVdNS4XwUSC
	 pkpwEpNpCf1o/0j2spMZ1whscbqrNHgHNWhqVfugEOhUQTne42IkERNl1Q6UuJ4nlzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ec5gUQ/o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90955606A334;
	Tue, 17 Nov 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ec5gUQ/o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1981F000CB;
	Tue, 17 Nov 2026 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794928360;
	bh=o2aVQzzisEWd87z6KaSb862RqKdVox+S/dYlgtvizfI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ec5gUQ/oI+dp0uuDnAk8EDPRdn3liOUGyvowPo3hWLqwP1y5UBleDuT2ZzrAY6EaQ
	 TvD1iANNCBSIRZKCmx57biV3/bQtt8uiTOTks7lyILOGtmZ3KE7c7x3Y8xRkOeIsqk
	 uN+kOmSEXpLMnCCcY3CGSG05BTwNjSdKjyEeXfHCL2sNwmcykxk9ABpKz+k0aH3MBS
	 UvQM0CDh6VgIet8znUMG4awsxOuLqQw2ByVsLK5HqeukOUKg4I6rzIY5nzP8JrZ/o8
	 7d7lHCQ3dW4fG9zH0OHUM9ZQlwnFx/33EMRMTUXmAWnjeokAYcoykeX+c+/V4OZchf
	 LdUIpOIVMrTjw==
Message-ID: <sashiko-outbox-219038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 15/17] selftests/landlock: Add tests for
 metadata access rights
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117150542.1169451-16-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-16-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:12:39 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Add layout1 and layout2_overlay tests for the two new rights:
> unhandled_metadata, write_metadata, read_metadata, fileattr,
> fileattr_write_only, metadata_open_time and metadata_transfer.  They
> cover the metadata system calls, the fileattr interfaces, the open-time
> semantic and the transfer of file descriptors between processes.
>=20
> The file descriptor-based checks reopen their files after the ruleset is
> enforced, so that the rights come from the rules rather than from
> descriptors opened before the sandbox, and the chown(2) no-op tests use
> the effective group ID so that they also pass as non-root.
>=20
> The fallback syscall numbers for file_getattr(2) and file_setattr(2) are
> overridden on alpha and MIPS, which do not use the generic numbers.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D15

