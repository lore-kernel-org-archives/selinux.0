Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086E413230
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102977; cv=none; b=aD1Be2AbNfvH0lEetY49+6ecS+mXeq/And/2fuBv0y28G8BpYZ3AFaJuIMTMRUqD324c7u0pHrGSriUfXC17Y2AxziUxcHuZmCcvmD+CuWaXh6904G3n7xCLn11Y+kuN/PAVxC1HrxvsIdySD2a46IA6KyYFIKewnrt3KDDQUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102977; c=relaxed/simple;
	bh=3cqaN0RVyG3HcjiiZHHNoNCmf/sLe4BbiqgWeXXBljw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfJKtTWACgulkkqFvc1pUJASKwllmWlnA5kDTxXB5EwoJELG9YYcOtY3eXwCN4/zcJyeie9CL+CuWieXSqskSxJmANDtwHOadGzENgMtFDWqWaOleLDdSbTICQQZfpeb+71KGX+eHTzfHCo9DxseN31ZgNKfqyYJuzME6+YsYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=gzScdmg5; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="gzScdmg5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FhXLXNyxijV+h1h7vxqlhpC4bS3EKGB4MDBcvB4i+bY=; b=gzScdmg5TdBEZ2OsVMmzdB48q5
	anPalwyp86ujCGZZTXZNew4xlWrgO6SI0nAkBPDIHsBlFMPplcPFrmzLvNFbr1FSQfsmHF8weddlp
	lHDL+LfLeyAAlOIGluTcgY1Q5OMi9RLPYBWj9HmFiAQ160Y5LIY7bKZkqIRXKmLU+reb1p+Z74Mi5
	cYu1oEL+H1E8jtE5mTnoKm9URZ75Olw8jeOruYgfNBY3tqtjEFaZpO5HesXqjprhm9opJR7kOEdIr
	Ad6K7zkMn9xFcU42otsah7rqEjagCmPVWvhjoQfVIPHuemwIrdKWx/QCuPrdANJfIIbIsW0Ymjdhf
	IopASA/A==;
Received: from [87.95.76.183] (port=4403 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wXKFH-00000008ZHU-3THn;
	Wed, 10 Jun 2026 17:49:31 +0300
Date: Wed, 10 Jun 2026 17:49:28 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com,
	omosnace@redhat.com, netliomax25-code <netliomax25@gmail.com>
Subject: Re: [PATCH] libselinux: avoid out-of-bounds access on zero-length
 lines
Message-ID: <ail5eHKH_RrxLQKo@AA-94-54-42-0F-E2>
References: <20260610122735.5486-1-stephen.smalley.work@gmail.com>
 <aileVqzUPbBsNwlo@AA-94-54-42-0F-E2>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aileVqzUPbBsNwlo@AA-94-54-42-0F-E2>
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

On Wed, Jun 10, 2026 at 03:53:50PM +0300, Kalevi Kolttonen wrote:
> On Wed, Jun 10, 2026 at 08:27:35AM -0400, Stephen Smalley wrote:
> > -		if (buf[strlen(buf) - 1])
> > +		if (buf[0] && buf[strlen(buf) - 1])
> >  			buf[strlen(buf) - 1] = 0;
> 
> While making these changes, I would suggest always using '\0'
> instead of plain 0.

Never mind, just merge that. I will send a trivial patch later for
libselinux.

br,
KK
