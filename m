Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102965;
	b=0A/dhgGOSCrBAVg+yfUTDubXEmplIu8yLXy7Qk6x66jpNRI7vkwiYZtQLP+ZUJaioXyK
	 a6jPQFCw55+4Huh/MPIECVZ1N8rQHPN05OUQO4WFFqSJlowoIeqJaNEbbVU7A/T/hq80x
	 B7tg1PK8+YU1qniFUWuoSk227bjhMhAFhLM4s7colGmaNoLihHMB+Fo+Wu91VEapxFVBC
	 LGYPkDax4wwEdj/DuzEUGdVjR64qnEot7hLeAqG5e4iEjERoSUMVDgo5BLnKb9t1Pjw++
	 /J/02KchnCt/tZ1jAI/c4PVrL1LWN2N2Asaw/8wqoRxtINe7O7dpLJy0qm0tPYQC6Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=evCcOqmZ0PoHSXr04MufIqjTVZPugdXzeP8evY0RRik=;
	b=CcmsurP7FfGqFcWUHOhAZDAd5OGuD+hN+XWQeKvIAojchx+X6pW90yqvLaw600fc/9SS
	 uQyIwfBv+MQYFyHxnZHeh0SdB+iLsmzMkaHEcFEe6MT4wKAcQEk0AK8XosVqYZsLqItRE
	 d7kHsgYHhOm99QNf2ZjSjxGUJJ0FroiJjQsWnpbnmEBVXGNh9V9l14vN2ttnIWdIvO5Qy
	 TFNiwIs4bZRZzqgJtHWVz2ihELO/g+18VL4BDNyDDn1fU6gLOO/0Pra9B0Xd3mDI+baZS
	 VP+HFmsFYkhL0k6UdpSWy/kXMoFzJAUjnAJXVjLufZZEqKVLVlnMqeQcg5M4JlIZKmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMyQHlrj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCA606A31A;
	Tue, 27 Oct 2026 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMyQHlrj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01F31F01825;
	Tue, 27 Oct 2026 12:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793102965;
	bh=evCcOqmZ0PoHSXr04MufIqjTVZPugdXzeP8evY0RRik=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mMyQHlrjfqmytXAdhZe++1mFa1vtRi069kbCt3Invf54K2Y0BbpVg1jdZSajVflDJ
	 bLLlmhe+h3R/SWlDhx1bFYGtBimanXETrl+036Y1Y5ft98sAVzh0HXe2+Q1f33DGXX
	 ck3fEUv2oeb7IyKA3KNUrAfqQGOjLylTlfMW4grSnLbNp5AouspJJO0Gv6Bqh91Bwg
	 bYtsJ8FmWaUSkJWcFAzZhzn151oYuMwOAeJxYkyz4y12h2rdZZhA+Odnn165w9jN8b
	 zEfbIvPf0rK+Ho5Tp5bn1Ds3kt1iY1H3Uj363jL5DgrItBG1Ew36oBDyVQqXVC7tQM
	 xCc1OFfJvmkRA==
Message-ID: <sashiko-outbox-186512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 02/18] LSM: pass struct path to the
 inode_setsecctx hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-3-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:09:24 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The inode_setsecctx hook and its security_inode_setsecctx() caller
> in fs/nfsd operate on a dentry even though both have a struct path
> available.  The SELinux and Smack implementations write the label
> through __vfs_setxattr_locked(), whose idmap argument they hardcode
> to &nop_mnt_idmap.
>=20
> Switch the hook to take a const struct path so that the upcoming
> conversion of the xattr helpers to struct path can be reflected
> directly in the implementations.  For now the implementations keep
> passing &nop_mnt_idmap together with path->dentry to
> __vfs_setxattr_locked(), preserving the current behavior; they will
> be switched to pass the path itself once the xattr helpers take one.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D2

