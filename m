Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F372223DC4
	for <selinux@vger.kernel.org>; Fri, 30 May 2025 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748606062; cv=none; b=lXTs0TMbIEhYqoQzpJsvUrsTt8KD+PJcfKqOy/XooEFq6tjRggf3YkjEv5gqI6t88EcurT/5LaZeiR7vsYXvoNT1aiVu3stvAwRwZeb+3q28D+f6wVLjvzV1Pii186j2lLLOiuvFCSuqDVGVDWngWRmGxZFzD+5KTgloxeIeFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748606062; c=relaxed/simple;
	bh=fqxVsYD0t/8945aFzHnlCvFGopLEFyqerYECjEJeWF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9qLR7wI2W8jGBdBX7pTseH84HpxetlME8ScbQ49L6DSt/Z2ajKeEFj4+vehSMYSDOPaaeunIZoa+zHc8rZCJmXyteydVVsWNVlmAaKQ+W8+q4EioIX0yuu2rATRDrdKT3lVbmDZ9se1t3KMlxQPtlH6cmSCRSjgVYzJXRzIvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=kbalQXul; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="kbalQXul"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1748605727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogR2xq2CGVWxa8jl2ORNRVEouhNzt0ywQf3GIozitZE=;
	b=kbalQXuloayAENo2svLH+vS/oBLUtyVyA8TSqf6cMZSrBRg7dySI+JMSS22vtyxzbp3CqD
	Ko6o1cQ6QHFX21Y+ZUow7DxjdwPSJxxC3Nl807tWqUyT6/MHIP5XOnrQFtYXwKKF+74w9Q
	AfI5JQNbQzaiVSQXD67vHxscAy4d3NrN/vu/oSRM/ewWTCaCkpac8/n9ltGPKtLV/7qG7Y
	9h285ziWP+9sYEXFsUtcQdGo6/GtJjDEBxFU5Zvo3Br72M3TmLGVpqiiw8olbFaw1yY8HG
	DlonjmmBDD3EJ4wjWQhEnS2PLLckvke3Hwg3ZLQ59W4N0V/I5UgTAJH0dTzwdg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/4] secilc/test: add test for wildcard netifcon statement
Date: Fri, 30 May 2025 13:48:36 +0200
Message-ID: <20250530114836.30643-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250530114836.30643-1-cgoettsche@seltendoof.de>
References: <20250530114836.30643-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/test/policy.cil | 1 +
 1 file changed, 1 insertion(+)

diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index d0d52d0d..9761fb4f 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -288,6 +288,7 @@
 	(portcon sctp (1024 1035) system_u_bin_t_l2h)
 	(genfscon - "/usr/bin" system_u_bin_t_l2h)
 	(netifcon eth0 system_u_bin_t_l2h system_u_bin_t_l2h) ;different contexts?
+	(netifcon podman* system_u_bin_t_l2h system_u_bin_t_l2h)
 	(fsuse xattr ext3 system_u_bin_t_l2h)
 	
 	; XEN
-- 
2.49.0

