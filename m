Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C992EEE9D
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781660660; cv=none; b=ranGnQ6cFrLyhljKV8RbT+VHcRGcsjzpweJXY6o2v8aW3hDyYol2zqTnHuzeLS2xZYRsLk3mMBYqtgNnoyblEaSho/b7thtIojhFdfXdcpB7csDVmH2SBNCt3kpBQ++xcAYH4YN5OTIijX7HLbV/6xDXZuQFL47vQGN+WvL2+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781660660; c=relaxed/simple;
	bh=pPnpHdLmOpXyY2gSj2iuxObv7Jc3inJ6z0hzSdIrVDI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FkTzjsgzF6b5JeoYteRQZYUONQBacEgrOYueTLyU1vdFTuaxmZ8V/w3m+y6GNW9zkkKRVSB0uL+/MgZQavEsfblDOd8BF23CRRw3kTWjfQtHGbrJ39oUIJsGe0LNzl/bx/X0xB+o4EdmTjAOXMCXTHCfgLoVZaJ8eagj1hs+lhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=mja6TZve; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="mja6TZve"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pPnpHdLmOpXyY2gSj2iuxObv7Jc3inJ6z0hzSdIrVDI=; b=mja6TZveybihVzAJMKrfNmI/Yp
	rO1i//Qb7HHU6otdwyRLlqCB+muLr25kvqxL59jYuy/iMqaDnMb6Gncp62axCEExit+udYL89ZJp/
	HaEGRExTY2GmtRO11bsmW9iGejPj/lKZ2F3EPYxGyU4skI9p2aFwzlkSRYeePlaCPP6NdETex5rM/
	4jm0PU95P2HE1iNslWQLcplIXLdTwiotKsQobc4f/76NAWpC+h7m6pvgqwwPpT6pTOfb2OpqvYDgi
	Av6EOEOZErsMD6ZPn7uuUqIx6wVNEAQCjS1mDDZ26WiHRayH2nVdSNw+DpALGRsV0cQTVR+wAzRxG
	4lPvKLxQ==;
Received: from [87.95.76.183] (port=4599 helo=AA-94-54-42-0F-E2)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wZfKE-00000001wCf-2ALI
	for selinux@vger.kernel.org;
	Wed, 17 Jun 2026 04:44:16 +0300
Date: Wed, 17 Jun 2026 04:44:14 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Subject: SELinux kernel code and clang-format
Message-ID: <ajH77uobc9rUlhae@AA-94-54-42-0F-E2>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello!

I just sent a trivial patch to selinux/ss/services.c.

While at it, I ran clang-format to make sure my changes
were in harmony with the coding standard. To my surprise,
clang-format-17 made many changes and I had to git restore
the file.

SELinux userspace code just went through a major overhaul
with clang-format reformatting. Should we do the same to
the kernel code too?

br,
KK
