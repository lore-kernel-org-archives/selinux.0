Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC9397E9D
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239198; cv=none; b=GgXNPrJBO/nVshBXcarX8cDyU5BRjf6zngzGVnppjWIvIvXoNvImUXbpodvL+ALXWxnSnL0jQc3XJOGJmL8P4pRLJFOjioTS8vxCaVppE+cC0vNCycs4rgQGZNDIwKYCawofj8VGIVfeUgSrl+bbWEGrpbbD3Qoelka4bqP0Dg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239198; c=relaxed/simple;
	bh=v50hzPFibZ14TB2WdC7fmauJrMVQg1aVcktbwwXTXkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYnN24ROqulOg7pfLycIqVcS5dF1b8B0cPL3LIAOqDRqr4CictryxFF20dNP6DNAQf/Gdyc2W9sL0khixdRJ25Ee5uAiSx1+dUxOfWm+b+JkIZnKkv0mowX9i5cabCNsmuPkJNhiZRsU158WNy6XjSlFkBEylxy4BvZiLkl1OEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=SjRtGiyL; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="SjRtGiyL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v50hzPFibZ14TB2WdC7fmauJrMVQg1aVcktbwwXTXkE=; b=SjRtGiyLygK2T6RmOeRlhzyWir
	IoPTOzUY5JCbhfnBj6A9RRYgI3REAcEZZau41dw+dtJQzbQEtnCC55iarYe1RP18QPfnW2oHvurFV
	GriO9G6GctyaHP9DxIqL0qeYT+sbcxxQ/Yicd0Mn+JGBBZ0DYFLsGbCNkOgABnXLr2LhaNUr0ylzd
	lOGGWvDLCk6gH0JWoMHnxbCU+nmv9EbWk00z26fs5GB0Nvpml4s6XKN+JYKxfcBWyv5C5Rs0fHAnJ
	kIacRLCHBVL/rfzaqEFhP4CQtku5Q0j5e31DnxEwB4G03xP3URV0kgvDXN7Wg+ntJ8VOtbll6ALfK
	Oz+S4gPg==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11504 helo=2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wLJFJ-0000000BaoU-17Qp;
	Fri, 08 May 2026 14:19:52 +0300
Date: Fri, 8 May 2026 14:19:50 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] checkpolicy: replace malloc()+memset() with calloc()
Message-ID: <af3G1iurbABukq3H@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
References: <20260507213838.85273-1-kalevi@kolttonen.fi>
 <DICRV1S9SASW.2NQC19L5E71QA@posteo.uk>
 <af0KxyCu_hVF0EuH@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
 <af0ox3uY6I1LQSDp@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
 <DICX9I4V9L7C.3KJTX0MUJ9CEM@posteo.uk>
 <af2K83UGkQhVYEJz@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
 <DID8QJHTR64F.1P933P9Z03623@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DID8QJHTR64F.1P933P9Z03623@posteo.uk>
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

On Fri, May 08, 2026 at 10:58:50AM +0000, Rahul Sandhu wrote:
> If you're making a number of refactors, you might prefer to send a patch series
> for them given that they seem to be related.

The common feature of my forthcoming patches is that all of them
are minor fixes that are safe to apply without fearing regressions,
but I can certainly split the changes to be a series. I just need
to base the patches on my previous branch with those calloc() changes
and not the main branch.

br,
KK
