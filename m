Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3089373C00;
	Fri, 19 Jun 2026 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864757; cv=none; b=rpTqrPAaf+wl8AKlzyJXmqN74ioIcCjyLwGQ2LGKmUiKqSG0IUPPW+1VQEWJXmFAL+1Uezx3U79V4StHGY74l5SQByWHRA65r5AAEpnsZ7CH88cJfCTE77cLx58Ld0ZL73ZkRj2GSo6YRI7DEE/wCaLJQ7CMRdtnWmYdqi5JqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864757; c=relaxed/simple;
	bh=M0cKw+2AtZvbRJUPHpnp3czl/esm/nBakKOwdRLyPlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2hMLQkjHrzuVl1B78HX4AmwZ1xVJi4REITjnAghBBitkf/wrsnHykqWu/4oPOKdDLDdk7r0Yr/V4aaRNKb98cF0z5ExT93twkg9SsJvlOSPcfD0eYZj6ENN4hEK8Fke6V2fh28BauBqG0o1TvQs+UlV4xuzaP2FGBDkHHQEdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+fv5BuS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+fv5BuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0141A1F000E9;
	Fri, 19 Jun 2026 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781864747;
	bh=51JmzhDApRWTAppcWz2i3ZcbrdqeXCGrp5pih003jZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W+fv5BuSgc8AKNGlfXJ1ZwxSTCAWiq1lA1EfiNtxl54Nq9LwOaIGWgTXyJ1M1WPBD
	 NxI1hx7uiXCmH/3RpWxZoQvOfap62HbQjGhxEFxBGrhkY4r7UmqSfXOBQ/Cd8em84Z
	 Vmz5uOsM6IxJHtXUwwc2y74fe+cnVMJgg3aLNBlPcKYGrY5wGum4JPOD+oW5VIZSPc
	 LIdn+0jS2O4zwAcldUhJAp/vIBiq5DDONIBx3uutnMRBcxfGFh7ILSQIHH6g79Mwk8
	 P2azC24W+otdCwdfRriXNvTS8MebPfHJeBVgJdTteBkrl4rYnsAS1N+UJP+5iWrk9H
	 3C9rp5BmDfc+g==
Date: Fri, 19 Jun 2026 12:25:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Windsor <dwindsor@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, kpsingh@kernel.org, 
	mattbobrowski@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	casey@schaufler-ca.com, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
Message-ID: <20260619-vordem-schloss-kuppe-b0ec679f4665@brauner>
References: <20260618203411.73917-1-dwindsor@gmail.com>
 <20260618203411.73917-2-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618203411.73917-2-dwindsor@gmail.com>

On Thu, Jun 18, 2026 at 04:34:10PM -0400, David Windsor wrote:
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using lsm_get_xattr_slot().
> 
> The inode_init_security hook previously took the xattr array and count
> as two separate output parameters (struct xattr *xattrs, int
> *xattr_count), which BPF programs cannot write to. Pass the xattr state
> as a single context object (struct xattr_ctx) instead, and have
> bpf_init_inode_xattr() take that context directly. Update the existing
> in-tree callers of inode_init_security to take and forward the new
> xattr_ctx.
> 
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant.
> 
> Because we rely on the hook-specific ctx layout, the kfunc is
> restricted to lsm/inode_init_security. Restrict the xattr names that
> may be set via this kfunc to the bpf.* namespace.
> 
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c                | 106 +++++++++++++++++++++++++++++-

Please split this into the VFS changes and lsm changes required for
this. The api change to the lsm layer can be done independently of any
of the actual VFS level wiring. Will also make it a lot nicer to
review...
