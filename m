Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78AA42A87
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349990; cv=none; b=RL8IgnWRSAqsftkGDxFLgZAoRbyU70xWQtv6Adu45HfbZW1tCj5N00VI9o6BWYF30i0zjc7AZgd7YfHO5zWoEVOQomEsdkpP2gcfAJIqk1L6yP3g56B3jQsLzASBdBmH0qFvmaDGzYs2mxq4LWuF6HLEy5XeWhsMRufalhLnYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349990; c=relaxed/simple;
	bh=AecZYOkXyQNvtsN2F6QGS+Md3xK+SMBPlEU+Jl4SAtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rlbT7M0ZoogrBXrAbc12N0sJx6gVSqZ9nrzIRlotcoR9Btrqxo+N2GRQH0fcfHvjPxnNLMd8OICN35neDZqgheQEQ3ilkGnwVbgqD7xCMYUyyQ1z2Uv6Ji9e3GybfNsgdyV0WptiIkBxodfq0PiKNlqPcw2+YWL3B9h4eY8DJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=B2bmavgy; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="B2bmavgy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1731349985;
	bh=AecZYOkXyQNvtsN2F6QGS+Md3xK+SMBPlEU+Jl4SAtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B2bmavgyc3A+VTdHBTixFsgWpmitaYd0pE4yUxyUCh7eUE2HNBR9sHTa1WZrR3cUq
	 OZ4lu4pKoGEpJ8zOmsPSnWiUuzSOqlGJZb5aCvphUDpoVkWblDBHV1lN+JoqsBK7Wv
	 uaehf2D0sIUFc2E4SCNHsO0TkujgRhOiLZgn0r5w=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id E6543DF5A0;
	Mon, 11 Nov 2024 19:33:05 +0100 (CET)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Ian Pilcher <arequipeno@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Subject: Re: How to write a policy for a "service wrapper"?
In-Reply-To: <435b1b8a-a6b6-4180-a038-520d226b88ef@gmail.com> (Ian Pilcher's
	message of "Mon, 11 Nov 2024 10:14:02 -0600")
References: <435b1b8a-a6b6-4180-a038-520d226b88ef@gmail.com>
Date: Mon, 11 Nov 2024 19:33:05 +0100
Message-ID: <87ldxp8vtq.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Ian Pilcher <arequipeno@gmail.com> writes:

> I have a service (stunnel) that runs in a confined domain (stunnel_t).
>
> Due to changes in Fedora's systemwide cryptographic policy, I need to
> run this service under the "legacy" cryptographic policy, using the
> 'runcp' wrapper[1].
>
> So my idea is to create new domain for the wrapper (runcp_t or similar),
> give that domain the permissions required to perform its functions, and
> then use a type transition rule to run the actual service in its normal
> domain.
>
> It's simple enough to write a type transition rule for a specific
> service, e.g.:
>
>   type_transition runcp_t stunnel_exec_t:process stunnel_t;
>
> However, it would obviously be nice to allow the wrapper to be used
> without the need for service-specific rules.
>
> Any service that normally runs in a confined domain presumably already
> provides a type transition rule for the init system, e.g.:
>
>   type_transition init_t stunnel_exec_t:process stunnel_t;
>
> Is there some way that I can make the wrapper take advantage of these
> rules, possibly by transitioning back to init_t?

You can label the runcp command with a private executable file type and
then allow systemd to execute it without a transition effectively
running runcp in init_t just like systemd. Then when runcp executes
stunnel it should transparently transition from init_t to stunnel_t as
if runcp was not there.

>
> [1]
> https://gitlab.com/redhat-crypto/crypto-policies-extras/-/blob/main/runcp.c

-- 
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
