Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847DA51DAE7;
	Thu, 15 Oct 2026 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067536; cv=none; b=pXjyQ4ERNW6RD/cENJWWuxgXYpYgaTKwRBRteT7q31npBmrKIJTvb+xeBf8PK0Ihl9fTOApzo04+w0jlChQ4eyoWnqkkeghDsgxwQES0sBDG/1gV4I5cJkmXmo+y3MgmisM83RkJd4L2IU6sHpEouWuomj5xhu2sg6ypWmxH0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067536; c=relaxed/simple;
	bh=HejyJLOEQ4bNFT7hx7JSB8dVGpowiORfhtkRDVDOoX4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cEmxqcJzMx59sDatxr3VrakM5mF2xQ2XlP9effoln9yjij0eSxE2OluS327Mwf089Z3NLS6eagSyFLzAU8aqpXdK8DO1b1VIx79oBFqneVm5UukfYmO1HZStrd4ZgPX4HcNNFIhnPc8+p4w0oGlakG0I6CVzOEpA/fCcZmRNqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hawJH4ek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hawJH4ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C801F000C5;
	Thu, 15 Oct 2026 12:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067535;
	bh=8etAxyRmCuvkkC/PGT2E+WBnQNEAaqxTl1oxVQeGT2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hawJH4ekBuCurUcbv9JacMIj+rwmSdJuuduabyfJMXFoSXtxPrtvBy2ntchxhsWIq
	 4Hzs2ONwk6QA+HIiirr0xc/Y12eFtRnxsglG2un9GIGm1u3elKXhute/Ri8KjGBKLT
	 hLwGr9lFhAjoSd/KXy4efu80LNgU57GgX/MYDCj1p497thoV79cWWcpF5bHddjTKGn
	 K97duie7Wm9lpQh77coAW3LQFSzj/Ida2Wm0L9zY8lROmIvQ6BOmcP940yP3hqZpSp
	 vg9FsRmnvXjQvcKY6goNWEMMpoKcrdvBXl2++rbC0aeMzK54A9vIdCq3WD1yqkKG36
	 JMswIStUfXtOg==
Message-ID: <sashiko-outbox-172804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 05/18] LSM: pass struct path to the
 inode_setattr hook
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261015125425.3246251-6-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-6-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:32:14 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] smack: outdated kernel-doc for smack_inode_setattr
--

commit fc2e9041a9cd4acf5cf778a4a5188a00f3450d29
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: pass struct path to the inode_setattr hook

This commit updates the inode_setattr hook and its LSM implementations
(SELinux, Smack, EVM) to take a const struct path pointer instead of
deriving the idmap and dentry separately.

[ ... ]

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 42b028bbcd028..fdc74ca0e8702 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1272,10 +1272,11 @@ static int smack_inode_permission(const struct mn=
t_idmap *idmap, struct inode *i
>   *
>   * Returns 0 if access is permitted, an error code otherwise
>   */
> -static int smack_inode_setattr(const struct mnt_idmap *idmap, struct den=
try *dentry,
> +static int smack_inode_setattr(const struct path *path,
>  			       struct iattr *iattr)

[Severity: Low]
Are the idmap and dentry parameters still referenced in the kernel-doc comm=
ent
just above this function?

The function signature for smack_inode_setattr was updated to take a single
path argument, but the documentation block does not appear to be updated to
match. This could leave the documentation out of sync with the implementati=
on
and cause a kernel-doc warning during the build process.

>  {
>  	struct smk_audit_info ad;
> +	struct dentry *dentry =3D path->dentry;
>  	int rc;
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D5
