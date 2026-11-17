Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926900;
	b=1xz3m+zzPoYxGvSKiGBjZZBKIR8ld6FrsOymAN4urWToTvkm3rskXaqKQl7mgtCUhcqK
	 KjNXgwGyrJHsFHKznV4a3a4SCWnDRIpVXC3WhmidvVnVZoPwOaQIyySZmTorO+hbTNfaj
	 YupWO0yut8g7TxgDkpQxCLsm9lmwqLAReOdyaCX5iSS2+COFZlGupXR3BXu8rF4MFVMCH
	 Do5w9vGxVc+kY3ewoFQ8iVA/u8jyB26QbQfKOoRShJlouJ6pAbiUe16aD83HvSFWTIWv/
	 5o/poeyM0Zur0RDYNdL1hnytBUTCG+TJjF+YguXZykHGnK5U3nemtCsu2MmEH4roFTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926900;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bCHveX5ddYGbE/XJJkqp1uZJCR77H2yWn3Vq/RBTOmA=;
	b=LcC98knPHmsMKLjraIUvkm3KTDWQhPQVtPMxwMtMLZCkGmUCgFIbprL4QwRYiAy42JoQ
	 +6YmBW1wAahAgwbRHBA5kn0JnGe88w9MlCGfTioy/dFl7lk0i7tk0eQojkDa4B4SVTctt
	 6D/SUq3zfiK+2XzKqXzHmmfZTfmU2jAVomOgM1YCdhuVhNYR8pr909W0qusl7jmdCJlbZ
	 kdxTwXidG9vyWNG4mI4DgBo3yT7WU/hf9+2Z1DHU/5HW8Fw9BS0OYtK7FT+BjZUuQJS1i
	 1YSKyprLFtG9Z/pd2CdHBxZqGD5K0xUt86r7ww/loHf3yumdvKHrv+HeN51pC8gM92w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFbUXsIu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75A606A336;
	Tue, 17 Nov 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFbUXsIu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C651F000C5;
	Tue, 17 Nov 2026 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926900;
	bh=bCHveX5ddYGbE/XJJkqp1uZJCR77H2yWn3Vq/RBTOmA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JFbUXsIuDBQxs05+RM2KT7XCFaR1/NoKbGBVoAaPKy+60bNFQAO4RlvT/B9ctyKpZ
	 aS/M74vh98eXCjc4MhfqJfWVsIqWGBzpBr4R0xRSaLn/8a5H1k5QVrEySb4qqMnKWS
	 E4gplsyzmdMD+bfM+08/Ls2YESAil4dEkrQwmAGpQNqkI3bp7EQPi/Qw1lAwHBnx7p
	 /U/NGDse7LS7PQSkX2/7LlhBzgj9+x426Ru+tXI3+xaz8Ojw60JOLIw/6cxAEZ0qgd
	 R+vMjSU22JB6y+h3EZ9IYVK/NwiTn95O1OK8VHSgVL1z5492wbEUODPQYcfyUMACuP
	 HLi9Lyz24SaoQ==
Message-ID: <sashiko-outbox-218986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 01/17] fs: pass struct path to notify_change()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117150542.1169451-2-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:48:19 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> notify_change() and do_truncate() take a struct dentry even though their
> callers either hold a struct path (or a struct file) or only need the
> mount they already use to build one.  Pass a struct path instead; the
> idmap stays a separate argument, as it must be taken from the mount when
> the path is checked and passed down unchanged.
>=20
> The NTFS named stream support forwards a change to the base inode.  Add a
> notify_change_target() helper for it, and record the path the change was
> requested through in the new iattr.ia_path field, which is only valid for
> the duration of the notify_change() call and must not be stored.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D1

