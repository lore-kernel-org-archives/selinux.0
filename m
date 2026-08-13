Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335C1DA62E;
	Thu, 13 Aug 2026 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786585244; cv=none; b=kYqtTH6NxDIRfwsJtA5Ro4VAdcUyX0aGgp7sYTj1XulbAHqC+zWxybaqZuFs+kEmC9iy9sp8MltXRpnhH+XKhrgyoo4toVDJWvX6okZrlGnN3xDOyeCkTjTvvBPJin+15epXNaYjPh4ikkYf7saUYH6DoFLHtoqIDakacIwMhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786585244; c=relaxed/simple;
	bh=m7Te/YczoRGmilo7HL07eq3N4vDaQWIsO4f1FiUqCfQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d3Pxeh2Pna+A6Io3q8kXlNx9jtLHaX+gcQdufOzuLombCrYHE1bQfjsmO/Em271pRQzws6fbUa08Y4P5DDZ6NbAPSEiKwzSbTumVyM57VD8/A8oITUd6rBcCQ0SxFN0uYaxelRsag9a2hPttpJO3INmGJhcvh5EmwO8cn5kJxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1sUN4pV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1sUN4pV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C60E1F000E9;
	Thu, 13 Aug 2026 01:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786585243;
	bh=mXf0ZJW7ZXDLKPnzpwkp4QXkXFkxiNB4I5GNtEEMI7E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=O1sUN4pVRx0k2lx9d1y9CF78CDJUTHoKOv9Wugg0RwC/SOmoax71TTUNYwEV2aI9n
	 fEXcR9OnaptaysaN5MppBuPHoe0X28X7+Sh5+6So69AcWgJuhJLVjhF/ciXRQUa20+
	 /2kGzlnR7LOKJi0V969VFkzx/KlmNcrgSFkwn0jASkaGPtUNcak7E6RmOHK/aTg5Jr
	 bMga6GXe8SJLUYkqZ6ilLZ7undFdzr3h4vhd8umNuT1vdwmhikoY3i2jL1ITc9gtYD
	 21odE1KBiPi+bU3Xv4cD/DbElRvsVE/WGIYX2c9mC8FvDTX7INvUE9yKLDQxgjWl5N
	 b7WZxk5ytJAGA==
Content-Type: multipart/mixed; boundary="===============8644008455691499072=="
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3abcd8cbdfaaf30f62976f1aa38b182f82ed49a3c63bad64a757f0ce08f92d05@mail.kernel.org>
In-Reply-To: <20260813002618.3755631-3-tweek@google.com>
References: <20260813002618.3755631-3-tweek@google.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Introduce BPF_LOADER_LOAD_FD command
From: bot+bpf-ci@kernel.org
To: tweek@google.com,paul@paul-moore.com,stephen.smalley.work@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,jeffv@google.com
Cc: tweek@google.com,omosnace@redhat.com,ericsu@linux.microsoft.com,bboscaccy@linux.microsoft.com,sidnayyar@google.com,nkapron@google.com,ebiggers@google.com,gregkh@linuxfoundation.org,kpsingh@kernel.org,bpf@vger.kernel.org,selinux@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 01:40:42 +0000 (UTC)

--===============8644008455691499072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ffd96e8b920bd..05b070a489fc2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -993,6 +993,7 @@ enum bpf_cmd {
>  	BPF_TOKEN_CREATE,
>  	BPF_PROG_STREAM_READ_BY_FD,
>  	BPF_PROG_ASSOC_STRUCT_OPS,
> +	BPF_LOADER_LOAD_FD,
>  	__MAX_BPF_CMD,
>  	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
>  };
> @@ -1950,6 +1951,12 @@ union bpf_attr {
>  		__u32		flags;
>  	} prog_assoc_struct_ops;
>
> +	struct { /* struct used by BPF_LOADER_LOAD_FD command */
> +		__u32           loader_fd;
> +		__aligned_u64   ctx;
> +		__u32           ctx_size;
> +	} load_fd;
                 ^^^^

The new load_fd member has an implicit 4-byte padding hole between
loader_fd and ctx that CHECK_ATTR() cannot validate. The compiler inserts
padding at offset 4..7 because __aligned_u64 enforces 8-byte alignment,
but CHECK_ATTR uses BPF_LOADER_LOAD_FD_LAST_FIELD = load_fd.ctx_size,
which only checks from offset 20 onward. This means bytes 4..7 can contain
arbitrary garbage, and a future kernel can never add a field there (like a
flags word) because existing kernels accept non-zero values in that region.

Every other similar member in this union explicitly reserves the hole with
the __u32 :32; bitfield idiom. Could the same pattern be used here?

Also, the three field declarations use spaces after the type name instead
of tabs, while every other member of union bpf_attr uses tabs. Should these
match the surrounding style?

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8d111da886553..d79cd63f9f7cd 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -41,6 +41,7 @@
>  #include <linux/overflow.h>
>  #include <linux/cookie.h>
>  #include <linux/btf_ids.h>
> +#include <linux/kernel_read_file.h>

The patch adds substantial ELF-parsing code that uses Elf64_Ehdr,
Elf64_Shdr, ELFMAG, SELFMAG, EI_CLASS, ELFCLASS64, ET_REL, EM_BPF,
SHT_NULL, SHT_NOBITS, SHT_STRTAB, and SHN_UNDEF, but does not add
#include <linux/elf.h>. The code compiles only because linux/bpf.h
transitively includes linux/module.h, which includes linux/elf.h.
Should this file directly include what it uses?

[ ... ]

> +static int bpf_elf_validity_ehdr(const struct elf_info *info)
> +{
> +	if (info->len < sizeof(*(info->hdr))) {
> +		pr_err("Invalid ELF header len %lu\n", info->len);
> +		return -ENOEXEC;
> +	}
> +	if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) != 0) {
> +		pr_err("Invalid ELF header magic: != %s\n", ELFMAG);
> +		return -ENOEXEC;
> +	}
> +	if (info->hdr->e_ident[EI_CLASS] != ELFCLASS64) {
> +		pr_err("Only 64-bit ELF is supported\n");
> +		return -ENOEXEC;
> +	}
> +	if (info->hdr->e_type != ET_REL) {
> +		pr_err("Invalid ELF header type: %u != %u\n",
> +		       info->hdr->e_type, ET_REL);
> +		return -ENOEXEC;
> +	}
> +	if (info->hdr->e_machine != EM_BPF) {
> +		pr_err("Invalid ELF machine type: %u != %u\n",
> +		       info->hdr->e_machine, EM_BPF);
> +		return -ENOEXEC;
> +	}
> +	return 0;
> +}

The validation path adds 15 unratelimited pr_err() calls on a path that
userspace can drive in a loop with only CAP_BPF. A trivial loop over
bpf(BPF_LOADER_LOAD_FD, ...) with a malformed ELF floods dmesg and evicts
unrelated log data. Additionally, no pr_fmt is defined in this file, so
the messages appear in dmesg with no subsystem prefix, and several strings
are byte-identical to the module loader's messages, making it impossible to
tell which subsystem emitted the line.

Should these use pr_err_ratelimited(), or could they be routed through the
verifier log mechanism that the caller already receives?

[ ... ]

> +static int loader_load_fd(union bpf_attr *attr)
> +{
> +	void *buf = NULL, *insns = NULL, *data = NULL, *license = NULL;
> +	void *kctx = NULL;
> +	int len, err = 0;
> +	int insns_sz = 0, data_sz = 0, license_sz = 0;
> +	int map_fd, prog_fd;
> +	size_t ctx_sz;
> +	union bpf_attr sattr = { 0 };
> +	unsigned int zero = 0;
> +
> +	if (!capable(CAP_BPF))
> +		return -EPERM;

This uses capable(CAP_BPF) where the rest of the bpf() syscall uses
bpf_capable(). bpf_capable() is defined as capable(CAP_BPF) ||
capable(CAP_SYS_ADMIN), so a CAP_SYS_ADMIN-only caller is rejected here
with -EPERM, even though they can already issue BPF_MAP_CREATE,
BPF_PROG_LOAD, and BPF_PROG_TEST_RUN by hand. This is also the only
capable(CAP_BPF) call in this file; every other privileged command uses
bpf_capable() or capable(CAP_SYS_ADMIN).

Should this use bpf_capable() instead?

[ ... ]

> +	CLASS(fd, f)(attr->load_fd.loader_fd);
> +	if (fd_empty(f))
> +		return -EINVAL;

[ ... ]

> +free_ctx:
> +	kfree(kctx);
> +close_prog_err:
> +	close_fd(prog_fd);
> +close_map_err:
> +	close_fd(map_fd);
> +out_free_buf:
> +	vfree(buf);
> +out:
> +	return err;

A subsystem pattern flags this as potentially concerning: the function
mixes scope-based cleanup (CLASS(fd, f) at the top) with goto-based cleanup
(the five-label ladder at the bottom). include/linux/cleanup.h expects
that a routine converts all resources to scope-based cleanup or none.

I traced every exit path and found no functional defect: the CLASS(fd, f)
destructor is at function scope and runs on all goto paths and all three
early returns; the goto ladder correctly skips close_fd(map_fd) and
close_fd(prog_fd) for descriptors that were not yet installed; and
vfree(NULL) / kfree(NULL) are no-ops. Is this interleaving intentional, or
would it be worth converting the remaining resources to scope-based cleanup
to keep the style consistent?

[ ... ]

> +	memset(&sattr, 0, sizeof(sattr));
> +	sattr.prog_type = BPF_PROG_TYPE_SYSCALL;
> +	sattr.license = (unsigned long) license;
> +	sattr.insns = (unsigned long) insns;
> +	sattr.insn_cnt = insns_sz / sizeof(struct bpf_insn);
> +	sattr.fd_array = (unsigned long) &map_fd;
> +	sattr.prog_flags = BPF_F_SLEEPABLE;
> +	strscpy(sattr.prog_name, BPF_LOADER_PROG_SEC, sizeof(BPF_LOADER_PROG_SEC));
                                                      ^^^^^^^^^^^^^^^^^^^^^^^
The strscpy() size argument is the size of the source string, not the
destination. sattr.prog_name is BPF_OBJ_NAME_LEN (16) bytes, and
sizeof("__loader.prog") is 14, so it fits today, but the bound no longer
describes the destination. Would sizeof(sattr.prog_name) or the two-
argument form be more appropriate here?

[ ... ]

> +	memset(&sattr, 0, sizeof(sattr));
> +	ctx_sz = attr->load_fd.ctx_size;
> +	kctx = kzalloc(ctx_sz, GFP_KERNEL);

The commit message states "BPF_LOADER_LOAD_FD takes 3 arguments, ... a
context and its size which are passed to BPF_PROG_TEST_RUN" and "returns
the updated context," but the implementation kzalloc()s a fresh zero-filled
buffer and never copies the caller's context in. Only the copy_to_user() at
the end happens. This means attr->load_fd.ctx is write-only, and the input
half of struct bpf_loader_ctx is silently discarded: log_level, log_size,
log_buf, and flags are all forced to zero.

A practical consequence is that the loader program can never emit a
verifier log, so a failing BPF_LOADER_LOAD_FD gives userspace an errno and
nothing else. Is this behavior intentional, or should the caller's ctx be
copied in?

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index ffd96e8b920bd..470e3b575497d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -993,6 +993,7 @@ enum bpf_cmd {
>  	BPF_TOKEN_CREATE,
>  	BPF_PROG_STREAM_READ_BY_FD,
>  	BPF_PROG_ASSOC_STRUCT_OPS,
> +	BPF_LOADER_LOAD_FD,
>  	__MAX_BPF_CMD,
>  	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
>  };
> @@ -1950,6 +1951,12 @@ union bpf_attr {
>  		__u32		flags;
>  	} prog_assoc_struct_ops;
>
> +	struct { /* struct used by BPF_LOADER_LOAD_FD command */
> +		__u32		loader_fd;
> +		__aligned_u64	ctx;
> +		__u32		ctx_size;
> +	} load_fd;

The tools/ copy of the header uses tabs for field alignment, while the
kernel copy in include/uapi/linux/bpf.h uses spaces. This makes diff -u
include/uapi/linux/bpf.h tools/include/uapi/linux/bpf.h report three
differing lines after this commit. The tools/ copy is expected to be a
byte-for-byte mirror of the kernel header. Should both use tabs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31655295294
--===============8644008455691499072==--
