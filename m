Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828930BBB1;
	Thu, 15 Oct 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067992; cv=none; b=oI2HSFGnoKIhkMiXZEB3lc9gOTSUYfHWdj2Z8r5U3/+w2h66vxCbAA/oYoutiqCMAaqauSE2FD6zbGRQh+tmEb62yJJNeiW+scYOySYXDSS+YwfuSV2Pm6ZpkGhC2KZZtvkzY/B4WzLLB2p3yblZMZKJAkeubh6HkHm07BMISvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067992; c=relaxed/simple;
	bh=AE2/yoYhkqAS0x6CFKBByGroSum+FzNB8vNnE+mBSWs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kX4zo53+7HGzteNH2GpyBqz4vS/zujEnyM+w3Q60GOokF2r6HCZh1Ji2b3zmrlUAcHJxS3u9Bg9qvoh4PVCcKz85cCVDvluH6m7cwAuYEUZsd1GJnV4nP9nXtO0W+Jw46odnl6Wigj0k2oPWZMHCC3Qwf+2jLhoq5Y0cAED3yPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af8zDVjF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af8zDVjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8C41F000C5;
	Thu, 15 Oct 2026 12:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067991;
	bh=1K+l7oHTsRSVGW0EAoQEFweeHkw3d0xMxZTaZVWvwg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=af8zDVjFxNfKvcrNKZi3C/r7JKJiaFd3kN5wqvORZm5ALMXJ/dXaigQBF8nP+o6ql
	 WrHxTj7uKuChdio3zOwqxloU5x/C5rto31RwKIk43oHdc3o1BTVgxrIOnmOSMZ4/mN
	 9MiNZHBtPZxzUyATfnnmd7FsOKCxI8s5QNey4DvG4E7pqGf5q9FonJa39cL8bEn7f5
	 dFUBDGnFkt1gq20O2uM9i2y9ntyhj6qBBRh6H2HtPkbwRf/D9MdSH0NaHW+x0EQYGZ
	 BcutS7Ncy/J8ulB3kUqJyM+0Oa5nNkoC+3SJZhQFWoimQtBcGHLd0zZkilVcFN9FLQ
	 xE2rtFMlkRlJw==
Message-ID: <sashiko-outbox-172823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 13/18] LSM: rename the inode posix acl hooks to
 path_*_acl hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261015125425.3246251-14-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-14-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:39:50 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] smack: stale kernel-doc parameters in smack_path_set_acl
--

commit 86b58223ea4147721a6935310d93abd33d140861
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: rename the inode posix acl hooks to path_*_acl hooks

This commit renames the inode_set_acl, inode_get_acl, and inode_remove_acl
hooks to follow the path_* naming convention used for other hooks that take
a struct path. It also updates the inline wrappers and the LSM
implementations accordingly.

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 95799afbb5c9f..1a1e9f11939eb 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c

[ ... ]

> @@ -1540,7 +1540,7 @@ static int smack_path_removexattr(const struct path=
 *path,
>  }
> =20
>  /**
> - * smack_inode_set_acl - Smack check for setting posix acls
> + * smack_path_set_acl - Smack check for setting posix acls
>   * @idmap: idmap of the mnt this request came from
>   * @dentry: the object
>   * @acl_name: name of the posix acl
> @@ -1548,7 +1548,7 @@ static int smack_path_removexattr(const struct path=
 *path,
>   *
>   * Returns 0 if access is permitted, an error code otherwise
>   */
> -static int smack_inode_set_acl(const struct path *path,
> +static int smack_path_set_acl(const struct path *path,
>  			       const char *acl_name, struct posix_acl *kacl)
>  {

[Severity: Low]
This isn't a bug, but the kernel-doc parameters for smack_path_set_acl do
not match the function signature. The function takes a const struct path
pointer, but the documentation still lists idmap and dentry.

Should these stale parameters be updated to document the path parameter and
prevent kernel-doc build warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D13
