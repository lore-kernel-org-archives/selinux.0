Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239188;
	b=BgGAxQLmnZ9tQ/CORUYpWUqRXnIx2skCv44/zuHGsEt8sXo5+1ZfDkgVLXak8Y2Trmic
	 vgiNPNf+ekUCbF/WJCgnOKSlD/8zi9vML90iIyxFSfHKa/82yc5cQtZ3ZBjLSEdU81X+7
	 6osiH7Boi3KgQ814mxhZ4iokmBTTZsquxEFrbGT0XhGVmfZsOYRQoCVTmT9x2eHr1bcNV
	 H6wCrjImDshrqNvyj9psFvM0tREsjAsZVQI53VNgYtHxRss518/jS7U0labLU4QGWOERV
	 eMqYOo/kJa3ItjAGHVECjB+crCTInAFqpRIgsyEwb19zMf1iDF3pwZfibW7dYNVA9kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239188;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l21ZTklP4MgAXylFvClFv6SnpbWXYs40bm0Q0j1nYoo=;
	b=oN9gbY4Tn0m1NPxwgLiTnEHx8NUl3CzifjSdXSjgsh0LZC7c/V42a4/uog84NjBaYpPR
	 PyPbmzbDkesLCfPsuU0BxX4rKbpCpf1eLvgydhiV3XAtAXz0pRNgJg1b79Zg3aQcV83XH
	 LW1NpC1E1IyB81mJDdqFikI5eHV1hckDZq9k2kj8ZwGiTIEPpiLIYcdNchQmjH5Vf120N
	 2NSyPSVBun01YHBpvNMY1Qujx4adt5niBIvIXLMXLJfBZ+WBoPPT+Wx/eepz1HBy/eYKh
	 yG5xoPt35FyNwcv55QmnnCUdyDfuEY4Xx+Jr4zINFP5+Il1+Xl1QZWv9eMdp+YZdkKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFhIEDMo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76495606A331
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFhIEDMo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25431F0089F
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239187;
	bh=l21ZTklP4MgAXylFvClFv6SnpbWXYs40bm0Q0j1nYoo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HFhIEDMop+y7Zy/+4Qn0T8OLut1nO7Zo9/undk4mpzBiJoGTSATK4GJEN4G1XTPyR
	 ie9TpN/SVXnZO8ZqkPtbHVcFG/1u6l8ydrfkCFNJhm5UvvRJpMsiyIabK10uX2TC/Z
	 hwjcf0hhClWp2K1dwcrKfCrxc7aztn03e9eKfkC+7avZtYnCp0eGwQqpSiarMyf9Cs
	 CiGyFKsT+h0My2N0O7++KSxSUAbZEVydZs7ju2/urskIPPS3ctLaF4YtYoG6j9alcs
	 cvgPguK6D3cbkyb9Yq0F9RhaVuuasxJvJZypwXmVESkc06dbZUdqbTlhBjc98M6LUh
	 ++ISRHpR6+rXA==
Message-ID: <sashiko-outbox-205177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] selinux: do not cache permissive grants after
 enabling enforcing mode
Reply-To: sashiko-reviews@lists.linux.dev
To: selinux@vger.kernel.org
In-Reply-To: <20261109153802.76176-4-cgoettsche@seltendoof.de>
References: <20261109153802.76176-1-cgoettsche@seltendoof.de>
 <20261109153802.76176-4-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 15:46:27 +0000
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
> In permissive mode avc_denied() allows a denied access and records the
> grant in the AVC node via avc_update_node(AVC_CALLBACK_GRANT).  Enabling
> enforcing mode relies on the subsequent avc_ss_reset() to flush such
> grants.  The enforcing check and the node update are not atomic though:
>=20
>   CPU A (permissive check)     CPU B (setenforce 1)  CPU C (same access)
>   avc_denied()
>     enforcing_enabled() false
>                                enforcing_set(1)
>                                avc_flush()
>                                                      cache miss,
>                                                      avc_insert()
>     avc_update_node(GRANT)
> [ ... ]
> before is removed by the flush.  The current access is still allowed,
> as it was checked before the switch; only the grant is not cached.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109153802.7617=
6-5-cgoettsche@seltendoof.de?part=3D5

