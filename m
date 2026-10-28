Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199881;
	b=E1hWWta055BYtdt1fwXVqElFIRI6qiNSo8zcTeNJzcKWvGggzJ2bDHkrbtsgwcSWoGC9
	 +vGIp4njadRKpON4xdplMlMEyo9UMezeW6XQKP/T9MkLPvLAu7RdudsCPfypR3d8JzjpJ
	 L9ygAm37Sqj+EwLqX5acrd/Rh2Rf/T4Hmgh3D7DsnE9IxluLqXOt1/IFp2s8e5vV8Lc+A
	 ujqg+H0mze8GkSUFO3Tm7MnpV12p3r6i0xu9x+fEMBUy8Nx/5ajLpgOBCYjQFxw0qwDVs
	 n+KaM2Vj/vMgqsVxTM2EFfDYKLKsTmk0K4MP6IYuB4/a3mjyFCtarQrq5E/ql1+bPqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199881;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mSdqxz6Q37ONxr+q5PLgX5Mx5sgsbL1ZlDMhRwJ4tls=;
	b=PbwmIaUKm7pb5eJvg9je/6kjJ8givYqD8WSjSA7SjtGMepPB7x5cDjtZBadcXtOIaOWx
	 MjjRTuuYSpFeW9fP0vAtwwQg/3Ht+qx5fK2QRZh7lnpZUPpMPM50CgIRsOOlnawfPOvbe
	 Locz229KYJipPBFJT/WuRFeEpj20BPFw9Mw/MQOPaf/n4iHg12MDncp2SGPYw6kIh3Ckx
	 0/eXJ5WqOljmsw7yUNRtwLiSuBHKzc82jMNfz+ThgmwahHE0fgNnOL8W0hpB0N78Veoey
	 jRoEeysb7HNF/ujXYDZX/4DL4lkfgYeq0oJZ1grXuqAToD6TsRWhyDQx8mmby+/9Ctw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ii2Cv1I1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688C606A32D;
	Wed, 28 Oct 2026 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ii2Cv1I1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7631F01829;
	Wed, 28 Oct 2026 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199881;
	bh=mSdqxz6Q37ONxr+q5PLgX5Mx5sgsbL1ZlDMhRwJ4tls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ii2Cv1I1mFw6z0jUk6ND3vI1KQsc+cPLiCIZMvKnAo54Gp0s/gplwdGsTCOINjF3m
	 Vyp8TPUP1c89LMrtNfl1SSCyLKR8iCzMdClXf8Ag22Q466Srn6wp0pPBEPe1niet9S
	 ltmp6epcmx5o/iHtRObx0gat20oSI3vbNsnbdjdF1arYD08Zmh3aUxS6DVRKuWcEhE
	 +D3p7ka5Cqbc2R7/WvOlKFR5jK2qoxxu/WaG77pXfVBFw+gw6l11JjB/aHP5om3QIg
	 XPjWzyvY1HOBKSJdOvSWDFjmd3ugT+ApaWExa7poGt1jjmuxkJPlMjdXVPIc7LG6HW
	 WCOxu4Wy9nCCA==
Message-ID: <sashiko-outbox-188032@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] dma-buf: transfer memcg charges via
 DMA_BUF_IOCTL_XFER_CHARGE
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
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-7-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-7-78d2c4cb8647@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:04:39 +0000
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
- [High] dma-buf: unprivileged cgroup escape and OOM via dma_buf_xfer_charg=
e()
- [High] dma-buf: race in mem_cgroup_transfer_dmabuf_charge() double-charge=
s memcg
- [Medium] dma-buf: broken disabled-memcg handling in dma_buf_xfer_charge()
--

commit 1660729e62b15fd915c69f26225530bd5ae30ce0
Author: Albert Esteve <aesteve@redhat.com>

dma-buf: transfer memcg charges via DMA_BUF_IOCTL_XFER_CHARGE

This commit adds DMA_BUF_IOCTL_XFER_CHARGE to allow transferring a dma-buf's
memory cgroup charge to a cgroup identified by a cgroupfd or pidfd after
allocation. It also introduces a memcg_account flag in dma_buf_export_info =
for
exporters to opt in to memcg accounting, enabling it for the system heap.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f31f49ebd0af3..07513ecedc105 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -540,6 +540,45 @@ static long dma_buf_import_sync_file(struct dma_buf =
*dmabuf,
>  }
>  #endif
> =20
> +/* Transfer a dma-buf's memcg charge; see struct dma_buf_transfer_charge=
 */
> +static long dma_buf_xfer_charge(struct dma_buf *dmabuf,
> +				const void __user *user_data)
> +{
> +	struct dma_buf_transfer_charge arg;
> +	struct mem_cgroup *memcg;
> +	int ret =3D 0;
> +
> +	if (copy_from_user(&arg, user_data, sizeof(arg)))
> +		return -EFAULT;
> +
> +	if (!IS_ENABLED(CONFIG_MEMCG))
> +		return 0;
> +
> +	if (arg.flags !=3D 0)
> +		return -EINVAL;
> +
> +	if (!dmabuf->memcg_account)
> +		return -EOPNOTSUPP;

[Severity: Medium]
When CONFIG_MEMCG is disabled, should dma_buf_xfer_charge() still validate
arg.flags and dmabuf->memcg_account, or return -EOPNOTSUPP?

Returning 0 before checking arg.flags !=3D 0 and !dmabuf->memcg_account cau=
ses
calls with invalid flags, non-accounting exporters, or invalid file
descriptors to silently succeed under CONFIG_MEMCG=3Dn, while also leaving =
the
!CONFIG_MEMCG stubs for mem_cgroup_get_from_fd() (which returns
ERR_PTR(-EOPNOTSUPP)) and mem_cgroup_transfer_dmabuf_charge() in
include/linux/memcontrol.h unreachable.

Also, when CONFIG_MEMCG=3Dy and cgroup_disable=3Dmemory is passed on the ke=
rnel
command line (so mem_cgroup_disabled() is true at runtime),
mem_cgroup_get_from_fd() behaves inconsistently across its two branches:

mm/memcontrol.c:mem_cgroup_get_from_fd() {
	cgrp =3D cgroup_get_from_fd(fd);
	if (!IS_ERR(cgrp)) {
		rcu_read_lock();
		css =3D cgroup_css(cgrp, &memory_cgrp_subsys);
		if (!css || !css_tryget_online(css)) {
			rcu_read_unlock();
			cgroup_put(cgrp);
			return ERR_PTR(-ENOENT);
		}
...
	memcg =3D get_mem_cgroup_from_mm(mm);
	mmput(mm);
	return memcg;
}

For a cgroupfd, cgroup_css() is NULL and it returns ERR_PTR(-ENOENT), where=
as
for a pidfd, get_mem_cgroup_from_mm() returns NULL rather than an ERR_PTR, =
so
dma_buf_xfer_charge() returns 0 for pidfds and -ENOENT for cgroupfds.

> +
> +	memcg =3D mem_cgroup_get_from_fd(arg.charge_fd);
> +	if (IS_ERR(memcg))
> +		return PTR_ERR(memcg);
> +
> +	if (dmabuf->memcg =3D=3D memcg)
> +		goto skip_transfer;
> +
> +	if (!mem_cgroup_transfer_dmabuf_charge(dmabuf, memcg)) {
> +		ret =3D -ENOMEM;
> +		goto skip_transfer;
> +	}

[Severity: High]
Can an unprivileged holder of a dma-buf file descriptor use
dma_buf_xfer_charge() to escape its own memory cgroup limit or trigger OOM
kills in another cgroup?

In the call chain:

  dma_buf_ioctl()
    -> dma_buf_xfer_charge()
      -> mem_cgroup_get_from_fd()
      -> mem_cgroup_transfer_dmabuf_charge()
        -> mem_cgroup_reserve_dmabuf(new_memcg, GFP_KERNEL, nr_pages)
          -> try_charge()

neither dma_buf_xfer_charge() nor mem_cgroup_get_from_fd() checks DAC or
cgroup delegation/write permissions (such as inode_permission() with MAY_WR=
ITE
or cgroup_procs_write_permission()), capabilities, or ptrace_may_access() on
either the source cgroup (dmabuf->memcg) being uncharged or the target
cgroup/task (new_memcg) being charged.

Because /sys/fs/cgroup directories are normally world-readable (mode 0755, =
so
any user can open them with O_RDONLY | O_DIRECTORY) and pidfd_open() can op=
en
a pidfd for PID 1 or any visible process without privilege, an unprivileged
process can resolve a handle to the root cgroup or to another cgroup on the
system.

When SELinux is not active, security_dma_buf_charge_cgroup() and
security_dma_buf_charge_task() return 0. Even with SELinux enabled,
selinux_dma_buf_charge_cgroup() returns 0 when the cgroup kernfs node has no
explicit security.selinux xattr set:

security/selinux/hooks.c:selinux_dma_buf_charge_cgroup() {
	rc =3D kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, NULL, 0);
	if (rc =3D=3D -ENODATA)
		return 0;
}

and neither hook checks permission to uncharge the existing dmabuf->memcg. =
As
a result, a confined client receiving a pre-charged dma-buf fd can move the
charge to the root cgroup to bypass its own memory.max limit, or move the
charge into a victim cgroup where mem_cgroup_reserve_dmabuf() with GFP_KERN=
EL
triggers direct reclaim and the memcg OOM killer.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b841b9057594..3adc84fe6668d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5786,6 +5786,47 @@ void mem_cgroup_cancel_dmabuf(struct mem_cgroup *m=
emcg, unsigned int nr_pages)
>  		refill_stock(memcg, nr_pages);
>  }
> =20
> +/**
> + * mem_cgroup_transfer_dmabuf_charge - move a dma-buf charge
> + * @dmabuf: buffer to transfer charge
> + * @new_memcg: target memcg; caller must hold a reference
> + *
> + * Transfers the charge for @dmabuf to @new_memcg and, on
> + * success, stores @new_memcg in @dmabuf->memcg.
> + * Returns %true on success, %false if the charge against @new_memcg
> + * failed or a concurrent transfer raced on @dmabuf->memcg.
> + * On failure the caller retains its reference to @new_memcg.
> + */
> +bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> +				       struct mem_cgroup *new_memcg)
> +{
> +	struct mem_cgroup *old_memcg =3D READ_ONCE(dmabuf->memcg);
> +	unsigned int nr_pages =3D PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> +
> +	if (mem_cgroup_disabled())
> +		return true;
> +
> +	if (!mem_cgroup_reserve_dmabuf(new_memcg, GFP_KERNEL, nr_pages))
> +		return false;
> +
> +	mod_memcg_state(new_memcg, MEMCG_DMABUF, nr_pages);
> +
> +	if (cmpxchg(&dmabuf->memcg, old_memcg, new_memcg) !=3D old_memcg) {
> +		mod_memcg_state(new_memcg, MEMCG_DMABUF, -nr_pages);
> +		mem_cgroup_cancel_dmabuf(new_memcg, nr_pages);
> +		return false;
> +	}

[Severity: High]
What happens if two threads concurrently call DMA_BUF_IOCTL_XFER_CHARGE on =
the
same dma-buf?

In dma_buf_xfer_charge(), dmabuf->memcg =3D=3D memcg is checked without
synchronization before calling mem_cgroup_transfer_dmabuf_charge(), which t=
hen
re-reads old_memcg =3D READ_ONCE(dmabuf->memcg) without checking whether
old_memcg =3D=3D new_memcg.

If thread 1 transfers the buffer to new_memcg after thread 2 passes the
dmabuf->memcg =3D=3D memcg check in dma_buf_xfer_charge() (or if both threa=
ds
concurrently transfer the buffer to the same new_memcg), thread 2 sees
old_memcg =3D=3D new_memcg and still calls mem_cgroup_reserve_dmabuf(new_me=
mcg,
GFP_KERNEL, nr_pages) before uncharging old_memcg. That transiently charges
2 * nr_pages against new_memcg for the same buffer, which can trigger recla=
im,
memcg OOM kills, or -ENOMEM in new_memcg even though the buffer is already
charged to it.

In addition, old_memcg is read before mem_cgroup_reserve_dmabuf(new_memcg,
GFP_KERNEL, nr_pages), which can sleep in direct reclaim. If another thread
updates dmabuf->memcg while mem_cgroup_reserve_dmabuf() is sleeping, the
cmpxchg(&dmabuf->memcg, old_memcg, new_memcg) fails without retrying against
the updated old_memcg and returns false, which dma_buf_xfer_charge() reports
to userspace as -ENOMEM even though charging new_memcg succeeded.

Finally, if mem_cgroup_transfer_dmabuf_charge() is called when
mem_cgroup_disabled() is true, returning true at the top without storing
new_memcg in dmabuf->memcg or dropping new_memcg's reference would leak the
 caller's reference to new_memcg, since callers only call mem_cgroup_put() =
when
this function returns false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-v2_2023012=
3_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com?part=3D7
