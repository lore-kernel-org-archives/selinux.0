Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4E221548
	for <selinux@vger.kernel.org>; Wed, 14 May 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258829; cv=none; b=QK5Ff+h4vRKXcQMwufl3mQx3j3DphkUzoRmATgaWZmbpjGonda4EDgRsmnjyvKMGlK1UeLB6bHw6SWr0XAsvb5RGMEMaDVBFi2CJzYoska83Rcb/qmdypTjtLsucZmarCgfwrJ4aOQ5fM4uDULEuHZqqgRDVwTJvObYKc+zIs3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258829; c=relaxed/simple;
	bh=rIDBuo4iqnCdpR6LrhzrzWsGZjobTnoDGWq2MogPsrA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aAMqAfJHOPibo/+K9yClbqly6iMRgrwqyamp6e+FS/5F2xJAf4DOJ+vSAHfb/zOx4cWSZ9POpTkxyn07mRE5iUGBXF8jX2dc71OobsILRcvulM28n1nn43tjDe/8y492XIB6M+b6ixdstuGOX85Vn8nGGotAf+m+KGlhIaGpLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=VGhEk2PA; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="VGhEk2PA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:To:
	From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vOJ4EbMgcHyrILV8LwQpITt2D27JJQyC+I6D0knT87c=; b=VGhEk2PAcclT/hes4uX5kKDS4Z
	1O5P5XyDAE5Bv6++74siN3arqF+HhJ+ztVHk/O8cVECqszZ6TwYTINW5cM6K3W0sHZ5NVL7JcszGD
	yES4vg4lcsHT9P6o4QK5ilPOQbva7gdXbmSi49L/GkzSGAu+DrKW3vrzGDARR3ex8JZXIMldcv/yx
	6Q6wjiUywaqFkI6Z5NnUfjcBPAGapw5iO3LyzJCBzGMAGggYv4ArIg7QpWw71Er9zlYNBfi572I1m
	994sjcAZUhy+sqhvvFqJlp56yuakqhl2njHgIIl4pybXZ6l7btC30NrdPIPrfoln+Pdwm2BvKZCrG
	D7T5u0HQ==;
Received: from 87-95-116-80.bb.dnainternet.fi ([87.95.116.80]:11709 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1uFJpm-000000037l1-3vmn
	for selinux@vger.kernel.org;
	Thu, 15 May 2025 00:40:16 +0300
Date: Thu, 15 May 2025 00:40:06 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux-list <selinux@vger.kernel.org>
Subject: [PATCH] userspace: Make git ignore ctags output file called 'tags'
Message-ID: <aCUNtrN_-RGv7PNq@14-5A-FC-31-E8-67>
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

From a442c879df2db6aa8ec026af236029c66f8c97bc Mon Sep 17 00:00:00 2001
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
Date: Thu, 15 May 2025 00:34:34 +0300
Subject: [PATCH] Make git ignore ctags output file called 'tags'

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 6ff61265..30290c41 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,6 +20,7 @@
 *.pyc
 *.pyo
 cscope.*
+tags
 .#*
 \#*
 .*.swp
-- 
2.49.0

