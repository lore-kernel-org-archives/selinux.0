Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35E35675C
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139307; cv=none; b=PZwPWYJfrjUsLItr54nMX0P43JMWZfkUJlGd7Rxar+IzhBT75IRn0rTeQBD+A5xan9yWWVg9u3WOns72xX5YM2gB/+uJcxkJFEKw5hRuNlruTxaW79hVV9hCsWja9eJXEZUHdP9kD08yXgPr6xd2RCLopSpVFjaFmEvvXOHhK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139307; c=relaxed/simple;
	bh=Nii9oBxuPS/XQ8tzKM4SwnM0FsSKwCN/5cc9R6gFJ7U=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fhdHFmUXTjriTNxHRSB/UHr6gRIHgyQbtfusD3CMuBPlpNccN3IGfj/ahyzLIE0nslJHlBJxs+o29p//nTBYYpvII73s4UycNXMdkdOVFN4lRePQhOV6JzDZ5+si9xdAgZLUtCTWWWb7ypXD3AoxBDu5JWxWAt3kYzsWq8ZZmYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU8sgby0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU8sgby0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24DE1F000FF
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139305;
	bh=Nii9oBxuPS/XQ8tzKM4SwnM0FsSKwCN/5cc9R6gFJ7U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GU8sgby0vLnDaV9Piz5THn1DFgV61aM7++bVcnsCxIGqek1u5aNkgvruklZsO8KLt
	 ExJvbR/lcJoPUEWP5Epjhnwslm4s5OjKFYFGRH8vt5UkAtbJkKMhS+jXluHGNHxOQY
	 ivffHdeN6KUv5krodrxd0eG7i8YjrLKeKzf7oyNtMbOSnyK6hYXse7EqOlvZRS1lAu
	 3Qxldwz4EMrqwDLVj3/qSepri58mVMRyfoWFdcqMGL7u2veS/t3prCVpuO/mmYBbju
	 8TiyRRl+81B1h7u9QA28OG/K9xdWUg+H0Bq9pHG1tBlcyABYJ6GEBdXOvV/QJKhezK
	 jRuedlwWRotWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selinux: reject writable opens of status file, drop
 mmap write checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260911145840.19039-2-stephen.smalley.work@gmail.com>
References: <20260911145840.19039-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:08:25 +0000
Message-Id: <20260911150825.A24DE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Similar to what
> https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/ does for the
> policy file, update the .open handler for the status file to reject
> writable opens, and update the .mmap handler to stop clearing
> VM_MAYWRITE and checking for VM_WRITE. This does NOT prevent
> truncation via open(O_RDONLY|O_TRUNC) or truncate(), which is
> left to another patch.
>=20
> Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> cc: ljs@kernel.org
> cc: jannh@google.com
> cc: jack@suse.cz
> cc: cgzones@googlemail.com
> cc: brauner@kernel.org
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911145840.1903=
9-2-stephen.smalley.work@gmail.com?part=3D1

