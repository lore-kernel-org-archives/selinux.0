Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E57233933;
	Tue, 30 Jun 2026 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845462; cv=none; b=UHabML1Rg0bytpWd2leef0xfQZVa2czAIbrzi/Ev0JDOK6tiDbMqoDhWkY5OWWV8pUjLkiXVRPpZY3gqZUR8eTFxIRRvWuNWM9Rhz2NOn12bq+O6POiPjWB0r9f5+fWCU4Gz13kHY3IcaECxVXgt625ql1hBmdyf+5ppL8ZXLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845462; c=relaxed/simple;
	bh=kyVkXyc/CRE1P42mt+kc8FCAR2ecXVss//zPwyRniRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pwQwh6L+qUNVbf6TMA7e+ZUX0R7Y8UE2bTz3VhrWc3VErNwlJO4byuLT2YqNcgF8NZKBFwrkLlzbsIvhv+LC3/HDqHv7319qBIYmjjIvJ+2HtGfxOkIEVlkOnm2Jb91Lrs4d7pYjJ4nj5PoCw62yUrFZh5TxpXkie31TbVRASLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU/YbiRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU/YbiRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F481F000E9;
	Tue, 30 Jun 2026 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782845461;
	bh=+zI3ALXQ0/fGvtpuncfJ9f6z4k2oLCNLfTv93+3Yg+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SU/YbiRv4aTnikdBDpQHU5c4rPMqUCu8ckwY6/kvqNem3Kn6DK96INv05ii7glJEn
	 CamYOlwYd3w3MxMnsGiCO0CDXIVh93mNZw8CStZOsIeniz3ZQQeUwYVEr0HSgoljOc
	 M1qWKDGPB6If6/atUGMEgL8HqTfZGrrYKxlHlGV0U2X9bBO/JrpvqgVmKT+9Q22OT1
	 3FHBMIrBvFY5ywfHqzuDytsIkuiDF8/yBNyKhIMnChozheqa8LDI4mNEx+lZ6pkI0V
	 iHr90NBGxVyVFPRsRW7yQtTPz1fyJBpaFlLN3zo5RmNDvCCChnmYGX3pgnxPgU17K2
	 njXPapznqtaWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 3/3] selftests/bpf: add tests for
 bpf_init_inode_xattr kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260630183956.281293-4-dwindsor@gmail.com>
References: <20260630183956.281293-1-dwindsor@gmail.com>
 <20260630183956.281293-4-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 18:51:00 +0000
Message-Id: <20260630185101.68F481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The tests use predictable temporary file paths with `open(..., O=
_CREAT)` but without `O_EXCL` or prior cleanup, leading to test flakiness a=
nd a symlink attack vulnerability.
- [Medium] The slot limit test triggers duplicate xattr name creations duri=
ng `inode_init_security`, causing the test to fail on filesystems like ext4=
 that enforce `XATTR_CREATE`.
--

commit 9defa5666243f46c3a058ad117a6ee0ace1b9f5c
Author: David Windsor <dwindsor@gmail.com>

selftests/bpf: add tests for bpf_init_inode_xattr kfunc
   =20
Test bpf atomic inode xattr labeling in inode_init_security.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/t=
esting/selftests/bpf/prog_tests/fs_kfuncs.c
> index 43a26ec69a8e3..8b2e0d433aea2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> @@ -268,6 +269,116 @@ static void test_fsverity(void)
>  	remove(testfile);
>  }
> =20
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
Since this test runs as root and uses predictable paths in /tmp/, can this
allow an attacker to place a symlink to overwrite arbitrary system files?

Additionally, if a previous run leaves the file behind (e.g., via panic or
early abort), open(O_CREAT) without O_EXCL will open the existing file
instead of creating a new one. This bypasses the inode_init_security hook
entirely, which can cause the test's assertions on init_result to fail
spuriously.

Would it be better to add O_EXCL to the open() flags or unlink the file
before opening?

> +	if (!ASSERT_GE(fd, 0, "create_file"))
> +		goto out;

[ ... ]

> +static void test_init_inode_xattr_slot_limit(void)
> +{
> +	struct test_init_inode_xattr *skel[INIT_INODE_XATTR_MAX + 1] =3D {};
> +	struct bpf_link *link[INIT_INODE_XATTR_MAX + 1] =3D {};
> +	const char *testfile_slot =3D "/tmp/test_progs_fs_kfuncs_slot";
> +	int ok =3D 0, nospc =3D 0, other =3D 0;
> +	int i, fd =3D -1;
> +
> +	/* All programs attach successfully; there is no attach-time cap. */
> +	for (i =3D 0; i <=3D INIT_INODE_XATTR_MAX; i++) {
> +		skel[i] =3D test_init_inode_xattr__open_and_load();
> +		if (!ASSERT_OK_PTR(skel[i], "open_and_load"))
> +			goto out;
> +
> +		skel[i]->bss->monitored_pid =3D getpid();
> +
> +		link[i] =3D bpf_program__attach_lsm(skel[i]->progs.test_init_inode_xat=
tr);
> +		if (!ASSERT_OK_PTR(link[i], "attach"))
> +			goto out;
> +	}
> +
> +	/* Trigger inode_init_security once with all programs attached. */
> +	fd =3D open(testfile_slot, O_CREAT | O_RDWR, 0644);

[Severity: Medium]
Will this test reliably fail on filesystems like ext4?

The test attaches 5 identical BPF programs to inode_init_security, which all
attempt to add an xattr with the exact same name (bpf.test_label).

On ext4, ext4_initxattrs() passes the XATTR_CREATE flag to
ext4_xattr_set_handle(), meaning the second identical xattr creation fails
with -EEXIST. This failure propagates up to the VFS, causing the open()
syscall here to fail with -EEXIST and breaking the test before it can valid=
ate
the slot limits.

Should the attached BPF programs generate unique xattr names?

(Also, similar to test_init_inode_xattr(), this open() call might benefit
from O_EXCL to prevent symlink attacks and test flakiness).

> +	if (!ASSERT_GE(fd, 0, "create_file"))
> +		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630183956.2812=
93-1-dwindsor@gmail.com?part=3D3
