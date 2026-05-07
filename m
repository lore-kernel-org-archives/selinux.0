Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98FF379ED7;
	Thu,  7 May 2026 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147828; cv=none; b=elv2RLTHEe4uFZRpY3fubtsKvVQFAQmHHkrTPyc+R4W5W5ELl0H/EaCNeSAFSG5CJfBhTIMpi8NH5WWlyvU3Pf3oVcDX+qvQ4lmAJbLTEYNeK2aTHR0swJBV1vMGK0TPyEK1SCMFzon4rzZUeEVZ0abNBF7zFCRNVl+wHMnduxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147828; c=relaxed/simple;
	bh=O+5jgUrWPjry/W0UJbvzKTQMNjti2z78IZOE8hKG+Zo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbEap+WcYtb9VcN4hGWsJFIfM8uX49VZ10brU1IDmOMiOKS7ToUe24+kAHt2ui2Eg/aSA/CFByfTiuvsmMUgnDRSDwvVlqUuuW1x9cgqawTB3hH19H13S/1a0D3duaItCFnY6v7IMwOtuq9BOUHFi0qXdcygJPQwSjTUZ8uG3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=x8C7C6+Q; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="x8C7C6+Q"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8BF21207E4;
	Thu,  7 May 2026 11:57:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vB-CUbQZBU4X; Thu,  7 May 2026 11:57:03 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EF44520704;
	Thu,  7 May 2026 11:57:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EF44520704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778147823;
	bh=MOYDlUqeISiGGsbkC1yMJoUSWt54w/2P59yNM6sgj+4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=x8C7C6+QFhWbuLOlA4f2TLqiJMhlazJt2gYIt//j0sqPsJ1u3xUKKcidONFWViTmT
	 lJu132TWKWkxmVHz8nriv8AIBrMaRLkd0Qmu+cAuQkZMLk5OSsCNbkrijh1glWPcbe
	 BvVLC60aJ9Yt1jsan8m/3mWMYZMaFIyzSPWez5YB/c1sgtfKS/eDK6bBJy/qJctuM/
	 Vzuel4ZWycS+xUSPq6QOFP6UQqDxDqosGpetYk8AOAgwn2tpE80wOd50q3e9XYAkgY
	 B9tFnw5bdoqqHXb91Imk683M6f7JgEsrHJ4OEo+YkHGnCqXo9PHDJH/Fk6Syisj+i2
	 N3nLAHNjqhdhg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 11:56:59 +0200
Received: (nullmailer pid 1537037 invoked by uid 1000);
	Thu, 07 May 2026 09:56:58 -0000
Date: Thu, 7 May 2026 11:56:58 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Antony Antony <antony.antony@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
	<dsahern@kernel.org>, Masahide NAKAMURA <nakam@linux-ipv6.org>, Paul Moore
	<paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Chiachang Wang <chiachangwang@google.com>, Yan
 Yan <evitayan@google.com>, <devel@linux-ipsec.org>
Subject: Re: [PATCH ipsec-next v8 04/14] xfrm: fix NAT-related field
 inheritance in SA migration
Message-ID: <afxh6tZDV7RwXQ_a@secunet.com>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-4-4578fb016965@secunet.com>
 <afxcVV83k7CxImwC@krikkit>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afxcVV83k7CxImwC@krikkit>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, May 07, 2026 at 11:33:09AM +0200, Sabrina Dubroca wrote:
> 2026-05-05, 06:32:43 +0200, Antony Antony wrote:
> > During SA migration via xfrm_state_clone_and_setup(),
> > nat_keepalive_interval was silently dropped and never copied to the new
> > SA. mapping_maxage was unconditionally copied even when migrating to a
> > non-encapsulated SA.
> 
> mapping_maxage should be harmless (0/unused on non-encap), but I think
> migrating nat_keepalive_interval should be considered a fix:
> 
> Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
> 
> (maybe even split out of this series, but that would cause a conflict
> with the previous patch)

Can this be backported without the previous patches?
If not, we might need to split it out.
