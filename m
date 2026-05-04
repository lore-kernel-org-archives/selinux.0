Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F2370D4A
	for <selinux@vger.kernel.org>; Mon,  4 May 2026 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777936197; cv=none; b=oMi5wB2co/EBrVbmx4Q2+/UbmeancgKpDU1qkf68OvdSyIjdTaHjfthZME/Z3aRpfmh6j2pHn5TuTrjRbJZ82CkQVkb+sRAviSbSAn1uXLNco/GVHktBaeGCLWbiIyipFiezJV2fFy+bR6jn2p2dYSvk3tosKJQp30kO+oP5rfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777936197; c=relaxed/simple;
	bh=/3c97m+rtbalvwzEj0fQM3k4OJDBTzI/7E9Y/T/5CJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1kA9Dv9yNiMgRdSYI4foCnb+SS9JxlYUbZw3G9POy5k8UfM4G7dBUeel4TXEG3t4nnOauYq7i3sS6KnlFFsZFhLSxDumTPyNQvqQtqiGNIsezLU8gedqnITos5rE7jNWjz49NW8RakzYgnfWMoJz+3z16lKwe2Zs+HqaTGSOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzq/kDMa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzq/kDMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B95C2BCFD
	for <selinux@vger.kernel.org>; Mon,  4 May 2026 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777936197;
	bh=/3c97m+rtbalvwzEj0fQM3k4OJDBTzI/7E9Y/T/5CJ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gzq/kDMaCEdmMmhGocKKabTCSq40g+055ppMSW8xaHsmRNq+o2iT/0O81ZGUE9S8d
	 2m5+YuyxhK64bueNaU4YAd4QzfVti3rqv4EXjsAzda7IpmQJEJIxrpa2nWpd4Z7wnI
	 9GVIG7tViSxi3cpGOcWfoo5svTomubzTVcQ+ke++n2az0XDqeVGDwubvpZFqk28FSw
	 mkAw41qR3HqIqIcZVTl6qSk1SoFBlzS61udiuXPG4cGA2q7oQUIpKoJH/pMMr6puFM
	 yXYiyBeaidwm1fZQpydikvV2FJmlKbb1WvpH7+ideT7TRiuvP7wZP0fLHFpOg/qP62
	 VRiC7A9nYIbGw==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso48652486d6.3
        for <selinux@vger.kernel.org>; Mon, 04 May 2026 16:09:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+vn20OTxFBEGz5Ri36lVeIVadEX920wUQhxXkZx6t8T1FtLyP93QA+wsocj7C363TmFsGMU/iX@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIDZrGF2Z2JLwt754xQDuOwtffMIAIT9d9LT8YI6YHJN4N1cJ
	43jkTBjp/Q89zodnm6Q9OCiRVhOIDZqJHPbbXh3pqBnbyOAfIa8tZfy3OtA+e+1HjnCwO/w42k7
	NVCqDBtRaKLGWKAlOoSHVu8WTwVss1fY=
X-Received: by 2002:a05:6214:4d06:b0:8ac:732b:6cf1 with SMTP id
 6a1803df08f44-8b6682579b0mr177893876d6.24.1777936196061; Mon, 04 May 2026
 16:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com> <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
In-Reply-To: <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 5 May 2026 01:09:44 +0200
X-Gmail-Original-Message-ID: <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
X-Gm-Features: AVHnY4KbucuUmnfxrM96daVxOOqJnDfF1BBq1hZ1I15QYlozTuBaoPnofTKtzcs
Message-ID: <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
[...]
> > > Perhaps I'm simply not seeing it, but is there a check to ensure that
> > > there is only one BPF LSM calling into security_inode_init_security()
> > > at any given time?  With the BPF LSM only reserving a single xattr
> > > slot, multiple loaded BPF LSM programs providing
> > > security_inode_init_security() callbacks will be a problem.
> >
> > I don't think there is such a check. Also, a single BPF LSM function
> > may call the kfunc multiple times, which is also problematic.
> >
> > I think we will need to make the default bigger, and also introduce
> > some realloc mechanism for the worst case scenario. This should
> > work, but the code might be a bit messy.
>
> Thanks for the clarification, that is what I was afraid of when
> looking at the code, but I was hoping I was just missing it.
>
> Increasing the default is an option, but I don't think we want to
> support a dynamic reallocation scheme for the xattr slots, that will
> likely get extremely messy with synchronization between the LSM
> framework and BPF LSM hook registrations as well as special code to
> handle inodes with lifetimes that are disjoint from the BPF LSM
> programs ... I suppose there may be a way to do it, but it will surely
> be ugly and come at a cost.

BPF trampoline already handles all the synchronizations, such as
add hook, remove hook, etc. properly. So this is not that hard.
All we really need is to allocate a new array, copy pointers, and free
the old array. And we only really need this in the worst case
scenarios.

Thanks,
Song
