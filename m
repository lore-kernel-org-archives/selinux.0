Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66C3A6F07
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699555; cv=none; b=d0/XWoNVd8OZ1XzhASqlqj5CTJu+vWsQT0MS2VSbt9bTgli4B1tapWNdZGwgEPuRdbNvEpFhD25DGUuqubXbvV+f6KG3DqHzoTPEur9D5vWGoOQjo1H7wizX+JVJJiPygUqLkRzmj0fFRzSp7MoMOkv7fWtjCXIfZKH0nR/8Qm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699555; c=relaxed/simple;
	bh=a70RqtMdjUSRKg+n8oNDolyWGNkiOXrdgu/0AuA8Iyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWSi11EA4/k45Hh+e4DHkfu6E9wfuG0H2bOxiGNLZ4kHzdNJINErYyZR3dA/uZ5oV309fEgjwX7Z4hXEu5ywrq/WFCpvBP7mBxDWo8uc10Jy/3wRWRTfmw/yR/yd+T0msMnM0TfRULbCqE/WlYwtmN+uXDhjpyDx3f1Rru578Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=Z4MAZbXA; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="Z4MAZbXA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sZZC+ACMeAMx1CQVFm3nmYkGlhdNbBMxfou6GHfuY0w=; b=Z4MAZbXAeJyeYTDsvJl0VQ8sMW
	jvd3WKlPZESee0PfyJfKwUYcD9T443BY4CEPF8J5AG9k4y+BjOc3HcdlLj3uYlYGVGKfT72LPdoQP
	kjeHEw8LT2ebv1auiZVdxAanm9PKWS3okVDS5o/LhlTVG7bRilpSkpP5AFGC3v2tQcS66w/7XYUF6
	pFJDeHzFb7btLbR06BFpGtBswWttczOGfx5AvZNvzkk3CMAcWaHTTuDmnjC5RKZN7cNRGkmht2F/f
	8wmNrY7SvJEFloPK/t1bMeIoMVQTxyZnzBiSzr4fxtQhmDmD3uKurhC2hqS9LiBRZau2PycUJFxJZ
	zNrasKAA==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11315 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wNF0M-00000009ISl-0qJS;
	Wed, 13 May 2026 22:12:24 +0300
Date: Wed, 13 May 2026 22:12:23 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH v2] checkpolicy: use calloc() so no need to do memset()
Message-ID: <agTNF5HrIELW1izW@14-5A-FC-31-E8-67>
References: <20260501230959.65581-1-kalevi@kolttonen.fi>
 <CAP+JOzTZHui1Ce-r34YOrjbDOABL=h4YMOrzJUqWxaEnmE3eYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP+JOzTZHui1Ce-r34YOrjbDOABL=h4YMOrzJUqWxaEnmE3eYg@mail.gmail.com>
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

On Wed, May 13, 2026 at 02:44:42PM -0400, James Carter wrote:
> p_types.nprim is the number of types, so that is the value that should
> be used as the number of elements rather than 1.

Yes, thanks, it is cleaner that way. I will send fixed v3. 

br,
KK
