Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B811F2C34
	for <selinux@vger.kernel.org>; Tue, 13 May 2025 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747172209; cv=none; b=ABUA0/Ehdfu5p7l2TICqtsDkpZMDAiZxq+YmFTTKzEWOhI/vvO44+1Qvcv2u7zBl5g0ZbvHRj15VHT4KT8pRmgC9a9w/Hsb9mssg1PM48uBfw1OMQDZeDeFD8ZBnaVkcByYR89V4FmTDYdkaFJSM97CuFbFdnSGzY16wycWm6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747172209; c=relaxed/simple;
	bh=XDiuxXjqrHQS2/+O5bieevY/YXKmAnfo9P42Zs6P2DA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t4IHjPa0ul2ODA25B16vhktPS63j50BwyTFo5MS/ocb6aHl4rmAJglDy/H4MTVazWQI9zCGFAjLbQbUmoslo+47E93u9IYKrlIPF6hevs+XEjuvOQOdan1MFEccnf04QsHoy6scfynoI3ntgo/F7oLcv4wI1KDQe1Q+3PntBZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=tqgQyatu; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="tqgQyatu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XDiuxXjqrHQS2/+O5bieevY/YXKmAnfo9P42Zs6P2DA=; b=tqgQyatuHY71QsOFS3K43Z0H4T
	BAAUFD/Lom8urovTTXeMCueQDdS4iFz15JEqV1d1CS79vlZ6GHLZ8lC8Q1Zrj8os5mxD+rwesSBvn
	W1mqIZwwFj4FuyDrwq+LzLSne0D74Wj4XqJ1LbaI6GE7TwUj3wDL2VheYcolR6Fg1Nj+QYuM8CBFD
	DoBTt0jmFOhxAHfqxyWBjE6ke+wf2JqvnUupyShHfCabz5RWhoSTsFKt11Lf/Nrjov8K2T2Qfv+Pz
	V4Yj0iHXL/8Uo37bMB/Rz6au1yt0WS19GgyJsV+eX6Lt+U3IF/5L5pwXgntWRhAWxwizF17kU0a9R
	obb0DVRg==;
Received: from 87-95-117-63.bb.dnainternet.fi ([87.95.117.63]:23862 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uExIr-0000000G3iG-28BP
	for selinux@vger.kernel.org;
	Wed, 14 May 2025 00:36:45 +0300
Date: Wed, 14 May 2025 00:36:43 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux-list <selinux@vger.kernel.org>
Subject: Changing return type from 'int' to 'void'
Message-ID: <aCO7a4yriVmD0P9l@14-5A-FC-31-E8-67>
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

I was just going through the file linux/security/security.c.

Could the function early_security_init(void) return void
instead of int?

After all, it always returns 0 and the only call site
in init/main.c does not care about the return value.

The same question applies to security_init(void) too.

br,
KK
