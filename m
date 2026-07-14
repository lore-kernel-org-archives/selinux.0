Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA447884C
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034461; cv=none; b=Ro6VNVaBMsUX/Hs8VKZA8MHL/GkYKC9BZJGbGisGdp7nObXOr/gwzm5yzVlj+nUO2e2nRcUZ7EjKbzh1a6x9BzSO9//wWE/OXo7q3Ws6pXnD+TIcHMF/wq9YesX1oI58evp3LfKGdBwCrTjRNnj0VcpoEMpQXK4oLb2mIpmfgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034461; c=relaxed/simple;
	bh=WxSfDj324mY2YqZyS+wxTi+M6ULRMtR2xte3My7C2PM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XNjpkWpMghNiaXxxMDsGhnSz/rcTsOd/pdVFyJYHUT/G58KlxPL6LLtMKDSJ1Jwh8LBe5Nn+39cqMn4XvP9PVe1DTnB/IV4Y1Fi/40jTK7OJWYZ6vNHKoEjsd7yTFxDN/mZRvj5SpDYQv56N3JFWq0gAM4vNNuMu5fz+TLn96PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpmA9aRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpmA9aRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C42C1F000E9
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034459;
	bh=WxSfDj324mY2YqZyS+wxTi+M6ULRMtR2xte3My7C2PM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IpmA9aRwwKteCGEal4iPyQ8PXrr1h6U0G+8pvCg0e6C5GJ+Bttzeh6xgCfjBMA8XQ
	 YlKgx9pnArkz7h9dvrJinfcQRKu9uNk6Zh1Y1DTRYigm4Zc6OlDpb7SiTdebaxWg3G
	 JeozVlJpsfqQRxHEKRO4uK2eJdSzNPn3KExf0AkXxi43SNX0BcCz76W+ASphjy0H5p
	 3lWnFOFuKShtBKGXEDNxMQAQzPe6Usi5K4uveUKmda6uP9rGeVvbXMLQY9QsAh2/a/
	 VgHBJb/P0B8qS8Q7jsq6O0Hn6vXzd/0FQ3RUl+8t+DNQl8NdbSyrsz0AGRWD6kAB9s
	 QOtoD/OEdBXyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selinux: fix incorrect execmem checks on overlayfs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260714125759.1042127-1-omosnace@redhat.com>
References: <20260714125759.1042127-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:07:39 +0000
Message-Id: <20260714130739.9C42C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> The commit fixing the overlayfs mmap() and mprotect() access checks
> failed to skip the execmem check in __file_map_prot_check() for the case
> where the "mounter check" is being performed. This check should be
> performed only against the credentials of the task that is calling
> mmap()/mprotect(), since it doesn't pertain to the file itself, but
> rather just gates the ability of the calling task to get an executable
> memory mapping in general.
>=20
> The purpose of the "mounter check" is to guard against using an
> overlayfs mount to gain file access that would otherwise be denied to
> the mounter. For execmem this is not relevant, as there is no further
> file access granted based on it (notice that the file's context is not
> used as the target in the check), so checking it also against the
> mounter credentials would be incorrect.
>=20
> Fix this by passing a boolean to [__]file_map_prot_check() and
> selinux_mmap_file_common() that indicates if we are doing the "mounter
> check" and skiping the execmem check in that case. Since this boolean
> also indicates if we use current_cred() or the mounter cred as the
> subject, also remove the "cred" argument from these functions and
> determine it based on the boolean and the file struct.
>=20
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714125759.1042=
127-1-omosnace@redhat.com?part=3D1

