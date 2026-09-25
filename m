Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD8481A8B;
	Fri, 25 Sep 2026 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333125; cv=none; b=datABaBj2s9Ad0XRC4W7XC7HscqKZ7FU2Nnx3vuzxSHAqeZHQ7ObtHdfWF+l6r1hPUZpIwZJch9neEhVP/XL7RrmvN0D2KLA/KUTneLPt/Y2U3av/Pi4BBd6wsPT1JmfSzteRqysTZ36JTHITnDU8HnNaMVy/qrrI9OnTlsAF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333125; c=relaxed/simple;
	bh=VsnHGOBwuvBqVCQtGKHhIso5YcGfaTlCu7YB99ej4G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osiPxQAYGAHnWWEFfjahUQMjop0UhCGV3K+HRwK+ldHnVEdLwQGVTlp72nDqLgc7ZXkbojMEhfPqMe1BRhu99Jlwa+yBO6LnMt9Fz2eV1iJxC6b14QfqPx1v2YXsBWJkCer+KMhNtRHt5MUxTDByoJADhDP5ICYSjpovpdq3ans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=iqQCFzg3; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="iqQCFzg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1790333117;
	bh=0UPyRTfN6HmC0POfDtojd1fceOTTPp/b3wmaDXflYKY=; l=873;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqQCFzg3PVfLtZw8YQDz0yqCh+MObnc/u9uJOi8ua+Fi/O3bisRYuJjIaLRGZyA3b
	 6oNEApMWjI+SpH1W/KDOfZXW3Hk/KVWmDoMVPga8VQiTFUdTx7RhRYEQInng2qAaMU
	 5O8L2Vm0z52yls7k2ybIKvrfKJbgZr0/xjgvMZ3g=
Received: from liv.coker.com.au (unknown [IPv6:2001:4479:6d00:3a00:2b1d:49e:579a:70c5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id BFA3FF081;
	Fri, 25 Sep 2026 20:45:13 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: James Carter <jwcart2@gmail.com>, Inseob Kim <inseob@google.com>,
 Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>,
 selinux-refpolicy@vger.kernel.org, Chris PeBenito <pebenito@ieee.org>,
 Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: kernel oops on recent policy with older kernel.
Date: Fri, 25 Sep 2026 20:45:03 +1000
Message-ID: <U7LUwIasQzWInMep3BgooQ@coker.com.au>
In-Reply-To:
 <CAEjxPJ4KTvpC1g6uE9fJwrm6oVE62bNM3qir1bQ-MWMQTWJpqg@mail.gmail.com>
References:
 <L8sbFRgfQca4r8AaNEEfTw@coker.com.au> <DG4uy2aaSG2YnBe-oDHGFw@coker.com.au>
 <CAEjxPJ4KTvpC1g6uE9fJwrm6oVE62bNM3qir1bQ-MWMQTWJpqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 17 September 2026 22:33:04 AEST Stephen Smalley wrote:
> > Thanks for that.  I commented the genfs_seclabel_wildcard line and it
> > worked on Debian kernel 6.12.107+deb13.  I'll keep that patch in for the
> > Debian/Forky release unless something else forces breaking compatibility
> > with older kernels.  Being able to upgrade to Forky on a Trixie kernel is
> > the expected situation.
> 
> I think it should be reverted in refpolicy unless that is now the
> minimum supported kernel version for refpolicy.

I think it's only an issue for distributions that have a release with a 6.12 
era kernel that want to have an upgrade to this era of policy without 
upgrading the kernel first.  Such distributions can include the same patch I 
am using for Deban/Forky.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



