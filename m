Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E489202963
	for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431925; cv=none; b=hz56TSrvjVJxMLo8gv/bMOGqxKGtR7Rdz2I3X6WPcm4ICQnCz33Tm0pOEP1yoLUNcb3lOhzXm1FZYJoEE6SrWB1Fe5FoPA5hMlcQErAREVtd+YzyQ/+ivzNzy0S0Pa73qlR8iAspQMrA1bSCMqFj58pq5QxYtLtsfHpfJWAFrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431925; c=relaxed/simple;
	bh=yHIchMwFQptwsieeQLAjRYa4N1zdRMJwEkQ6FPUDU28=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ai1X48sOawOYJKT0I320q2XJi3FqooR+FO37yE30i6qwIynsnGfnD9L0zdBKIzfGzHveIqVcmFpQeViJYTRgQDYH33BR2FJ+ylq7G4naVe8Eh4SLcTE2MuXnnTeDJ2nawM9RYEfqFP9I/x7Ci8CYvSu1EFA3AmUfRViTRZdN8Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9zdXn/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9zdXn/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942AE1F000E9
	for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 23:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782431923;
	bh=OmSycFdF16KDIi8ScvU4CQB9E6QuKLV6oo2BhfAg6Zc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Y9zdXn/s7wEkDDGw+wQmJTshKmCbSCEPGCZnM1RbJdQrchOShiJf3h60oQ4HGtr0V
	 24nvgz/3v3Vhp9UhUlpU87Da4yZZU/Lf8Y339PaWbcWGpViCnDXz57ncNjpxHVvQ1M
	 0ghNWOK0mZqtB0q+NAoN74oDBYBCLHXPfF9+5yqfUdXpWig8Y0LGO1aXMFMOHBJb3f
	 /rlQKQqtA/6i/FOW00UDefPu4MG0UXP7E+hDweZQTVrmYFIrSzcyGfekVrOaCKXFmy
	 GByXb6wEKRm3jlf07QxaMEKF+tlTYw8pg534hfkm7AEePiXFvPzH1flH+8I5VDZp1F
	 S/ZlpGYSZNYyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] selinux: avoid sk_socket dereference in
 selinux_sctp_bind_connect()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260625235336.3641828-1-tristmd@gmail.com>
References: <20260625235336.3641828-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 23:58:42 +0000
Message-Id: <20260625235843.942AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> selinux_sctp_bind_connect() dereferences sk->sk_socket to pass a
> struct socket * to selinux_socket_bind() and
> selinux_socket_connect_helper().  However, when the hook is invoked
> from the ASCONF softirq path (sctp_process_asconf), there is no file
> reference guaranteeing that sk->sk_socket is non-NULL.  The setsockopt
> callers (bindx, connectx, set_primary, sendmsg connect) hold a file
> reference and are not affected.
>=20
> Both selinux_socket_bind() and selinux_socket_connect_helper()
> immediately resolve sock->sk, never using the struct socket * for
> anything else.  Refactor the inner logic into helpers that take a
> struct sock * directly so that selinux_sctp_bind_connect() never needs
> to touch sk->sk_socket at all.
>=20
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625235336.3641=
828-1-tristmd@gmail.com?part=3D1

