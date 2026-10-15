Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175D25B0B6;
	Thu, 15 Oct 2026 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067854; cv=none; b=pejgnzxTJxr4DFllnpOzQeTnpf+eI/dNvX3+PJYfTVS2duwZK2KQTGAEwzYY5nZl3ICJxqD8yRUmW7ip94+3jyjOH7/DxBcIMQwUh1Ori27RGeFXNNYarnEse1D1Y/R4dRmEAGGu459JmpWVZIIdnr9/j3bIRcRibSLVW3Lo/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067854; c=relaxed/simple;
	bh=ghyK1jd/KxM9L+HdUDqRbMxk+0qQtZizdUn/qi+DyGY=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=k1HhpNsDyMOt2pG+5hgy1Q2DnXpXFPWnlkF0ZatT0ogRMzhS3ZadAfc1Kr9WIuJybSagnlwXl6U1YynztCWiXrvW66KJI+v13g0yMK6/MC5F5IBXkap8tgH8we7DCbhbePM4QLh0fHmlaRkiBGMy9km/rPD9wF3o2PnAveQQLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpgtTOok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpgtTOok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E80E1F000C4;
	Thu, 15 Oct 2026 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067853;
	bh=ghyK1jd/KxM9L+HdUDqRbMxk+0qQtZizdUn/qi+DyGY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QpgtTOokiBClHd9d2psYRLR8rDOZTcgELp2487G5flRFpQhklsliOvE4N80oG8XdM
	 jH9rApDaxb9srUPyMaIBgCyh4YDHFMPVaT+iDxIDFVAbwIETOe0HVSB/Y5vDcem2Ml
	 9botBGNmvL5LfB8ou6ZJYghm6ndjn2oGIvjg7KLtk6O8EO6/ZJQN/d/Q9rzx5Oho2+
	 Q3Y8YvOxo4GnEZj6y0FKk6ztIthDkWJterCdqR2qYv+E2WGVEjxoLiPyaPVtoeEx/T
	 bwv3xI3xOq6lgqEB/h0rZ9G9ARKmkGH7FrHhnYAZYolEZZ6BRHRvQuxMCkyXNhPxmf
	 jJXbbVkgPwcxQ==
Message-ID: <sashiko-outbox-172817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 15/18] LSM: rename inode_setsecctx to
 path_setsecctx
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261015125425.3246251-16-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-16-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:37:32 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> The inode_setsecctx hook receives a struct path, so rename it to
> path_setsecctx to follow the path_* naming convention used for the
> other hooks that take a struct path (path_chmod, path_chown, ...).
> Rename the security_inode_setsecctx() inline wrapper to
> security_path_setsecctx() and the SELinux and Smack implementations
> accordingly.
>=20
> Assisted-by: opencode: glm-5.3
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D15

