Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA73AA4F1
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683643; cv=none; b=GFdduuWrslSmMMwTQinUpS4QCeV+xOGTC5qHz8ZbJ0A8RX5SnRGBQ8QXuJruE9/KynCFIQC4R9Ho+iF7asMBuL00eHhXXG0A04TtfZ7X3PwaHX9vi1bAXY5XUYlgm+8YnrcE4Xh2yWAjN4aHW+5+O2f2dDa4+EybOgcBW9FiL6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683643; c=relaxed/simple;
	bh=WUj/giaC4clULbwZxSuXydGUGBznsv7AlBpL/j1l3VA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M8kwbWcXGOdIjDc4B++8timMPByXZLffaNPDgkiPZRODcEP+p6GChyATvKeDCQGY1sQwaPZPTUk/2YYJ6cCCbegsGZ0mVtldVrLV5SIdGNDHDZSwfpFW0vbGc9uex0s4sCALAFpX3QfxwMRfW0DGxdeU3+zfbGX+njNK2yKzSrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZgXibuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZgXibuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A3D1F000E9
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787683641;
	bh=WUj/giaC4clULbwZxSuXydGUGBznsv7AlBpL/j1l3VA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gZgXibuf4v1sxbofAoc0Rt+R8jc7MDRNM41Gck8gUAcVB8wtB1hyz7HROSxPY111L
	 r8BggC8U77/69/lMeLa3/AJ8cExf3JTjtqmvmtnPPa9P2GRuGsAupzd5bKqngWgxzt
	 6vnJJm6NYqV9YABtQR8ueFVl/SgawmO5jjl43iq9BfNxcGiWlH8hfxq3V6VRrPTNib
	 13V99TNxcJG5laNNmbzUMk3/295/j5+fzdgX6A200/wLRYwi59EutVHx/+ViKxTEUv
	 I6Uyao79kRLPl3fiQ2Jba1FDjvyYL6Dq3dys2mJ/vwAF13uXKRu3RAdKtcdob8WxZf
	 a4p6YwAk6gEoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE
 introspection
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
 <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 18:47:21 +0000
Message-Id: <20260825184721.A6A3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process c=
an
> only create anonymous executable memory via /proc/self/mem if it has
> PROCESS__PTRACE (like when using /proc/$pid/mem of another process).
>=20
> This closes a hole in code integrity enforcement that Project Zero has us=
ed
> in a remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without
> EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
> /proc/self/mem, which made it possible to load and run shellcode containi=
ng
> a kernel exploit.
>=20
> Signed-off-by: Jann Horn <jannh@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-selinux-po=
kemem-v2-0-b46bc64916d8@google.com?part=3D3

