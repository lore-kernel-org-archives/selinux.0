Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991262;
	b=tpRYxBy4xAuIgZUkczN2K+wgQz2G1m9a37l7qHsLCm98aHA3KPKP9PcFnkARXwCqF8pc
	 bPwSq7eZubs3W+NBMGPwPywHT8aSLqcGrXLmeWaAdy7LoxYGVKpmqI/jGDbPdEpfUUW6A
	 6FyOjb8X3F9bnDO0LH9B4KBXukc6tLz0Irrm0wBlu2ls6naL0IplDigVyZmwLwUKXtJ1P
	 7Avb7yfPmq/vOKm60D2CfKZMnf55tkz5RD3PdqDRrz+dhDjzCttN04xB1u5V4oZJlBXot
	 a/bnqKVpim8Uyf3MxQSdA9zV/3n9LIDf0sDFdeH6F/7vRMehaP+KZiqd2xatyLqtdsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IdaKqlzukNksjVfifP64arAvMVrVLyE39e40pX+LyqY=;
	b=lI+/ib1AnHyWHES5bOMej7ZeZSLpQG38YhaOw9vgX/xxCPFd23qZCCgEaSyBrv/OPVeN
	 hcgHbR/65iOypqdJsHMv3iPVX9Q1G9hLmr7PK59ZZPkojPzmz6HPHBxdZvFwEIW+i2aF5
	 6ERV+qb5jWnQ/0qhpKk+5CVXcE1MAS53NwV15yz1063QxV4XizD/HT6D63NqBDp29b2y6
	 Ba1fC9R0566bUdT4kGvm+0Txq4Xyi5OZu/QkkewqbTPOKPSosQ/6VEMF+HehSNRRKVU/G
	 XLA1RmZyjYykTQy8f+cUFaae03B1D91JcCk2vBD6jZ6AeytSg5EbNdF5ukUk4ZEFMAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feIg5nbJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06303606A325;
	Wed, 18 Nov 2026 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feIg5nbJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E482C1F000C4;
	Wed, 18 Nov 2026 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991261;
	bh=IdaKqlzukNksjVfifP64arAvMVrVLyE39e40pX+LyqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=feIg5nbJbO2b2EYanKLYw5Jz9X/ZlURQvCTbD7uE9fauni3bxe2rCTl2/yUzQyBVb
	 7N/dtTDt+OZdv/ucKM67qfnajtCQk5rXqLj3S/dzbkmVTnae8KwIxEKTtVE4iyHYNX
	 oiWr2uBh2obHcaWCHy8n2xa4Wr0CpRuRdjx6JuI1EUnt7TT016ncPAYdiSc8IxXSz1
	 LZjDLyZ8ZZqjpvZ/ZjHcGGfRDpm3FetVsbRM9EFQITvGcr3GU8DaCYPa8IWeisXr5r
	 YnpjKB2wbQ/D6KezcCLNv/azt+46FcmWceScj3Ed5hPZALEtiDZEQQCMPFbab60o76
	 5z/Ha5rErJTKA==
Message-ID: <sashiko-outbox-220468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] dma-heap: charge dma-buf memory via explicit
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
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-2-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <20261117-v2_20230123_tjmercier_google_com-v5-2-1ce975f2a9ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:40:59 +0000
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

commit 7e6b5f51c2c9a154a8386e2fbe69f7c3fe1c4a27
Author: Albert Esteve <aesteve@redhat.com>

dma-heap: charge dma-buf memory via explicit memcg

This commit adds a charge_fd field to struct dma_heap_allocation_data so
DMA_HEAP_IOCTL_ALLOC can resolve a target cgroup from a pidfd or cgroupfd
and charge system-heap dma-buf allocations to that cgroup's obj_cgroup.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 45e82cda7c441..adc0abcf80fae 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
[ ... ]
> @@ -3168,6 +3169,88 @@ struct obj_cgroup *get_obj_cgroup_from_folio(const=
 struct folio *folio)
[ ... ]
> +struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> +{
[ ... ]
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
> +			rcu_read_unlock();\n> +			return ERR_PTR(-ENOENT);
> +		}
> +		rcu_read_unlock();
> +	}

[Severity: Low]
Can this one-shot task_css() and css_tryget_online() lookup spuriously fail
with -ENOENT?

CPU0                                  CPU1
get_obj_cgroup_from_fd()
  rcu_read_lock()
  css =3D task_css(task, ...)
                                      cgroup_migrate_execute()
                                        css_set_move_task(task, ...)
                                      cgroup_destroy_locked()
                                        kill_css_finish()
  css_tryget_online(css)  <-- false
  return ERR_PTR(-ENOENT)

Also, pidfd_get_task() on a process pidfd returns the thread-group leader;
if that leader has exited (PF_EXITING) in a multi-threaded process whose
remaining threads migrated and whose old cgroup was offlined, the leader
stays associated with the offline css even though get_obj_cgroup_from_memcg=
()
can walk up to its online ancestor.  Using task_get_css(task, memory_cgrp_i=
d)
before put_task_struct(task) avoids both issues:

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-v2_2023012=
3_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com?part=3D2
