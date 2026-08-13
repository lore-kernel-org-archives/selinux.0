Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1112E8B64;
	Thu, 13 Aug 2026 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581743; cv=none; b=GHU2PTWuC33F++Qy2ZZZdgCws1mzWF6OLsKGDutDgerUiOZUTMexJImGfUko5EGIAhJ1uprz8UUebhkhos11hUbZLun207iaU44Rd9TRjiC1TrzjY5Qo9U1oslWwuesCyROYOBD1LMPt2jivVpTTks/vB4dxp1pfXuS8wz+iuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581743; c=relaxed/simple;
	bh=mVlhbSwScQ7Y96WUPp6JDK7vKCc74GM3UItx6exWSOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b30vK/I80R42Xsp5wNcARrWHOMhpZqYz81r4Vqn3t3AIGFsUMW+A2K1dIvVEMLqamPZVUNv4BJnOU3bKlmslGMBU8Hz7Atmq68LTsXc64E1AxJ7RfVDmw2WiRi5SLbqixXHeDq2NdoDENC40Roh5zZlv4w3yhM9cnsAzyY7/t9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJFZLEiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJFZLEiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D0B1F000E9;
	Thu, 13 Aug 2026 00:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786581742;
	bh=QExoHw/dynKZ+Pu/ZSgB68rR2S2T7P5NpZ0C5l/X8F8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJFZLEiDwnkrA6sbGPLwi68KCocnH6rWJ+n0AbRScN4eruAiw2WskyMG+xCpkBxsI
	 UnVWXMwjxw3D+KMoL1iNH2Ijhs8+FlCzj8nshNa4GtIap8f/tnf2mFySoCRSNuIKW5
	 ujFqGhhMmMVdDvcmQsQb95JZsEJvZJ3EHC2ldDzKOW/g1imH44eZb61MY2S+nQZz4v
	 ofcbMm39vRoMSF/vH6Yu2/RukKckiMpmBcaSnzYMYssV8gXDf+aBbxJTrBMDLVF3Ab
	 IO1OXMUP9S6MlV3XKw2Ck45S1I92xtlJx0lT1x7mcCElv9vlBo/8nKWYg22yKdDIHj
	 WA3EscuuTHTHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/5] bpf: Introduce BPF_LOADER_LOAD_FD command
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhpw6liYXVkIFdla3N0ZWVu?= <tweek@google.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260813002618.3755631-3-tweek@google.com>
References: <20260813002618.3755631-1-tweek@google.com>
 <20260813002618.3755631-3-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 00:42:21 +0000
Message-Id: <20260813004221.D6D0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Information Leak / Out-of-Bounds Read in BPF verifier via load=
er_load_fd
- [High] Out-of-bounds Read / Denial of Service in ELF header validation
- [Medium] File Descriptor Hijacking Race Condition (TOCTOU)
- [Medium] API Misuse / Broken functionality on non-JIT configurations
- [Low] Direct cast of `__aligned_u64` to `void *` for `copy_to_user`
--

--- Patch [2]: [PATCH bpf-next 2/5] bpf: Introduce BPF_LOADER_LOAD_FD comma=
nd ---
commit f9a928bc7f89cffc836753c26236211ed8039c51
Author: Thi=C3=A9baud Weksteen <tweek@google.com>

bpf: Introduce BPF_LOADER_LOAD_FD command

This commit introduces the BPF_LOADER_LOAD_FD command to allow loading
and executing loader BPF programs directly from an ELF file.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8d111da886553..d79cd63f9f7cd 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -6291,6 +6292,336 @@ static int prog_assoc_struct_ops(union bpf_attr *=
attr)

[ ... ]

> +static int bpf_elf_validity_cache_sechdrs(struct elf_info *info)
> +{
> +	Elf64_Shdr *sechdrs;
> +	Elf64_Shdr *shdr;
> +	int i;
> +	int err;
> +
> +	err =3D bpf_elf_validity_ehdr(info);
> +	if (err < 0)
> +		return err;
> +
> +	if (info->hdr->e_shentsize !=3D sizeof(Elf64_Shdr)) {
> +		pr_err("Invalid ELF section header size\n");
> +		return -ENOEXEC;
> +	}
> +
> +	/*
> +	 * e_shnum is 16 bits, and sizeof(Elf64_Shdr) is
> +	 * known and small. So e_shnum * sizeof(Elf64_Shdr)
> +	 * will not overflow unsigned long on any platform.
> +	 */
> +	if (info->hdr->e_shoff >=3D info->len
> +	    || (info->hdr->e_shnum * sizeof(Elf64_Shdr) >
> +		info->len - info->hdr->e_shoff)) {
> +		pr_err("Invalid ELF section header overflow\n");
> +		return -ENOEXEC;
> +	}
> +
> +	sechdrs =3D (void *)info->hdr + info->hdr->e_shoff;
> +
> +	/*
> +	 * The code assumes that section 0 has a length of zero and
> +	 * an addr of zero, so check for it.
> +	 */
> +	if (sechdrs[0].sh_type !=3D SHT_NULL

[Severity: High]
Does this bounds check properly handle the case where info->hdr->e_shnum
is 0?

If an attacker provides an ELF file with e_shnum set to 0 and e_shoff set
near the end of the file (e.g., info->len - 1), the size check evaluates
0 > 1, which is false. The code will then proceed to access sechdrs[0]
unconditionally.

Since info->hdr is backed by a vmalloc buffer, could this read past the
buffer boundary into the unmapped guard page and cause a panic?

[ ... ]

> +static int loader_load_fd(union bpf_attr *attr)
> +{

[ ... ]

> +	memset(&sattr, 0, sizeof(sattr));
> +	sattr.prog_type =3D BPF_PROG_TYPE_SYSCALL;
> +	sattr.license =3D (unsigned long) license;
> +	sattr.insns =3D (unsigned long) insns;
> +	sattr.insn_cnt =3D insns_sz / sizeof(struct bpf_insn);
> +	sattr.fd_array =3D (unsigned long) &map_fd;

[Severity: Critical]
Is it safe to pass a kernel stack pointer (&map_fd) via sattr.fd_array
while leaving fd_array_cnt implicitly as 0?

When fd_array_cnt is 0, the BPF verifier falls back to the legacy sparse
array resolution path in fd_array_get_map_idx_sparse(). In this path, the
verifier extracts an immediate value from a BPF_PSEUDO_MAP_FD instruction
and uses it as an index.

Since fd_array is treated as a kernel pointer, copy_from_bpfptr_offset()
expands directly to a memory copy:

    memcpy(&fd, &map_fd + idx, sizeof(int));

Because the index is attacker-controlled and lacks bounds checking, could
this allow an unprivileged user to reliably read arbitrary memory from the
kernel stack?

> +	sattr.prog_flags =3D BPF_F_SLEEPABLE;
> +	strscpy(sattr.prog_name, BPF_LOADER_PROG_SEC, sizeof(BPF_LOADER_PROG_SE=
C));
> +	prog_fd =3D kern_sys_bpf(BPF_PROG_LOAD, &sattr, sizeof(sattr));
> +	if (prog_fd < 0) {
> +		err =3D prog_fd;
> +		goto close_map_err;
> +	}
> +
> +	memset(&sattr, 0, sizeof(sattr));
> +	ctx_sz =3D attr->load_fd.ctx_size;
> +	kctx =3D kzalloc(ctx_sz, GFP_KERNEL);
> +	if (kctx =3D=3D NULL) {
> +		err =3D -ENOMEM;
> +		goto close_prog_err;
> +	}
> +	sattr.test.prog_fd =3D prog_fd;
> +	sattr.test.ctx_in =3D (unsigned long) kctx;
> +	sattr.test.ctx_size_in =3D ctx_sz;
> +	err =3D kern_sys_bpf(BPF_PROG_TEST_RUN, &sattr, sizeof(sattr));

[Severity: Medium]
Does kern_sys_bpf() support BPF_PROG_TEST_RUN when CONFIG_BPF_JIT is
disabled?

Looking at kern_sys_bpf(), it only intercepts BPF_PROG_TEST_RUN when
CONFIG_BPF_JIT is enabled. Without JIT, it falls through to ____bpf_sys_bpf=
()
which explicitly rejects BPF_PROG_TEST_RUN and returns -EINVAL.

Could this cause the BPF_LOADER_LOAD_FD command to be completely broken on
non-JIT kernel configurations?

> +	if (err < 0)
> +		goto free_ctx;
> +	err =3D sattr.test.retval;
> +	if (err < 0)
> +		goto free_ctx;
> +
> +	if (copy_to_user((void *) attr->load_fd.ctx, kctx, ctx_sz) !=3D 0)

[Severity: Low]
Is it correct to directly cast __aligned_u64 to a void pointer here?

Directly casting attr->load_fd.ctx to (void *) bypasses Sparse address space
annotations for __user memory. On 32-bit architectures, this can also cause
pointer truncation warnings.

Should this use the u64_to_user_ptr() macro instead?

> +		err =3D -EFAULT;
> +
> +free_ctx:
> +	kfree(kctx);
> +close_prog_err:
> +	close_fd(prog_fd);
> +close_map_err:
> +	close_fd(map_fd);

[Severity: Medium]
Could unconditionally closing these file descriptors introduce a race
condition?

The kern_sys_bpf() function allocates file descriptors and installs them,
making them temporarily visible in the calling process's file descriptor
table.

If a concurrent thread blocks copy_to_user() (for instance, by passing a
userfaultfd-backed memory region for attr->load_fd.ctx), it could close
these exposed file descriptors and open new ones.

When the page fault resolves, would loader_load_fd() resume and inadvertent=
ly
close the newly opened files that now occupy those descriptor slots?

> +out_free_buf:
> +	vfree(buf);
> +out:
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813002618.3755=
631-1-tweek@google.com?part=3D2
