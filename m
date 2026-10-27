Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109681;
	b=r+1BLRy0PinqMj7eS8kBL141cqgy7CPoAhzZyjUSfl+fXP4pv45HzDfDG4fjS5HbGsyr
	 kgz5UgeDtC8fpzd3E/po8y7yPQ4TrrkWJb62lJZ3cswaHakgqtogZXNoWjaVb3BzTdeLk
	 jr3aURc9b3e8dg60c32S0zhgUrK5zVl88k/H1YamIqeSViKXara4hqISpkJmLWks/gYS3
	 SPRxGra8iFHxhhWhA5koUwRvbMa7/0i0RULz0L1DyTOu9EBO37Ap+hB+QRZMiRYeWRAng
	 Nap4lUJtPXAzY9yd5iwH1FiZNSnvem/4qQRsfohgUt7nuOSbDLnRcgtoBDs5zIqF2Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109681;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M/y2iGPGqnOInEfAT6KNTRdsf2PIAzJoNzC+BVcHG8E=;
	b=ieQ+jUYo9MSK8kjIfCupFzddnUYftGoBWhXlDOmVgMXDzwpIyBql5RSCzqnfK6AyC2Ge
	 F2L/KH6/60lRSDUqYxCK+jdTioynt8bBWr+O813WqK44BYziNxbC3AkZsg+a8lbUDwXS/
	 +a4S4R8wsWKu+J5h+6Zs12jvrt+BA/67zLWI4OV4kjw3TYxOrqMigMPRRUGYQ4ns/Wqz5
	 83ckDaFMfDvMR9E0YXUyyP/FPDnIUsea7u632iRaHJzhQJ6tnsywZO3hYjvjCQOngz0nH
	 EDaG09x3+PGY+xmUNs8skTH74Y4BLQPtQzemSu23AMfLuc61AifZpyee+Uu6Rtl2iCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXxaE4Lb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D21606A31B;
	Tue, 27 Oct 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXxaE4Lb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E018D1F01825;
	Tue, 27 Oct 2026 14:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109680;
	bh=M/y2iGPGqnOInEfAT6KNTRdsf2PIAzJoNzC+BVcHG8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LXxaE4Lbg8WK49qsT405ak5hZRgTuQ5GAFU9NMDtW7nGvjsiGy7SkQrVqk2z4NKCF
	 c5PhEa11t2/365oUcxiMpGToUDBY5M6VXy3rDKPsjP+iSuTZXEco1di1Lewq6VZoBL
	 Gox6NWj/GgoXYfWS5N1O3BIwZ/5Rz24H7WtQ14PPII1VgQLWcEUKCGakcbTvLP/83Z
	 mckh2IWHovfagXKx4cIqVolgup5sAURxDK9ij+ywmmqJrdWgudCWe2i2Ge0Ae35aO0
	 NmNqaWxbvtjJ0UMl7Id8jRPgrhj2XDQ7RGbUZHo0NSWBYzXrgZDPU9SqvkT4zg6Fd0
	 VTkfMyLRpec6g==
Message-ID: <sashiko-outbox-186681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 09/18] LSM: rename inode_getattr to
 path_getattr and pass struct file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261027121151.1887650-10-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-10-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:01:19 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf, lsm: missing __nullable on file arg in bpf_lsm_path_getattr()
- [Low] tomoyo: missing @file kernel-doc in tomoyo_path_getattr()
--

commit b5ecf79579b44f0d69e46ecb8c8c91e302299f23
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: rename inode_getattr to path_getattr and pass struct file

This commit renames the inode_getattr LSM hook and security_inode_getattr()
wrapper to path_getattr and security_path_getattr(), and adds a struct file
parameter passed by file descriptor-based stat operations while path-based
callers pass NULL. It also updates LSM implementations, BPF LSM/tracing BTF
IDs, and BPF selftests accordingly.

[ ... ]

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 96ae1b548e8d4..0f7712f516444 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -153,7 +153,8 @@ LSM_HOOK(int, 0, inode_setattr, const struct mnt_idma=
p *idmap,
>  	 const struct path *path, struct iattr *attr, struct file *file)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, const struct mnt_idmap =
*idmap,
>  	 struct dentry *dentry, int ia_valid)
> -LSM_HOOK(int, 0, inode_getattr, const struct path *path)
> +LSM_HOOK(int, 0, path_getattr, const struct path *path,
> +	 struct file *file)

[Severity: High]
Can this trigger a NULL pointer dereference when a BPF LSM program attaches
to lsm/path_getattr or lsm.s/path_getattr?

In fs/stat.c, both vfs_getattr() and vfs_statx() -> vfs_statx_path() pass
NULL for the file argument when calling security_path_getattr():

    retval =3D security_path_getattr(path, NULL);

and:

    error =3D vfs_statx_path(&path, flags, stat, request_mask, NULL);

In kernel/bpf/bpf_lsm.c, LSM_HOOK() generates the weak hook stub
bpf_lsm_path_getattr(const struct path *path, struct file *file). Because
bpf_lsm_path_getattr is not in untrusted_lsm_hooks, btf_ctx_access() in
kernel/bpf/btf.c marks its pointer arguments as PTR_TO_BTF_ID | PTR_TRUSTED
without PTR_MAYBE_NULL unless the parameter name has a __nullable suffix:

    info->reg_type =3D PTR_TO_BTF_ID;
    if (prog_args_trusted(prog))
        info->reg_type |=3D PTR_TRUSTED;

    if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
        info->reg_type |=3D PTR_MAYBE_NULL;

Without PTR_MAYBE_NULL on the file argument:

1. bpf_may_fault_on_deref(PTR_TO_BTF_ID | PTR_TRUSTED) returns false in
   include/linux/bpf_verifier.h, so direct loads from file (such as
   file->f_inode) are permitted without a NULL check and are not rewritten
   to BPF_PROBE_MEM by convert_ctx_accesses().

2. Because bpf_lsm_path_getattr is in sleepable_lsm_hooks, a sleepable
   lsm.s/path_getattr program can pass file without a NULL check to kfuncs
   expecting a non-NULL trusted struct file * (such as bpf_get_file_xattr()
   in fs/bpf_fs_kfuncs.c), which immediately dereference file.

Should bpf_lsm_path_getattr() have a strong override in
kernel/bpf/bpf_lsm_proto.c with struct file *file__nullable, similar to
bpf_lsm_mmap_file()?

[ ... ]

> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index c66e02ed8ee3b..c67455e060f74 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -112,13 +112,14 @@ static int tomoyo_bprm_check_security(struct linux_=
binprm *bprm)
>  }
> =20
>  /**
> - * tomoyo_inode_getattr - Target for security_inode_getattr().
> + * tomoyo_path_getattr - Target for security_path_getattr().
>   *
>   * @path: Pointer to "struct path".
>   *
>   * Returns 0 on success, negative value otherwise.
>   */
> -static int tomoyo_inode_getattr(const struct path *path)
> +static int tomoyo_path_getattr(const struct path *path,
> +			       struct file *file)

[Severity: Low]
Does the kernel-doc comment for tomoyo_path_getattr() also need a @file
entry to avoid a kernel-doc warning under W=3D1 builds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D9
