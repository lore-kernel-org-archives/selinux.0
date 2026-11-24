Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561761;
	b=ZdCo2zntDYTWo8Jgl6+REa2scx63G/a6idZ2ERcyfzmWtg09T7+9u2ZSE3vyWyWs3NaF
	 4rkOe8iCqpuKYLpGb3psaWwbszD9+BTzVUx6CzC0UgCOcf0X8IanbqZ7ZOHxeytLUNpRh
	 sqqDPcSxrhCKhZY7UUoDYV0ddYWLLUlUHlLg2OM9rY0syeYmOrauQ6ec59xNi8SumuqJi
	 /BDbjScBdQGbsVOoCmAwPJ4hiVIaMtyc2hOrNLbjnHWEKw4f0VJ/LjmGBLoV+rO4/87gh
	 7qLLuXzhz3eaLb+Vl4TPy2zw0zG3BBYsBq/Nye8qy8uQyPdqwo5FECK6UcrE7/OKwWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561761;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V2OmqIyRYNn84fTcJ7B76gimFKbuWcXbIw+xjPcSzkA=;
	b=iupYWw0WTWXx63pe2zS+caQ4xdt0yWpr1d9t5awUJF0XPfMi29/nfx9+pqzm2onO4Saa
	 kQp73c1KeTKlGJHp5hljRLQtoOgbhoZZBT9QMZIoZhLeCDlmC1yBOnQyxWo48yGk6YNKe
	 z2kaWQOEPQgFrutTVz6qwUMep9rrqBaC8mfCAC5I7QNuPNtUo6BFjltbjOoGwZJiGIvml
	 bWtvtMavqzjq/kCvHd4ODNL2IaMx4yrpwZEpikhKSC/4hjhxGP9ksQWEsX0wmGpEob7V4
	 VvDM5EqHxxbDvRAbBBh2uEqzA/P4YNVcZ8+N7RIRmLuB/G2jMLo4iQhJ5TRU5Pnt+Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cIkS9woo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043A606A31E;
	Tue, 24 Nov 2026 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cIkS9woo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3601F000C0;
	Tue, 24 Nov 2026 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561761;
	bh=V2OmqIyRYNn84fTcJ7B76gimFKbuWcXbIw+xjPcSzkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cIkS9wooJ7ryPDd26vHC20ZQO3Zxtf7rslQEkHJ0huW94PgSBPlsm+VyL2xH6uOOS
	 NTSb/OxkWuteyzM3VHtDUuv2F3lvni1lP8dAafx1caQsoOshGwiSpQLFB8dg2f+OKp
	 OLWu+kzZv1jW+JToXxr6un6lL2zluzmSel+vueb2JaA7IxqNqHIEM6WSR09t/7X3Co
	 m71At3Z+MPGdE84VIuQw0QHM6DoAisaW/V92zsAjnhqB9RPDa1WXZOfEnyTWdyE39L
	 ES/JAyWdJJA10/OhROMGYeAhaS/Z37rjyD1qgtLTdNEoGxBjeHQA3+5eswrsji95XN
	 hDJnULqenHi2g==
Message-ID: <sashiko-outbox-232207@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 17/19] proc: look up map_files vma without
 exec_update_lock held
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Jann Horn" <jannh@google.com>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org, "Kees
 Cook" <kees@kernel.org>, linux-mm@kvack.org, linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, "David
 Hildenbrand" <david@kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-17-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
 <20261124-work-exec-update_lock-v1-17-e489035395b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 23:09:19 +0000
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
- [Low] proc: separate __free() declaration and initialization in
  map_files_mm()
--

commit 6e8b44b478838f53cfc44f13f68cf03b45a869ce
Author: Christian Brauner <brauner@kernel.org>

proc: look up map_files vma without exec_update_lock held

This commit restricts holding exec_update_lock during /proc/<pid>/map_files
symlink resolution to the access check and mm pinning in map_files_mm(),
performing the VMA lookup after releasing the lock.

> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 7685660c36241..b28bd6c57e1d8 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2228,18 +2228,40 @@ static const struct dentry_operations tid_map_fil=
es_dentry_operations =3D {
>  	.d_delete	=3D pid_delete_dentry,
>  };
> =20
> -static int map_files_get_link(struct dentry *dentry, struct path *path,
> -			      struct task_struct *task)
> +/* Check the access and pin the mm with exec_update_lock held. */
> +static struct mm_struct *map_files_mm(struct inode *inode)
> +{
> +	struct task_struct *task __free(put_task) =3D NULL;
> +	struct mm_struct *mm;
> +	int err;
> +
> +	task =3D get_proc_task(inode);

[Severity: Low]
This isn't a bug, but per the cleanup.h convention, task can be defined
and initialized with get_proc_task(inode) in a single statement rather
than being initialized to NULL and assigned right after.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-work-exec-=
update_lock-v1-0-e489035395b8@kernel.org?part=3D17
