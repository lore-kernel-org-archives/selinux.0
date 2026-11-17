Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927104;
	b=r6solIwhpn8frg8SfJUU9JfdF1UHFl0KG/dw9Xv2pqhp6bCc18ogKQGIxkA4m37Nnwzw
	 Q9sBTFeINjkvBizg787JZzJ7YJxaPDreumnDhncxoE1XonMPyFummY8Y0ONgAoVaMXWUi
	 tGDNtz8Md9aAK9izcj7ja/GEFm9/T7p8KKuPpayyaD7UwOZaf7jefPg5jUj+nkD5cbVK4
	 niiC2sBNhFCSbHx7VSBj+CNDRR/NkRZolwMFijEI4dttCC5jZ4e+Vg0A5x56XWjmTgLHi
	 D0IW/l8ofp6z7ngNJGekxyMqpUJ47DKQYi7jskT9/cIK/YfZQXS1rUm+mjmQLhZORBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927104;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9r0CTQwqOc/EuPRU6kz4jyqdws2NOCL2inigCOrimVI=;
	b=iznQXVCcOQxiq355NQvq8104BtIeMd1mHcHYliYObwSEs6qy4Y4mEDKQU7CesUzfyGQT
	 YMV+mQmKd/aXZvpgN2w5TkhzJzHfSxV6vUv6AhT5T6wtss/sEFQ84TKCUtDLSRzuPj4kI
	 /K68jAUC3Eibn8F21UOkkloeAXMcD/0pUoyVe498ny4qj1kXHLr3+Mm3hlCNo2PzG/Xjg
	 rAUsgliYrkRPYOsuDQlm54C2zqA9prpNnfUb2k6LF8EW15KaBOZp0radkKrQJaiYhMSqc
	 GqEjt09WYS4+rLzUAMz+LURQZBnxI5eF9jOByiLSmrVFxW3nsfpahx/5xBHApxv6PmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZshAAOGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957CE606A331;
	Tue, 17 Nov 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZshAAOGr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526A71F000C9;
	Tue, 17 Nov 2026 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927104;
	bh=9r0CTQwqOc/EuPRU6kz4jyqdws2NOCL2inigCOrimVI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZshAAOGrbnG7zV2a/gpAnRe5NT3oXZ2bPLAM+aoPm84WafaWuQHuUtUCU569lhICp
	 mcPjm++bu+964H7Y8GyrSJ4sEnUKhkFp/RKoc4fQXg4UC8gQN/KGcq5qXPZNFWIy8O
	 jqfdGw78CdtkycLG49MhU50vypqmqODOWAKSk33FO4FQZtDS4dUJYCXvRiabTLZOX5
	 UG+NX7cHg2MlIUTTurzPlX703xMpADBZIUXikv29Jv6ai/5RzNbw588wNm4BvU3cPz
	 OY/4NVBk4ziaSZ0X62bfH9YGzxSGiwwZ/lKUABL/YhpqEcVrTFbyYultWwuP+evey+
	 8pZo5qGZWvEHg==
Message-ID: <sashiko-outbox-218993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 07/17] LSM: pass struct path and struct file
 to the inode fileattr hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117150542.1169451-8-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-8-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:51:43 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Switch vfs_fileattr_get(), vfs_fileattr_set(), the inode_file_getattr and
> inode_file_setattr hooks and their SELinux implementations to take a
> const struct path, and pass the struct file through which the operation
> is requested when there is one.
>=20
> vfs_fileattr_get() keeps checking i_op->fileattr_get before calling the
> hook, so the -ENOIOCTLCMD fallback used by the ioctls is unchanged.  Add
> an unchecked __vfs_fileattr_get() for the internal users: nfsd's casefold
> probe, and the read of the current attributes in do_vfs_fileattr_set(),
> which is authorized as a whole by the set hook.  ksmbd keeps using the
> checked helpers, passing the file it holds or NULL for path-only probes;
> stacking filesystems do the same, so overlayfs keeps its existing
> file:ioctl/file:open workaround until the LSM semantics are agreed on.
>=20
> Add strong definitions of the two bpf_lsm_* stubs naming the file
> argument file__nullable.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D7

