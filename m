Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877124;
	b=p6JwyDhPqEifdTMAL9nT1LqCnWdeuY3EvBLqXZTc/0KibIARnSBdJsEuRIrwPp0F0kW7
	 r8JkquCsUp1dTztX1NhcITy4NXrA6Ywf4I0r5R2FJJNiVSq+9+QtmOyxhAkdcfITe38/6
	 BykdGzSTwIgyirmDP/bQy7J70GyrBXCrifYSLk5nvAT/Scgm9qwVG353QGqrwztteUeFA
	 HewrQOJU/BvAp709nx9yk6nIJV2hJcZtuY34bOAx/gQvjA41AJu1N9QAUtdgpHnIC3OP1
	 CuOCuRyzRTCCQMcLucjyaUikjF3izIPFtDu5OYHY7Ke+L1lo13x2T8PLYs/vHb9Xdsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877124;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u4OwYANC6wqKDyPgO6eDc7wNQ6edH7rpigotQa7/OCk=;
	b=S1z2nAeKQzYHzdAJ8iNu3qaKezN+h+LBmKOEg6wSLhOmJmv55ZFAKvAyJxTNG6IzipvE
	 UzSHPPe2S137MO2cw82LtcWcMhpLerGoyd4/vts3hcW69Dtyp0bCGYKPsKwFS/Az/0q3J
	 6Mgotksdw7zodhGM6KqY0akWDx7yYgNUQ5R7lUzeRYQ9Gwfe/IpxuAt+PVFIglMaEuryX
	 yEm1a3Z1fjvRJz8kuTLxiRme1Z9elp+HOQIbW7szS3jktdaLoyJkIDVv4fAPg/uISlvl/
	 1rB7JYi8KtjqzAfVuZ1fDDSRbgHk+pEOK4Mz+sj2YBy9tcvHq9aJFATNGEDk58qJOpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c2uN/Ng5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4025606A334;
	Thu,  5 Nov 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2uN/Ng5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FBF1F00A18;
	Thu,  5 Nov 2026 11:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877123;
	bh=u4OwYANC6wqKDyPgO6eDc7wNQ6edH7rpigotQa7/OCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2uN/Ng5l1zRBU1f6aKBEfZtQoOnizQ0rrFd9kCVSSHUE4EkaG4YPu0DVrXFd/sYf
	 WQRytoL/bcOM1tMwGTUhoxMGZjd7nrw9Op3dgk7LlqQMSjRvDJDTBSXagtU5aDYa4F
	 iloIC0z1XqsAvA+wuzjNVVxTNcK1vJS2YM72nD09YWg7Y+1F+DhJmXRU8T8Gy/xhN6
	 KiQgtSFJ6rsFJt5ladVLcE0huTLON36jq97Rw9RRIPx/9cUI0YxCWADXC+FyRY98yA
	 EIszDEoo4+ImNGcD/JzSRE7yMABOCWcp+srnamdEnAnuamz3kghzyKLk86XsIYtlff
	 pshldAJJUYr3g==
Message-ID: <sashiko-outbox-198921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/8] selinux: Restrict cross-cgroup dma-buf charging
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
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-6-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-6-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:12:01 +0000
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
- [Medium] selinux: one-off dma_buf class instead of general cgroup access =
control model
--

commit 675e985fff50ea6716b8c00023a75c07ff345a6f
Author: Albert Esteve <aesteve@redhat.com>

selinux: Restrict cross-cgroup dma-buf charging

This commit implements the selinux_dma_buf_charge_task() hook and adds a
new dma_buf object class with a charge_task permission in SELinux to
restrict cross-cgroup dma-buf memory charging.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 30776b0107f29..8f39d91eabc97 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2204,6 +2204,12 @@ static int selinux_capable(const struct cred *cred=
, struct user_namespace *ns,
>  	return cred_has_capability(cred, cap, opts, ns =3D=3D &init_user_ns);
>  }
> =20
> +static int selinux_dma_buf_charge_task(const struct cred *from, const st=
ruct cred *to)
> +{
> +	return avc_has_perm(cred_sid(from), cred_sid(to),
> +			    SECCLASS_DMA_BUF, DMA_BUF__CHARGE_TASK, NULL);
> +}
> +
>  static int selinux_quotactl(int cmds, int type, int id, const struct sup=
er_block *sb)
>  {
>  	const struct cred *cred =3D current_cred();

[ ... ]

> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 90cb61b164256..b4ebedc6e4240 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
>  	{ "user_namespace", { "create", NULL } },
>  	{ "memfd_file",
>  	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
> +	{ "dma_buf", { "charge_task", NULL } },

[Severity: Medium]
As reported by Paul Moore on RFC [1], adding a one-off SELinux object class
and permission for a specific subsystem's cgroup charging (previously
dma_heap with charge_to, now dma_buf with charge_task in secclass_map[]
and selinux_dma_buf_charge_task(), along with charge_cgroup in a later
patch in this series) introduces a narrow, subsystem-specific policy class
rather than a general cgroup and resource access control model for SELinux.

Although resolving the target memcg from charge_fd moved into generic
memcontrol code in mem_cgroup_get_from_fd(), the SELinux hook in
selinux_dma_buf_charge_task() and class definition in secclass_map[] still
define a dma-buf-specific class instead of a broader cgroup access control
abstraction.

Should this permission check be designed around a general cgroup or resource
SELinux object class rather than a one-off dma_buf class?

[1] https://lore.kernel.org/r/16093a0278a6d7d1a0a8bc055c228bed@paul-moore.c=
om

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D6
