Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926638;
	b=MFf4FOZ4/8p9yRWNQvs7Fdxr5iy2e81eu+JhmfDqiJqCX7goLXIItrodeZsp2g+TTeq1
	 rqSj7mzkEMDfj+XHEU/sq0zYlHe0qdHK3tOUkInhMdLsVszKRkJBX2mLZc6EYCLFlqNAi
	 29BNhrNF2aYMlTkD/3QgE7F385F666fThBbdv1CB+ABlptkx5m3lxa7Fnw+5dg5KN7lo+
	 HG+pjbV7o4Zx1bzbctbSjI+/OhUTKhbY1TF/GBvwHsUkzUfJtfaV4j2YsU9qRvJNIRKfu
	 RBg676sCR+ohiHgkH51ha0YposkWvMxDCV9ypFZ4CwWWpj/WzCXgQ8I9jeLP+CZT6YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926638;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lcHEk8sWUkZg5ddzjFIk+Og+AgdkxAjdzAfgikSVvL4=;
	b=wqJz+dIuZunRL8YQatyEtIRcyhcP87c4Rya39Me1LA/z6oTHeRNtLX4mPs2ne0AU+oE1
	 bCq2aUGOaqfhAKIX5dwYsL/CMUYadunnUuMuIfsvobP0g2fJBQBuw+96cn/1YX3dVTFEj
	 x+funbEJ3Q6/lpTAlX935HJ2Ld+wCbaGJ6DHAQb/CAqfk6wecz29PL6E4yuv2ExowS7c6
	 N96n1q/tGORAOtPALIG8VYxwP2SIC8VDq4U01g7+P6DATxtio0oiSrCD+qjkh7Gs/HU9f
	 mfPzA2xU7a53rzsjYFLeOl5GHc9riuwZ62vomBfBL2D34mUnP/W86SOSqS6dzglCiJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B9R/APCb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6A606A323;
	Tue, 17 Nov 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9R/APCb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499381F000C4;
	Tue, 17 Nov 2026 14:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926638;
	bh=lcHEk8sWUkZg5ddzjFIk+Og+AgdkxAjdzAfgikSVvL4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=B9R/APCbuzV4G6YWYvLwpvOiRu8DEDCq7t0GW8dO8igyPjnvRtCnBYf7hheSF+47X
	 5jChTQBoL7b9K+XDVjYMdQkGFzTMQs4PO3Qp5+3retZBjmvmVN1lPE82GwxPLlC2Ez
	 qB3DmUwFv4A4bUKQAYeXMt6jbMUot7QMOsvqlcs+GkQyudPwluHAy2rm5zi0wvc4Gw
	 jFAmlzdNFqzzZ+fx9CcD0N40BvLkfX+RrL9JTH7RXahUeAUzvSkTwDJeXSyavQNRMf
	 J3iNy3bBM6PnghHigXpwvTAxv3VTUz/UJgJBG3kuJ+n2EjNjeCcOGsudw4Jv1yf/bS
	 3xeJRN24fic7Q==
Message-ID: <sashiko-outbox-218982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 02/17] LSM: pass struct path to the
 inode_setsecctx hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117150542.1169451-3-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:43:57 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The inode_setsecctx hook and its security_inode_setsecctx() caller in
> fs/nfsd operate on a dentry even though both have a struct path
> available.  Pass a const struct path so that the coming conversion of the
> xattr helpers can be reflected in the implementations; for now SELinux
> and Smack keep passing path->dentry and &nop_mnt_idmap to
> __vfs_setxattr_locked().
>=20
> Also document in lsm_hook_defs.h what a struct path argument may be used
> for: it can be passed to VFS helpers taking a struct path, but nothing is
> guaranteed about path->mnt.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D2

