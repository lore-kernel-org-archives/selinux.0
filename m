Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C41EE026
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257976; cv=none; b=OvH9ZFq4rIDvBZv3iKJ7/m4uErgllYo9FIhpu/IDFu87nH5J0qCZW665UiS/pnD9NdUDAXkZ3TxKTC8bBW4xuDrj7jCnNPPr2SZLl/XQx8HsB1gf2SVPeMKInFjIB54A8/xdYZxaiosLmtKurNdUm0NxpLTnL13G0eT7BWDWGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257976; c=relaxed/simple;
	bh=0/qmHCb/DmIUdOE+NSCKf1USE/12wn7xITYwPloOo3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzm5XW/yuVJSzno+Nb1/p82AKeO3X9tM991glNOcBqhT/6NFT+QTMdFL/lhvgbScbDsuHu/hrAtxSkYKf/sHO8l7PRH5jHunFbKGaMONVIx6v3dThuJFGTannB1RFU9KiYst7uyITJcvUBMMd/4Zsg0+DGmSclhbh20v+w45cnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=m+AJRkO1; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="m+AJRkO1"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257572;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5j/ooeukgKd26zwX8yrYkx5Hqd92cEXz0P41zNMtbI=;
	b=m+AJRkO14xAwfgNmyZZEXnW5awIfkVhPxBAvwkNw6JphEeO67e1NjnO3YHAV+kS+ztc4O+
	2ChUkx3NyAdmQozMeWSBUCtJilyv6fIyRlTFq/rUq/SOP9M5hKykujHG21BC42k+h+5rc5
	UupNDi+QB0GR38juEbmzdizzBP3d2Gjew6VxrnemqCBIPKyplj4gNrlyu+6P1PIkJvJORE
	Wt9ObKKRHi2ZxXiUznZdphVardZpWuHz85G0lsqA30iNAas+IEvBTkXOUGh1ifa8NzJOWz
	KOorLr0KHgrzj6WYfhYW9RWr59LSXJ1GWJOL/dIJU8ZWXnF4l4Vsjxxoea+57w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 02/17] Makefile: use $(MAKE) to pass options
Date: Tue,  7 Jan 2025 14:45:50 +0100
Message-ID: <20250107134606.37260-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
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
2.47.1

