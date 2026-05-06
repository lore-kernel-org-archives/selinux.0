Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393AD31A81C
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090858; cv=none; b=bAdfEMJZpLGGJwysCa58g8Z8h0IFMfaDLGI/moOYtcCWEbjvyd6GEyPwr4jEBKurql7CO/wOfIuT767+ZuEAnYSaCXlg7wepa37rh5qv4AjtC6CHsScNCYGm3FUCYZnjrE7Vwq6zDQS9Ml3B+v+5jaOMULzzwirkSU8EHthIm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090858; c=relaxed/simple;
	bh=FD89W0tw9S9nhZ8GPROr5BO+TUuyYBS+B3CqV+o40Pg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+gJ0JR67oT4s97cFWhY1s/kXP1v0Cj48uBKksqNJNFcx2qZwQBLjjkJJ8Fkw9Fk00Nbt3SuYXn5CVmVHeyCoVAGcx71iMJeGxDlVplM6QZHrQGkZFhGAuBdDQrX5XTlxFOIhTDgPOOgJHCm8BjmHOeEA97+1f9Ekci8Xo5v9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=dQEu/5OG; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="dQEu/5OG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FD89W0tw9S9nhZ8GPROr5BO+TUuyYBS+B3CqV+o40Pg=; b=dQEu/5OGGubXCnyh1bVthfzh+z
	BgxSb0p/7ARBSsg2L6LnPP4GjOcJg2SAGMJBOEoUvkLe0+nbhlW9uYJoANuEG0+PwCR0BY4/aFKDS
	WcgzpsK/EAdOTXNE6ZOv7EU6vHd9SuEU8Vc1qLSgrEnUqsFwLutwE+Q8OgRju1B2FKyMHV7aMilhx
	sm8PnfUmJ+ZNTHvnNwehLd+Wq6n1sodP3o3v3vir15XCfxiJuL0DYA4lD9rW36r/07sOIIIeO2z7R
	0dqpMsv1ouF0vbO2Y5dF9eg+Sj0sn7ztDtiayt1cJL9swAGBys4OuO7plg4cJQAF3U0dSY08jIg0F
	SMtTTM5w==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11544 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKgek-00000002moV-0uRw
	for selinux@vger.kernel.org;
	Wed, 06 May 2026 21:07:34 +0300
Date: Wed, 6 May 2026 21:07:32 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Subject: Re: [PATCH] libsemanage: use 'bool' for boolean options
Message-ID: <afuDZJgFhEZrkdlJ@14-5A-FC-31-E8-67>
References: <20260506163042.83573-1-kalevi@kolttonen.fi>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506163042.83573-1-kalevi@kolttonen.fi>
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

On Wed, May 06, 2026 at 07:30:42PM +0300, Kalevi Kolttonen wrote:
> Use 'bool' for boolean options. Check strdup() failures.
> Add explicit 'conf->disable_genhomedircon = false' default
> initialization.

My apologies, I blew it again, forgot '-s' to git commit. Have
resent the patch with Signed-off-by added.

br,
KK
