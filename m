Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8630E834
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777679040; cv=none; b=jbZ7RE0kTVfQ75JOv/V2NnMiYQgvBbk/9gKO0k6uwz2c8ocn7ZSRk/qHET12aQ7t2+NH2MqfMmrms1DSCuVZqc+iq94WrgH8y6K44dikctgjMrF4jhVSPrl8RUqgXoaXOla4TYPn1gzPQwQQAb9j9AvgLbd7vJqSWVL9wRBzGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777679040; c=relaxed/simple;
	bh=7KmIKNRqMDttW4grmPTzHF8oaPe63b143Ind7z1orZQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rShogOKxd6yJmgQOBdVONZKQy6izPu9GkVNz4yNMR634KkvvDn/9tqdZCL0Om0v3kiHLdhI56y0O1giNGyWZN3NxzqzI7wyeqYh5OVMGkHdp4Hy1dRVa2SBNZgVtytLfDYLnKdy3lUhL9nlDywNsxbgyZbZEL7xMdO1pKKkpi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=UTEKq81x; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="UTEKq81x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3FEyGqvUrifD/8cSqg8wzAqNxaH9mRyf57iR/ACEafU=; b=UTEKq81x4HYlKnAUyQOCoBieEQ
	5i0176sN0GTDDFV8QCZMRtyNoQscMCpRnnGsVrVxAFO+NcH4VEdB4zgDw6TWgg2/V+6NaLgWF8Pry
	4w8UcIqnhHljMF9KmS1HzcQoRLzvne50iVNdbuA5GKDQSXcXKtLwDNG4Ic4+Mx4xXMpsMBHzovqKL
	rQNa9ePoGXCyqQfJKMo4H+AIIDWwZh4suy4gSmE1U9swVUpzJQeao52X/KovBG291w2PivxKOa36D
	YAqw1yV40fOPdNIqA+LxZTuycEavbHOO5X+d8iMHPK654NRPEhjEJOqSX7Pb28aD8s3GHXglXeMoD
	7Do0Z23Q==;
Received: from 37-33-160-15.bb.dnainternet.fi ([37.33.160.15]:53640 helo=2001-14bb-678-1e30-88bf-e40e-789b-2.rev.dnainternet.fi)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wIxWV-0000000Dbn2-4AjE
	for selinux@vger.kernel.org;
	Sat, 02 May 2026 02:43:55 +0300
Date: Sat, 2 May 2026 02:43:53 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Subject: Re: [PATCH] checkpolicy: use calloc() so no need to do memset()
 afterwards
Message-ID: <afU6uezlxzYv7SH1@2001-14bb-678-1e30-88bf-e40e-789b-2.rev.dnainternet.fi>
References: <20260501221751.49065-1-kalevi@kolttonen.fi>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501221751.49065-1-kalevi@kolttonen.fi>
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

On Sat, May 02, 2026 at 01:17:51AM +0300, Kalevi Kolttonen wrote:
> -	type_rules = malloc(sizeof(struct avtab_node) * policydb.p_types.nprim);
> +	type_rules = calloc(sizeof(struct avtab_node) * policydb.p_types.nprim);

Please ignore this trash and my other message too. I did
not remember that calloc()'s signature differs from malloc()'s.

I just sent v2 combining these two patches into one, with the
correct calloc() signature.

br,
KK
