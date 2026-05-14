Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DDE390200
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792026; cv=none; b=X1pY1UZida/tvzkBpzspX8DKqnp2fHvJPSnTupWBgvCvwyWIzaw5iBfcnwQCPnZrs1vFC/Q4tPve+QmM7eFkHDS+WAOcE8dZluM3cZ/e2U/Qk6FUGcC0aKZ8+AtAs5ecoDKrmH3GDBPgRQuMGrkQpxxinwJthNI0awoRTDeY5rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792026; c=relaxed/simple;
	bh=vBJK8jt1I7p/Ft9VcAz5py8P1pGJn8Q1PhdGInLExMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmnla6YRnM2ohZlKeL9/jt8bZwrmet0JFBl+Uhfvo03ITIpCLTM8dxqwIE29GvuxLNejSufMAtx2NNQuggU6vSV5DRfowTN7FDwKZYbbrELhBaStM8nRfv3uWvIvS+hmDulBkX3VgnFqQLo1Me+VsDAZAT9/EL0psZozZvqnMD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=EyxhT3Gv; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="EyxhT3Gv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t/8SKT1+xMM/tWRJJEEWhYwrfllsugVjWrXrtbntDok=; b=EyxhT3GveoHljRlNyIoumsCzQO
	tEogiuNQZ50LkU30S/kZywiKv3CvA8JUwRnQPuwHw0vt3iibw31MnlxyhDr9AY0wle7/PShJcWp4u
	oVvMyMYK3jiG2CdBWXNVXIfh+i63MuicPF40ypcntqikfPdBFFo1hEQTNesxw/TyJo+maF5NEjTRT
	bLqyHTImDZfmjSnBHxszdVR3xyu3jMP2r3zSYhg3VltkTucKm8y7l0KrAPRtnfZIvc4BVNw/elu4b
	uQKEKszFnTNBU8s5eyfXeg2c1orAXF15AfUz2NOvk6L52+z0X0W/cdIhfPG5hSFAQ1QqZjWpNerpJ
	9kpVQ1GQ==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11752 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wNd3z-0000000E3az-2Hgq;
	Thu, 14 May 2026 23:53:42 +0300
Date: Thu, 14 May 2026 23:53:40 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH v2] libsemanage: make expand-check a proper boolean option
Message-ID: <agY2VOjmO3Ct9Pda@14-5A-FC-31-E8-67>
References: <20260506195834.19-1-kalevi@kolttonen.fi>
 <CAP+JOzQt9MW2W_6KZOt3_7OEwd2o+7pDszpcKt=cwGu1GoNGFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP+JOzQt9MW2W_6KZOt3_7OEwd2o+7pDszpcKt=cwGu1GoNGFQ@mail.gmail.com>
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

On Thu, May 14, 2026 at 03:30:51PM -0400, James Carter wrote:
> > +                               yyerror("expand-check can only be 'true' or 'false'");
> 
> 0 and 1 are still acceptable, so the error message should reflect that.

Updated.

> Also, you need to update man/man5/semanage.conf.5 to reflect that true
> and false are acceptable values (along with 0 and 1).

Updated. I will send fixed v3 now.

br,
KK
