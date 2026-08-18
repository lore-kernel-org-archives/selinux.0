Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD5356758
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083125; cv=none; b=H+uMKDu03PpZpkpAWpQouuiKaLUEVIvTSgl6sL2p+2RLKcgRQ0fLQkU8PztWpcHWJplSTTPd8MS1gGzFepvmhaVYgG242N0HGGJmdfFckV2RzyohFZw7P2zvkShNgo2PLChpV+s53Az4SzQpSS2HUp8VymC46vvxPV1r3E9QuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083125; c=relaxed/simple;
	bh=XueumaBGTHUqLmHFSNXsdYgTR1Kl+Se4NQouYhs67fM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J0rFTM8BGcA/cU9IOdRlT9kcGjpFuwmmwtw9RFFm3SWWaEstOEXYrDWqf7yqDTXcRpr3TYbxAF0eoNhCmT5hSmjtpABa2lxxxYJv9S21Fd8rt3O9OiBJm+/HWiROnhOXPFFlGiLYCSh3ua7sUKiyVTnZuUqtLcR+RY97TMdVsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs+LLolp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs+LLolp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E32E1F000E9
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787083124;
	bh=AsyCluSs8c6u04TbUcS+67K84BYIw24oX0NJdY3ikkY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Vs+LLolpTWQg73rDDczBLeGhIECXnZRrHpq/H3nAdb+IIIc8tbYEtUZhKNeD1ync3
	 0kxxsHW1o/DXIkeW6sXjYkaMlphC8OQ0YqTPx9JXrOYp3y/iEz5W2rKnk2PZ7Eof40
	 ZfJsdBz2o726mbDiO0vqRQW3uH+06yf2Z3GbO2t5PKVue8FY2Im/W9dDJrPwpY1Csh
	 t2be8gkwFFxttO2ASH6HKo/8AckIdFv4Cv4nAAjjCBmQW/AbKszx6mGq4kY5ytPr0D
	 S/quR2RSwScy3VJ9fyLu4YWBi3rVv3HlKkEl9hLQEAR450dyoR/FIXJSnrVq0XRGZd
	 W5M+SxiUSVjeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE
 introspection
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 19:58:43 +0000
Message-Id: <20260818195844.3E32E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process c=
an
> only create anonymous executable memory via /proc/self/mem if it has one
> of:
>=20
>  - EXECMEM (like for other methods of creating anonymous executable pages)
>  - PTRACE (like when using /proc/$pid/mem of another process)
>=20
> This closes a hole in EXECMEM enforcement that Project Zero has used in a
> remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without EXECM=
EM
> permission to overwrite executable code via /proc/self/mem, which made it
> possible to load and run shellcode with a kernel exploit.
>=20
> Signed-off-by: Jann Horn <jannh@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-selinux-po=
kemem-v1-0-90cd2357ee05@google.com?part=3D3

