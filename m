Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06393176FD
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108337; cv=none; b=eZvaHUOgdfdz8z+Wnm/H4sB9lpPoaHpeJQKs5HhTjcPSIATMleTkHk01rLTNqrIVasGbIl59ms4iUFbHmkFvoADj6SH8qtd1Rarmj5xBt3K7qEZlaW5kib27GdJCOys2pjKZ8AtxyDW/+HE/RTSvaj5Rujuqe2ySpxzBMUdXBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108337; c=relaxed/simple;
	bh=N426HyQXk9lTb3DcIFyr1toUlaGL7E8f0FUGdBMOctk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hij88mQPgJDUwV4B9ZbBNZyR5NilsePnjMMu1mNm1FZKNsdspfcYpE2Z9lNA2WYAbG84M2iUIAFKzksFqZ5tu/C/CE5qKpCqOTW1W5sPLolSJF6q1hbgM4H1tKm+JXD3GNYM1705XbS4CUwM0gHnf4D/M55uE+jisd0lb1Sj+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=Gl6rHe8g; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="Gl6rHe8g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sFNNdG4HRvyVCKxBmMl1ZALEIMCLvAUEWhOLM3qkOx4=; b=Gl6rHe8ghrbqm3aZIuIpfOwTXX
	V3C6Bgp9jV8z/9Tc9GkBdAGlxOfXQPzs4/7wE6/0BQpPJ0Fl+U1R/ZVG5Qlxub1w38bJENURpJoZU
	TC9Od4asUqwlH4xTvSfrmeeyxtA4B0L1rLrbbvdX2BdKb3qVjGAVJUu3DVE69g1YuZ6FsUu706TDH
	kl4BWMmI5xg/6crwXzsoE+am4ONvvB4qFcM175r3PwwkgBOeKoumsIX9LRyaaTkYe58+FAcOLfCEp
	flKq+9XGlV3AWjKurWqEu+yIy5Q64j4ooQCtzOjisVSyIKDmlxineCdnGSNDvGFJn6IJbC/G6SFGV
	U3qM7Y1w==;
Received: from [87.95.76.183] (port=4416 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wXLdm-00000008r6t-1uLQ
	for selinux@vger.kernel.org;
	Wed, 10 Jun 2026 19:18:53 +0300
Date: Wed, 10 Jun 2026 19:18:51 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Subject: Re: SELinux userspace build fails on Fedora 44
Message-ID: <aimOa0nIe8uUYY6s@AA-94-54-42-0F-E2>
References: <aimHv-w8yri0aoB_@AA-94-54-42-0F-E2>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aimHv-w8yri0aoB_@AA-94-54-42-0F-E2>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Wed, Jun 10, 2026 at 06:50:23PM +0300, Kalevi Kolttonen wrote:
> python3 -m build --no-isolation --wheel .
> /usr/sbin/python3: No module named build
> make[2]: *** [Makefile:17: python-build] Error 1
> 
> Fedora 44 has:
> 
> Name        : python3
> Version     : 3.14.5
> Release     : 1.fc44
> 
> How we do fix this?

Aargh, it should have been obvious! I just needed
python3-build package like it says in README.md.

I wonder how it worked before...

br,
KK
