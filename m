Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4A517BA7;
	Thu, 15 Oct 2026 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067665; cv=none; b=hXNUA/2lBJdfeF5ITkFuYido9tvtmLYlGPl8g5I3AWOOaeb/QwJ/4YzpOLArtw47CGEF0ep4tB4CIOxPS33ilQzlKsB5cR96MBADKYfF2m18QYF5yCqJKKIHOYVDiJrMIUMhUma2bxzTFV57ppSa61HXKJzYSB3SwLZigsTbU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067665; c=relaxed/simple;
	bh=a6L2ZxPr1ZBEDa5M+7B/kAaFJ9fIABTWuITW9fP5h4w=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QlckQ0n2O+yXq8AgOLuP+AkbL+PtL09JhNO5OMKM8jDt5kKsqEECU3a6g2KVO8ok4/Zjw7WE+Kot0g9VaroNfWW6RrtQ0KQnnphtODR8DGZtvaavNu+W0NUj3ZsnPwx/RgQPAovk9A4xQzV22knl6zFM632s7LODM8zJnB8Uxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy41xONj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy41xONj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5301F000C4;
	Thu, 15 Oct 2026 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067663;
	bh=0SpW+WjMIgOIDSfmX62JF+VOuFA7w0ACjnyqSHCFUmk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Jy41xONj0Lf3pgaGv1ktDU04QmBP3qw1cXfSWQW78E6SqQ+n7Ge94UVBGayeddywz
	 TsT0x5YEeDAnObcZHgkdCv0OZs/aoqfm3G2SsQ8RVHNj8GuGW3yZucAYxjbUoSpoBA
	 MuLw3oqpG0bnFmac09ztMvzqL1/eWKflv/iLCnfQY3DLLlGdOWKXtWhc/wTC0V7RJN
	 UR+VJVnxlKXRh7mbjwgnNaMeCGDBOVLVPy1DA2BxG3EhnBIFaDqORr7RqfG1V6oMtc
	 Xs71+W5ACswyMo25lD5ae68lW9Smdz4NqzOU4V11SqPMii3oyKIJ5JmSUnZbQtHfZk
	 rKSPRqPzA75Rw==
Message-ID: <sashiko-outbox-172809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 08/18] LSM: pass struct path to the inode
 fileattr hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261015125425.3246251-9-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-9-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:34:23 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> The inode_file_getattr and inode_file_setattr hooks are called from
> vfs_fileattr_get() and vfs_fileattr_set(), whose callers -- the
> FS_IOC_GETFLAGS, FS_IOC_SETFLAGS, FS_IOC_FSGETXATTR and
> FS_IOC_FSSETXATTR ioctls and the file_getattr(2) and file_setattr(2)
> syscalls -- all operate on a struct file or a struct path and had to
> derive the dentry and the idmap from it just for the fileattr helpers
> and the hooks.  Switch the helpers and the hooks, along with their
> SELinux implementations, to take a const struct path.
>=20
> vfs_fileattr_get() and vfs_fileattr_set() are also called to forward
> fileattr operations to underlying inodes.  Such internal forwards are
> performed with kernel-side credentials (e.g. overlayfs uses its
> superblock creator credentials) and the user-facing operation was
> already checked by the hooks, so they must not invoke the security
> hooks a second time.  Add __vfs_fileattr_get() and __vfs_fileattr_set()
> [ ... ]
> hook-checked vfs_fileattr_get() and vfs_fileattr_set(), passing the
> struct path it already holds directly.
>=20
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D8

