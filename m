Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877126;
	b=gnAi3XAYfiJokB3mZBX1TJ5vLUUFnugUxuJAuBqbX/lq9000Wjp3DY5rQAKmedkyXwRa
	 BuCOPAbBqr3v87bleoORzI2JIhXRuKg27oBeEdB9HRKXg6XIH1RSII24X/v+1uAB67i54
	 ILTV84gjQoaZkpGv7sS6Iu/qei3N6NYo6ZSJ0DrylD8bL/CjbcSLWxV4VsTW86x9PioJo
	 GXMmujXfiR7kY1+u8Cy2tMMY/3aUd53SQrVEko+5vk6iynG7oCK+wEZ97RlLBGDKjGJxW
	 jsg5Bo4HeXHPA+uWZ0VhWcnpU5N9Wky25VXX+o3T5olDi4ao3r3srCoUS44y1Ymet9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877126;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A6Btm3+v+dnXqWTR2GX+hsLiVMvVrLHj5mxZiRv+uQA=;
	b=x+Fg3FGbSLozNBzy1Opek04AGYC6ITc6GPk9M08J5baLiHM5ar13QgR49fHlmxOxkbxu
	 RwpiK2QXz/qoQA9u5bK1snnS1OKlPlgzuj9p+8i8kE+Sh2RC6n9ju33U3lAFI+V6qHqlq
	 AD5Bc7J5TFF68yqqXt7MUV3no0pabxP2UIeutJ0DjQr0GlIvgZltYttalcGLQxrtGki9v
	 elqqLjJPU/W9GZ1SN2TRxdD17Fn1Tiye6drUwxpzAtKWDPjjXV9PCpBsZ/LY+OuZGoflj
	 ynG5yVCyljEEsFfqZtknhQmFLsQCOA+PzZQyRqoDqL79Z+O5b8C8EKEk1FVxj0P3lQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAbXpW5G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D48606A337;
	Thu,  5 Nov 2026 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAbXpW5G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B671F000C1;
	Thu,  5 Nov 2026 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877125;
	bh=A6Btm3+v+dnXqWTR2GX+hsLiVMvVrLHj5mxZiRv+uQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WAbXpW5G+J81zpga2YkofDFAJr37p7VW0gGXFRU1+QCgzM/A2pZgHgznNZ2nCalqE
	 Ia3JyUZPh6L8Rg/y+uDgpDdpHVkNXyzDJVU61C50bKdJpxk3QmFsmifPi+WacjV/XA
	 QcdaQ2JwYWDZM/S9fBxO98d3uu84tMP2L3LX4JZ6BhPLw+JPH/18HgMzAJJzcMfDF3
	 tw4HNNjQMzFdjFhehxPRAgVYMCdqVn+EzZzkd0u3g2A/L89+VMUZrPX21d6cbm+Hxu
	 OFZ2xzICDiinoYKDYRJ6cNwQKSRtQb9bUblJfArFReo7oJfCXLWSKUy3cXW4MihmdO
	 KKFQUwanA6LGA==
Message-ID: <sashiko-outbox-198922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/8] selinux: Restrict dma-buf direct cgroup charging
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
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-7-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-7-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:12:03 +0000
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
- [High] selinux: selinux_dma_buf_charge_cgroup() bypasses check on genfsco=
n cgroups
- [Medium] selinux: one-off dma_buf charge_cgroup lacks broader cgroup cont=
rol design
--

commit d0dd0ed1dd84ec5c8f4de9a298a749d83668b53e
Author: Albert Esteve <aesteve@redhat.com>

selinux: Restrict dma-buf direct cgroup charging

This commit implements the selinux_dma_buf_charge_cgroup() hook and adds the
charge_cgroup permission to the dma_buf security class to restrict which
processes can charge dma-buf memory to a target cgroup.

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
As reported by Sashiko on v3 [1], in security/selinux/hooks.c, does returni=
ng
0 in selinux_dma_buf_charge_cgroup() when kernfs_xattr_get() returns -ENODA=
TA
bypass the permission check for all default-labeled cgroups?

When a process calls ioctl(DMA_HEAP_IOCTL_ALLOC) or
ioctl(DMA_BUF_IOCTL_XFER_CHARGE) with a charge_fd referencing a cgroup
directory, mem_cgroup_get_from_fd() invokes security_dma_buf_charge_cgroup()
-> selinux_dma_buf_charge_cgroup().

In SELinux, cgroup and cgroup2 filesystems are configured with
SE_SBGENFS | SE_SBGENFS_XATTR in selinux_set_mnt_opts() and obtain their
default label (such as cgroup_t) from policy genfscon rules. When a cgroupfs
VFS inode is initialized in inode_doinit_with_dentry(), SELinux computes the
default SID via selinux_genfs_get_sid() and only uses kernfs xattrs as an
optional override:

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
inode_doinit_use_xattr() gets -ENODATA and falls back to def_sid in memory
without writing any security.selinux xattr to cgrp->kn:

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

Similarly, selinux_kernfs_init_security() sees -ENODATA on the parent node
and returns 0 without setting an xattr on child cgroup nodes, and if the
cgroup_seclabel policy capability is not enabled, security.selinux xattrs
cannot be set on cgroup directories at all.

Because kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, NULL, 0) returns
-ENODATA for every cgroup that has not been manually relabeled via
setxattr(), won't selinux_dma_buf_charge_cgroup() skip avc_has_perm() for a=
ll
default-labeled cgroup_t cgroups and render policy rules like
"allow allocator_app_t cgroup_t:dma_buf charge_cgroup;" ineffective?

[ ... ]

> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index b4ebedc6e4240..90d1e04c3d27c 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -181,7 +181,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
>  	{ "user_namespace", { "create", NULL } },
>  	{ "memfd_file",
>  	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
> -	{ "dma_buf", { "charge_task", NULL } },
> +	{ "dma_buf", { "charge_task", "charge_cgroup", NULL } },

[Severity: Medium]
As reported by Paul Moore on RFC [2], in security/selinux/include/classmap.h
(secclass_map) and security/selinux/hooks.c (selinux_dma_buf_charge_cgroup(=
)),
this adds a narrow dma_buf class permission for cgroup charging invoked from
DMA_HEAP_IOCTL_ALLOC and DMA_BUF_IOCTL_XFER_CHARGE via
mem_cgroup_get_from_fd() -> security_dma_buf_charge_cgroup().

Rather than introducing a one-off dma_buf cgroup charging permission, should
this be part of a broader SELinux access control design covering existing
cgroup control points so that the object class and permission model is
consistent across cgroup operations?

[1] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
6-78d2c4cb8647@redhat.com
[2] https://lore.kernel.org/r/16093a0278a6d7d1a0a8bc055c228bed@paul-moore.c=
om

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D7
