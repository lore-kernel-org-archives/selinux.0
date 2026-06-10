Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0007632B10F
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108715; cv=none; b=MCtr7SRzLCYkvCW7z3Cct3TTYWbiA4HkNdZtxEG8bBQt/agyzW0eejrYft+jL0BOCu54rXDLawTMaCaSvoHPKSe5daQbIP9YZ7memtELgEhheoIDK72eWijFbAiiw55MsX1cT8P8ByzrbYUghmESQbU3zqc8XnilMTP7YKH2VyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108715; c=relaxed/simple;
	bh=npKEVkcBRJiCTYrS4xxXanbcp/jaa5/Xe4fzet4LayU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTMBLsXDZjPzOFpf++Oxk6ZZo2HrqglfumkcWVP3cVXGvjdbIdO7KAvaRwZd8hkj6kOyxbdV24zoFq9mpEvsmLU2KcPLPDV2E9j1VpeWAOc0Xi9cxUS7kxLgDvF9bcfM3oO0Y89Qbbvlecx8Co6tkVCHF1VAp1GJDw3HnvbwXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=JnUmndt5; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="JnUmndt5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=npKEVkcBRJiCTYrS4xxXanbcp/jaa5/Xe4fzet4LayU=; b=JnUmndt5WHM8WKqM2scLfNzRSm
	ZTyxVJoDSgfy6WtEqsdJl0ENxtv4WCqAPr5w8bOAuxrncm+630397jobUyIU/oWuPkZGMbfhR/B52
	6mdahR8Ggcyr9SuPb3SZr2fzJ/UxtaI0M6NIZZb1YDiqyJNRg9ZxjSNNQ4IasoeSGWXGp+imW3sig
	xos2dhcSSArGqSvq6v9rNXP18H4NcEfsU8HtgBvJoMNqSVyqQXlpiwnUWhhR5yui6p2EmSZOU4g09
	2t23ZKzkeQSxYBFNdG2Ovho61kkBbS4O49ipJ6IdTEF3Dj/c4Q4WYNd+H6y1nB8MULYvDjSa398jd
	YHd57j4Q==;
Received: from [87.95.76.183] (port=4480 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wXLjs-00000008sE7-301W;
	Wed, 10 Jun 2026 19:25:12 +0300
Date: Wed, 10 Jun 2026 19:25:10 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Subject: Re: SELinux userspace build fails on Fedora 44
Message-ID: <aimP5q1iNXCKvxMb@AA-94-54-42-0F-E2>
References: <aimHv-w8yri0aoB_@AA-94-54-42-0F-E2>
 <87eciemkn7.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eciemkn7.fsf@redhat.com>
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

On Wed, Jun 10, 2026 at 06:21:16PM +0200, Petr Lautrbach wrote:
> Works for me:

Yes, I was foolish, the error message was quite
clear. I got confused because it used to work earlier
and I thought I had all the dependencies installed.

I just saw the git logs about the Makefile and realized
this changed recently. Sorry for the useless noise, it
works fine for me too.

br,
KK
