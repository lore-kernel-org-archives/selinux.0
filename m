Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928026;
	b=5L4D49qQlX47berAsbiwYbcb0CXgacfpokCUQU4P9svvSJc1JlW4npDUVHq3X1eF4td/
	 6tl8AuXFnEu9sVTlgGN/aPJl+agI9d0bZbAeEg23pCbiVkXB8/kOKaWC5Izms1Yie+SbD
	 fk3A4D62hdg1xP6xw2X1tHQdZ2NAE7tAp5kn31EalyNo4wA9YQ08UAn36+Hmk8We1XC4F
	 yJdwDnrNVO1aVoU9T4ZI9txt/6o7ldwPaL6ORhusI2xJ/TGJ4R4eUS1/rFaijz/GsE/uD
	 c3FvG3g1M+EH7Uz8N7IEE4JWoNZD6YUyk7GXQGrsOJxNUWGb8l2yb06wbqjqbFyeTWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928026;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OA+4LgYs43dBp1ce0tQYSVPQiW3jxfKKN47qnK22mm4=;
	b=q4js1PK0C1dvJ9+txEua3Y8h+VBk/mxR44CNK7dtRiQd9PKlx4lMDwISFbWW56eLCu/u
	 peoO+TAvqEoQ8JJ+GyA4ITEGIjd9OpuFsnm1Dq6D3H8gt3eIWO1vYf4YI02OSEvvpfuZF
	 FXOKSbo3Hoc0HuOQQiofsjQMVuxUXkdOiciz44QpOyX+J/5Z+/irZ0GwKSXYshOEwAgvr
	 3ZQIPqWGsAzdCmVm8dq6e0bRZiZqs2BHJ8h+xPCS4VTuF0wr92IFdvHMe8vd8wXtee/f9
	 5ZTUdRuCHhyHxFTCTNbTLeW2IIlGjX2iewMB5Y50Li+ASDaVRf9QgUXdd5ADk0zxHQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApUNGGJa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045E606A31C;
	Tue, 17 Nov 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApUNGGJa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910601F000C4;
	Tue, 17 Nov 2026 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794928025;
	bh=OA+4LgYs43dBp1ce0tQYSVPQiW3jxfKKN47qnK22mm4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ApUNGGJaxh6mG253i3H2ZtzB+zRjEq/3zw6qXWe384F0vAzCDbc1peBfbfI/lbboy
	 hto5Ttcz/cHRnoZXMDiUCYnGiF/a9plBvFsXrR1+OGTR7eYY+ajJgavqeDuTimAzoi
	 yXJ+7JZo1H2K/9cBlCS/0OSuN+pVlc4QkAaNAWIabUpjuD1A38QRg3U5Ngipo8tvK+
	 7J1CQvuCRZxVXEMV8Wfu2G1+Gc/BqGRSAaZ+qWtUUbzTvJGGeg5xIKw2RpGDurF2By
	 S7T/xmc8RZKFXpCElWHGvkDeBUrmBAvlMgbwQDOTvTRfvxhoN8yhk2R2Hs3AoGyTsh
	 9G4U3aS1GD9yg==
Message-ID: <sashiko-outbox-219019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 06/17] LSM: pass struct path and struct file
 to the inode posix acl hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261117150542.1169451-7-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-7-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:07:05 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Convert the inode_set_acl, inode_get_acl and inode_remove_acl hooks and
> their SELinux, Smack, EVM and IMA implementations to take a const struct
> path instead of a dentry.  The implementations derive the dentry they
> still need from the path, and the idmap stays a separate argument.
>=20
> Also pass the struct file through which the operation is requested, when
> there is one, for the same reason as for the xattr hooks, and add strong
> definitions of the three bpf_lsm_* stubs naming it file__nullable.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D6

