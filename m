Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D522036E9
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105369; cv=none; b=NNMRo0H5rtLMiji+w1v9Nlb1kuYVbjGV+t9pc10fQCkSRRN3ixyFYNtTcQi26WCkbQOVTsGjstmeb/PsfAJ4avMU98VDaNOREgmDj2Fr4ROYO8DY/L8YZASFcWb/aEOOZSacXBXBKzJVTd8OE7fZKLBm7rIgDQFtRwqz0M+Uf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105369; c=relaxed/simple;
	bh=eG7YFJDmZO7ArQ14kaw8wkWJRN9RSVEj1beaiXlvStI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQV9nncDlcSnE80yNteZ10gYrydh9ndXkopHDd7j4XecVwBGywvq3BDtdJwww4k5oaf2hKOWuA2mGF3uam6IXBOa3g9gJJ8+/2q9qM8krtAizqi299ovu6RAD0Mr4vQny8vzrhbiCuoRgGQhYrui2zGoJQRC6SBqvxB1aWNmunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=oaS0b4Zz; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="oaS0b4Zz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ny3g9GNOGyUwXoZ6X/ZCcu3OWxHVTopJH5JbSCmokcA=; b=oaS0b4ZzcGpikXwA3xU9+uHpU8
	OvsLFC2/eGLiqSzNzw71bxrGrFN/T9WPjq+CCWTzg/3LCJKvMilZmUPC79Yleav5U9Gi3t4wchijC
	Y+QRvtJEHvkUfWASDijaLpbDw9zohpFmgHTyWZF0jxcuHzcxW7U3mLPRB1IZApXvn/7Epobrcu211
	04/jTEwxGC+hesxyJ9Fy39r25PgCAUfM9ivUwg2btSZ2T0q7f0s4pVygSHK6/50GFFyCslxOQV6Mw
	3vDDCLqo9MPmJehRajVJMt68ucvK2XljacoERZLerOtwfb1Fnl4+j4N5+Cln6IgnG2Q4NwXQB6+FD
	2jefHQ8Q==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11544 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKkQl-00000004Fly-3XoI;
	Thu, 07 May 2026 01:09:24 +0300
Date: Thu, 7 May 2026 01:09:20 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com,
	omosnace@redhat.com, paul@paul-moore.com, perfinion@gentoo.org
Subject: Re: [PATCH v3] libselinux: restorecon: revisit pinning files to
 avoid TOCTOU issues
Message-ID: <afu8EGSYh7ng9_qq@14-5A-FC-31-E8-67>
References: <20260506194721.48427-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506194721.48427-2-stephen.smalley.work@gmail.com>
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

On Wed, May 06, 2026 at 03:47:22PM -0400, Stephen Smalley wrote:
> +static size_t walk_path_append(struct rest_state *st, const char *name)
> +{
> +	size_t base = st->stack[st->depth - 1].pathlen;
> +	size_t nlen = strlen(name);
> +	bool need_slash = (base > 0 && st->pathbuf[base - 1] != '/');
> +	size_t total = base + (need_slash ? 1 : 0) + nlen;
> +
> +	if (total >= sizeof(st->pathbuf))
> +		return (size_t)-1;

Is not size_t an unsigned type so how could returning -1 work here?

br,
KK
