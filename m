Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64945221CE;
	Thu, 15 Oct 2026 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068028; cv=none; b=bEhus/psjRETwpXskhLNPtyI/h+1rarXrnY4RDPCE8klV9omPFuLBzIUwpMoW48X/RsvQsgQPnSSnB+PSvXTijoMW0z4nyn0GqHAk2Mx+9aS5gZxgsUHHrDtZGVLYVRFBFWDk4ZPsQ4j9HVpDCwQ3dsG4RA2QobeEsFjsEAKKiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068028; c=relaxed/simple;
	bh=oK7VKWjhGYm2qPY6/AP2r0XlK+RVLwW/xmLIxjvOkso=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=h2t1cSTX7iXcaZ2H5+OQDqPQ8Vl2WNnMC3ILXh9VgcOJGlZnl4k3xAz0jr1fZR0xSs1ADm4Xo1SYRAHiS6oL3aSabKIsCNIh/JNN4MPyeoiwelle7PpCUoqs2sIHqsHTWPunLaW2bcC3a3/G0pMYJGUq2Sj0WnmTQOKND3zCx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpTEnZ7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpTEnZ7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFA61F000C4;
	Thu, 15 Oct 2026 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068026;
	bh=VVq14v7QH8nMCzV7tqUn+81I04gz5rFi0oAU6mLzyHg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GpTEnZ7OXzOvqmNXz1omODmIoGwB2VuI3Wx3uKHcyJaPAIh1dqpwWsBr7K66jGK4Q
	 Xr5llF1+q9NCB0ERsrb/V1NV8cGgjHJ7FqaTWqfOzIxTKuoJk0OJZjriWwpivhxTnP
	 OjYabXJ4qbZdrbEQS/Ge8loqEnc5M6Oyo3WkzQNahIzspMbmu8W2XYxHBcik8TRid0
	 bGgEW4AVoYmgNyLLlPOZNfki0RRJ7W5PfMQ28Xj89wOQcF5wDtD7Lx4b/AmuCueYfS
	 H3v1aG9tDQC+/rfHTAoFeaHYVrGijR3RVZ99jArP5/ENwk8JTDRqPeJru8M1NWEfyw
	 A56B9VHOQMn1g==
Message-ID: <sashiko-outbox-172824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 14/18] LSM: rename the inode fileattr hooks to
 path_file_* hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261015125425.3246251-15-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-15-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:40:26 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> The inode_file_getattr and inode_file_setattr hooks receive a struct
> path, so rename them to path_file_getattr and path_file_setattr to
> follow the path_* naming convention used for the other hooks that
> take a struct path (path_chmod, path_chown, ...).  Rename the
> security_inode_file_getattr() and security_inode_file_setattr()
> inline wrappers and the SELinux and Landlock implementations
> accordingly.
>=20
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D14

