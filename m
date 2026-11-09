Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239219;
	b=HVUmWjlWrU7ztJUZmKuYMmX3seadeXFexFM/WKbbABicnTEFk0kVc2etS3jEloeBRi3Y
	 +bwPC0jKQfzXCKXcm7UGG9dnyq2TA/RTKkgLkkA/c+9INdQu3KhFh/Qgjv3rSryzlTn/+
	 GV4B339vCJaEZjrZpUNtlcjj8Hg1UHWyik1PVWjsFezSKQoXM5YXVZwfH4C9eC+Z0I1HD
	 0OoO9M+xqjPfF1yObwevvGmBeLe83FHjcBxJVrUK/g0DhqQ6NoXNGAkTOOFCRBh59pemO
	 WLnssX8y5wcTfTXbylNRCMlkkFvEWUr+Oj6qmrNBWds9ia9HRUtVbch5Ys5OLjA9YGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ItfM4V5MJEWOrmuxmeF6FdgWskOSzn1nV9vlVs/n6N4=;
	b=n+GJPkWgOxOY2JJGFX2sLj+ateHTAHIv63gHspMhkPNAzSxVLv5Eiy/qEaTkcxAEVG5z
	 JC48cCzU1vgFFKfCITAkyHGBHKEZGmroav30Hpit8Mc25IKWUf55C6VEmwh5tzlzM6e83
	 0tYqtfw6HOVqWLYiLAvVoDksIPZxpmeW3zG3sXl8M9yFcEsxUuI+Op2qcKhRAzEKoOEo3
	 /VvPTQMvh+MSwpYFsODfEJTx1Zl3ilP5i/hMNYyhVBM2EjNGqBjYa7CiqkGPuBx9p6aTT
	 7p+cEv+uthEeRDJoEhV8BwLBLfKn9v0Q6ng8i1Q+8CFcf1cRibQMlNz3eewMTn0y+Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2iMBlPM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037AA606A31C
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2iMBlPM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7F51F0089F
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239218;
	bh=ItfM4V5MJEWOrmuxmeF6FdgWskOSzn1nV9vlVs/n6N4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=V2iMBlPMnI1QLVVYs1WWP+sQCc20TqOB9ITPO0skNyilOV7QxJu4ChznLbjpRZaD4
	 0hTHScMkYH7fkVD9rAyo286SQyDDzJWSIQ52sDJvTx09a1n1sSL9qPpR6YQVyFiQnK
	 6cVfc0cgXVL21LalLpumOmm8LGiXPLyZBKkonexlu9Aw3GYzCaiSC4bYvFJ3GQbiXt
	 188D12Vodvgwbeh8/vTMlEDJXvk7M2ztl6cl1DO/CI85ozYgJ9JvHrUisfNUpszgHC
	 sN7loAFKwIQJVd0q2sBaJ1OsnX+4Tl3fNyGvCj3MB7Rr9rUrgdTvuk4gW0amkGIuUD
	 Jv+YxDOKw19uQ==
Message-ID: <sashiko-outbox-205180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] selinux: prevent stale AVC insertions after
 policy changes
Reply-To: sashiko-reviews@lists.linux.dev
To: selinux@vger.kernel.org
In-Reply-To: <20261109153802.76176-2-cgoettsche@seltendoof.de>
References: <20261109153802.76176-1-cgoettsche@seltendoof.de>
 <20261109153802.76176-2-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 15:46:58 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> A cache miss can compute a decision under the old policy and pass the
> latest_notif check in avc_insert(), then be delayed until after a policy
> change has flushed the AVC and updated latest_notif.  Inserting the old
> decision at that point allows subsequent cache hits to keep using the
> old permissions, including permissions revoked by the new policy.
>=20
> Keep security_compute_av() and avc_insert() in one RCU read-side
> critical section.  Both selinux_policy_commit() and security_set_bools()
> publish the new policy and wait for an RCU grace period before flushing
> the AVC.  This ensures that insertions based on the old policy finish
> before the flush.  The sequence-number check alone cannot provide that
> guarantee, even when it takes the notification lock.
>=20
> The insertion path uses nonblocking allocations and already runs under
> RCU when called from avc_has_extended_perms(), where the new read-side
> critical section simply nests within the existing one.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109153802.7617=
6-5-cgoettsche@seltendoof.de?part=3D3

