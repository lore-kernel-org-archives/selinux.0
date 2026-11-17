Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929429;
	b=IKOFwLoD5HFoqr+sOC4WoBH+XpMaEOQqTGRHthFzjK69P3lHZviB+g5muK45nf4G1JXc
	 i8e+2z/nxyG8bR+zYSh/ttuck9RqeM2+7cgTOQgPjngSeuKxDnbT0/ZI7qS+4EY3Wv0Bu
	 WIl8v8NsYq3zrmINRXzc0XTya7MsGAJ+HwEktPQq3G6/uenVH6xHtGxMybg3vYRe89f10
	 RRSVVrRjlZyS5IxBBuzo5LHh7Hy/kRFZxtHTCVJcw/89q9LaCjrIY3nDRL923tXd2QWbB
	 T/HtChUy/Zl90viz86f30FFjHppFw48HriPpvRYvQT8UfoyF5waX4soMvsRMvZ2hkpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929429;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eUiV82wATUSPCwlSD1XXk58SR4YDh94KILPEirK1hsA=;
	b=eWSeKt0YEX9eK4apJh+l1OhsSb2EKtK0TBESHsGiAqiVhVm1R9/3+TA9hJ7hkXF5kzLh
	 D3Hyc4aYHDOOxxSLbh3t04YdtRWBkFlC6lyugmu+WKsWEAyZ2rHXNv8rXx6pRVfaBVyHQ
	 B2HXqNe+QLZ5Z20zYpR5O7ZreGEW3rtheMh5sMcmAJDGN+o9RKm5QdrFmyun3KtLzmGEG
	 g0nZjIt/IQbGwRiVh5qXkCiXBkr6sol3uwQGFyYz+U3n/e9mwL5JGOB/KKt3LYUkRsIrU
	 Ryadz3EmMsg1ICJ2dWgDAFp9o1nQ0EKsmXN6lGPByKR3gEfgysVcY3YZsZTuoHnoC2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSpkObxc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCB3606A332;
	Tue, 17 Nov 2026 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSpkObxc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BA51F000C5;
	Tue, 17 Nov 2026 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929429;
	bh=eUiV82wATUSPCwlSD1XXk58SR4YDh94KILPEirK1hsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nSpkObxcWQrpakWFJdfq1J245xxBtUofjbRiKt5zGDGQPNFKxsYdsHTTv9JmoFv3v
	 PYLYYxNv8MHKHzjkFAi4aTBWDqI6TBQuz/2FUSu0s8MX7XHkzRcDi2JCGO4p57IxlM
	 TequOgPHspmxigOocZ5MVdOeAs5aWeYUA3fdblBVMEj6au3IpFke5ZuluOckCLholH
	 +XNz0pANMqNzs2KzkEvsEq7w2EHFokRhFenu6QO4BLYhrkn71kaqf+AtXTC/C4fdJZ
	 eygtPWc+R7J1GA10XVHx9XaGz1Bu7CYGdrZDxfegKiLYyYq6ms97AGfo3uNMdTS+OO
	 riB50vlvyiOvw==
Message-ID: <sashiko-outbox-219078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 09/17] LSM: rename inode_getattr to
 path_getattr and pass struct file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117150542.1169451-10-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-10-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:30:28 +0000
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
- [Medium] bpf: missing vfs_getattr_file() in btf_allowlist_d_path
  breaks stat tracing
--

commit 0fd5e45352f3174f9865b405ef695f6fda94ab43
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: rename inode_getattr to path_getattr and pass struct file

This commit renames the inode_getattr LSM hook and security_inode_getattr()
to path_getattr and security_path_getattr(), adds a struct file parameter,
and introduces vfs_getattr_file() for callers that hold an open file.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3107400454982..7006e1830269d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -962,7 +962,7 @@ BPF_CALL_3(bpf_d_path, const struct path *, path, cha=
r *, buf, u32, sz)
>  BTF_SET_START(btf_allowlist_d_path)
>  #ifdef CONFIG_SECURITY
>  BTF_ID(func, security_file_permission)
> -BTF_ID(func, security_inode_getattr)
> +BTF_ID(func, security_path_getattr)
>  BTF_ID(func, security_file_open)
>  #endif
>  #ifdef CONFIG_SECURITY_PATH

[Severity: Medium]
Should vfs_getattr_file also be added to btf_allowlist_d_path alongside
vfs_getattr?

vfs_fstat() and vfs_statx_path() now call vfs_getattr_file() directly
instead of vfs_getattr(), so fentry/vfs_getattr and fexit/vfs_getattr
programs no longer fire on stat-family syscalls.  Without
BTF_ID(func, vfs_getattr_file) in btf_allowlist_d_path,
bpf_d_path_allowed() rejects tracing programs that attach to
vfs_getattr_file() and call bpf_d_path(), and on kernels with
CONFIG_SECURITY disabled no allowlisted function remains on those syscall
paths.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D9
