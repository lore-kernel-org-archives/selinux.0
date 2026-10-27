Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113872;
	b=hh3oSsCzLx6/mhXueQmWgcnG0A1Qa21z+XAAXo42X0F4dWYJP0BgWMUwLzJdV5y1yZAC
	 LWPYMExVilgIUwVGiJSykC8rMWlIemkJVic1Eq14fB2XCmr6uu+JX6RDTMr/W/hglTOf9
	 mt2h9vY+adUgClxSRCtgw48BijhAMN0odjDtsYJyEcR8FKRPCMG6A4Zt9FvyQtO9rFaR6
	 tEKan7sygx1DPvLLiMAMr4QCCg0DDWv7ZE6ZgSV9wc7VzYHIzxV6XlSlFmwSL2qiJVBcA
	 Tf/FZgdyeSJ/WQEAJBm4eMHJPeFdPfty5027Q06jkApdI22DDBWIDiVqbLgz192DBoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113872;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WAORpCca99WVFsa9yjQHj3w3E3G9OGYxMnl8hxLGEco=;
	b=eiaWKYX3L6a76ovH9CeZS0149LetLkoH2yyrucytglRCxFNlWlT/foutEEr3apOvo7uw
	 rDZHaxm6+RkBy1yhO/mYve/WEpReqFkDVZ4kwr45Ge1DeBL49N96rb6eoMCIQJqL3+VCI
	 Blt8Yd6BFayYDBpsm6gUqolwVjoiVZKJtFQRW9l+ZCkMF0rqRhd97pzixvV5c3oSWbCeM
	 gCOEE+jBcrMO4FjQBvaCLDJVWmShUUvkHY+gdZSj4Z8krIBHbhnJ4xqm/Y1Cam0WpVBAf
	 CHjeXrJIU6nrQm2DRPHUxNPXjEEM7K2Dst6BUdNV0Em4hd5Po58NAIP9g6l9M9GL5LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCwdUWcP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D14606A31A;
	Tue, 27 Oct 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCwdUWcP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BAE1F01825;
	Tue, 27 Oct 2026 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793113871;
	bh=WAORpCca99WVFsa9yjQHj3w3E3G9OGYxMnl8hxLGEco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SCwdUWcPJ5GOGJmMBPaMdlKCnxMINtnDlwsm7Wy3p/b/7ZazvgRlOdAn7c6eoUE7l
	 MiyeWLL83tdWmgZ43WmhtGBV8nkfNRe8WJZrvFpMaKVqNDLM6Aq1S3Ai39+jvlwPXY
	 lHE1bDqcDl/GFY+RmDmOEM2n9evKzxa1Ur0lwbLcY3p0u68fQLjTtDCM+X4hhJlZhC
	 kyH31xi5KQ9sYUoRBYyBIKssFDb9Zk2mYjtVBNcp1Hm0MvaxzpzWyOwfoH8D0H2Wzc
	 08D3A/YXh3TQzjPo4HZA2ojOQd/BOGWFpRcvRGg24EOY8B9AigBU95bLSZfVJ3LXzt
	 3JSQDSVsEWSiQ==
Message-ID: <sashiko-outbox-186809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 16/18] selftests/landlock: Add tests for
 metadata access rights
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261027121151.1887650-17-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-17-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:11:10 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] selftests/landlock: hardcoded GID 0 in chown metadata tests fail=
s for non-root
- [Low] selftests/landlock: duplicate linux/fs.h include before sys/mount.h
- [Low] selftests/landlock: missing MIPS offset in file_getattr/setattr fal=
lback NRs
--

commit 76c1b6128ed1afd1dd4933dbcba43ffec623cd33
Author: Cai Xinchen <caixinchen1@huawei.com>

selftests/landlock: Add tests for metadata access rights

This commit adds selftests covering the LANDLOCK_ACCESS_FS_READ_METADATA and
LANDLOCK_ACCESS_FS_WRITE_METADATA access rights across chmod, chown,
utimensat, xattr, stat, fileattr, open-time semantics, and overlayfs. It al=
so
updates the ABI version and access mask definitions in the Landlock test
suite.

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index f725882fa4a78..1e819ba952ac6 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -12,6 +12,7 @@
>  #include <fcntl.h>
>  #include <libgen.h>
>  #include <linux/fiemap.h>
> +#include <linux/fs.h>
>  #include <linux/landlock.h>
>  #include <linux/magic.h>
>  #include <sched.h>

[Severity: Low]
Could adding this include of linux/fs.h before sys/mount.h break compilation
on toolchains where glibc headers conflict with UAPI linux/mount.h?

Further down in tools/testing/selftests/landlock/fs_test.c, linux/fs.h is
already included after sys/mount.h and sys/vfs.h with a comment noting the
ordering requirement:

    /*
     * Intentionally included last to work around header conflict.
     * See https://sourceware.org/glibc/wiki/Synchronizing_Headers.
     */
    #include <linux/fs.h>
    #include <linux/mount.h>

Because UAPI linux/fs.h includes linux/mount.h when __KERNEL__ is not
defined, including linux/fs.h at the top of the file pulls in linux/mount.h
prior to sys/mount.h and makes the deferred include a no-op.

[ ... ]

> @@ -10916,4 +10921,918 @@ TEST_F(trace_layout1, check_rule_fs_empty_grant)

[ ... ]

> +TEST_F_FORK(layout1, unhandled_metadata)
> +{
> +	int file_fd;
> +	int ruleset_fd;
> +	const char *const file1 =3D file1_s1d1;
> +	const char *const file2 =3D file2_s1d1;
> +	const char *const dir1 =3D dir_s1d1;
> +	struct stat statbuf;
> +	const struct rule rules[] =3D {
> +		{
> +			.path =3D file1,
> +			.access =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path =3D file2,
> +			.access =3D LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path =3D dir1,
> +			.access =3D ACCESS_RW,
> +		},
> +		{},
> +	};
> +
> +	/*
> +	 * READ_METADATA and WRITE_METADATA are not handled, so metadata
> +	 * access should be allowed.
> +	 */
> +	ruleset_fd =3D create_ruleset(_metadata, ACCESS_RW, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	file_fd =3D open(file1, O_WRONLY | O_CLOEXEC);
> +	ASSERT_LE(0, file_fd);
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	EXPECT_EQ(0, test_chmod(file1, 0644));
> +	EXPECT_EQ(0, test_fchmod(file_fd, 0644));
> +	EXPECT_EQ(0, test_chmod(file2, 0400));
> +	EXPECT_EQ(0, test_chmod(dir1, 0700));
> +
> +	EXPECT_EQ(0, test_chown(file1, -1, 0));
> +	EXPECT_EQ(0, test_fchown(file_fd, -1, 0));
> +	EXPECT_EQ(0, test_lchown(file1, -1, 0));

[Severity: Medium]
What happens in unhandled_metadata (as well as in write_metadata,
metadata_open_time, and metadata_transfer) when the test binary runs with a
non-zero GID or inside a user namespace where GID 0 is unmapped?

Landlock selftests support running as a non-root user with capabilities via
SECBIT_NOROOT in _init_caps(). During fixture setup,
FIXTURE_SETUP(layout1) -> prepare_layout_opt() -> disable_caps() clears
effective capabilities and drops CAP_CHOWN from the permitted set, creating
test files owned by geteuid():getegid().

When getegid() is non-zero and the caller is not a member of group 0,
chown_common() -> notify_change() -> setattr_prepare() -> chgrp_ok() rejects
changing the group to hardcoded GID 0 with -EPERM because CAP_CHOWN is not
held, causing the positive EXPECT_EQ(0, ...) assertions to fail. Similarly,
if GID 0 is unmapped in the current user namespace, chown_common() fails
setattr_vfsgid() with -EINVAL before reaching security_path_setattr(),
causing the EXPECT_EQ(EACCES, ...) checks to fail as well.

Would passing getegid() instead of 0 to test_chown(), test_fchown(), and
test_lchown() avoid depending on the caller's GID while still setting
ATTR_GID in chown_common() and exercising hook_path_setattr()?

[ ... ]

> +#ifndef __NR_file_getattr
> +#if defined(__alpha__)
> +#define __NR_file_getattr 578
> +#else
> +#define __NR_file_getattr 468
> +#endif
> +#endif
> +#ifndef __NR_file_setattr
> +#if defined(__alpha__)
> +#define __NR_file_setattr 579
> +#else
> +#define __NR_file_setattr 469
> +#endif
> +#endif

[Severity: Low]
When building against older UAPI headers on MIPS, won't these fallback
definitions for __NR_file_getattr and __NR_file_setattr evaluate to raw 468
and 469 without the MIPS ABI base offset (__NR_Linux + 468 and
__NR_Linux + 469, where __NR_Linux is 4000 for o32, 5000 for n64, and 6000
for n32), causing test_file_getattr() and test_file_setattr() to fail with
ENOSYS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D16
