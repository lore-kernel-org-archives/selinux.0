Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103649;
	b=ZG9iOSRlGu6kGyRKWccLbQJJJoqgLzi4DOQPa5tIDjyj8LN6FO81E5TV59wk9IhRuVv7
	 HGXhYdy13G987O5swmTJ2jD1L4sMJt1FwN6GmfXyOGYGn8M5yiN/2cBoOmYd/W7Sq6cxF
	 rsKYay0jayJPpqieefhBEoskEVPpWIKl1rLVE7iNNoXuIDKITQJuPkpAqDf2hgNgRC+tu
	 TANmUXU5GmSJggmnsea0dRvDO/gdQtBhBltP61llDm1webWdEr3u6/veKJ+3xD+SFuSde
	 Tof+CG6sWHOV9+334kmDRHWdHvoKCZatUIc0b7LuwRY1aAv8Yy5eB/i3xl2uiav8+JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103649;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S+WdzR0NMigxUS/M036VDMBEh9a6N7VOr/xiFQVlZK8=;
	b=0MXD6reL5HMGmPMqznPs0reXPFHZMlSNirw4nWo9Q9gs8v3Jc/I87nSTzLOuK1KwjN/V
	 MY2X6J5X1FzlS2OQbPZMc9p4qbFTrTAtjMrrdyTgNDIp1DnA5S0v9tDDJfiPHUW6Da+DH
	 /trHHPJg1Cj67XlRqmzAhLpZnojGPV2Kw37OOxH81ZwVKoaBaGkX6S3sOXDtFfC/VQOaS
	 KNvwu/Gt8AbgPc5oyRtDR2wEtYLCdijz/hQAzmzOlqXTr5KX3gbAQuTk7LzGvricrMRbF
	 k4Dt1nTjZ96QepZoYzE9pq4w+m5Jjs05x9PXca+rTJPaO3KpKGCwfqMFBklyqVdmceA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mco7xSBt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E0606A324;
	Tue, 27 Oct 2026 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mco7xSBt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0241F031E2;
	Tue, 27 Oct 2026 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103649;
	bh=S+WdzR0NMigxUS/M036VDMBEh9a6N7VOr/xiFQVlZK8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Mco7xSBt6TRFt/OqBIDhhFaEOthxnHslXmtyMqXC8znVYfkTbLsLtvf3VplLXcNAZ
	 1seAj1y4IaFOe34ASUENSC1Q6FVnwea8KJGvKRDq3ndQ4S3wkvhdJtRPTzcoqcTR5c
	 jqH7bH6IV928ZCJWpoHVIpqMDBtpv4g1BrgIQBzFR0B+8FRi0C28YOHxIspVG3R9OX
	 tn/VS8pdYhfVnTNkvC55XYwmvOJfbCqMkm1GW0iEVwMft5UAgXpnvAhFjB2utE+Fzu
	 SkH14dCbXxeJk87fZYF9s5m6Zrr5g+1bqKdpxzXsU4Y/PWwtiMBWYjS2/hG1pQomE5
	 iJh3bbbmgLB4A==
Message-ID: <sashiko-outbox-186532@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 04/18] fs: pass struct path to POSIX ACL
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-5-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-5-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:20:48 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> vfs_set_acl(), vfs_get_acl() and vfs_remove_acl() together with the
> do_set_acl()/do_get_acl() syscall helpers take a struct dentry even
> though their callers either already hold a struct path (or a struct
> file).  Switch them all to take a struct path instead of the dentry.
>=20
> The struct mnt_idmap stays a separate argument, now consistently in
> first position: it is taken from the mount at the time the path is
> checked and must be passed down unchanged so that the VFS and the
> filesystem are guaranteed to see the same idmap, so it cannot be
> derived from the path inside the helpers.  A stacking filesystem may
> need to decouple the idmap from the path it forwards to the lower
> filesystem: ecryptfs_set_acl() is invoked with ACLs that have already
> been translated into global filesystem ids, so it must keep passing
> &nop_mnt_idmap just like it does for the other vfs_* helpers it
> calls, while ecryptfs_get_acl() threads the idmap of the upper mount
> through to the lower filesystem.
>=20
> set_posix_acl() keeps taking the idmap and dentry as it is called
> from inode_operations->set_acl, which operates on a bare dentry.
>=20
> The security_inode_*_acl() hooks invoked from fs/posix_acl.c keep
> taking the idmap and dentry for now; they will be converted together
> with the LSM hooks themselves in separate patches.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D4

