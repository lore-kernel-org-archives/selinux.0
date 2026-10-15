Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692523A99F;
	Thu, 15 Oct 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067855; cv=none; b=Jr78DCix/dqwIgAMlk5j1EVHadJ7p3Hgh7Oti5U5M3LkMVXQCoJOzq8MvdcyxBUcao5s18vv5K5sleaRhOt35NB0Edx1vdNzNv1BNq3mSbSaqi19YR6OE1G5AzZzsrRo++v/ofcPm96EnkRxpvXMfp+YwFE2gAfuNgQcRe0iFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067855; c=relaxed/simple;
	bh=Y9YSuC5jWBe/toxVSL7yFDLIgALwlUhbmmUUuHN2/pY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lYJ1HgaZHfnAbn47MtK07eojhf82/2b4j9UIoAi/c9LSw7qaY7ShgtNmZ8LsIop3FN5EOet5+kZHePuvTmgZRFsQBo7gQSBNAN7msHWt9d3JacVAVukBF3uILn3wG5XlPXvRToxVwo8OP47d99xjPnGWF1Nn5r9ZZCTj67Y7K40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq/AhQyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq/AhQyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71411F000C5;
	Thu, 15 Oct 2026 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067854;
	bh=dBzvjADkfSlS5jrfZTRmJKj5MRK4PA0zFXIYqB0QDQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lq/AhQyxIbzzWhjXzVZA5HJAewRC+BZTFuwtfzbGHWfiJgI39/+m5XOEtX5plrh/6
	 bS5dFhHYrtnzfaHKaHLtUwTTK43nAyK6v2mR9sYj1SglIl/cg8UOpmbcHqSMNCUMfX
	 yUQUkjloYCCAc6h5xC3rTJqGHjjAz13rXhbgYoIszEaZs5boL7Kk6vQZ+6ybmYDLiy
	 5DlxXJckSKUVLAe3affToxdvLYbn/NU/kI4sS/R0pGYytlDTcycAZmwAy3iekHvj3E
	 Zxywenjbj0Lf7lOe6Hi++pyZm3I/h5vXtbRL9iFSoH6UfV+r8zmTCnaxFZXtojDFHd
	 0DmhuAuoVjdRw==
Message-ID: <sashiko-outbox-172818@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 04/18] fs: pass struct path to POSIX ACL
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261015125425.3246251-5-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-5-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:37:33 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] fs/ecryptfs: ACL corruption via unintended idmap translation in ec=
ryptfs_set_acl()
--

commit 3198ac18e49aeee9567bdcfb9d89fa401024d0e1
Author: Cai Xinchen <caixinchen1@huawei.com>

fs: pass struct path to POSIX ACL helpers

This commit updates the POSIX ACL helpers (vfs_set_acl, vfs_get_acl, and
vfs_remove_acl) along with the syscall helpers (do_set_acl, do_get_acl) to
take a struct path instead of a struct mnt_idmap and struct dentry. The
intent is to simplify callers by deriving the idmap and dentry directly
from the path where needed.

> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 8b2542c761ca9..b08eac01d32fd 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
[ ... ]
> @@ -1102,11 +1103,10 @@ static int ecryptfs_set_acl(const struct mnt_idma=
p *idmap,
>  			    int type)
>  {
>  	int rc;
> -	struct dentry *lower_dentry =3D ecryptfs_dentry_to_lower(dentry);
> -	struct inode *lower_inode =3D d_inode(lower_dentry);
> +	struct path lower_path =3D ecryptfs_lower_path(dentry);
> +	struct inode *lower_inode =3D d_inode(lower_path.dentry);
> =20
> -	rc =3D vfs_set_acl(&nop_mnt_idmap, lower_dentry,
> -			 posix_acl_xattr_name(type), acl);
> +	rc =3D vfs_set_acl(&lower_path, posix_acl_xattr_name(type), acl);

[Severity: High]
Does passing lower_path to vfs_set_acl() here cause an unintended idmap
translation to already-global UIDs?

When a user sets a POSIX ACL on an ecryptfs mount sitting on top of an
idmapped mount, ecryptfs_set_acl() receives a posix_acl containing true
global kuid_t UIDs. These UIDs have already been translated from VFS-level
IDs by the outer VFS layer.

Previously, passing nop_mnt_idmap bypassed idmap translation and passed the=
se
global IDs directly to the lower filesystem. By passing lower_path, the low=
er
mount's idmap is exposed to vfs_set_acl().

Could this cause vfs_set_acl() to erroneously treat the already-global
kuid_t UIDs as mount-specific VFS-level IDs and invoke
vfs_set_acl_idmapped_mnt(), mapping them a second time and corrupting the
ACL ownership IDs written to the backing filesystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D4
