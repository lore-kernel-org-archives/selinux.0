Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BC1F09A8;
	Wed, 11 Feb 2026 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830433; cv=none; b=e9/uxSDzpJR3JSNW9Bl9ntgMYHGC+oItFJwMWxKDJqnqvzQPRT7kJxmF3qP56FUFQ1ZhzFDzAStsBRJOsfb2jQVeVoYNGSEM96aAE7zQnfoGXkRzUuj7uC24CDj8JlqFushBDLoZldVdbkul4CV1JM+FOmFUDrUeqasmF2LhHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830433; c=relaxed/simple;
	bh=rDSxVoUqlCob1134dE/I8Idt+0slLPa+P7T12+XN680=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWbyAiWMuQF18cNzNksqCi9Hjj8rJlQOdwVpH6YKzJlrTgH7X/Icc56LLQmQyW+bm1FxNVNFmAl2PaBeUa+IjUWJjDfRtAQOFuruxidwJpVR+UUsNOaO3aHx8bFg1PvugsqjglNq551PzVpTe6GpfkqMcTi4pgY0S+ChAL8Prfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzjJXyDK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzjJXyDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E24C4CEF7;
	Wed, 11 Feb 2026 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770830432;
	bh=rDSxVoUqlCob1134dE/I8Idt+0slLPa+P7T12+XN680=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzjJXyDKkuMiD1TWTrSWYbgn9kffOgIbfvI3AhVPguFvdeEFAsv5bcCmE6XwkItrA
	 r21jXe6CGUPUOLBsRjAbfePMJvbYopIzISGZIo1JgYMMM4LvPDTHrFJyjXwJNgppqR
	 P4C9udt9AFqzgxIoCPz7xmXXyqrQdUgT7ANoqJtC648qAsPBAO1s1HCbiCuqAu5fWi
	 KNdjJmx95Id7CbPmu/VIpG8XqbdJwG1EUg7TubBQ5NjPb/GrFbw+NbcftIaz9y7tIV
	 ffs0+iieazDbiCY4m0CCufiSaVM9mdMYn2Fx0Xrz+ysSMUp99JqUpvd5w40SGmzCTy
	 +pAUV/swTzY7g==
Date: Wed, 11 Feb 2026 22:50:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com, 
	chris.lew@oss.qualcomm.com, Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH] net: qrtr: Expand control port access to root
Message-ID: <5b2fm4nbceqdmeu532vsr26il7jroli2sh6azcwirzm43b32da@grqzpgmmdvyp>
References: <20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com>
 <20260206183657.0477e50a@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206183657.0477e50a@kernel.org>

+ SELinux folks

On Fri, Feb 06, 2026 at 06:36:57PM -0800, Jakub Kicinski wrote:
> On Thu, 05 Feb 2026 13:51:31 +0530 Vishnu Santhosh wrote:
> > When qrtr is loaded as module, qrtr-ns runs from SELinux kmod_t
> > domain. On targets using upstream SELinux policies, this domain
> > does not receive CAP_NET_ADMIN, which prevents it from binding
> > control port even though qrtr-ns is a trusted system component.
> > 
> > Granting kmod_t the CAP_NET_ADMIN capability in policy is possible,
> > but not desirable, as kmod_t is not expected to perform networking
> > operations and widening its capability set is discouraged.
> > 
> > To address this in a contained way within qrtr, extend the control
> > port permission check to allow binding when either:
> > 
> >   - the process has CAP_NET_ADMIN, or
> >   - the process belongs to GLOBAL_ROOT_GID (root-equivalent tasks)
> > 
> > This permits qrtr-ns to successfully bind its control port in
> > kmod_t restricted environments without broadening SELinux capability
> > assignments.
> 
> This really feels like a one-off hack, but it's far from my area
> of expertise.. Could you get an ack or review tag from some kernel
> maintainer working on security, capabilities or permissions?

I'm also not too sure about the problem because it looks like kmod_t has almost
near root privileges, but cannot do network administration.

Maybe there is a valid reason for that?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
