Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927806;
	b=LV9+MDvfbXlUT6e9bczD/4H6LXfA7LmRDYAsARyXDHzDLqzJRyQLfy/LgGOzU35Fz8ok
	 BzTvGMiQGT4WxC5wnR9rEgy62ZIXY8ZjWs3/DmGmovyU5W49PDL0VReTOTqGmFey4P62o
	 AmEKH7zqMqqXk4PQeZvOI4J7UPy5l2DzYkYDDmB9WjJruKZsxKQrYdKFMf7UtAHkT5l57
	 AbRxW3mav+CZCI7AlM9gUKizJ3lo77uSfcLgy7nSpYA61fKicHry6R7bgcr2eP+Zypp1c
	 ccmjHNz13upffkdgKkM2W/fVjxornOS8bj+Cpj6IO7vIITyWQU1MwrbiaLb+zlwq6sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927806;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+tfiMLdxyxs5zBUNFtLAsPWlmRlcbZ+uO4Oe3qnqOZ8=;
	b=I3MZluz8maLLnHWW/qFeu8/Z66nXo7KqoKINVWRXmZEY8pielEq81cBn0YxCd43UZ2PI
	 zktJ1ctTPZuaE4GWko+booSwBY7U1UbHlyRfNhDdY0LL0OE8BHAlEF+k84tmjJyWC9yZD
	 IbpbTLgbgLuHOTSfsovmc8dhPDCyMjFmJEBWjmWGhpIVDPl0clTTKfqxtKgwte8s7hbUP
	 kkVVr2agXM0iiKzOOUzZhmr6ojwJ2Ubls1BOT4DaCio1sVt37neBTDgAnZXCpwoJGXmAe
	 LWLlpWXyiQFZfMLnRl9ifps7VJ9B2vMdU4eKmRpmOJAddKLWbiQXmVWYpUQAK5LVZ7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hz5UqD5i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F2606A335;
	Tue, 17 Nov 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hz5UqD5i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1771F000CC;
	Tue, 17 Nov 2026 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927806;
	bh=+tfiMLdxyxs5zBUNFtLAsPWlmRlcbZ+uO4Oe3qnqOZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hz5UqD5iyZLQJAJU0snBBlX2drK6p12kwxd/JfJ/UPcb3DSPMsbDUqSGsR8nhyqno
	 Y/E2D4u79mKZZU0HoUVxOtZWskjM+XDmU71f8u6BzS9agSL3mhRPFShx7YIbIPIs4G
	 ukjsUMkOPSb5DkBzA2FD8qfHEfLApUmCZqjcCb9aJkWSfzhjyWApgGTUOOPXCylBPN
	 n6ptguWosZXo+0GauayDWAVsSs3j3yquCyqSqNz6y6+GL9W7mn6EE+9bX5Zxp5JYqO
	 QF51zv4bUPvL8nbD1Lvj50I7IlBFq1WFoP7S9gvXXZHXIxURERzswyCrh0UP+YXULH
	 SKrz3dLVWJgUg==
Message-ID: <sashiko-outbox-219012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v4 05/17] LSM: pass struct path and struct file
 to the inode xattr hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, dsterba@suse.cz, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261117150542.1169451-6-caixinchen1@huawei.com>
References: <20261117150542.1169451-1-caixinchen1@huawei.com>
 <20261117150542.1169451-6-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:03:19 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: missing BTF_TYPE_SAFE_TRUSTED for struct path breaks
  xattr kfuncs
--

commit 8e13dee6fc4fbca67536485e5988ae543a847e9e
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: pass struct path and struct file to the inode xattr hooks

This commit converts the inode_setxattr, inode_getxattr, inode_listxattr,
and inode_removexattr LSM hooks and VFS xattr helpers to take a const
struct path * instead of a struct dentry *, and threads an optional struct
file * through them.

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

[Severity: Medium]
Does the verifier reject passing path->dentry to bpf_get_dentry_xattr()
here and in test_set_remove_xattr.c?

Because struct path is not listed in BTF_TYPE_SAFE_TRUSTED in
type_is_trusted() at this commit, check_ptr_to_btf_access() drops
PTR_TRUSTED when dereferencing path->dentry, causing the xattr kfuncs to
reject the argument and breaking these BPF selftests across bisection.
A later patch in the series, commit "LSM: rename inode_setattr to
path_setattr and pass struct path and file", adds
BTF_TYPE_SAFE_TRUSTED(struct path); moving that verifier change to or
before this patch would keep these hooks and selftests working here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117150542.1169=
451-1-caixinchen1@huawei.com?part=3D5
