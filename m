Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927355;
	b=0TdpRI2NZmoWzsfLr6II/6ZskKyW5U82gRP40aInjMh0S3kYtS9HqBAQXcwsUAKcKRvC
	 myMACebZzeoUztTWIVmL2I2yLvzLV6uWu8LGv9onp+xoeh9c2qt3Qx71cI9i+RxEByHCu
	 3A9MZ6xeGIoz+e9dVgBZfZy0LmmS3BcYQpYZKzcNOHDV+nuCi1pkwhZdnxylofK6r1+9v
	 sDCSToaL63MXF7Jc3EV+fweRuPq35mAoQ7xofTdMq12DsPQoXkQ+krbiu4MAeaMoqjaoG
	 F4NY9UFziyoVbuvC01dQcVa41hxroFtCqX+8m9+EDwksr5qwcyzR21+HKEAorZhV0Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927355;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RsfS6NcpuFiGEhFir4rll3lOVUU8X22g94nf/atj1XU=;
	b=jPQfeRkBuK2Uh/vqTCcY1fc67YOdQJc/TzBUFzm+Nsp1CjBv4R8x5eR9p/tBdFLXoDVs
	 1vkrjnIpJrYigGf9ZvhkOizmTsWY5y7cVjAgh1Sv4cLVeKDZ402e0jDl+ytKZMVAeOWQL
	 QKSxdaIQgCFVH3d4+RcSMuSOym37+SBWgko6WG2yFwhE4ZwNO3UA7zLqNPpp+fyle2STL
	 zsOa0M+ng+O5p+o3wN3bsB+WzHcF1SVnvAhNj2xts3oaQhmPfM27W3gTOc/A8jIzGZxkK
	 9BOCKBcy1VfP02Dy4eAzfZXj4374OBIurPzhNoSXZy3BAvFsLjG1o511iR9mBZFMsVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9+CoULo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA13606C72F;
	Tue, 17 Nov 2026 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9+CoULo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E091F000CE;
	Tue, 17 Nov 2026 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927355;
	bh=RsfS6NcpuFiGEhFir4rll3lOVUU8X22g94nf/atj1XU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9+CoULoIP9zUuuhZsIBL6/un/wZ8C1BFKXp5asVlYKimvaQTNppgKgQtkB+fAVOX
	 pDiY3PLjnphos8lg1yeiK5uprhTezh7jiOTJIgDLRODfxMpsG2XTTp0C5wxi+I56oT
	 6vQat6/86qAGQRvEbBX43tk1bTdVtAoF4iaA08OJPPwdy7FMVpdvaUPMUXOj0Hgxj1
	 aX/pU17IubDX36P7xS4rUF8TbHjQk6fIBL754vdTKfOnd/9VGcO1n/Tt7CODjkQL1Y
	 Agxf0KAG5OopJ5FympVq7DHPpBGYAoDV4k1d8Q2pfGjZO9X29sA85CZoggjwuT0ilB
	 5iAv64NKAsPcg==
Message-ID: <sashiko-outbox-219002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 10/17] LSM: rename the inode xattr hooks to
 path_xattr hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117150542.1169451-11-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-11-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:55:53 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: multi-line comment style in
  test_set_remove_xattr()
--

commit 5a35ac0f5c000b29a6a994caacc2c58218d41cdf
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: rename the inode xattr hooks to path_xattr hooks

This commit renames the inode_{set,get,list,remove}xattr LSM hooks and
their security_inode_*xattr() wrappers to path_{set,get,list,remove}xattr
and security_path_*xattr(), updating LSM implementations, BPF LSM hooks,
and BPF selftests accordingly.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/t=
esting/selftests/bpf/prog_tests/fs_kfuncs.c
> index 43a26ec69a8e3..5145b1f03cac2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c

[ ... ]

> @@ -148,13 +148,13 @@ static void test_set_remove_xattr(void)
> =20
>  	/* First, test not _locked version of the kfuncs with getxattr. */
> =20
> -	/* Read security.bpf.foo and trigger test_inode_getxattr. This
> +	/* Read security.bpf.foo and trigger test_path_getxattr. This
>  	 * bpf program will set security.bpf.bar to "world".
>  	 */
>  	read_and_validate_foo(skel);
>  	validate_bar_match(skel);
> =20
> -	/* Read security.bpf.foo and trigger test_inode_getxattr again.
> +	/* Read security.bpf.foo and trigger test_path_getxattr again.
>  	 * This will remove xattr security.bpf.bar.
>  	 */
>  	read_and_validate_foo(skel);
> @@ -167,13 +167,13 @@ static void test_set_remove_xattr(void)
> =20
>  	/* Second, test _locked version of the kfuncs, with setxattr */
> =20
> -	/* Set security.bpf.foo and trigger test_inode_setxattr. This
> +	/* Set security.bpf.foo and trigger test_path_setxattr. This
>  	 * bpf program will set security.bpf.bar to "world".
>  	 */
>  	set_foo(skel);
>  	validate_bar_match(skel);
> =20
> -	/* Set security.bpf.foo and trigger test_inode_setxattr again.
> +	/* Set security.bpf.foo and trigger test_path_setxattr again.
>  	 * This will remove xattr security.bpf.bar.
>  	 */
>  	set_foo(skel);

[Severity: Low]
This isn't a bug, but BPF coding style puts the opening /* of a
multi-line comment on its own line, with the comment text starting on the
next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D10
