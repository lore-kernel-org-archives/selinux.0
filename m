Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106179;
	b=IvjKwjFCXtX+11lvZo+kdYY6sVWqramnhhvL5lzhXwve/lh+zZcqjQhoghQQVzz91qE7
	 JhL2zlEWAXbcguLaKk63ndgxcdZH9oJQyQoKk+wpkiOSkp2J79oMWow8EWPdDhr2UEOUR
	 TYdEfPmhwCB/E4HOPhfOyl06zTaxGDhAY1mfR0Vf8mWgXxLYyazirqiaOgnNqTfXd3HSj
	 JoF3v5alT+9D076gl8X9CbiVD3KACfW8bKp5WVP7zjq8KSmEASldIDWCTEGhYHM8tlGYt
	 Wg1DrDBmdwFZxO+zdvUiIRsjCxseN8L0vwLrau/BeJMglq7slc51P869e7J4e6k3Mrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106179;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AuGd6/0lV3u80K6afDNvZ6QslFjyuo8zZBO2WmTuR6Q=;
	b=wXM3FDP9+z9ZXeYbdlLdkBf8td6eviZOKtrD+TjZmM9GFZ2fuoyxX35nTRXWlkbdVDl5
	 Ibtllzz0yG6CjXrlVdJnL/OxOQ3WGGPpR5GTzHz/pDQ6mWFaGSKX0j1dGWIcNs8hGEQJM
	 5tzVuLTzr6A3scvCVe3AXrz6RDNBrh8jBiuRSOqtrB211EmcDmh0SOpdkiCPTHK0+WXdJ
	 YjoPzoXTrTOYbonL5J2+FD/r1K2dhlXsE6tSKBbOkViqXle3GBG8T0DGXc/uQxFjjMrSL
	 AmReBDuuWokcLkb1daWDJ65QbhU8ywjfN6rEqxveA3uX+S8aw+Wew/OjLqllX0Ohz3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCLDFWFq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C87606A31B;
	Tue, 27 Oct 2026 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCLDFWFq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972DC1F01825;
	Tue, 27 Oct 2026 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106179;
	bh=AuGd6/0lV3u80K6afDNvZ6QslFjyuo8zZBO2WmTuR6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HCLDFWFqpPC5fPv/s1XgegxV2pfFOiq6gDYLjEeL0KW/FEwXvunP3SyV/oAzGvCjS
	 g8BrXQBlLfguB4lxYcGKFlaxDbT+UhNYIOniJE9dBuc21qbI1/BXZUt2dI5ur/tDZP
	 tnjmwSpSxC4QLOz9L6YFQvpLmcdhjc9JDYYsAcX+d8QYGOvXMAAa4HV5UNBXTKFlIr
	 TyICR5pjWpbKKfepf3/oNfoopSxHZQr3uzW0i23FBKh6tYzjegG0tJsPBX6CiN/31R
	 PujZZArYR/oSwmOHBIOrv0qsVzmvWZLP+/JnJ90MAC33CDPa7mR81KVTShE5wq7E8M
	 voYqIXBu/VDng==
Message-ID: <sashiko-outbox-186599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 06/18] LSM: pass struct path and struct file to
 the inode xattr hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261027121151.1887650-7-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-7-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:02:58 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] bpf: missing __nullable on file arg in inode xattr LSM hooks a=
llows NULL deref
- [High] bpf: untrusted path->dentry in inode xattr LSM hooks breaks dentry=
 kfuncs
- [Low] security: missing @idmap kernel-doc in cap_inode_removexattr()
--

commit e83206fa3b704333b0de2a23321bc120a419f251
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: pass struct path and struct file to the inode xattr hooks

This commit updates the inode_setxattr, inode_getxattr, inode_listxattr, and
inode_removexattr LSM hooks and their callers to take a const struct path
instead of a struct dentry, and passes the associated struct file when
available (or NULL for path-based and in-kernel operations). It also updates
the BPF LSM selftests attached to these hooks to pass path->dentry to the
dentry xattr kfuncs.

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ea6e0fbaa3b9c..2315961b6d713 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -156,14 +156,16 @@ LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, co=
nst struct mnt_idmap *idmap,
>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
>  LSM_HOOK(int, 0, inode_xattr_skipcap, const char *name)
>  LSM_HOOK(int, 0, inode_setxattr, const struct mnt_idmap *idmap,
> -	 struct dentry *dentry, const char *name, const void *value,
> -	 size_t size, int flags)
> +	 const struct path *path, const char *name, const void *value,
> +	 size_t size, int flags, struct file *file)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
>  	 const char *name, const void *value, size_t size, int flags)
> -LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
> -LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
> +LSM_HOOK(int, 0, inode_getxattr, const struct path *path, const char *na=
me,
> +	 struct file *file)
> +LSM_HOOK(int, 0, inode_listxattr, const struct path *path,
> +	 struct file *file)
>  LSM_HOOK(int, 0, inode_removexattr, const struct mnt_idmap *idmap,
> -	 struct dentry *dentry, const char *name)
> +	 const struct path *path, const char *name, struct file *file)

[Severity: Critical]
Since path-based xattr syscalls (filename_setxattr(), filename_getxattr(),
filename_listxattr(), and filename_removexattr() in fs/xattr.c) and in-kern=
el
callers pass file =3D NULL to these hooks, can omitting the __nullable suff=
ix
on the new file parameter allow a BPF LSM program to trigger a kernel NULL
pointer dereference?

In kernel/bpf/btf.c:btf_ctx_access(), pointer arguments of trusted BPF LSM
hooks are marked as non-NULL PTR_TO_BTF_ID | PTR_TRUSTED unless the paramet=
er
name ends with __nullable:

kernel/bpf/btf.c:btf_ctx_access() {
	...
	info->reg_type =3D PTR_TO_BTF_ID;
	if (prog_args_trusted(prog))
		info->reg_type |=3D PTR_TRUSTED;

	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
		info->reg_type |=3D PTR_MAYBE_NULL;
}

Without PTR_MAYBE_NULL on file, bpf_may_fault_on_deref() returns false, so
convert_ctx_accesses() does not rewrite loads from file (such as walking the
trusted field file->f_inode via BTF_TYPE_SAFE_TRUSTED(struct file)) to
BPF_PROBE_MEM. In addition, the verifier allows passing file without a NULL
check directly to kfuncs that require a non-NULL trusted struct file * and
immediately dereference it, such as bpf_get_file_xattr():

fs/bpf_fs_kfuncs.c:bpf_get_file_xattr() {
	struct dentry *dentry;

	dentry =3D file_dentry(file);
	return bpf_get_dentry_xattr(dentry, name__str, value_p);
}

Should these four hooks either name the parameter file__nullable or provide
strong bpf_lsm_* overrides with file__nullable in kernel/bpf/bpf_lsm_proto.c
(similar to bpf_lsm_mmap_file())?

> diff --git a/security/commoncap.c b/security/commoncap.c
> index 565c893c6d4b4..0a94b9cd231fa 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
[ ... ]
> @@ -1044,25 +1048,21 @@ int cap_inode_setxattr(struct dentry *dentry, con=
st char *name,
>  /**
>   * cap_inode_removexattr - Determine whether an xattr may be removed
>   *
> - * @idmap:	idmap of the mount the inode was found from
> - * @dentry:	The inode/dentry being altered
> + * @path:	The inode/path being altered
>   * @name:	The name of the xattr to be changed
> + * @file:	the file through which the xattr removal is requested, if any
>   *
>   * Determine whether an xattr may be removed from an inode, returning 0 =
if
>   * permission is granted, -ve if denied.
>   *
> - * If the inode has been found through an idmapped mount the idmap of
> - * the vfsmount must be passed through @idmap. This function will then
> - * take care to map the inode according to @idmap before checking
> - * permissions. On non-idmapped mounts or if permission checking is to be
> - * performed on the raw inode simply pass @nop_mnt_idmap.
> - *
>   * This is used to make sure security xattrs don't get removed by those =
who
>   * aren't privileged to remove them.
>   */
>  int cap_inode_removexattr(const struct mnt_idmap *idmap,
> -			  struct dentry *dentry, const char *name)
> +			  const struct path *path, const char *name,
> +			  struct file *file)

[Severity: Low]
Was the @idmap kernel-doc description above cap_inode_removexattr() dropped
by mistake? Since const struct mnt_idmap *idmap is still a parameter of
cap_inode_removexattr(), removing @idmap from the comment block will trigger
a scripts/kernel-doc warning.

> diff --git a/tools/testing/selftests/bpf/progs/test_get_xattr.c b/tools/t=
esting/selftests/bpf/progs/test_get_xattr.c
> index 54305f4c9f2dd..97361ff10e9f1 100644
> --- a/tools/testing/selftests/bpf/progs/test_get_xattr.c
> +++ b/tools/testing/selftests/bpf/progs/test_get_xattr.c
> @@ -56,7 +56,8 @@ int BPF_PROG(test_file_open, struct file *f)
>  }
> =20
>  SEC("lsm.s/inode_getxattr")
> -int BPF_PROG(test_inode_getxattr, struct dentry *dentry, char *name)
> +int BPF_PROG(test_inode_getxattr, const struct path *path, char *name,
> +	     struct file *file)
>  {
>  	struct bpf_dynptr value_ptr;
>  	__u32 pid;
> @@ -69,7 +70,7 @@ int BPF_PROG(test_inode_getxattr, struct dentry *dentry=
, char *name)
>  	bpf_dynptr_from_mem(value2, sizeof(value2), 0, &value_ptr);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(xattr_names); i++) {
> -		ret =3D bpf_get_dentry_xattr(dentry, xattr_names[i], &value_ptr);
> +		ret =3D bpf_get_dentry_xattr(path->dentry, xattr_names[i], &value_ptr);
>  		if (ret =3D=3D sizeof(expected_value))
>  			break;
>  	}

[Severity: High]
Will the BPF verifier reject loading test_inode_getxattr() here (as well as
test_inode_getxattr() and test_inode_setxattr() in
tools/testing/selftests/bpf/progs/test_set_remove_xattr.c) when passing
path->dentry to bpf_get_dentry_xattr(), bpf_set_dentry_xattr(), and
bpf_remove_dentry_xattr()?

Previously, dentry was a direct argument to the inode_getxattr and
inode_setxattr hooks, so btf_ctx_access() marked it as
PTR_TO_BTF_ID | PTR_TRUSTED.

With the hook argument changed to const struct path *path, dereferencing
path->dentry goes through check_ptr_to_btf_access(), which only preserves
PTR_TRUSTED if type_is_trusted() or type_is_trusted_or_null() returns true:

kernel/bpf/verifier.c:check_ptr_to_btf_access() {
	...
	if (flag & PTR_TRUSTED) {
		if (type_is_trusted(env, reg, field_name, btf_id)) {
			flag |=3D PTR_TRUSTED;
		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
			flag |=3D PTR_TRUSTED | PTR_MAYBE_NULL;
		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
			clear_trusted_flags(&flag);
			flag |=3D MEM_RCU;
		} else {
			flag =3D PTR_UNTRUSTED;
		}
	}
}

Because struct path is not listed in BTF_TYPE_SAFE_TRUSTED in
kernel/bpf/verifier.c:type_is_trusted(), walking path->dentry drops
PTR_TRUSTED (marking the register PTR_UNTRUSTED in sleepable lsm.s programs=
).
Since bpf_get_dentry_xattr(), bpf_set_dentry_xattr(), and
bpf_remove_dentry_xattr() require a trusted struct dentry * argument, the
verifier rejects the call with -EINVAL ("R1 must be referenced or trusted").

Does struct path need to be added to BTF_TYPE_SAFE_TRUSTED in
kernel/bpf/verifier.c so that path->dentry and path->mnt remain trusted when
accessed from LSM hooks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D6
