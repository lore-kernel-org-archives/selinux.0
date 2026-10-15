Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E7154425;
	Thu, 15 Oct 2026 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068394; cv=none; b=UzVAwSkfTnlEjhOuE5tCg7O3aO8jZPrYKKBbLFIMM3SUlou5PlDqxA+/WmTuMe4Rr3VIeYc16BWZKiAhRWv5G3qKi3MKVE+s/grP30P/zDIp3/cGrOmTPsEGhmm8CDHJUsenUf7M0ODqCtdr66NfQWezsLCPFaONGNn+TOgAso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068394; c=relaxed/simple;
	bh=UOPthWoU6vTrRhoY6+yql2QUYF59fWMykBfO1SrtK8c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CRbufFLoUeH0agEKDKjzrn/v1tsdOjahmhyUsZGQ+yb3u+eIPRPTCftaQnOkQBREjanbRzlNzsXaHrNn9x9dlDiEa4wp/agxyR7Kz3c2AtWU5VzhQS/4PfxTrz//Rzjh4qXCBJw2cpYxcbgSScFiVcP82GVC77+4OSZb2z/GZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY0frMGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY0frMGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294B21F000C4;
	Thu, 15 Oct 2026 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068392;
	bh=VWcJq9INiAuVzwdCjQBu5vBURcRDe4u4t6rDjXko4oU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bY0frMGDK+tWU4/S7veUx2bL+tOHPgiju0MwdufELxaI4MVrW9Sef5thaSVpLIEOm
	 pL6hi8EpX3q/IBa3WHVD6rDY5sSfJPLOjmHFEzfJW5Fm8qX5sSMSITTyJqZ8qLNVp1
	 G/ixe7uidq38KxQrL9zKLLr3FWvzG7emXofsV15885j6trY8ndxbWinCpMu65brF9J
	 OiEWlfYxgfIIOIwbMUDsklLpuhOZ6zRb690+CTURR9e34rsEcjqS0ZcEMyjgKRgm1R
	 iD+lXJShyiiHFEuqfJmUPnWoBpoGaPEgqDzzjdlfkuD7xohI5oQe59cmWNsUmY/Jub
	 iDwN6vb1CX92A==
Message-ID: <sashiko-outbox-172860@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 16/18] selftests/landlock: Add tests for
 metadata access rights
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261015125425.3246251-17-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-17-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:46:31 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/landlock: test logic and commit message contradiction =
in fileattr_write_only
- [Medium] selftests: hardcoded syscall fallbacks 468/469 are incorrect on =
Alpha
--

commit 14e6c962c9835f4d2f9d99bb2bfea0e277c3117a
Author: Cai Xinchen <caixinchen1@huawei.com>

selftests/landlock: Add tests for metadata access rights

This commit adds layout1 and layout2 tests for the newly introduced
LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA
access rights. It verifies metadata restriction behaviors for various
system calls and fileattr interfaces, including overlayfs scenarios.

> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c

[ ... ]

> +#ifndef __NR_file_getattr
> +#define __NR_file_getattr 468
> +#endif
> +#ifndef __NR_file_setattr
> +#define __NR_file_setattr 469
> +#endif

[Severity: Medium]
Are these hardcoded syscall fallbacks correct for all architectures?

The assumption that syscalls post-424 are unified across all
architectures is incorrect for Alpha, which uses 578 and 579 for
these syscalls.=20

If the selftests are built on an Alpha platform with older host headers,
it will invoke incorrect system calls (such as splice and sync_file_range),
leading to failures or undefined behavior.

[ ... ]

> +TEST_F_FORK(layout1, fileattr_write_only)
> +{
> +	const struct rule rules[] =3D {
> +		{
> +			.path =3D file1_s1d1,
> +			.access =3D LANDLOCK_ACCESS_FS_WRITE_METADATA,
> +		},
> +		{},
> +	};
> +	unsigned int flags;
> +	int fd, ruleset_fd;
> +
> +	ruleset_fd =3D create_ruleset(_metadata,
> +				    LANDLOCK_ACCESS_FS_WRITE_METADATA, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	fd =3D open(file1_s1d1, O_RDONLY | O_CLOEXEC);
> +	ASSERT_LE(0, fd);
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * WRITE_METADATA alone must be enough to set flags: the kernel-side
> +	 * read of the old flags must not require READ_METADATA.
> +	 */
> +	EXPECT_EQ(0, test_setflags(fd, FS_NODUMP_FL));
> +	flags =3D 0;
> +	/* READ_METADATA is not handled: reading is allowed. */
> +	EXPECT_EQ(0, test_getflags(fd, &flags));

[Severity: Medium]
Does this test logic contradict the commit message?

The commit message states that for fileattr_write_only: "metadata
reads (ioctl(FS_IOC_GETFLAGS)) are still denied".=20

However, the test explicitly creates a ruleset that only handles
LANDLOCK_ACCESS_FS_WRITE_METADATA. Because
LANDLOCK_ACCESS_FS_READ_METADATA is unhandled, reading metadata is globally
permitted, and the test expects test_getflags() to succeed.

Additionally, by leaving READ_METADATA unhandled, does this test fail to
effectively verify that FS_IOC_SETFLAGS (which internally reads metadata)
works when READ_METADATA is actively restricted?

> +	EXPECT_EQ(FS_NODUMP_FL, flags & FS_NODUMP_FL);
> +	EXPECT_EQ(0, test_setflags(fd, 0));
> +
> +	ASSERT_EQ(0, close(fd));
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D16
