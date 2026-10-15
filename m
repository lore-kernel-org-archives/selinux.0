Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86551FCBD;
	Thu, 15 Oct 2026 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067743; cv=none; b=idGV4tweBuCNzscagTmFsH4MxH/xMrRTY0NrdfmHkMeANN8Jv0sEzvlPmEn6HUDtmSv00mHnO6nIhMVZhMLS4Zj1Tsj1dvoUZ0gpx9xwwMDj3qYqlzyH0h8rIVSWaZeZQbuKfYyDwCEV79zVKAoQP9+ZHAd6rOQfaIeeNbMxuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067743; c=relaxed/simple;
	bh=kN/Ght0dyVwzno5BOw8aHvZRmcT4+OB5RF2gBiB6AFk=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qgUCPcf+mUUnR3zLwbqgEWDFNQk+PWS/pBk+KAQ57VrneTOhj4h72C3xEY2w4adF8U5Bbhhgt+2jluXx/9PwvpySWBUIxwQ3C9+uYf6n7ssc6cu/j83yZOljX39rSf0zM0htmxIfCTenwrqeWXl8wSJpTanwntnclHk+fMY/b84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOWnm6Od; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOWnm6Od"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9476D1F000C4;
	Thu, 15 Oct 2026 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067741;
	bh=kN/Ght0dyVwzno5BOw8aHvZRmcT4+OB5RF2gBiB6AFk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MOWnm6Od2tqeFZtTxAXR1zh75/68we1O3BWUOgseBUwsMXe9wACQISkNtz7p1ZqiR
	 886OvbEesuXYQnmNx4uTqC982WhdKG58x59xYRUeaF416Qivd20tqZXPYl+KwbYZX+
	 JbSFl1wjZUQ4X2gy5VEinusCBIvVCxFu7rfw4+T4Hg45Cyx2wm6XhpZkUCOVFBgGzK
	 V42kQggdotXThXI9FzxyIwTOb9/AD7EUCwWWWtvzsxGXgKLwwGAI7ksHvnpwjHLRHY
	 NYwyKZpwYcWN6aEBLn3TcS14MUEEZzEZJbirSaUpHHoCyU4bxPev3XDujIzP9lGqjZ
	 krZOhzdkKaFgA==
Message-ID: <sashiko-outbox-172811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 11/18] LSM: rename inode_setattr to
 path_setattr
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261015125425.3246251-12-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-12-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:35:41 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> The inode_setattr hook receives a struct path, so rename it to
> path_setattr to follow the path_* naming convention used for the
> other hooks that take a struct path (path_chmod, path_chown, ...).
> Rename the security_inode_setattr() inline wrapper to
> security_path_setattr() and the SELinux, Smack, EVM and Landlock
> implementations accordingly.
>=20
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D11

