Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE303515DD
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683591; cv=none; b=jfWKG5dEblEPK4EYsDEbJR39t3JZWL3swcxI5xtbFKH0Yrq/C9D4ocym8oCSCz43NA0wLQTPSJmhO4jlBWLmK+CMKwvmdux4h2ZcASoarT+JAotCtXzVqfOeIbi0Sz1D8975wvnZQp5Cv65w6EDr/yovswxmRrACY/UXFSk6JuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683591; c=relaxed/simple;
	bh=x1AH4P9SRxAwr3zbveutAzgb2dXn4LxsqKWxpQHl29k=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C5PuhXTEa6Sb1it8C1p+fIQBdoHlCwTGxa0MfdTUSi6i3qtkLP15C+oBo+0stMcYTpQhvowqzLk4P3qZDXoAcuUm3mArX3mP9D4vfL1foPWhdt3ZSuqXnmINU/Gv0HZrjX5gHT0UJTI2sgS18loPuxpco2uHTxXDFIGtlBrbXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmLgoaoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmLgoaoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C65A1F000E9
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787683590;
	bh=x1AH4P9SRxAwr3zbveutAzgb2dXn4LxsqKWxpQHl29k=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gmLgoaoCHqYgg2uYMy7S1ZK1MBXSUTKFv8XSX9op6+X/ynTKwgdCyPLL7G/Fl5w1/
	 rmzzPLLTsoIw4Vlg1fTzXcU4XSC6ZLamL9M80utYLgZx/q8ZqOr06A5od4Qz7EfJx5
	 J6CLTcINImkUi5wHx3SdRh88AGYr33VCwNSLKmn2YibczDV398dfn9yxzDLdLri32y
	 a9npovjTr8B9OinFsPQr4IN10ZhvRQ0mz5/aQsaiddVcNJIFv1ikYfJDFwJimiwKHw
	 CLDfZS8y5KVkrP4aBEoVJR++M3leDLs4yZLRlEsIie0nfJU6j7vO6iH4vo2LdW5AZE
	 f7XIYlG7sHqqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access
 (if PROC_MEM_FORCE_ALWAYS)
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
 <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 18:46:29 +0000
Message-Id: <20260825184630.5C65A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have =
no
> good opportunity to block a process from overwriting read-only code in its
> own address space through FOLL_FORCE writes via /proc/self/mem.
> The security_ptrace_access_check() LSM hook is bypassed when a process
> opens /proc/self/mem because this is considered "introspection".
>=20
> This causes a hole in SELinux EXECMEM enforcement, which tries to ensure
> that a process cannot create executable anonymous pages.
>=20
> PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> accesses are only possible when the LSM allows ptrace() attachment; but it
> is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> environments running lots of third-party code, such as Android.
>=20
> So, introduce a new LSM hook that can forbid FOLL_FORCE specifically for
> such "introspective" accesses.
>=20
> Signed-off-by: Jann Horn <jannh@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-selinux-po=
kemem-v2-0-b46bc64916d8@google.com?part=3D2

