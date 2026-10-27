Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110168;
	b=PHgudunMrwbmh/+UACqqggFrXJ9OgXBAwtvYtIEFE58eT8DT1+3MmYlJDS0MH8O+35pn
	 TqdSfsDIv/itAaCfN5tpTR/zbcGyergoVNLgXWQoHqol5mG6ImIC5HuMfw6pyh50gKDgx
	 WuQ/UL6aAXQVTAgLZhKxW/y8vtwPN0lQl6jLC3VE/OT+wFz3vgzkDTYIaH2HqMu9DlmY5
	 ZRKtc3CbDyonnnUYPhln8CHzOSOeCalAMlncRPl0N/E6K6DtE+oMoW+IJIGVqQteXndMa
	 fJfccLKp124cvROgFAge90KLyyCc9vc/GcZQO03jGY2ntN1pIsgNL492oka2crI5z5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8AyGzI/4Zr42FCULKHwBPVeoA2QY7v9XKyd3TGZAWIg=;
	b=SpspDi6YMFYFjThSpq3cQl5de3qE80weP8JSMKpxpwh1JNM/IlOvbvODL+lFY70oKD/Z
	 zKLuAGUAYxjN80AAluZkAENN93Z66kyLPnvCpAN1RTweXoK4ktMN8O3uL9zSZDcUWtIVW
	 37RFswn+/LDnlqvv30auzYuV3vaB2RXNfURML9e8GKCW6AdG1H62pFv5kk/RbYJdY5xx5
	 Y+64t6vOPGyL1LrO1/7qHOYLcvuijy8KGg2+iUTGlNM6+cBZIIBs4gjq6oQUAAo0Hm1sK
	 w9j2GmjSlVuEkBd8NSFxcksJH6NFdPalULBB4eXxA3wX8FGgWupIRmg791b30ZfFz1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JptonooE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16727606A31F;
	Tue, 27 Oct 2026 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JptonooE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8303B1F031E0;
	Tue, 27 Oct 2026 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110167;
	bh=8AyGzI/4Zr42FCULKHwBPVeoA2QY7v9XKyd3TGZAWIg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JptonooEvUnV6EsPiOkFYn5+9IvOgZBYLoV6LMvzoYgFsbQ4eTVZGJjdPBIN81e1S
	 AUqQbkRr7QoSYgVL2/qSpJX+zPNRuhaOTxa9TT9vBZe1Oi8kO6pDDEeaD7FxCUdSQe
	 Ufu0Q3leSPCGXbYYf44PJnWCr7143dNnBsLzf+KehYxP+6+N3tFdv6vRoizhJpQlb0
	 H4SdOGCW3kEzHMoEq6ZYw32ifsoR4Wo8kE0KDmRc304Tzrie5rzFrvWS4ABXBRH9c5
	 QXRMKzFkyHto8Z+1NXOzoB5tDJzXCQK6igk0F4GRquPIKbk7PgqIGEJ+5pbvR3A04x
	 FgApkOF/dB/dA==
Message-ID: <sashiko-outbox-186706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 12/18] LSM: rename the inode posix acl hooks to
 path_*_acl hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-13-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-13-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:09:27 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The inode_set_acl, inode_get_acl and inode_remove_acl hooks receive a
> struct path, so rename them to path_set_acl, path_get_acl and
> path_remove_acl to follow the path_* naming convention used for the
> other hooks that take a struct path (path_chmod, path_chown, ...).
> Rename the security_inode_*_acl() inline wrappers to
> security_path_*_acl() and the SELinux, Smack, EVM and IMA
> implementations accordingly.  The inode_post_set_acl and
> inode_post_remove_acl notification hooks still take a dentry and keep
> their names.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D12

