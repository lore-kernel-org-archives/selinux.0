Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA523AFCFD
	for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994454; cv=none; b=UGTyEwYRiAgRN1WK846GFmj9Xv7gNh6/d1qXHIfZNFoq8HTggsTIirN7Lu+42zyjRJeK5W2Dm6U93oW7QKtEis+I4rEuJfafzs7HzRlIbc4A5lDky+fx9U6WRGmSJS66I5E0IMwCOz+exfWLKPzaFgcQHg2PjXvmkL1HCuzpSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994454; c=relaxed/simple;
	bh=AgVyCoIg2My9yOZiCftuy6KRwDQPeNZWgy42WqGA6FE=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GBPI5pI/f8PQ7jfzOLVWbeRSt2Xi9sQZD3NN5d03FF321RRbmH+d1+S3WNSZLrbHS8gp/VJpS1Skdupf0AR2YTVbTefkPyIY+wYbC/wsXXRbgCYiLHcWSZ76mYlWHvsLD+142wsuOUeBvfwdpKNfbY94LklEiuwaAX2Vfp+GdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIWGPxw/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIWGPxw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD091F000C4
	for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791994451;
	bh=AgVyCoIg2My9yOZiCftuy6KRwDQPeNZWgy42WqGA6FE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KIWGPxw/06qAUKLJV7AdgyZ0dqg/LQG9NA998oJh4D6EJYOULwfxRBXieCj4Ranfv
	 Vr5CZUppiQQzXM50mc/leth6uYWdnitNofK0UDBarLd9MOlVV/4qhXhUjgvces/3DZ
	 +YVUzw6YbwnRDQUi0D1RnZirfmNbrVNZSCNb3PGtQK8BMPkGrI9AmBMhu4lr25YEMS
	 FA4cHR7z/2odGG8JR2XMgv7C0ZFg3U4DuathymKVM1tCKsgqBIlk0xG59TgVur22iX
	 H567zG/CFDShV7qDtfsM0mB1KN1UKAtNbHkvwkVX3MkfoY6sNIHt1W0j3oUvzomG70
	 xxRD5AUmjmQDg==
Message-ID: <sashiko-outbox-171520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: use isdigit() in selinux_genfs_get_sid()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20261014160741.222219-3-blum@kernel.org>
References: <20261014160741.222219-3-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:14:10 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Use isdigit() to replace the open-coded implementation.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014160741.2222=
19-3-blum@kernel.org?part=3D1

