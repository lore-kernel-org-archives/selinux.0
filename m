Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611926;
	b=PJlCvOzrGGNvUBHfW4/jz0/si2GQ/WGIHAdXHGZbdeuKPMEO+a08BCKDcxkMpnfPoKjI
	 OX+EBrk+HV8xQHjsiAJk90p6Yyf4ccRAAyvfLE/zDbueA9DzqFqfEa3HszGCewTc1Za2D
	 ZvVEwgruT1tiD+05rTN1GJ7o8W3+M833OQlJ7mIo32cBUeUP1iJG+O+bnmtx8Vctoyx1S
	 Kig/3Wju4B4a3Wu0YwjTFuWmNFNh8/uWnC8mcwtm2cqHMJSpl31lQEnrPucWX5LLshwAt
	 GUgr3w/dtx0sEIvEDaBPrO45x35Y4YBq1O1/DdGAPSPMVmuVjYfnHtsapL1HNLLgktQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611926;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mk8/GrdShzBimqotJLwmFPdZ5k/yU8pDK1zQzPphDwE=;
	b=ivIhXGJO0eduL9/eMsGEiY3TQMu9lrZO2AeML2S3UksEpaint4DeaEUZHrnrB3pUpCyN
	 Q8p+JJd7KAVmP7/yPFGiqHAVv2ymbZM7ZIA+wmI6v0K01dpSgoumYGvFJqZViMSQ0JadS
	 KDnqkwM00WURz4f/sqk4zS343bDJfAiVomZKEt21oOGQ2zwclGUfl7dy+nzzJAbQfJZQG
	 9/2/3z4uNoNCYMt4NzUsNlnK7ZrH0Rs4htw/JhFuxIieubbMpcW/DC2xqidvLgWMpNGmN
	 z1AAujRideRZUHKgXOm0GxR++YInx6yUJmjqaUlipf6mukS1td5bTAbYG/mKHGZ6ukA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7CgCBaT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E7606A321;
	Wed, 25 Nov 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7CgCBaT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E65F1F000C0;
	Wed, 25 Nov 2026 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795611926;
	bh=mk8/GrdShzBimqotJLwmFPdZ5k/yU8pDK1zQzPphDwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7CgCBaTStMB4v1DHVH43pVcRsQYovYl0Zz21echw/YbsR9o2vyApTc95kjPxcrwy
	 S2FzqBpCClDMF9wNZ/Ew8c5qFKJrr+QzSjRt0v5GRpuEefLzYP+9pSMSiofX3su4uj
	 XPlTKPfIcFa97GGBlZhso19bbpFvn6mTriSpKdORjSj2n+3jPhBolSUjsHSC1IcPU8
	 +OL3Mb7QkfBN1vyPAo6fyqfoLVQ+zclgNL6OQSqOk8+l5qdm0dlHjGUW3Qqg5WYpdR
	 b8GgxvNGAt8LNwKw/G8td8mkfZ/iHRMuG/h/QZnQV3x+ZAxvRsBq0nXwPVY4YySt7e
	 SMZOtPVstK1xA==
Message-ID: <sashiko-outbox-233444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/7] dma-heap: charge dma-buf memory via explicit
 memcg
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
 Garg" <sumit.garg@kernel.org>, "Philipp Stanner" <phasta@kernel.org>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261124-v2_20230123_tjmercier_google_com-v6-2-dce12fa03ad6@redhat.com>
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-2-dce12fa03ad6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:05:24 +0000
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
- [Low] mm: memcontrol: task_css() race with migration in
  get_obj_cgroup_from_fd()
--

commit 62e5304eba9bb9d84f6229eddf1a9273649483b8
Author: Albert Esteve <aesteve@redhat.com>

dma-heap: charge dma-buf memory via explicit memcg

This commit adds a charge_fd field to struct dma_heap_allocation_data so
DMA_HEAP_IOCTL_ALLOC can resolve a target cgroupfd or pidfd via
get_obj_cgroup_from_fd() and charge system heap allocations to that
cgroup.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e4a9af2fdaa3b..7826bc21bea9e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
[ ... ]
> @@ -3171,6 +3172,88 @@ struct obj_cgroup *get_obj_cgroup_from_folio(const=
 struct folio *folio)
>  	return objcg;
>  }
> =20
[ ... ]
> +struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct obj_cgroup *objcg;
> +	struct mem_cgroup *memcg;
> +	struct task_struct *task;
> +	unsigned int pidfd_flags;
> +
> +	if (mem_cgroup_disabled())
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	CLASS(fd_raw, f)(fd);
> +	if (fd_empty(f))
> +		return ERR_PTR(-EBADF);
> +
> +	css =3D css_tryget_online_from_dir(fd_file(f)->f_path.dentry,
> +					 &memory_cgrp_subsys);
> +	if (!IS_ERR(css) && !cgroup_on_dfl(css->cgroup)) {
> +		css_put(css);
> +		css =3D ERR_PTR(-EBADF);
> +	}
> +
> +	if (IS_ERR(css)) {
> +		if (PTR_ERR(css) !=3D -EBADF)
> +			return ERR_CAST(css);
> +
> +		/* fd is a pidfd */
> +		task =3D pidfd_get_task(fd, &pidfd_flags);
> +		if (IS_ERR(task))
> +			return ERR_CAST(task);
> +
> +		rcu_read_lock();
> +		css =3D task_css(task, memory_cgrp_id);
> +		put_task_struct(task);
> +		if (!css || !css_tryget_online(css)) {
> +			rcu_read_unlock();
> +			return ERR_PTR(-ENOENT);
> +		}
> +		rcu_read_unlock();
> +	}

[Severity: Low]
Can the pidfd lookup in get_obj_cgroup_from_fd() spuriously fail with
-ENOENT when the target task is concurrently migrated or has an exited
thread-group leader?

Between task_css() and css_tryget_online(), the task can be migrated to
another cgroup and its previous cgroup offlined, causing the one-shot
css_tryget_online() on the stale css to fail.  Also, pidfd_get_task() on
a process pidfd returns the thread-group leader, which in a
multi-threaded process may already have PF_EXITING set and remain
attached to an offline css even while its obj_cgroup has been reparented
to an online ancestor that get_obj_cgroup_from_memcg() walks up to:

include/linux/cgroup.h:task_get_css() {
	rcu_read_lock();
	while (true) {
		css =3D task_css(task, subsys_id);
		/*
		 * Can't use css_tryget_online() here.  A task which has
		 * PF_EXITING set may stay associated with an offline css.
		 * If such task calls this function, css_tryget_online()
		 * will keep failing.
		 */
		if (likely(css_tryget(css)))
			break;
		cpu_relax();
	}
	rcu_read_unlock();
	return css;
}

Using task_get_css(task, memory_cgrp_id) before put_task_struct(task)
would avoid both failure modes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-v2_2023012=
3_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com?part=3D2
