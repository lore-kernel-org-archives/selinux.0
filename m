Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110452;
	b=e3qY2wJo94mr63JvjV03egjL1YxasT5q8b9wD4kxnjct6tjYT6Yhg5H8D8mbrpCoqewx
	 oL25QO0GxU20C1doF8WzdVt/ArfRzAUMkG3G9XCcfN4neP/CoIQfKDo1gIHDrXTK4EKqR
	 1IWBMBR6R4j64Bk3H9X229vYtF1E+Dq4o6lx+AqCsf6h00+pK0i9mcci8rVJ3fJibnHt5
	 VWDbru6LA4Pp6odHP9A8crQFa3BX/FFuxELcJBTIi+W/y52FWHeb+gdFxieoPeQEzxMOy
	 Me69Py8ZdU7kOPpXOYjwBbcXbi0FVDm17bjqOOlZdkQN1LSDgfAfh5x/envv4FzJFgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110452;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hUG0Kkvaa9i7e4bATN2gCCKInPimNU5vPsFmRV5p+LU=;
	b=2IbiCkNsmpDC1YexaOjJdago4nw8YNiGCooKTprsajjXKzBzrsRp7DTQNMGVrsI844la
	 8UpYNE+ZL5cV08/X/h/hUuRLjB1gZae/28yQX3OxluUIHjbKR9J6Q8/SF0Q7vloIGE8bm
	 zb4RmIrP+/Xm7UdLBGISJkNmMu6AIzo2YVyTo6HEuRxU/5z9+BE0d3x5QPqNAgtfBUGSP
	 jbhUSJb0f2ivK0A8+DfHGZ4om4tDnGFoUcgDTqwOzz8aq3MR1O+jICMdtLhKdJyVbtiOP
	 vHeDvPKBZvvQlNGLzd6IUqs6L+DPRiHM1Fy/+Uj0F6XnJx4npuQvlcG6CPSGjy2TJCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdB6ZxWx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949AB606A31A;
	Tue, 27 Oct 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdB6ZxWx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C711A1F01825;
	Tue, 27 Oct 2026 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110452;
	bh=hUG0Kkvaa9i7e4bATN2gCCKInPimNU5vPsFmRV5p+LU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NdB6ZxWxjMXJbBYfVBFQutnBVvToWRicdJ2jvoPrEE/NjL09tC2TXDGD57kMZ97uc
	 4ZK2uwh9D8BS0LTJcybuJzwvv3Q8ZMbWfuQqeWvQGY496XkR72LmqavLO8Rn673y7e
	 flVqhK9Y/jxPzbPySeLoRT2q94VoFF/qkMfYBJOIQi9qIy8BxtVipwQhPp+YNTvHAJ
	 0oMJ68/EzZ8aRgGBf5pd3E5GxaMa0TKJokFZVvfj8BjsnrqJXa4WR9UutFTxF5Hyl7
	 VruKmVeHAeC03jJrhxhmwvnwevu0BLLrtHp1VjqG3bNgg1wo4cspTJP+R1giRxVKe/
	 zWY/zwXcs9t8Q==
Message-ID: <sashiko-outbox-186716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 14/18] LSM: rename inode_setsecctx to
 path_setsecctx
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-15-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-15-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:14:11 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> The inode_setsecctx hook receives a struct path, so rename it to
> path_setsecctx to follow the path_* naming convention used for the
> other hooks that take a struct path (path_chmod, path_chown, ...).
> Rename the security_inode_setsecctx() inline wrapper to
> security_path_setsecctx() and the SELinux and Smack implementations
> accordingly.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D14

