Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9312D23BC;
	Thu, 13 Aug 2026 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581399; cv=none; b=K/8yy/30oZfNz0UIJuspAOdDSbP2cge8U2jz20hg4vku5o5huCRWzd9wioQ6AzJR/BVz0HJWKAK4+atfKz3RskZZtHLuWhCAPpAG5hNFB9EklWiHHFwim7iPSi/qRJDHc+4E83eyzyvXBxYKK3UTktT3j7LGt+M9KG/vaBOeEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581399; c=relaxed/simple;
	bh=q/ZFSActgJYqAEUHhAmbaYwZ5QLHaxQ67NZDLRBCZqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qNfuSau8c5wp0Yj8RMT2h+xjinfjFva33WGVN7B2IR0bdlzrm+3H1mRGH3P79TlHFJEY4fYKyzHkhNwaFjtmaJp0gVOeQZ2aNSwzJu9E+xJltJc9daiIHgPU5Ti8A61noH8mi1Ad1nrN9QLdTieEuTwlI707MRRobm6f4KRGZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz70iHMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz70iHMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E52D1F000E9;
	Thu, 13 Aug 2026 00:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786581398;
	bh=KfyE//Cou5yAU10w4ncKQGMqqg6lHdgwdTSUS2DXxQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cz70iHMTJZ3CYbN6xjSFK1ygjttnesn74QRKJQ93swIx27y0JqsEv4i77loWK+dYv
	 M0Q/S7uD/XYJl8Y9Rg+67rkO3V5H3QwvDKssGq1GRNSyUS2GMnujr+eMhIdn9jZDw9
	 VCVY6uOFyu40A8ahV6itOcEcZiDToQDxv/HIzcYrkCR9SnY0/eOVZGPQFuhqJjl3Zq
	 OOifOZjkawe3eru6jrwKaoC6qEss//3V1V0UBQQe97CCWUL9SNTuvijBX+arMCo86h
	 DKQtftStNsOAEPMq04Rp8LfbLUQe6LwGFMJPpF79FsSyyg4FjoJoHxsR8G8o0O7spt
	 E6RmCG7bxNUPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: add loader_load_fd tests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhpw6liYXVkIFdla3N0ZWVu?= <tweek@google.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260813002618.3755631-6-tweek@google.com>
References: <20260813002618.3755631-1-tweek@google.com>
 <20260813002618.3755631-6-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 00:36:37 +0000
Message-Id: <20260813003638.4E52D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unchecked pointer returns from libelf functions in `create_loade=
r_elf` will cause a SIGSEGV upon allocation failure.
--

--- Patch [5]: [PATCH bpf-next 5/5] selftests/bpf: add loader_load_fd tests=
 ---
commit b9a0b98c13acbc44d106f86733ac4cdd18481ce7
Author: Thi=C3=A9baud Weksteen <tweek@google.com>

selftests/bpf: add loader_load_fd tests

This commit adds user-space selftests for the BPF_LOADER_LOAD_FD command.
The test ELF is generated based on the existing light skeleton generator,
using an awk script to extract the loader program and map.

> diff --git a/tools/testing/selftests/bpf/prog_tests/loader_load_fd.c b/to=
ols/testing/selftests/bpf/prog_tests/loader_load_fd.c
> new file mode 100644
> index 0000000000000..ab971662dd047
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/loader_load_fd.c
[ ... ]
> +	ehdr->e_ident[EI_VERSION] =3D EV_CURRENT;
> +	ehdr->e_machine =3D EM_BPF;
> +	ehdr->e_type =3D ET_REL;
> +	ehdr->e_version =3D EV_CURRENT;
> +
> +	shstr_scn =3D elf_newscn(elf);
> +	shstr_shdr =3D elf64_getshdr(shstr_scn);
> +	shstr_shdr->sh_name =3D shstr_off;
> +	shstr_shdr->sh_type =3D SHT_STRTAB;
> +	shstr_shdr->sh_flags =3D 0;
> +
> +	shstr_data =3D elf_newdata(shstr_scn);
> +	shstr_data->d_buf =3D shstrtab;

[Severity: Medium]
Could this crash the test runner if libelf fails to allocate memory?

Earlier in create_loader_elf(), ASSERT_OK_PTR is used to check the return
values of elf_begin() and elf64_newehdr(). However, the pointers returned
by elf_newscn(), elf64_getshdr(), and elf_newdata() are dereferenced here
without prior validation.

If these functions return NULL, the test will abort with a segmentation
fault, preventing subsequent tests from running. This pattern also appears
to be repeated for the .prog, .map, and license sections below.

Would it be better to add ASSERT_OK_PTR checks for these allocations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813002618.3755=
631-1-tweek@google.com?part=3D5
