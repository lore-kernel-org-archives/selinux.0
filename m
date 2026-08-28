Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88073A9DA2
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939922; cv=none; b=a9+jbP4DJT+I3nDNHNWjn3STB+V9RcWPe2hw1M0bSRCe9aPZeKe4aSonmAA8q9NclqyA6o692HD9K+n8OD6tFrWQ+QoGU4uJmCaLq6kr7/pN5NFcNIgEaxe6Gy62oSLBozAkkkUSo+KcrHyfJzMHAebDupAbgepIsb8MJEnQ4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939922; c=relaxed/simple;
	bh=L5SvM2Kc7PJI7zqw3D+i5ormkSIiwr+DJTltrv/jetg=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J8JEWEAkxmX+v9V0gjzKHOzTTA0ksSHwxMRjlWhmk1xr+N8Tmcgs4Z7cF5VDhbnE5xKhd2f5wVikPOc13PYLqwWjEbxqsl9M/w6I3EBwhRLlyuQ8BC254J4k/4I8wv0OquPnyB0+5yQIIv5uuxOM0H9rPdzX2SvPiZoPkolI8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuQ6z+/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuQ6z+/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E4B1F00ADF
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 17:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787939920;
	bh=L5SvM2Kc7PJI7zqw3D+i5ormkSIiwr+DJTltrv/jetg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JuQ6z+/Fo5CVguiO/sPCAddtoQo76uYVvG5WYv3umMwFOitQC7G3GKKcM54wpejP0
	 j8nvi2KPSBbVSG5trjjoRwZh5ckhwA0e/SFLMs7Emh9O8iToKDLAwM49WGfL+LNzj8
	 xZEX90nmnTShzq6lDPTZA/pNhbV/0vFGDHOoA7sXcBukrbkEf+Av2AJDw56Gf4XQrF
	 r5Q9COsoFHeadW0j7WlL01jYSG2VnAoRPULmk/QDy4U2qS8Yc7UVYza34vCsyu5XG4
	 Lj7eCMGNPcHikTAZKngvyP0Kpm/Aj5trkcz3Xg3YUEl1OW3Qvwdx9zNHGEM7qYnmOV
	 ESbOLVA+KwSow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libsepol: add include/sepol/cil symlink for in-tree
 builds
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260828175314.38256-1-stephen.smalley.work@gmail.com>
References: <20260828175314.38256-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 17:58:39 +0000
Message-Id: <20260828175840.04E4B1F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Invalid repository target. The patch is intended for the SELinux u=
serspace repository (which contains `libsepol`, `secilc`, `libsemanage`) bu=
t was mistakenly applied to the Linux kernel tree.
--

commit 38dcb6e7783a077514cbc09a9dbfdbd6ef4f7c1a
Author: Stephen Smalley <stephen.smalley.work@gmail.com>

libsepol: add include/sepol/cil symlink for in-tree builds

This patch adds an include/sepol/cil symlink to allow in-tree builds of
SELinux userspace tools to resolve <sepol/cil/cil.h> without a DESTDIR
install.

> diff --git a/libsepol/include/sepol/cil b/libsepol/include/sepol/cil
> new file mode 120000
> index 0000000000000..a1b89f5916832
> --- /dev/null
> +++ b/libsepol/include/sepol/cil
> @@ -0,0 +1 @@
> +../../cil/include/cil

[Severity: High]
Is this patch intended for the selinux userspace repository?

Applying this patch creates a dangling symlink at the root of the kernel
tree, because the target ../../cil/include/cil does not exist in the Linux
kernel source. It appears this might have been mistakenly applied to the
kernel tree instead of the userspace repository containing libsepol,
secilc, and libsemanage.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828175314.3825=
6-1-stephen.smalley.work@gmail.com?part=3D1
