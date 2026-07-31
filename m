Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08D2B9BA;
	Fri, 31 Jul 2026 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456252; cv=none; b=lYFbcp+7yLa1dGnm0lZLo0APYp2MpF41jjaBRJ5aU0o+YUD+hnLUARef9azF+EeLtuE/7dNxyWYZ+0AsmCg8vvA/ScdwGC5Ua91Z23iMAzKJAvVE387gfc1apCwXyRUZbM4IuHSNpd7JZY/B/GJ161tETa5y94233w3Y6Wyzqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456252; c=relaxed/simple;
	bh=/OKIWtWzYZ01BKHed0hB8u9hiaEUvXzOnxcQx7iOZ6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CGzLEt2+MwquZqhO2LRl0BR6YhZaFMSzdDestnMQ116nDO0klyw3QYqIUqEXKog8w9WOehcHpnv7/mlZHJn88qjxZe2fetRi+RYwaMkdFIda5glG3o4vz5Kw4pbAyjrILjdyXYOaVLuDP0LuyYL64mY7lHLlmAd+hcvqUYk+eFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS0PEvkl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS0PEvkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872D01F000E9;
	Fri, 31 Jul 2026 00:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785456250;
	bh=/OKIWtWzYZ01BKHed0hB8u9hiaEUvXzOnxcQx7iOZ6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aS0PEvklR8nj0SSf6ZbkHvNr2h42ZH/G1pVSfFeIonQq6XKi2kML8Xk7wBc34QvTF
	 VRVL3dDInZ6HpmH/egnnJHFCZGxce79rENBf3af0W03RxnsoHCLTVRqoaU/MfkPsba
	 Y3rBIKV7qQ1ZwqrvDrla+WOcPLHfj0TzBNub2mqqH97GNT2MwSiPWR814/P5+7jRbm
	 Hrlr+EwhGx9CnsOXYPmsl8YeSNlmAKJilNafbOnOu+9bRJl6YsUmeulblv8VmobXY/
	 2oP7wdMsvtuIkoh59nBUN804ozezo3D547btXljoVAytgE7Y5ufN/i25S8lDL5xljp
	 IVyA0yigEuf8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20260730234533.1912709-4-dwindsor@gmail.com>
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 00:04:10 +0000
Message-Id: <20260731000410.872D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using security_lsmxattr_add().
> The hook now passes its xattr state as a single struct lsm_xattrs
> object, which the kfunc takes directly.
>=20
> This kfunc is only callable from inode_init_security; the verifier
> rejects attempts to call it elsewhere.
>=20
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant.
>=20
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-Oc=
tober/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6bcdfd2cac55 [2]
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730234533.1912=
709-1-dwindsor@gmail.com?part=3D3

