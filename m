Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110017;
	b=anH93q2vYDthNdEM60UGGqvHfdBkJe97JCUZP2rIEVtVNa4kxG8Z9eSq3shTQ8RtKTEl
	 Rygvy4U5Zwupi5uKo1BFkh/qqBsQ/wcYLggfHQKme1v6DJ7+0tDjPfgxt16AU0KC+cIwT
	 6sys9rBZofTLPqyZXKGUsncipFDWV+6o7sQQJsA/ex8sIfyUjkSH3fM5CVs65tIRep/Zm
	 Tso4Mwqxgc0KecILtkR6J+MxtLiN22HIipwoCvVh9Mldr8HW47UlISvLq9NiUMmDGkjz/
	 K9kULwqCKctIZ6GOU4xIUY67yiL7zcnYtjSNBtg8OBEHFHQKeoQG2rUp7qYl+EFy/tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110017;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bXymQD7J8q64urWjAFE+IvKPSJZKLNjr0IOekkbpDr0=;
	b=cN8I/Uy+d4dlr2uquCHsfBgJEe+IRvUtJmkL++3bwChBQ1xFuUyjFak4rQ5OGoeClcuU
	 Zc6k4jfpmJ9Jnpn7ey/j76PjD087O9DwJ4Fs+7h5Tx5+Q32j3SRTZkWv5OY3zKgD37ljU
	 x7sTGWFhZXuvF5310nFxpyWwx+gbWejzyVGLh2d/J7xub+5jueu6YeYkr/fAU2TYW58T5
	 zwrqsdrvITr9EjZvvLiKYH+OICrM2EmQQ4z9YgnxZj2vv5wH3otuMPWUObgXYv1ZRcDet
	 MDbKeTjxNkzI38e6PMbLUyIH2ppxe4Nc23oipfUO7wKFz9yNkCQwZDDJrpvzDZ4VtIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCdtnD3F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57101606A31B;
	Tue, 27 Oct 2026 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCdtnD3F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C078E1F01825;
	Tue, 27 Oct 2026 14:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110016;
	bh=bXymQD7J8q64urWjAFE+IvKPSJZKLNjr0IOekkbpDr0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VCdtnD3FTAQiVHVET/+ErXvcvxQbHQGYWPLbwgiZ0/K1lCD8UasGZPdfGHTRry/vU
	 n/02IWVn08wkuTE/jk7onAGpKZgiOnvHAPbB8QG/+IuvXNn6Vm4jPXbXVBtnGddSCr
	 jEu8Fztf+DF7X0RA7htsPBlSLTL3fQFcx9VRNZXP6o72GOQ8eR0D1ctT81OssIlJY2
	 QXIF4YBT+PYz2BxmcrjCjetMYrTfGzkui8WE1uMcr+AUNnhRgZ5jwAm8ySrlCr0uGO
	 pN04wqWJpla0f1mzl4JdkVwytohzEX+H6d35j+OM1FsYflbtXLy3UdMaf9yQf/5Raf
	 rnFTvwQDMhFHg==
Message-ID: <sashiko-outbox-186702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 11/18] LSM: rename the inode xattr hooks to
 path_xattr hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-12-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-12-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:06:56 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The inode_setxattr, inode_getxattr, inode_listxattr and
> inode_removexattr hooks receive a struct path, so rename them to
> path_setxattr, path_getxattr, path_listxattr and path_removexattr to
> follow the path_* naming convention used for the other hooks that
> take a struct path (path_chmod, path_chown, ...).  Rename the
> security_inode_*xattr() inline wrappers to security_path_*xattr()
> and the SELinux, Smack, EVM and IMA implementations
> accordingly.  The inode_post_setxattr and inode_post_removexattr
> notification hooks still take a dentry and keep their names.
>=20
> BPF programs attach to LSM hooks by name ("lsm/inode_getxattr",
> "lsm.s/inode_setxattr", ...), so update the BPF selftests to the new
> names.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D11

