Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B93AFCE3;
	Thu, 30 Jul 2026 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455734; cv=none; b=JXwrJrRI4yUjxI6GL+nMlkyGBemFnHIT4Kzo+sN0yzAe3wFVgPeB5fRzDA5v7nNmdCT4jJy0wDNuiqi/6Ubu3TDHBmHFF9mO3l4TEqPb6ObAfADn/yTgfjVAxIZyiEh5aB6F0vb2MrfUaqGNqk8MmZbafHWd2GOrQiS0vieOTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455734; c=relaxed/simple;
	bh=SHi8hrGUVMlXpUQThGcl02Kp25AXCrQA3skq36nYaNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nx0VmoTbR5tFanPSHvjwLuS/04B7PX6uRI9+Y4GMGPs7SWQhzjotyUrqBnYGa56J6DPouitu1xvP9iNVxiWRBH/KmHjNuUjJ5LhEyd1QXk58zZ6Jr0CC0cpO+SRtWGlQQR3V+TKsaz68cUvxWHDwIH/8nRqTmexxHLPUQHgjbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDLKaG8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDLKaG8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02691F000E9;
	Thu, 30 Jul 2026 23:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785455732;
	bh=enAXmSOcZALStM88krp1E0Bemr2SIz+zXReAN6uGbt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eDLKaG8lWRAEDtU9loukW/gsRMvzKbo8TXu8cG3OXRbTigJvL8sG9+OQJrLodvUKn
	 RdCDhKXgmMKVAEefvOHkNEScUof+vmD45v4aaJby1yKPjfP7fXvkYwr3cSlqYit8NB
	 bLVlDpoz9rf8+5Y4tAFhOsCHbR3AmliZMXCIaIrr6AeqtSaEnEPn5HXEcT6LtAFC4V
	 xvuzumsT2kfr7xOAZM5Cimp7lttItwKyDN7L4h28w3jKIWsWUy/U5loFOrT1vTCbYx
	 3wCLVthCeGdwZkiXZ3V1WpjL+Bg5LbxKk3p5mKzm+ikveTuwnpdwQrKNPLbA1jwFiX
	 nM7xowUxg7zgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 bpf-next 4/4] selftests/bpf: add tests for
 bpf_init_inode_xattr kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260730234533.1912709-5-dwindsor@gmail.com>
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-5-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 23:55:32 +0000
Message-Id: <20260730235532.B02691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Silent test skipping if the testfile exists from a previous abor=
ted run.
- [Low] Multi-line comment does not follow the required BPF subsystem style.
--

--- Patch [4]: [PATCH v6 bpf-next 4/4] selftests/bpf: add tests for bpf_ini=
t_inode_xattr kfunc ---
commit a299ac47c44a77d98dbdf43f3ba7c981f13fd930
Author: David Windsor <dwindsor@gmail.com>

selftests/bpf: add tests for bpf_init_inode_xattr kfunc

This commit adds selftests for BPF atomic inode xattr labeling in
the inode_init_security hook.

> --- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c

[ ... ]

> @@ -268,6 +269,155 @@ static void test_fsverity(void)
>  	remove(testfile);
>  }
> =20
> +static void test_init_inode_xattr(void)
> +{
> +	struct test_init_inode_xattr *skel =3D NULL;
> +	int fd =3D -1, err;
> +	char value_out[64];
> +
> +	/* This test must be run from a fs that calls
> +	 * security_inode_init_security().
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment violate the BPF subsystem
style guidelines? The guidelines prefer the opening /* on its own line:

	/*
	 * This test must be run from a fs that calls
	 * security_inode_init_security().
	 */

> +	const char *testfile_new =3D "/dev/shm/test_progs_fs_kfuncs_new";
> +
> +	skel =3D test_init_inode_xattr__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_init_inode_xattr__open_and_load"))
> +		return;
> +
> +	skel->bss->monitored_pid =3D getpid();
> +	err =3D test_init_inode_xattr__attach(skel);
> +	if (!ASSERT_OK(err, "test_init_inode_xattr__attach"))
> +		goto out;
> +
> +	/* Trigger inode_init_security */
> +	fd =3D open(testfile_new, O_CREAT | O_RDWR, 0644);

[Severity: Medium]
Could this result in silently skipping the test if the file already exists
from a previous aborted run?

By omitting O_EXCL, if the test file is already present, open() will not
create a new inode. This means the inode_init_security hook won't trigger,
and the test will hit the skip condition below. Should we use
O_CREAT | O_EXCL | O_RDWR here to ensure we always create a new inode?

> +	if (!ASSERT_GE(fd, 0, "create_file"))
> +		goto out;
> +
> +	/*
> +	 * Probably should not be needed as we will be labeling a file
> +	 * in /dev/shm, but just in case we check if the hook was actually
> +	 * called.
> +	 */
> +	if (!skel->bss->hook_ran) {
> +		printf("%s:SKIP:inode_init_security hook was not invoked\n",
> +		       __func__);
> +		test__skip();
> +		goto out;
> +	}

[ ... ]

> +static void test_init_inode_xattr_slot_limit(void)
> +{

[ ... ]

> +	/* Trigger inode_init_security once with all programs attached. */
> +	fd =3D open(testfile_slot, O_CREAT | O_RDWR, 0644);

[Severity: Medium]
Does this face the same issue where a pre-existing file from a previous
aborted run could cause the test to silently skip?=20

Adding O_EXCL would guarantee the inode is created and the hook is
triggered.

> +	if (!ASSERT_GE(fd, 0, "create_file"))
> +		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730234533.1912=
709-1-dwindsor@gmail.com?part=3D4
