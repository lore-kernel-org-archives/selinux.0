Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877121;
	b=GO5rSJfN3umsqvJuxfmF0StNpjVvgqKhnMt8+PC8rcbEncrFFfzhe8LiY5Gyl61Mj9aV
	 2pAbSvp+BcCbA7BvoHvKS9C8OP369hMRdbnXF3K881SYBPBjv4hPNL9iPXcwiCb7MW0eh
	 5njuGU9KaRa0NLxhaqDFcZmn/BMi8CRV8tW/TJrj/areEcuavT/I1cQzas+bojpbII9hn
	 oDLcATjpDxMQFWX3VQv6iOlpXCNpCnoGQ4DVw/9t7OWSqb/ipiwTtqgxAY5qmGEXzLgKO
	 zsGh1l0soGbZSlG8cy4lGzYlAd64mQIJNzP+1Ka3Ki44/zeD1wdnfGSqSMSmZ7a/dhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877121;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XYfDIMn9RzkoOerCRsuzNDWKhLeLvHeL9jAZyhrpQ1o=;
	b=gUINYvveaMDa1rP/8ZDenxesiTq2Y4aTdOcnRh/BYcGWdLKmIMMtXuEM+s5jTDwdScYD
	 yotpEeHFd/FPZoglR90sl5IEleuJNU/8XGHtdhAY/IeUiN9lzKoCrw4Xo/jv8vjQgpXRQ
	 PzwHmG1Y4hjLz7Hwtes089cPTEJ3kDkPv6umyaA0Yh75t8a4n+3T5UyeZcKeYFL0iIqYi
	 GktYkipGINV3H35CMB6BjzhG6h2p2OjTuruGJB1cXvHCETa/CSN83xi3yKTarT0L8owef
	 7IEOyfhjFzTLs5U0q248WKNKoCl8C3g+mWH9rhmCuSJi0p/C31fCkL6eo03Y4q2OLdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJWzhgAC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065926082BC8;
	Thu,  5 Nov 2026 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJWzhgAC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12A91F00919;
	Thu,  5 Nov 2026 11:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877120;
	bh=XYfDIMn9RzkoOerCRsuzNDWKhLeLvHeL9jAZyhrpQ1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJWzhgACqO8Oh3sg03HVyCjyDRqS/0Kt880riTR9yqMxOzYkEHCrqPSIFOkv9f/hh
	 msR1KBHibiTLGBB9lFfczXDQTQIg7siuiS/H9s7ZO4h1RCevWVb/AkbQLYdz339fZ+
	 5TOS+Z2LCW+KisR0sqsGOL8BDOM3Y3KdTqb2nOSAznmJYsxiGkPcnbh2Bw5HBAWtYy
	 XP5SqcwLl3zSMCE7Y1FY9GWV9QwsTuYBPfhFQhYSuwSQSIgYrdqLB5w5SgLmMyxeK/
	 Mmjt52tv1l3Fg3yrRpcmpOMg9/ijrNbxtM7os5PorcJoiY10Lhz9Md+kpBwrSpxkYH
	 aZg86Vo2dk+nA==
Message-ID: <sashiko-outbox-198919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/8] security: dma-buf: Add dma_buf_charge_task LSM
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
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-4-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-4-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:11:58 +0000
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
- [High] mm: memcontrol: task cred and mm->owner mismatch in mem_cgroup_get=
_from_fd()
--

commit 8654d1fa67f56b32794f6b84163f6fcd4bd83d11
Author: Albert Esteve <aesteve@redhat.com>

security: dma-buf: Add dma_buf_charge_task LSM hook

This commit introduces the security_dma_buf_charge_task() LSM hook and calls
it in mem_cgroup_get_from_fd() when resolving a target cgroup from a pidfd.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3e717b5663c82..dd276e1230cc4 100644
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
As reported by Sashiko on v3 [1], in mem_cgroup_get_from_fd(),
security_dma_buf_charge_task(current_cred(), tcred) checks the credentials =
of
task obtained via get_task_cred(task), while the charged mem_cgroup is then
resolved indirectly via get_task_mm(task) and get_mem_cgroup_from_mm(mm):

mm/memcontrol.c:get_mem_cgroup_from_mm() {
	rcu_read_lock();
	do {
		memcg =3D mem_cgroup_from_task(rcu_dereference(mm->owner));
		if (unlikely(!memcg))
			memcg =3D root_mem_cgroup;
	} while (!css_tryget(&memcg->css));
	rcu_read_unlock();
	return memcg;
}

If task exits between get_task_mm(task) and get_mem_cgroup_from_mm(mm),
exit_mm() clears task->mm and calls mm_update_next_owner(mm), which sees
mm_users > 1 with no live task using mm and sets mm->owner to NULL:

kernel/exit.c:mm_update_next_owner() {
	...
	WRITE_ONCE(mm->owner, NULL);
	...
}

In that case, get_mem_cgroup_from_mm(mm) falls back to returning
root_mem_cgroup, where try_charge() skips accounting because
mem_cgroup_is_root(memcg) is true. Could a confined process fork a
short-lived helper child with matching credentials to pass
security_dma_buf_charge_task() and race its exit to charge or transfer
dma-buf allocations to root_mem_cgroup, escaping its cgroup memory limit?

Similarly, if task shares an mm_struct with another task via clone(CLONE_VM)
that has different credentials or cgroup membership, mm->owner may not be
task. Could security_dma_buf_charge_task() validate task's credentials while
get_mem_cgroup_from_mm(mm) charges the cgroup of a different mm->owner task?

[1] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
3-78d2c4cb8647@redhat.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D4
