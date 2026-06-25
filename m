Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D212382F15
	for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352239; cv=none; b=frkZDGRuCJn/w2mc+6goRLz5EBwNYgmnAY0r9wPTuVJQ9ovH9fqWUeN6EZfdMjyimD4W5TxgKCT+NCZguUaTyzZxonsPWJubSfNmfkYTbzSPQOBysn166sQIaTXGVkD+GVA8N2VasnSdjgQV4nDktmM7QS/Mm+Fu3u4CR7gASTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352239; c=relaxed/simple;
	bh=vkTkC3M6dBTJeFRN/W+c8uQpDh/u3asLmz7tjHfGU94=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fd5RiJBrsY8UT4JTbMLzcI8y39JrGXIixLbhjjVl1imLgijccJVRXNAqiB3dN6xSSVgpyVptXvrYC8z5pQEYAwTjmdZgHjJpmjPXi5z9ZvswxZ26X6oE1wF42sbZ4e96O2nAoXsub7WME560LZL1KyH6n84rTOjXC0duwqwUh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XV1an3xM; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XV1an3xM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1782352225; x=1782611425;
	bh=vkTkC3M6dBTJeFRN/W+c8uQpDh/u3asLmz7tjHfGU94=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XV1an3xM48qVValXK5urHVqGb+ulhgv5dmqvBzFkAOmRYFZXmzYy+4lawrGQurHo6
	 VnBbxClJcIXGSbMVyhJbywuuYExO5wB6njhlNhJufj2NhHeTOLiJh81rOO5lXrD/11
	 s9wAIjWCAnuoVFlSGtaXkyvkBt70IHUkx1NQ8LU08Y6OoG1z/5ZPv42bEcCW0mXw+q
	 KFyellH0k/5ZJGGovv0EWi8xGQrcsXt4BIsBO4ct+58Sj917DaZsM8wBhS86UajQFH
	 gA6VGXIPDk5GZXFiBMy3K4KuIL/Hlw3jTRulGkdmBYbikz5LcfH2d4CJ4bFU0qq9kj
	 S8v8+1CWxOaZQ==
Date: Thu, 25 Jun 2026 01:50:18 +0000
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Subject: Re: [PATCH] selinux: check connect-related permissions on TCP Fast Open
Message-ID: <20260625015012.63752-1-hexlabsecurity@proton.me>
In-Reply-To: <20260618175513.112443-2-stephen.smalley.work@gmail.com>
References: <20260618175513.112443-2-stephen.smalley.work@gmail.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 3e7c70881b92ad9b9437df32e3535b7ab3871750
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tested this on x86-64. I built mainline with and without the patch and ran =
it
under a SELinux domain (enforcing) that lacks the tcp_socket connect permis=
sion.

Unpatched, connect(2) is denied but sendto(MSG_FASTOPEN) still reaches the
listener. With the patch the fastopen send is denied too, and the AVC shows=
 the
connect check firing on the sendmsg path. Same for TCP, TCP6 and MPTCP. The
TCP_FASTOPEN_CONNECT path was already mediated at connect(2), and a domain =
that
allows connect is unaffected.

A/B logs on request.

Tested-by: Bryam Vargas <hexlabsecurity@proton.me>

