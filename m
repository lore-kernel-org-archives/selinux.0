Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA430FC23
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106268; cv=none; b=cgrRKC/UhHZ/dI7t6t612cwqw4VY0lXVTZ+XeKEp7653CDlhtEtXdZA8cN9NUFVrl+r1P4fcJtKMMrJh6vJn/zyaJ8iYTbTtwkfsWNJiANAhcxst4oDjgKIaP4n1tdT90yL2COsrKT1F9XkXtRdJd6gEnAfnPY0VoX8lVG3DWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106268; c=relaxed/simple;
	bh=MWmMTXO9L+pK3AqaimEXrG1VyEyJFi5OBd+XZAzjiR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kq2+WIEenWq+HCPo8VdABGtCdXy2hAW+FHOSIjX+mWsT0CgjFTkwVIiTqwpP9+NVPfewtHUeJ5t3aT4V+f88eaFKlxfk75sEG9B1llBvaLqKNTqLJrypbexlcXDcM9PAN2jms1Mr0DgGOLqQRedRA4unPRtGPcLpBrLI+Ws93og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=yzPdx1F9; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="yzPdx1F9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4QCzmAt5mRicWK1U65qwuXi0gv0rXzoAPKvLTZHsrJE=; b=yzPdx1F9Ib/gYhMZwY+FIORHH8
	D4R6gm6C8SDBH+8GKTxmm+L9iPkBeKm1ZamrSBrGjWfq+Wl58+tbRlj+HcqCs4y2a7pkDPc9Ni1mc
	4bB3NQ4UQh7S8xdY+1o+usfPXue3ao5BdeQisfJAmvEdZziByxCmgbjAQ+gfXtODElc5TNzGmoiJR
	tZhw6yhYEkh+rntTwDL5xkkZwsuSK3rvGFLHftqlixLOQtH3ZzheRaz3GTcxHanymJyPXW2Ut4I9B
	1yKs0FHS6XvH1ylbi34gDugBn6Ym31zNR7dboIqzBUKpar9Gc6jQxqHOUFwu3wSyAzuOpcaTzd+I0
	Jqv00wJw==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11676 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wKkfI-00000004Nxb-1fFg;
	Thu, 07 May 2026 01:24:24 +0300
Date: Thu, 7 May 2026 01:24:20 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com,
	omosnace@redhat.com, paul@paul-moore.com, perfinion@gentoo.org
Subject: Re: [PATCH v3] libselinux: restorecon: revisit pinning files to
 avoid TOCTOU issues
Message-ID: <afu_lEPPseXksJ_H@14-5A-FC-31-E8-67>
References: <20260506194721.48427-2-stephen.smalley.work@gmail.com>
 <afu8EGSYh7ng9_qq@14-5A-FC-31-E8-67>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afu8EGSYh7ng9_qq@14-5A-FC-31-E8-67>
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

On Thu, May 07, 2026 at 01:09:20AM +0300, Kalevi Kolttonen wrote:
> On Wed, May 06, 2026 at 03:47:22PM -0400, Stephen Smalley wrote:
> > +static size_t walk_path_append(struct rest_state *st, const char *name)
> > +{
> > +	size_t base = st->stack[st->depth - 1].pathlen;
> > +	size_t nlen = strlen(name);
> > +	bool need_slash = (base > 0 && st->pathbuf[base - 1] != '/');
> > +	size_t total = base + (need_slash ? 1 : 0) + nlen;
> > +
> > +	if (total >= sizeof(st->pathbuf))
> > +		return (size_t)-1;
> 
> Is not size_t an unsigned type so how could returning -1 work here?

Sorry, I did not realize you could actually do this in C: size_t
being unsigned, it wraps to a large number and this is legal C even
though it looks weird.

br,
KK
