Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529652;
	b=ymyr2J1F9eWeNTRqP/aC4Q0Fa/xklw3mZCJhqmWUSNsvw+akO571rDpIWupCfsoihTch
	 F5RLugUpAsGUogGoZ9NWJ9YZKvbrgqh901Nx12a1pYVbMONOxb2DJHqUjDvfzdUFTgZhP
	 9aUwWrhsxy1L6/CjCb59fHlH99QUMq9BtSMbZ18EHWRERCD8NInAmT4Nx/JOatjWUnV4s
	 SCpTX++GVRpimMNgtDZnduSZWUKzFiX+81g46crhIwUHgL/Yr2GFVsZ9z6CcPxgj73uo0
	 A4ethCPmS0SptuVfdC1I2W9wmzl/ywJ+GXUbH+cXmM2ZZ8twx2c+ZctErk+BcGMr2eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529652;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+2VlBMBrcM8CNysrvNIfCQ9bMyq3GU2IjEsJy3EjNxI=;
	b=2d8zON2z6Ek011E4cy2enk6KQ7h6m3/9p0MIHnHhg6QfjXc9W0kWDnqRcer0xavupkAy
	 pK7vEZTCyzO8QiyEy47RCcCa3NpkX4pPiWHsLY7cdFkoGzPNFu57VHof3Xs5xpkg/JEYL
	 IJzif3kFgTkfqfiAD2ZD3Epf4tpDWzdVC50Mxqg/cKfkiSVTv4gLC8OHbpyjRiYw8xQAp
	 A+mOIZgc9gbRkpjHOWu+5ZZ2QKN2AzKORpiopvvPWuE7V9FnmwiGnaCF6qodIqiKFPDOW
	 OcNeBVyL788h1cBTBofG3u6CmAXrykG8QHaGcizc5J/mCsjMJNiKr/yPSdC1plowJ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muLAYNzb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89779606A31E;
	Tue, 24 Nov 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=muLAYNzb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58A91F000C4;
	Tue, 24 Nov 2026 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529651;
	bh=+2VlBMBrcM8CNysrvNIfCQ9bMyq3GU2IjEsJy3EjNxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=muLAYNzb7RrFQQeR97SsymMqD05+bnUq5rkGDb6IfL7HBf089JTWAbsbZy6TfYMMB
	 ZpDyaeBN4fPqK2DhmBuylqkCHeIV9s645pJ1n8p2kpANCedzdtxSdujWSt/1xDsfGf
	 UB3+ofkQDH5/OwdaQe+h+vso+GE14Rr7wTURxZoNdShMpp4QplcXatGLuYvOD3jfgn
	 FEcmxRCCqL3uYJyZ/pv9+liQALQbt9kyfsc0o8noAPqM8BfozVZiRoT1hycWXmKFFT
	 sBkrJs5BfibERBvefLPxeaqBHS8uX213g+zNk9Q/XgvxCGTDb2PAepIqtg6bHVZ6Y+
	 1m5l/CsvnZTmw==
Message-ID: <sashiko-outbox-231323@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 00/13] mm: convert further simple mmap hooks to
 mmap_prepare
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: virtualization@lists.linux.dev, selinux@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 14:14:11 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 13-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-late-2026-=
mmap_prepare-v2-0-0b0d99d655f9@kernel.org
