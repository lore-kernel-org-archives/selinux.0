Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F5350A1E
	for <selinux@vger.kernel.org>; Wed, 11 Feb 2026 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770835077; cv=pass; b=ooIFl+fehBxyQGP3TNe/QBnc7kahRHTd0jSY/7EpvPWo1dQMP8bTxU3nE0XJQEG9umvgAVlAM5xFemWz73mLEcn4to8JMcvCHz7LrEyUf/zV7IJhQg8bqtRqWSAX3SznbxeRsALY7cHCN5a4fVU66MbmOQbaAtNDL7zmhqi5Xek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770835077; c=relaxed/simple;
	bh=9ZWLjOloP1Q5uHjLNR70INYP0pXvmwZRE/FY/ppnIWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rwit4o9QhJQIR2uqbBOPKMCu0A/hYv7FfwtvIwEjkmrohBoltv7MxM+9VKoaUXtFb1jWHS+V97D9kDszti9BR5so9DvJDm+i57EhOlX8brsidSrhe6BTeekYJnZV/RkOwJRZWWgQf/fe/xS6Oat+SBppQ45g8HAoKEXisrQ5bkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD4Bysm8; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD4Bysm8"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so1104681b3a.3
        for <selinux@vger.kernel.org>; Wed, 11 Feb 2026 10:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770835075; cv=none;
        d=google.com; s=arc-20240605;
        b=bUy/N0UGc6lRQhwwenUHz0GQ9Q4lQgkJ7jlTvACb33DGfJ4CJdVYR+v+xOXvNKx6Tr
         M/AeWuGQyfPTuMriydjhftf2BMDC4OCBhH8BqP1K4zkQSX/bX4cf3rgDN+HbCk41i3+D
         Y7rwOj2jM7X1K1AFoL//CcRLKj40/WCYU4SWL7XrAHU1PgVhWWqq6n0RRi6oLso3N+tr
         Eq2V6+BwkvCwnPKYLk9ieRJTSwaS+uP/gMFy/NodjxU46TlMJHB0I44C4t1ca29OFLpQ
         YjvYGr2b89kmCxepS6sYW/2BRXtyBuyhp79FzI9b8ziunNQvj/8FvE8XK+lgdYip77rx
         0L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMPWpykIwqzVnKpU0MqZGbLM8pCJKBxgV4mw17dHpGg=;
        fh=E0A8+em6npvRcGGPb9pxrP3qzM+o8SIV5md0L6qIY20=;
        b=UQctBoD7jm2oBngsMznLbGv/gHBU2EZ05gVJ47CHpmbdE6BzTRKrEpHi8BkRCA20vL
         qSwNb1reSruyaeLnJ2AHHv4+Fvk39KGZQo3sn5Uo5sXUBo7Rgfo0LMHYKrLeljX62iGX
         gYHxTNTdeZug5Dq/tvJum2V2pX8wb3RhtxK2a2N4JwMtBfsWU+EsKHBFO/fA1ljUISRk
         5wz0IFlLaod+HHc2KdTlJf1+sNNOR98SpY+3Po4dQy6RhyZwv2HxwB59oU+A0y7kUT0d
         AK5BMqAKn2y9k2p/TotVHKwJSt7pLCn8IAf+w8Bgyo6LGHb9mdddMF6WZ3pRvRgksD7U
         c8GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770835075; x=1771439875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMPWpykIwqzVnKpU0MqZGbLM8pCJKBxgV4mw17dHpGg=;
        b=dD4Bysm8qx2oNt/ljYK2dY+kw68Z2xBUGiI0IXibgjRxcMEVvrlAUFoHXtwbDrscd4
         3bbAWi/WA7yXun3eogVkRIca5PJYESQuIeDF3pTW5GFXqt24PGzOq7OK+u0hiHrk9GGn
         d/BYnuxs5gunbHQntQ5QV5y9KiWksyLfJgP3dPiDJZI5D+Uzq9fQlzV+VVgNAUL1cVT6
         C2t26hPMMmIkLOGmPBw+Ko9eL8cvflZ/D4s5J14PGOmx9h7tZX9xLNviXi5pzhhMZkDX
         dvsC6t4X5H2tKmh0gmhUDoRB+bpRtAiIYFrn2qNaXoTlilkJyv+rWnRChdQF/jW7I726
         ZtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770835075; x=1771439875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMPWpykIwqzVnKpU0MqZGbLM8pCJKBxgV4mw17dHpGg=;
        b=xLqlNmG41GsENdYEJGYIbWeDlTJyNRBU0ixjl8r298sIPFW1DSTUZGZhgKPnTSPhER
         jiovPPNtSHFEFdvUuiZf+g0WX3qjARo0gPLzs9NFeXyVq1UqG8ICe7wBSuhj/j3Lu5Hj
         sgOKPl10yDcR8JSJxmyoy02Sj/fFKHqclFJmY0x7RCrd88O53Z4v2SB2eE4BwakZU0/a
         yO/2FwZJz+66vsWZIfJXit2Ut54KGG4jaYCp7BQjlkIUiL0r6vUX3bJ47IKQgLsEiEKl
         G+2mbAoQbGh3J0Z+eoDRL4+YS/8/Gop5lY8EUL1XE+wpK8Xm8zv8nRz7rb4JHQ1lrrpH
         62BA==
X-Forwarded-Encrypted: i=1; AJvYcCU89XU0BLF5AzeEzO7cG447SnsIYrxvMlu+2+gwlu9edXBrX9BiJBz9ycdhaDEigVqGmasL3rkq@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZ2K/X2JUG2feKuRsHynvwbJNdu4oCOWFtBMx5eBKv5yJvp3X
	zOyusJdSHgfwx5xnv9YL7yPqh4dAw0+bd9bjldSsZLG1CKHIBaaxq7uYSlAuzoVKR5V6bOENQJo
	wI6ao7OsKiCb76pKzsCagW4zGI440snM=
X-Gm-Gg: AZuq6aLNUiQCMW6ZQQ35torcRrjgMVr1Zbv/+xl0KndtKSbBqrvFhLOfpOSxJOmleZL
	3p6OOcqrugkwDwFk7G3VB2gXmjrUQXcXqud4a/zJr2TKsR2Zx7DRevCWc4yHR/pSUtdHeNPNdTp
	zTEh83fM6ogXLI3c8npxPGipvCcxuicvX7lOd2aj6CqVjRcE+YwyzwylZDYsXkglvnk7/r22vBu
	t8lQGt61EiPVWMCdIwm03Qgiozm1W3/JERAVdTuBdzN7YZfzPHV/d8fDQihUFRGjVrkuaZ1ugUb
	EG2t+N0=
X-Received: by 2002:a17:90b:5211:b0:356:282e:7eb5 with SMTP id
 98e67ed59e1d1-3568f3f7f89mr227816a91.24.1770835075473; Wed, 11 Feb 2026
 10:37:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com>
 <20260206183657.0477e50a@kernel.org> <5b2fm4nbceqdmeu532vsr26il7jroli2sh6azcwirzm43b32da@grqzpgmmdvyp>
In-Reply-To: <5b2fm4nbceqdmeu532vsr26il7jroli2sh6azcwirzm43b32da@grqzpgmmdvyp>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 11 Feb 2026 13:37:44 -0500
X-Gm-Features: AZwV_QiEMEu8q-izEMqXgVPWSyu-zfy2ppyFTX5F5JMm-3LkhB33GLI1JN_qEvc
Message-ID: <CAEjxPJ4VA58rtSEEZpxeUZHMjURtrUbZCvV8kAkWwJaoR1YN2A@mail.gmail.com>
Subject: Re: [PATCH] net: qrtr: Expand control port access to root
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com, 
	chris.lew@oss.qualcomm.com, 
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:20=E2=80=AFPM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> + SELinux folks
>
> On Fri, Feb 06, 2026 at 06:36:57PM -0800, Jakub Kicinski wrote:
> > On Thu, 05 Feb 2026 13:51:31 +0530 Vishnu Santhosh wrote:
> > > When qrtr is loaded as module, qrtr-ns runs from SELinux kmod_t
> > > domain. On targets using upstream SELinux policies, this domain
> > > does not receive CAP_NET_ADMIN, which prevents it from binding
> > > control port even though qrtr-ns is a trusted system component.
> > >
> > > Granting kmod_t the CAP_NET_ADMIN capability in policy is possible,
> > > but not desirable, as kmod_t is not expected to perform networking
> > > operations and widening its capability set is discouraged.
> > >
> > > To address this in a contained way within qrtr, extend the control
> > > port permission check to allow binding when either:
> > >
> > >   - the process has CAP_NET_ADMIN, or
> > >   - the process belongs to GLOBAL_ROOT_GID (root-equivalent tasks)
> > >
> > > This permits qrtr-ns to successfully bind its control port in
> > > kmod_t restricted environments without broadening SELinux capability
> > > assignments.
> >
> > This really feels like a one-off hack, but it's far from my area
> > of expertise.. Could you get an ack or review tag from some kernel
> > maintainer working on security, capabilities or permissions?
>
> I'm also not too sure about the problem because it looks like kmod_t has =
almost
> near root privileges, but cannot do network administration.
>
> Maybe there is a valid reason for that?

On Fedora, kmod_t is an unconfined domain and is allowed all capabilities.
Upstream refpolicy likely hasn't encountered a need for net_admin
during module initialization previously and thus doesn't allow it just
as a matter of least privilege.
Since you referenced kmod_t, I assume this is just for Linux, not
Android (which has an entirely different policy).
I would fix this in policy rather than changing the kernel module code.
