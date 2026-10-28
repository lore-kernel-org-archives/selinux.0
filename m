Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199879;
	b=OLlYYRI00D0r/ijcmy9p/n9iCatjFApCLnx/GoQKbWtJ56RtGj5TP1U/7WsYTntZFxyw
	 1IPDUYX4Q52Tjn4m/2oSr15EUqV+P+Jd3pTrsg2QW07yAIILAcP97TDd7RBVdYPjedAx/
	 caOlM2Yo8IdMEgs8tU3wgAe48PmtAXHAkpzG5FxEUhp3jWbAGB88J6ZeH8rTlxh+UqjtM
	 0Xh5qrjicG7gxBxAi6pJ5PWZ6OQ8zMqlnBy8YHikevSf3UwP2bTWwkL/sB1J/J90QGLgp
	 wKNYLoXNuPq1xFZmYrQyt1T/BTscj5WZE62DBSwrkxtIwDV9pTAfj4Pm310lyav8rXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199879;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1TKqOP98FHIDcaJNoj3/GWwGDtZsh2WFMN9gl9UcQOs=;
	b=a4UqVkn8GyneSdcT96CbZuJmmdmv36hYtqhRHnSV5EUbBPqU59+qeO9s0GMnG7LTiKkl
	 azbw7a34/oP/GOf8i5odJTS30xEnfw1X9ucNZcQvE7VGbhcGZrRc33oCC0ppaFfdGmBaI
	 zr3zrM45hRkY9o6JBlkj8vd9ZlhkvAIkPBOZMAXrN5LLXgJyQU3th8NekUntQ8l2WgHdi
	 dDtjOjoWRTmyoysoMJ4HrgbA/5edXyJ0Wfec7rwlg9ZIlWqfkZigEJUzOAfOujbHACmb/
	 +c0PcGbIEUf80F274tflISMuGMOHb+d0Bg7yu/RdZMtjuwHTPqT8GNUQL7v6dCC84EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIRs14Ak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D8606A31D;
	Wed, 28 Oct 2026 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIRs14Ak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB0F1F01825;
	Wed, 28 Oct 2026 15:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199879;
	bh=1TKqOP98FHIDcaJNoj3/GWwGDtZsh2WFMN9gl9UcQOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EIRs14AkkJNqV4FP2ztjO7metvge3koWsF8rvc9H1eOkLYX/cgC+Pq+XLh/h7oAnj
	 MNEGn9M/5cbtIepg3E5EECqqap8BFEljXDT05wKvMgl+Apv61iiIqUYexNfJTjfmPs
	 AoRvFUnbC3JIf3GjxOS+wc+ep8hcuNWLd1w3y7jCZ6hnohvFWH1x2A80texn/ET9Kq
	 yEq4MfQLIx5q38dPZ7eq1EDKuY5cCnLKRotbFLGUKXR/tzKM6v7AlFttlp5sh19hjJ
	 UBMh1XXQFRZUVF7n1jMrjSfKEDoADfSjdgZdcB6KfU5RvH6Y0q7CasX9j84wOnfCZY
	 3UAJSV4V6VVAA==
Message-ID: <sashiko-outbox-188031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] selinux: Restrict dma-buf direct cgroup charging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Albert Esteve" <aesteve@redhat.com>, "Tejun Heo" <tj@kernel.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, =?utf-8?b?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Michal
 Hocko" <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Benjamin Gaignard" <benjamin.gaignard@collabora.com>, "Brian
 Starkey" <Brian.Starkey@arm.com>, "John Stultz" <jstultz@google.com>, "T.J.
 Mercier" <tjmercier@google.com>, "Christian Brauner" <brauner@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 =?utf-8?b?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, "Jens Wiklander" <jenswi@kernel.org>, "Sumit
 Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-6-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-6-78d2c4cb8647@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:04:37 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] selinux: selinux_dma_buf_charge_cgroup() bypasses check on genfsco=
n cgroups
--

commit 6b412783b17727c382f1a67078326c58c39264e7
Author: Albert Esteve <aesteve@redhat.com>

selinux: Restrict dma-buf direct cgroup charging

This commit implements the selinux_dma_buf_charge_cgroup() LSM hook and adds
the charge_cgroup permission to the dma_buf security class to control which
processes may charge dma-buf memory to a cgroup. It reads the target securi=
ty
context from the cgroup kernfs node's security.selinux extended attribute a=
nd
checks permission via avc_has_perm().

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8f39d91eabc97..2f99eaa910af4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2210,6 +2210,40 @@ static int selinux_dma_buf_charge_task(const struc=
t cred *from, const struct cre
>  			    SECCLASS_DMA_BUF, DMA_BUF__CHARGE_TASK, NULL);
>  }
> =20
> +#ifdef CONFIG_CGROUPS
> +static int selinux_dma_buf_charge_cgroup(const struct cred *cred, struct=
 cgroup *cgrp)
> +{
> +	u32 cgrp_sid, clen;
> +	int rc;
> +	char *context;
> +
> +	rc =3D kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, NULL, 0);
> +	if (rc =3D=3D -ENODATA)
> +		return 0;

[Severity: High]
Does returning 0 on -ENODATA here bypass the permission check for all cgrou=
ps
that carry their default genfscon label (such as cgroup_t)?

In selinux_set_mnt_opts(), cgroup and cgroup2 filesystems are configured wi=
th
SE_SBGENFS | SE_SBGENFS_XATTR. When a cgroup VFS inode is initialized in
inode_doinit_with_dentry(), SELinux obtains the default SID from policy via
selinux_genfs_get_sid() and then checks for an optional xattr override via
inode_doinit_use_xattr():

security/selinux/hooks.c:inode_doinit_with_dentry() {
	...
	rc =3D selinux_genfs_get_sid(dentry, sclass,
				   sbsec->flags, &sid);
	if (rc) {
		dput(dentry);
		goto out;
	}

	if ((sbsec->flags & SE_SBGENFS_XATTR) &&
	    (inode->i_opflags & IOP_XATTR)) {
		rc =3D inode_doinit_use_xattr(inode, dentry,
					    sid, &sid);
	...
}

When no explicit setxattr() has been performed on the cgroup directory,
inode_doinit_use_xattr() sees -ENODATA from the underlying kernfs node and
falls back to def_sid in memory without writing a security.selinux xattr to
cgrp->kn:

security/selinux/hooks.c:inode_doinit_use_xattr() {
	...
	if (rc < 0) {
		kfree(context);
		if (rc !=3D -ENODATA) {
			pr_warn("SELinux: %s:  getxattr returned %d for dev=3D%s ino=3D%llu\n",
				__func__, -rc, inode->i_sb->s_id, inode->i_ino);
			return rc;
		}
		*sid =3D def_sid;
		return 0;
	}
	...
}

Likewise, selinux_kernfs_init_security() sees -ENODATA on the parent kernfs
node and returns 0 without storing an xattr on newly created child cgroups.

As a result, unless a cgroup directory has been explicitly relabeled with
setxattr(), kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, NULL, 0) will
return -ENODATA even though the cgroup is labeled cgroup_t via genfscon.
When userspace passes a cgroup fd via DMA_HEAP_IOCTL_ALLOC or
DMA_BUF_IOCTL_XFER_CHARGE, mem_cgroup_get_from_fd() invokes
security_dma_buf_charge_cgroup() -> selinux_dma_buf_charge_cgroup(), which
will return 0 without calling avc_has_perm(), leaving default-labeled
cgroup_t cgroups unrestricted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-v2_2023012=
3_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com?part=3D6
