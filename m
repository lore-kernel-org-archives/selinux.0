Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1DF3590A9
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223869; cv=none; b=lk63HlETLVe8LuNdIGoHrOXDymDYAxRG1WcoNs+ndFbO1YCdiu+4vbF+aQDD0PX9P+atLsUfaHNYHxUXMcR2Ul5mWiKPZUBQ/B95xuz2HnL/WeIP4YPWIH+fuXKXu1HGE6vlkNYnZZ4TOZd88s3UfsLpEV2867vmc/NQp7gYnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223869; c=relaxed/simple;
	bh=GgLh5sWi3VXgYzZrX/L3VZvflDm0DkTfwHu7o1Cm7Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewo27tn2I84vuSkgu/AbXAS7bjDTdw8rnALnhXnkA/2iKZqyduJ0LwAj+UZC5napuaKfPazr6TxIJ0zGKYrfhPxz3mQUUcmcwEgG03KRDBVpzsDHwP1/AQtkbSVP5nbnKiBXQsIVBvQBx7yhm7BK8zN/pmrHnLYGsleROoDP0Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=nSd0yyfE; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="nSd0yyfE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GgLh5sWi3VXgYzZrX/L3VZvflDm0DkTfwHu7o1Cm7Ao=; b=nSd0yyfEiCpvBs7hYI/4cZeWHn
	Eo6f+k1crSBEnP/zBxwlLiB8q1Q+7AMjAU36Zk+9V/nJJaP3GXKKAcKomUtYUolZpunfkexWT+12V
	h1aj7lihk5fbV9gKvJfW4LjXfhgxN+E3vE6jwdDZ0STG97apmOreIk5Ml+mV7E651HcboQmMxjjwA
	YJHZZEBdTyqqh0Pz/fN/vZu+v+UQEAgiZYPcTkRrgYT/Z4NCtOPKJheJ5A4xvShr/RuavbXMM2o6x
	cvWZ2w6/9RoKmHkZYLe9sA09z1/25YEiwDlnOazblsP6edP3t3C+/hfbXqcPlZr0bL/AuJ8xRMQhu
	EG9nSe7A==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11368 helo=2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wLFG2-0000000AkHE-1f3i;
	Fri, 08 May 2026 10:04:22 +0300
Date: Fri, 8 May 2026 10:04:19 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] checkpolicy: replace malloc()+memset() with calloc()
Message-ID: <af2K83UGkQhVYEJz@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
References: <20260507213838.85273-1-kalevi@kolttonen.fi>
 <DICRV1S9SASW.2NQC19L5E71QA@posteo.uk>
 <af0KxyCu_hVF0EuH@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
 <af0ox3uY6I1LQSDp@2001-14bb-cc-ed64-88bf-e40e-789b-2.rev.dnainternet.fi>
 <DICX9I4V9L7C.3KJTX0MUJ9CEM@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DICX9I4V9L7C.3KJTX0MUJ9CEM@posteo.uk>
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

On Fri, May 08, 2026 at 01:59:23AM +0000, Rahul Sandhu wrote:
> That's fine. Granted, there's nothing to play that's "unsafe" about preferring
> *foo over sizeof(foo), but I understand not wanting to make loads of edits.

Thanks for understanding.

In principle you are right, but I am just afraid of missing something like
'*' in some call site and then accidentally allocating too little. The
last thing I want to do is to break something, although it will be
inevitable in life in general.

> This may be better off as something done treewide as a separate patch anyway,
> and if so something to be mentioned in the style guidelines if it is desired
> such that there is some reference of consistent enforcement.

Well, it is a matter of common sense to prefer calloc() in contexts like
these since it is only one line of code versus two using malloc()+memset().

So it is probably not worth it to single out this pattern in guidelines.

Please let me know if you are ready to accept further changes to the
file policy_define.c. I went through the file and found some miscellaneous
minor things to fix there (i.e. unneeded tests that can be safely omitted,
most importantly three missing checks for memory allocation failure, some
code simplification by preferring strcasecmp() over two strcmp() calls,
and one malloc() cast removal).

br,
KK
