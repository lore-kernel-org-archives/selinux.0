Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C9446859;
	Thu, 17 Sep 2026 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642912; cv=none; b=dcZHgKjYP3XC4S4q8n0+mHfmypaL7LjR5S1m1uz4eedfpcif64vNt4ioS6ldkgx9Y3u7hbJaQd+20BWZFFNtECWbuIXVS43D2Mg6msDG2s/cerMV/a4YK6LlaZ9fuzFLhjTrYAdP34SeqH7npa4BMCqPSYJUGcfBkifiSyqGoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642912; c=relaxed/simple;
	bh=bBQ3WvRIpmad8saJWAjlLoM28HrMX+5Q2EQWL0aM/8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLZmi2B0TqjGcIlTZLbokdUCV1WU12C2EBKEwCgh7uPRag/wSeZ3PHh0HOwK9LLyyhqK6kshYI9EX10M8H3NK4pN8xreeuqIPuMSjMd3LY8hougK/83tZM4qKb6s8Lkl21RKgj4bQA/zWMMPWYRLHFko44s+L/5E6NdSz3G7Uq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=d+scANP9; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="d+scANP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1789642898;
	bh=ZOMh7ARJ5O5zwE3u+vV5jh91e7bEYtXSg3AIAdCPWK4=; l=866;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+scANP9ii1ulGV3POCv2fZB6+kYv+HLJu32AoPsCznncL7rTsRCUdaocxNXVJHaq
	 l558f4L9QpD+zxpQZT3gTevkJhbp2g0y5nWgqUvDcGQ4GF1OGNNjv1PZssPpLsefGx
	 sNTWVDBZosdswLIHK5l6Ut3KM/XR2XqBeP/b55P0=
Received: from liv.coker.com.au (unknown [IPv6:2001:4479:6d00:3a00:2b1d:49e:579a:70c5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 42083ED2A;
	Thu, 17 Sep 2026 21:01:34 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: James Carter <jwcart2@gmail.com>, Inseob Kim <inseob@google.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>,
 selinux-refpolicy@vger.kernel.org, Chris PeBenito <pebenito@ieee.org>,
 Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: kernel oops on recent policy with older kernel.
Date: Thu, 17 Sep 2026 21:01:25 +1000
Message-ID: <DG4uy2aaSG2YnBe-oDHGFw@coker.com.au>
In-Reply-To:
 <CAEjxPJ7TLMCPkE7fwKrSp_FKJ5xm=7YpNu8LA4GM1-EFkjsamw@mail.gmail.com>
References:
 <L8sbFRgfQca4r8AaNEEfTw@coker.com.au>
 <CAEjxPJ56+YkfCgt_08NgD+6pQsvDGrsUgx3o5eC-U1ZmE9pfqw@mail.gmail.com>
 <CAEjxPJ7TLMCPkE7fwKrSp_FKJ5xm=7YpNu8LA4GM1-EFkjsamw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 8 September 2026 22:42:59 AEST Stephen Smalley wrote:
> It appears to me that there was an attempt to make checkpolicy aware
> of the genfs_seclabel_wildcard policy capability and have it
> automatically add the trailing "*" to the genfscon paths when it is
> enabled, but I don't think that works for modular policy. I do not see
> such wildcards in the policy.35 file you provided, not that that would
> help with kernels < 6.16 anyway.

Thanks for that.  I commented the genfs_seclabel_wildcard line and it worked 
on Debian kernel 6.12.107+deb13.  I'll keep that patch in for the Debian/Forky 
release unless something else forces breaking compatibility with older 
kernels.  Being able to upgrade to Forky on a Trixie kernel is the expected 
situation.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



