Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE391AA1FA
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942194; cv=none; b=cDMEib44rLlvqAWHfEj6DN9qv8giV9j89cdkluHmDEPwLD+qaQZUCbD9X1Vsi1VWlOCshqzyFmqR9/dQvFu/tKEx+TFKP/wOVx1JFqgq591FlYSi6Bd3yKy/SA9H7MTiNJixxW5F1/yxcrCQ1kva9Wc+Vd8r4tNbhxM/weVqqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942194; c=relaxed/simple;
	bh=x7eII/WdQVK9ZMv2QLkWixvsFQOXK1BaJ7y65fR0xSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRbHAnc+vOVuRjvEt4/6pK8+AKNxgFNEpkP5O1B7YbvHJII2RJMuVduyAiwUNVHTMQ1LDNpU8sLcPEBY84Cnf9jVBQXrCzvGYdE7kLFgDVNb57u646aQBXyhVVxhUGDUT8fH86bZvgzmbCGWdcmnedp9tV0lS16+LdrwRSfFxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=cE/avOku; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="cE/avOku"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ju/54G3LzPpfxmOs549yQo5+/CkfxemswAvsdmO+2XU=;
	b=cE/avOkuCX+JJp3U1H2jF8Hw/ObhPPAiLdigVTKRGrDoYzfP0lUMhOV2ywAm73SNNsZ40l
	LrbpJFVizCBwCebXwaG55c1N/2Sv8hH8glFdhLmgWGhdNI6kP8gDtVSJsVk2lhIdr0NUdO
	Zo/ArWmfU6MzOjWcqIQNGJI6K5hlaQjhBgmbFjT6fis80TmbRYo4aSFPzQiBUZwg9GbkQ1
	KdRU5g2sxboXkTm6JZjhPo/dstj2MPXuUpx6l9HPRJANe4D+HeEs8tg/djc7ZC24nKJ+1i
	fQUu8652yTYyFy7EMbpYilDFlgxj6KJLhNfobHJm/M4cnbtcZ/ZQhqRPnDNNwg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 02/17] Makefile: use $(MAKE) to pass options
Date: Mon, 18 Nov 2024 16:02:24 +0100
Message-ID: <20241118150256.135432-3-cgoettsche@seltendoof.de>
In-Reply-To: <20241118150256.135432-1-cgoettsche@seltendoof.de>
References: <20241118150256.135432-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Pass make options, e.g. number of jobs, which allows to build multiple
test executables in a single sub-directory in parallel.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 9081406..8d6227a 100644
--- a/Makefile
+++ b/Makefile
@@ -4,14 +4,12 @@ all:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i all ; done
 
 test:
-	make -C policy load
-	make -C tests test
-	make -C policy unload
+	$(MAKE) -C policy load
+	$(MAKE) -C tests test
+	$(MAKE) -C policy unload
 
 check-syntax:
 	@./tools/check-syntax
 
 clean:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
-
-
-- 
2.45.2

