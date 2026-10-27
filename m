Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103375;
	b=BWa4ogc70+8xN1NnDkq8YmAUcpFAsnh1z+oILUCXuykK8ErN1lGLD8Tw9GMzaMJ1J7Xb
	 5Qu2ctNCH4wrG6+mMS/80pbFOY61la/8u9RpoiaCFtLHGbiBQvKdkuFMJZAXZKkNico7N
	 7kVAXaFWIFcVJAcIVkwFiB5jQ/zw/Ue0yxe1Dv6qpvmQDFQlPEb4KXSOSYsqMWetvT6MT
	 NQS3OXVOwf9uXn8k/BOgL8ouBA9KEUkM3a65tzK/eRMaUV0tq3gmiVNqPe2GVeiJgEubc
	 D2tNurzOYPisZ++OBlpdu2gQxXdFkSM4gFkyADLJ4yvqAhtSIUqJVXjSuKjgdNe/DfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103375;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sq8vVmebYSjSDQKXcQYMGmX4Q/oSWGFw2ff/qw9fqWk=;
	b=vrO0FY6al4CMvQcyNJtRgrmRgNvCI58IHRQ2IvL2P0t40rpGTUaHBaYX5XOdW+fhj25s
	 yHt7V6Px4CtoHa22r8ybppNr99PZJlHOdietGpLJNOR8gyiM7F42Pknf12M+IYQqxjkul
	 16KCgluzMYNN0slVvc3930zgZV+H6/hrnzWB23DT+HVPPNh+pPhL2bjY0jcMpbKQgJqs6
	 SemZJ/5sX5EwKHlbFjGMRPtlbeOT4rjPLLLwHC5G2Qlvc7/xuLDJHarqqtmrEG0mR89XZ
	 5Vmca449E88njwtlHrJ8Vvv7cIwbRXxpqJ0UgEA3my8qjPyUcyRnAAm8Fm/DjCNE8BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0x230+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB88606A326;
	Tue, 27 Oct 2026 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0x230+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E891F01825;
	Tue, 27 Oct 2026 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103375;
	bh=sq8vVmebYSjSDQKXcQYMGmX4Q/oSWGFw2ff/qw9fqWk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=T0x230+CnAumzg97A3v6gBLA4Y9d+9ZI5AXT3Bt8nytUG/rbuDYPPE++lYXtU+lGy
	 UrH/Fld8IerzTZiByvKhQYJkf90R86tPG4EmFe2lpQ9ID4rQD1m59du13Ut9tmDwR4
	 dMoDRzsaVKHUbyj773W5wpZw2yweXHtBb78yvN99JQp11cxEwucckiFRVUpg4MuXOs
	 xDorsUSt5gRa2bmtRd0kH1bE9yfy0YAOvsDFB98e2RqmZBG0U+7m7kBh5r5/rVF96l
	 4N3/GuqsXxWQJ2ZPtLg7T35AO23/qjCfy4uoMUcMVaJzkQl2aG6vxWpnQEVN/2YtYI
	 wfkrzuC/V7wIA==
Message-ID: <sashiko-outbox-186522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 -next 03/18] fs: pass struct path to xattr helpers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261027121151.1887650-4-caixinchen1@huawei.com>
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-4-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:16:14 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> vfs_setxattr(), vfs_getxattr(), vfs_listxattr() and vfs_removexattr()
> along with their __vfs_setxattr_locked()/__vfs_removexattr_locked()
> counterparts take a struct dentry even though their callers either
> already hold a struct path (or a struct file).  Switch them all to
> take a struct path instead of the dentry.
>=20
> The struct mnt_idmap stays a separate argument: it is taken from the
> mount at the time the path is checked and must be passed down
> unchanged so that the VFS and the filesystem are guaranteed to see
> the same idmap, so it cannot be derived from the path inside the
> helpers.  The do_setxattr()/do_getxattr()/removexattr() syscall
> helpers that resolve the path themselves read the idmap once at their
> boundary from the file or path they resolved via
> file_mnt_idmap()/mnt_idmap() and pass it down.
>=20
> [ ... ]
> influencing the result.  Because that function only has a dentry, the
> call cannot be migrated to the new path-based signature; drop the
> check and the now unused user_space_size variable instead.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027121151.1887=
650-1-caixinchen1@huawei.com?part=3D3

