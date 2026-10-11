Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CCA383C86;
	Sun, 11 Oct 2026 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791714143; cv=none; b=pQgVvy/a+SGXI1nHGDXEtbDMROHjANNrUe5JAaLz6nisFCTYQ3BoLQXqs3Fpt/9FS91AC4ZS4wEiX7dB1ATp7z6BitvU+fxdeT9whvyVG7Iz/vBdv7VUW45jDIFMlYKIX4WwdZjoWbIZ2T3sl9pWMdNrZr/T1KykNHSb+O3RslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791714143; c=relaxed/simple;
	bh=rWsBX3Tlje8BgHngc/Cs4wk666aps+c0CL8EtmGqct4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqjypN+HzU0k3FRlLw6DlpEKI0Cp+LfuAEvHrA3Ah8MJ07m76sRj0i/fqqTJ5Y5a7V+Jz8KjweuKvgYKR3anzU4tp/YjVaRACEcBcfH2p5ardVPcOHt/G5mtO4TVXB/zMunatwKXKwvudoFb4k0k5KdWhbt2wXS9ozFVJyPn3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=nAyU+tnW; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="nAyU+tnW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1791713815;
	bh=f+JY1cL4u/NhUhrBJsrRVJmO12uPCrNem94uGEy7Ph0=; l=1058;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAyU+tnW27oT/aus5Hg2PVJMVsXDavgYrFmOUCy8zaxJKJiso1Sb2jf0kj9maWLru
	 P0U1Nrpu538Foe3EJiJ1TrkiLDIXLc2wzc/oPrVE+QCvyPt7jRs4ZM0m52egGAFwqp
	 mgH/nnFapf0hrr7vYqcegPRv7Kj0Gmh3AD/cLLns=
Received: from liv.coker.com.au (unknown [IPv6:2001:4479:6100:d300:5256:b7c4:cae5:ca00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 0783DEC38;
	Sun, 11 Oct 2026 21:16:51 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: Laurent Bigonville <bigon@debian.org>, Chris PeBenito <pebenito@ieee.org>,
 selinux-refpolicy@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej =?UTF-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
 SElinux list <selinux@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
Subject:
 Re: selinux_kernfs_init_security() ignores genfscon-resolved parent label,
 breaks type_transition on cgroup2/sysfs
Date: Sun, 11 Oct 2026 21:16:47 +1100
Message-ID: <pB9muNcGQZ6P-vJnlrrTKg@coker.com.au>
In-Reply-To:
 <CAEjxPJ60od3GG5wqEYuoQQjtW+3VykX2J9L1e4uX0z7yAhRxRQ@mail.gmail.com>
References:
 <6ab19069-a348-42d0-89c3-3387b5d38c30@debian.org>
 <833bdec5-3935-4f86-961c-f179e5f8fb9c@debian.org>
 <CAEjxPJ60od3GG5wqEYuoQQjtW+3VykX2J9L1e4uX0z7yAhRxRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 3 October 2026 22:45:30 AEDT Stephen Smalley wrote:
> > I guess the rule can be added to the refpolicy?
> 
> refpolicy recently reverted enabling of this policy capability because
> it requires kernel 6.16+. So this won't work for stock refpolicy yet;
> you'll need to apply it on top. The refpolicy minimum kernel version
> on main at the moment is Linux v6.8 (for userspace_initial_context).
> For comparison, the SELinux userspace minimum kernel version will be
> Linux v4.3 starting with the next userspace release (3.12) since we
> are setting the libsepol minimum supported kernel policy version to 30
> (xperms_ioctl).

Debian/Forky is expected to be released in the second half of 2027 with a 
kernel version of 7.2.x or greater.  For upgrade purposes we want the policy 
to work on the kernel from the previous release.

In late 2027 will anyone still be supporting a kerne <6.16 that needs 
compatibility with the latest refpolicy?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



