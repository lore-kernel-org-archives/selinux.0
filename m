Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0413232B116
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423698; cv=none; b=Qq3rcediJ5gKeW1KUFIPj9E6fOokIr67bvceTH5y2fVhKQhlNje2QcbOMi55xwIO61IbNmlF2Pys9qV/PuedL8JkuD9J26hABGZtwBmi/DpkN275rPV47fyVjnH3RGfadFFrzIGTycZp3AnaJaLQvsvB03EJAiTf4YQCQU/kM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423698; c=relaxed/simple;
	bh=xPIyp8yMMbTvKMCswtlr8O0J0cidSHHTKhAPyhpP+28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJJXsXLk4eC0dRTDi+p4q9An2IM8caHmtUvmzXiZ5UhPCIgqFDjhbUh/gMJfSMUhj6RYD1RNir6g/ZGk2EXy1l+FHy7aDaW0RNT4QIVjFwrVZGw1Rbpv7Gq9V+6jIjkJcVRkqle8vNdTFNoCD/Ay7dWuuD/efoQTQKcnhOwtxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=QGSdzDEG; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="QGSdzDEG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xPIyp8yMMbTvKMCswtlr8O0J0cidSHHTKhAPyhpP+28=; b=QGSdzDEGkQj0pOCh8GRNfrPWXW
	cDWYAM6TmMjiNwGzpmCKmY39Wx7uuSFD4r3EcVFESDSwjA/09XjPt8sWwxwIBbMofT4saOd/gSYJj
	LgcWEFX5FYLmOGPtgazyM+rlwUeSF6X2Qz91oa2KoiAOVLFwKDVLDmbtwASMgBi/dWIZPZw86bBcE
	PSIUscE08XYZ+EqaqKt4wOr8/L/nYBy1x/t3JYDe2WOcBaoYQ0IrNAdyWBRZqATts2yDeiwTbEfTK
	tvrUdjuJHuKM9FZrhz3qsQEluoiXJHoDeEw8V+LfiXZ+bhr1j6ZA4Tez2tZuvv5HgcoNDuDw0SSYR
	mTxc1wAw==;
Received: from [87.95.68.238] (port=36895 helo=AA-94-54-42-0F-E2.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wpRzF-00000007j1b-2Bd1;
	Thu, 30 Jul 2026 17:43:52 +0300
Date: Thu, 30 Jul 2026 17:43:50 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Subject: Re: [PATCH v2] libselinux: prevent ReDoS in file context regex
 matching
Message-ID: <amtjJhSP2HxalEj9@AA-94-54-42-0F-E2.local>
References: <20260729131413.1390890-1-pmatyas@redhat.com>
 <20260730085713.1484927-1-pmatyas@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730085713.1484927-1-pmatyas@redhat.com>
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

On Thu, Jul 30, 2026 at 10:57:13AM +0200, Petr Matyas wrote:
> The vulnerability was reproduced and confirmed fixed on:
> - RHIVOS 2.0 / aarch64
> - RHEL 10.3 / x86_64
> - Fedora 44 / x86_64

RHEL 10.3? Did you mean 10.2? I got RHEL 10 VM and
there is no upgrade path to 10.3.

br,
KK
