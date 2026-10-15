Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F65208B2;
	Thu, 15 Oct 2026 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067336; cv=none; b=jTWIxyN5sXzSy928bbbgndrN5o08l1qycrJh3cli+dTHTBeMhhWehjRNYFcAsoBxmdj6gNQYLcGL70BUHajWuoWcmsSkkpfkiOWpqUOxLcXkPL8HjtBKX8SQnWTCAMUQnrJx0RQudvBbQ6/2EU4K2clt2N5038EKmGa4JJKW4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067336; c=relaxed/simple;
	bh=jKX1oH7XUfkhSF9oUx9u61UhAri68mxhXmEwEojD4JA=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iB5otC5F6uTfdgoRpaik+kjZG6jhONvfjliwyZVB3EKSmKj2ZgrSDU4vIo8oCiCJCMA0EgV4jcraL5mn4KMllDQpcciY6j+qUutF5ewjD4XOphu9HPJdj19TejyeL/F0MQPa1lld/zMj8bcwU6rmWhQoVo8ECM+a2HwiY1DJBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/xP4BYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/xP4BYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC0E1F000C5;
	Thu, 15 Oct 2026 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067335;
	bh=ZnUtddvDeWh0tzbOAEP6dfsd3dCt0aSjBhGXWvfbEhc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=i/xP4BYP0HatmZy0NXBzaEbpZidvUaMIgHGD+OQFmS7iACPoTi3hCLlyG4r+hoh5X
	 PdJNmhWZSfwEp+I5sPuBDt3k6Uazi0f98vEXjF4NPfFCd5SaFaUCnTq6micrGif9Lk
	 EG2EHKhTxXwcMdbxQixbon9mp327amEeeI9aoGOAtkWd/V3bGdO16utYg9B5nv/FTu
	 ur+MbdwYEtAhrGI7bUxSLzrpuaYiKHXDxCb3K5ddhhdLl04wekEZQjsTiNXhPL442U
	 KLRownKLlRRhjtETIuBx10TIeHGXtTLEttc/XOc9vq72QUNFQzJY8H5P8yb+fQ55g9
	 YtGz+oZReOR3w==
Message-ID: <sashiko-outbox-172797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 02/18] LSM: pass struct path to the
 inode_setsecctx hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261015125425.3246251-3-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:28:54 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

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
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D2

