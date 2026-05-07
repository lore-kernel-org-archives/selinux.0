Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603B40DFD3
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176892; cv=none; b=pkkkr0k/VgReisQQaxiCGdj0wOjuyj7My/pWeBvjt8aluAZZT4vOdXTvYTUDgeUU3EewYh3W71T8Xtf1PVnTH7JHGeL7dSy+wmluBtkMrf503pORiIs7D+Q9hGZWLULdCpEyGspodIDLF3/4NnMkGMrTniQVdoxbMaWPTQDQqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176892; c=relaxed/simple;
	bh=rjd3yKlrWfY1B3dd8dtWz/JrgDdZaTRRg8jQsxSugVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3J1pzqNvCpaqj1FflVQ1XL38632ubbb0N0nnOw4i9YCeNGWuEFU4ImUPVnG5pyzb6QFdYUKMnW+LvmjQ6YD90eJ5MG9B3f4EF3uepVXMdn9/y6IceHUQ2kBt7YP0gmuaXpAwIzOXteAdZqWZ8L1CqITpBYUWMqv1cP3gLP7ITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=AnRh/rHL; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="AnRh/rHL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rjd3yKlrWfY1B3dd8dtWz/JrgDdZaTRRg8jQsxSugVs=; b=AnRh/rHLJ4AvWZubg4gRuMECbq
	ZweZzyzxPKivOl/uUSUOy2Z8KOJ/DX8un9AxsW48GMCm6qKfE/T+xPveWozFHV3Tn4f4NGytGQbd8
	W4WbxPCNvSD9aq7xKW3Q8agYKGue9Ash0pGDPVAeC3p8Iw+/2V1d0YAmfq2mA7QA1n+3/87+XmKXv
	2WpJKVsaVoNYqlevYomvDmUy+ckxKGCXnM9/zkaUTfJoKH6gQrlIrfLArZk3GsV6Eh1x4gQReOXnX
	9X+zRKUhZwIcEr9m4UoVELeWt2We9+iOr/em78K14TtYf9F/GEq0nTOwXozMkfCZ6uxeZsc1KN0ue
	kJncAXIg==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11289 helo=2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wL32O-00000008KUL-1LnF;
	Thu, 07 May 2026 21:01:28 +0300
Date: Thu, 7 May 2026 21:01:25 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux-list <selinux@vger.kernel.org>
Subject: Re: SELinux userspace coding style
Message-ID: <afzTdRFPLXUg1CG0@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
References: <afzMqTAtz3aHEx9f@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
 <DICN0RAL27J0.HFQFGZOGMV07@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DICN0RAL27J0.HFQFGZOGMV07@posteo.uk>
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

On Thu, May 07, 2026 at 05:57:46PM +0000, Rahul Sandhu wrote:
> Yes, this is a bit of a mess right now. We forgot to reformat all the code
> for the last release so my understanding is that it will be done for the next
> one. Until then, feel free to ignore the instructions pertaining to that part
> of the code style guide. :)

Wow, what a wonderful piece of news! I could never dream that it
would happen. It is bound to generate a huge amount of changes, but
it will be worth it.

Many thanks for this fantastic information, Rahul!

br,
KK
