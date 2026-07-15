Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E42FDC57
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138070; cv=none; b=OGweSnpEsxB60b75/E2ibJ4y0+OTOYsQDqzE19mpYzZMapF7WY4gaaQeulbJziQRXRW9xiCn/yMz/QnOUqn0PCwD6CWb4PpPNSWITjktIYahfvnTLiCNs3ZOUWMQmYKdVt/sRKFKAPyVaPlZmE+OlkFl+owFuFWmt1VCY5SKNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138070; c=relaxed/simple;
	bh=+6adDd6/xHzkWm2bf9Gy2fAjqVGpbD8dRg/fCWC+VkQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HkYIZ3A5EBRB5X0gJANSCOT4hmYhOBLYJ4krEH0IYd7hpvsdlKrIYkKPwerlmzxAErp/17W2ZAn4LI89c9lazTi0VSYIIGPToZjG2uWCiN0xmwR44g2dz6KEioFGG5157SdKphpsqFxu1scy2mHBrWQYIaX0tdKgtwYZw6qRwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYzUFd38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYzUFd38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F8D1F00A3A
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138069;
	bh=qk3fcdD1HvfrwPxx94xphx/jl+IrRk80KPFoYr4A/WA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EYzUFd38YQIfoeAGi5tUsHyvBsUu3G2NqxwCkcFuv58/iqraa67z8COw74ObBgN7Z
	 bTlZdJNZwjDsy0MKOF1/UQ4iHn9U7z+mUFNj/qd1n7vE6WwYHjuXCY+AyLCgoaaMci
	 xe2NHWveHS/+iSb3mcNc+hg5084A2RE1ctjbL/gk5thXoNyzNSNoy5FyI4dnS5oqzj
	 vRz5ehWQtWvlBLtd3a+Vcfj8uQnqa3Jxc0/qN82Y8EKzdcy18mnhDLTewSNGauD/y5
	 iXefQb1+tNFQ0Z49wnNXEmJF78Raz3VNgd3Mmek4SI/5MFY/d9sgb2vmll0Ik2G/JB
	 BcfWI5oga2LoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: use socket SID for SCTP bind/connect
 permission checks in softirq
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260715174521.589520-1-tristan@talencesecurity.com>
References: <20260715174521.589520-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 17:54:28 +0000
Message-Id: <20260715175428.D0F8D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] SELinux MAC Bypass in SCTP socket operations
--

--- Patch [1]: [PATCH] selinux: use socket SID for SCTP bind/connect permis=
sion checks in softirq ---
commit 7061b960bc8b25549fb5d5ff1d249127732f8627
Author: Tristan Madani <tristmd@gmail.com>

selinux: use socket SID for SCTP bind/connect permission checks in softirq

This commit passes an explicit caller SID through __selinux_socket_bind()
and selinux_socket_connect_helper(). It modifies selinux_sctp_bind_connect()
to unconditionally use the socket's SID to fix permission checks during
softirq processing.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8d6ccbf16c2b4..fe91c9191f732 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

> @@ -5766,14 +5773,14 @@ static int selinux_sctp_bind_connect(struct sock =
*sk, int optname,
>  		case SCTP_PRIMARY_ADDR:
>  		case SCTP_SET_PEER_PRIMARY_ADDR:
>  		case SCTP_SOCKOPT_BINDX_ADD:
> -			err =3D __selinux_socket_bind(sk, addr, len);
> +			err =3D __selinux_socket_bind(sk, sksec->sid, addr, len);

[Severity: High]
Does unconditionally passing sksec->sid bypass SELinux MAC policies for
process-context syscalls?

If a privileged process creates an SCTP socket and passes its file
descriptor to an unprivileged process, the unprivileged process can call
sctp_bindx() or sctp_connectx().=20

Because this check evaluates the socket's SID rather than the executing
task's SID, it appears the unprivileged process would be evaluated using
the permissions of the socket's creator.

>  			break;
>  		/* Connect checks */
>  		case SCTP_SOCKOPT_CONNECTX:
>  		case SCTP_PARAM_SET_PRIMARY:
>  		case SCTP_PARAM_ADD_IP:
>  		case SCTP_SENDMSG_CONNECT:
> -			err =3D selinux_socket_connect_helper(sk, addr, len);
> +			err =3D selinux_socket_connect_helper(sk, sksec->sid, addr, len);

[Severity: High]
Are these connect checks affected by the same permission bypass behavior
as the bind checks above?

It looks like syscalls such as sendmsg() and sctp_connectx() would also
bypass the permission check for the calling process by checking the
socket's SID instead.

>  			if (err)
>  				return err;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174521.5895=
20-1-tristan@talencesecurity.com?part=3D1
