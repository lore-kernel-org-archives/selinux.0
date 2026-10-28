Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199876;
	b=e+Yt/KIAL6ulkMAMuPNpVPCEbaWdeaQ1EHBSTXMXN21j0fKDKtyV0ipfnRI1ewlJtOlF
	 8tnJSmt91hOPcSUHl7Z2/Zfz5Sfvpte/bQGpqqLikm7bcMHWD0bnBbRwfYPJAxxtadOal
	 NWqvf21PUF8hAOBX1M6jKzWK2VGrWZe/l6B+/mUHSm9+pjWh4malvfOG4wRO/YcbR0pfg
	 IZAdDuunnZaduFlx7/Dq8vjz+recoCor96T6Bf6pTvVg+ZMJDvBATIno089g9VXBeK0Ey
	 uP5ew2cF2OgRjE0wuzQabSZTOm1a9c1sWZYz6i9P19cGQ/HT6CLQsX7BAleKeIHhrbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C7gQDIGtka4M6gFdPtyAUJTEmbG7HdtUcr2lveZNTbo=;
	b=O64/FeHVhJBP3PKLIrtls6mKR8xHKVmjB1DZWQBYfDHGzqEhybpugJastyz6t/24WpD4
	 N3U/I4sKFfGOSESv3goFL5NKKZx2p4PHRBSO1HyEQJEu2XclrUytrQ0H0zUSLd/Y3LMrt
	 ENwUKs/WX2LIMXuypQ7MsQpe4a5Aykqkt5JgWuIZ+HqDmCQ+N38ZPBnTzJomObBagrr0u
	 uTSWGL9Hki8ccyPwBYMldBvADdYR4/8PnwSA6OoIAMtzEucsMf4zDGFGd3gWFSjqBVDfy
	 9288oaSglqULf4ReXdYuia41U4X0A/phfENmeMwo7V7RUwVSQsC+EZ7f+sUqQMjX4AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGUhQnEI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A160A2603;
	Wed, 28 Oct 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGUhQnEI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412E71F01828;
	Wed, 28 Oct 2026 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199875;
	bh=C7gQDIGtka4M6gFdPtyAUJTEmbG7HdtUcr2lveZNTbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FGUhQnEI+RbAgshoSt9xu8P3vWredhcl377LgGwqtfoX3wn5xpg3pFBp+vxuSigfm
	 ZayPAsFGhzsDUdUEZHH3n/ZhwRISu8XF1pC0ItBWCTnESEGavXhgpgzipXn+EHWzvQ
	 Akuj0EKJEF9R83wVj8+keQjFL+c1V0vGNwZ/SI7OJ3yi5fEcgHKlzbAm/dgigrMGLw
	 1oRjmNabb4Bn0U6x1KMQbbSfx9YiCqrKV3gap5VEtC9UrJDcQnX7IYDzDDpo5VqXDQ
	 /gY6sk0QmG7CG5UwE26nMddVlxPpf3Xr3adyn8dxs46aPGhX8nqIGj7nsC4V+pmzhc
	 3fC+wcXctU+gg==
Message-ID: <sashiko-outbox-188028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] security: dma-buf: Add dma_buf_charge_task LSM
 hook
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
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-3-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-3-78d2c4cb8647@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:04:33 +0000
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
- [High] memcg: task cred and mm->owner mismatch in mem_cgroup_get_from_fd()
--

commit 6c6031732d7f42644e3d99679d750fcc12907447
Author: Albert Esteve <aesteve@redhat.com>

security: dma-buf: Add dma_buf_charge_task LSM hook

This commit adds the security_dma_buf_charge_task() LSM hook and calls it
in mem_cgroup_get_from_fd() when resolving a pidfd, allowing security
modules to mediate cross-process dma-buf cgroup charging.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f66254f52b999..ad195cfd1b5f6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
[ ... ]
> @@ -5698,6 +5701,14 @@ struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
>  	if (IS_ERR(task))
>  		return ERR_CAST(task);
> =20
> +	tcred =3D get_task_cred(task);
> +	ret =3D security_dma_buf_charge_task(current_cred(), tcred);
> +	put_cred(tcred);
> +	if (ret) {
> +		put_task_struct(task);
> +		return ERR_PTR(ret);
> +	}
> +
>  	mm =3D get_task_mm(task);
>  	put_task_struct(task);
>  	if (!mm)

[Severity: High]
Can the cgroup returned by mem_cgroup_get_from_fd() diverge from the task
credentials checked by security_dma_buf_charge_task()?

Here security_dma_buf_charge_task() validates get_task_cred(task), and then
mem_cgroup_get_from_fd() resolves the target mem_cgroup via get_task_mm(tas=
k)
and get_mem_cgroup_from_mm(mm):

mm/memcontrol.c:mem_cgroup_get_from_fd() {
	...
	mm =3D get_task_mm(task);
	put_task_struct(task);
	if (!mm)
		return ERR_PTR(-ESRCH);

	memcg =3D get_mem_cgroup_from_mm(mm);
	mmput(mm);
	return memcg;
}

However, get_mem_cgroup_from_mm() resolves the mem_cgroup from mm->owner
rather than from task, and falls back to root_mem_cgroup when mm->owner is
NULL:

mm/memcontrol.c:get_mem_cgroup_from_mm() {
	...
	rcu_read_lock();
	do {
		memcg =3D mem_cgroup_from_task(rcu_dereference(mm->owner));
		if (unlikely(!memcg))
			memcg =3D root_mem_cgroup;
	} while (!css_tryget(&memcg->css));
	rcu_read_unlock();
	return memcg;
}

If task exits after get_task_mm(task) increments mm->mm_users but before
get_mem_cgroup_from_mm(mm) runs, exit_mm() -> mm_update_next_owner() finds
no live owner with mm_users > 1 and clears mm->owner:

kernel/exit.c:mm_update_next_owner() {
	...
	/*
	 * We found no owner yet mm_users > 1: this implies that we are
	 * most likely racing with swapoff (try_to_unuse()) or /proc or
	 * ptrace or page migration (get_task_mm()).  Mark owner as NULL.
	 */
	WRITE_ONCE(mm->owner, NULL);
	...
}

In that case, get_mem_cgroup_from_mm(mm) returns root_mem_cgroup, where
try_charge() skips charging via mem_cgroup_is_root(memcg). A confined
caller in DMA_HEAP_IOCTL_ALLOC or DMA_BUF_IOCTL_XFER_CHARGE could fork a
short-lived helper child with matching credentials to pass
security_dma_buf_charge_task() and race its exit to charge allocations to
root_mem_cgroup, escaping its own cgroup memory limit.

Similarly, if task shares an mm_struct with another task via clone(CLONE_VM)
that has different credentials or cgroup membership, mm->owner can refer to
that other task while security_dma_buf_charge_task() only checks task's
credentials.

Would it make sense to resolve the task and its credentials from mm->owner
(or look up the mem_cgroup directly from task) so that the LSM check and the
mem_cgroup lookup operate on the same task and cannot fall back to
root_mem_cgroup when mm->owner is cleared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-v2_2023012=
3_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com?part=3D3
