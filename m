Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F725EFBF;
	Mon, 18 Aug 2025 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535616; cv=none; b=j+RV/h/dWctLH7swqXjDwHSIByouE6pxU3j9aNhXPyOq4h92UaVr9cOZ3hmcds2aPu4RnR9HpWRxvIfnHHSW05AYQCab+HRP7pSPk1HZdyaXCBHlT8woJum7YJbfunvEN859gef9CUvHT/j+Ty0yBAfxrXO5I3iVa3urZ7ntJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535616; c=relaxed/simple;
	bh=JeOgJPKPhlMM+v9nS1Rcs3P9Jhb7OnLeXhQkmAmW7/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/Wm+ijC/ACNdE0htd5DvpTiEd2MzphdOabPSVwuCbTZPr6jMIqWc79z/Fp3HR8KHoO18TKeohzVHdYa5jhgXDMWP5BSPF8ZIf8xw3GJrlMUrZagbbrsl+rAtiK1ZJEcyFnER2kKGgQb4bo+t96tnyJ2t48HV6ZrPxtT1athEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EeuEBVtC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EeuEBVtC"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 293C840AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755535614; bh=eS3VlHL5nEkglHH12GEGXdT6zm/VZKMW+fKKXPIqxEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EeuEBVtCRz7ejt7MEOTpnXH1VAkxqyfVkLzOcgqDXvEaJwsUTikh2R/mUbblicGwh
	 2T2lU6hrHSOLFoazvj6uuNdCDINGjEvfpvBWn/u5uB6d1d+AIIo8eS//tpLZjh55GS
	 MCsG35L42WzxZXABwAFRNROzPLQSGQ1WhonE2UpaQ2/nofb8zqEiHlmBaxHYVead/K
	 iYpOT+R5k2Q3ll3HX83Dj2eoPtYJP+PmX+XWxJ0OWAoKkbryXom1P4OpkkpfvWOn1Y
	 qtktr7116zS9IgsT7iH1dxcXuEiHpv79kvAnuCOFMB/SrOK9ZvaO4OgT6+7X0eWSZw
	 457VvFR0uUkVQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 293C840AB4;
	Mon, 18 Aug 2025 16:46:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: David Sterba <dsterba@suse.com>, linux-doc@vger.kernel.org
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>,
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org, David Sterba
 <dsterba@suse.com>
Subject: Re: [PATCH] docs: Remove remainders of reiserfs
In-Reply-To: <20250813100053.1291961-1-dsterba@suse.com>
References: <20250813100053.1291961-1-dsterba@suse.com>
Date: Mon, 18 Aug 2025 10:46:53 -0600
Message-ID: <87bjoc8tmq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Sterba <dsterba@suse.com> writes:

> Reiserfs has been removed in 6.13, there are still some mentions in the
> documentation about it and the tools. Remove those that don't seem
> relevant anymore but keep references to reiserfs' r5 hash used by some
> code.
>
> There's one change in a script scripts/selinux/install_policy.sh but it
> does not seem to be relevant either.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  Documentation/admin-guide/ext4.rst                 |  2 +-
>  Documentation/admin-guide/laptops/laptop-mode.rst  |  8 ++++----
>  .../arch/powerpc/eeh-pci-error-recovery.rst        |  1 -
>  .../translations/it_IT/process/changes.rst         | 14 --------------
>  fs/btrfs/tree-log.c                                |  2 +-
>  scripts/selinux/install_policy.sh                  |  2 +-
>  6 files changed, 7 insertions(+), 22 deletions(-)

It seems there is more that could be done here, but I have applied this
as a step forward.

Thanks,

jon
