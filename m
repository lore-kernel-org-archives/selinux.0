Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB07475342;
	Thu, 10 Sep 2026 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052554; cv=none; b=lk8pObu5ByitiL8b6vvf+t+DojaS5A9Ub/O5lJBnVs4ypugEi09F0AgTZr1lgLmMznE0gvTlCclnXHIvvEnRtIpN/6vvA+zGKoXgF7Ch6u+mzJfCLs+Kq4gygG0JBzN9Dir5/sQ7UIhoHuNYTVT4OQq1OQuY84YGkVk9Jncvaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052554; c=relaxed/simple;
	bh=s78oIKpVAwudSobYBrw71T0EeiJoh7UNhajjQWF3wAE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qXejDERHdMejDVVBCvI8c7luFhV9eoEVsCV+g8NsIYYM+8dK9KegOu5oSeOPEjclC6jr7Q0hCY0EfKW3RPtjmPed96GUF5j64Jk54+IjIGXAd5F8BSUMYQBdzKx9Jd62+g8Ve51/lkZAyoFdGFywfpZw7qRG5d+l5Z9BgoroRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkJq4lTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkJq4lTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680081F000FF;
	Thu, 10 Sep 2026 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052552;
	bh=Vd4Tx7a1KQM51gcptDQgMjNyzMdXfR0zGvfB//PT88w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZkJq4lTrjSMYxw9iDNw4FUVdel3SRzBmpipp6e6Yqgvk0YkxABYeI+SrnFzbIh+vK
	 F2/DAu/nCj7mRiQBvOALFzOvdQGBBWXzRBBZLAeSpNlKhABxggRm12MEQE9Y8R8RC7
	 us0LbKEKtBhtF21FWekLXezE1E1am7LJ9eND0qU+BUHptOBnPUqi73ZCHYehFXmxwk
	 fqaPfUrzF+R8WKWMfsAq3vcxf8eubFaaQzpaNn460LaRKXRkfjpN9mzeu4vjhfhFMY
	 QoNCFmcfyEo7D+8tAXUsO/gAkmJmwzC2TvQQrmiZbzSFcwRGPNlLDCSA8s80APdb9P
	 DBPyNBkRaSvNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] selftests/landlock: Check full ioctl commands in
 audit records
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260910144837.381855-3-mic@digikod.net>
References: <20260910144837.381855-1-mic@digikod.net>
 <20260910144837.381855-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 15:02:31 +0000
Message-Id: <20260910150232.680081F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete application of the architecture-independent ioctl tes=
t update, leaving `audit_quiet_layout1_test_body()` still using the archite=
cture-dependent `FIONREAD`.
--

commit e4cb547991b6b44a81dce30858992f55ca217a5f
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

selftests/landlock: Check full ioctl commands in audit records

This commit updates the ioctl audit test to use a 32-bit
architecture-independent command instead of FIONREAD. This ensures the test
can detect if the kernel truncates the encoded direction and size bits in t=
he
audit record.

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 86e08aa6e0a7e..92d2f720ab054 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c

[ ... ]

> @@ -7702,10 +7706,10 @@ TEST_F(audit_layout1, ioctl_dev)
> =20
>  	fd =3D open("/dev/null", O_RDONLY | O_CLOEXEC);
>  	ASSERT_LE(0, fd);
> -	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FIONREAD));
> +	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, unknown_ioctl_cmd));
>  	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
>  					  "fs\\.ioctl_dev", "/dev/null",
> -					  " ioctlcmd=3D0x541b"));
> +					  " ioctlcmd=3D0xc00ffeee"));

[Severity: Medium]
Should the audit_quiet_layout1_test_body() function receive this same updat=
e?

It appears that audit_quiet_layout1_test_body() still uses FIONREAD and
hardcodes the x86 16-bit value:

tools/testing/selftests/landlock/fs_test.c:audit_quiet_layout1_test_body() {
    ...
    ret =3D ioctl_error(_metadata, fd, FIONREAD);
    ...
    if (target->audit_ioctl)
        ASSERT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
                                          "fs\\.ioctl_dev", target->target,
                                          " ioctlcmd=3D0x541b\\+"));
    ...
}

Leaving this unchanged means the quiet audit tests will fail to verify the
32-bit truncation fix. It also leaves the test broken on non-x86 architectu=
res
like Alpha and MIPS where FIONREAD has a different value.

> =20
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910144837.3818=
55-1-mic@digikod.net?part=3D2
