Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7B420868;
	Wed,  8 Jul 2026 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469852; cv=none; b=eF7PmHXKo+EbTXgwFhz2Aioc95UGhi0egQcFTpYBqcWQiZR3O8skgX0s9mZal3FFOIHGV2BFx0cux3VqYBCNa2hMNNN4nU6uAkOcXuTvdOqdviHTyDSJO6hvE+db4AqOELAGp5Kax0fmShc0sp1Mcmv1rHb067O4HH5qYNUlTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469852; c=relaxed/simple;
	bh=mJ2tXIQ0ivNIqak1fDmBTJNOWoljvAgImBRvP1hijww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QWAP15dfqqULbBUTa08Y6cc29Uh4e9joqDvRVsohTJVCB4ZcsYGn2U0sqocHeaF6tNmil80dBhPfJ7+z2eMXYsw1+6NcQS9nKxMIzK0QJhQ6TV1HPo/CJ2tBRMdy3YNfK6gWMBpoUbJivMXHAamg2ui6HYS+CIywFcRceombnEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT7RB4Sr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT7RB4Sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA051F000E9;
	Wed,  8 Jul 2026 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783469851;
	bh=rNxqAx8a6mOIyK4hOCrCO/DTLd3GGUGrVLUWLC8lwnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LT7RB4Srwghjxy91zhr8jiFhLkNfGYvhlibXZjO+q6rq3Mz/nwGvAAOPnRzwOGd4K
	 46z2PLKWKydxiTf6QZHnAV62BS7liqstB1FejZZbE5yfykhmQvTr/JHhDiNe4zJx3A
	 28lD+Rt4XbvMor2aB9RGAYy3zO9VAqrZAPNaHK83/DPNH/PYTnkzvrdoyFub2edC9a
	 +TV7goEar6xVjkR8GZDn/HTjR48pPDXoQGRi5RaDdqPYfhGJYfw3pGBP/s2Vtp+h1p
	 1+VNwM2++O16YgwvxkqTKGf+iyes9VjerDxiSdDV8LMuN9EDgN5aQowDyl59WTQ1XS
	 7C1Sa920C6wTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 bpf-next 3/3] selftests/bpf: add tests for
 bpf_init_inode_xattr kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260708000956.46138-4-dwindsor@gmail.com>
References: <20260708000956.46138-1-dwindsor@gmail.com>
 <20260708000956.46138-4-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 00:17:30 +0000
Message-Id: <20260708001731.1EA051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing file cleanup before file creation causes flaky tests. If=
 the test files already exist, `open(O_CREAT)` will not trigger the LSM hoo=
k, leading to test failure.
--

--- Patch [3]: [PATCH v5 bpf-next 3/3] selftests/bpf: add tests for bpf_ini=
t_inode_xattr kfunc ---
commit fb13c41f9d223f18ed7c34e0e581869c6933b5e5
Author: David Windsor <dwindsor@gmail.com>

selftests/bpf: add tests for bpf_init_inode_xattr kfunc

This commit adds BPF selftests to verify atomic inode xattr labeling in the
inode_init_security hook. It introduces tests that attach to the hook and
validate that bpf_init_inode_xattr properly sets xattrs and respects the
per-inode slot limit.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/t=
esting/selftests/bpf/prog_tests/fs_kfuncs.c
> --- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
[ ... ]
> @@ -268,6 +269,123 @@ static void test_fsverity(void)
> +static void test_init_inode_xattr(void)
> +{
> +	struct test_init_inode_xattr *skel =3D NULL;
> +	int fd =3D -1, err;
> +	char value_out[64];
> +	const char *testfile_new =3D "/tmp/test_progs_fs_kfuncs_new";
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
Will this test become flaky if the file already exists from a previously
aborted test run?

If the testfile remains on disk from an earlier crash or failure,
open() with O_CREAT will simply open the existing file rather than create a
new inode. This would bypass the inode_init_security LSM hook entirely,
meaning the BPF program won't execute and init_result will remain at its
default value, causing the test to fail.

Would it be safer to call remove(testfile_new) before this open(), or use a
unique temporary filename to ensure the hook is always triggered?

> +	if (!ASSERT_GE(fd, 0, "create_file"))
> +		goto out;
> +
> +	ASSERT_EQ(skel->data->init_result, 0, "init_result");
[ ... ]
> +static void test_init_inode_xattr_slot_limit(void)
> +{
[ ... ]
> +	/* Trigger inode_init_security once with all programs attached. */
> +	fd =3D open(testfile_slot, O_CREAT | O_RDWR, 0644);

[Severity: Medium]
Does this face the same issue where a pre-existing testfile_slot will
prevent the LSM hook from firing?

If remove(testfile_slot) is called prior to open(), it would guarantee a
new inode is created each time.

> +	if (!ASSERT_GE(fd, 0, "create_file"))
> +		goto out;
> +
> +	/*
> +	 * Exactly INIT_INODE_XATTR_MAX programs claim a slot; the program past
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708000956.4613=
8-1-dwindsor@gmail.com?part=3D3
