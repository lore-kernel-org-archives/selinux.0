Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C701C3052
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942199; cv=none; b=qfIkhVadFJuOGsD7la/2m8VvbJM6EA5EUMcNBKSs0VgURE4z4Axo/VBvqCb0iGQnUdtDowYqXO6SFW3XavOw9YtJwFinPhkzaepblb3tZHCFI/RVQ0UdW5D+T7GYCAI1kvtdNjGRInrEsNnT4n85IOYCiw5onANNulZfggFivXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942199; c=relaxed/simple;
	bh=nd5MJkWG/ikwWX3ChVFMCu5V9TU6m3Gt5ZpFcGzBShg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRJSUDEYfe52lzHlbVGJ0IEmkXpuAbB9qNGXx1ToL2XTLVV9nnYU0GkTkUkzqm5ynubldjwBSskSqLksvfHVLtO14uYl4SEal/T2u0EE3nUVy3hYLeREyqQR2Kd09DMo5RcsUGhJimhnG/VUPgZc+gS5uFAuvjuE39VYRcx3wrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=HmT+bwEK; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="HmT+bwEK"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9Heze5wg91yc7ytY0iZxudFtT95Ni6upeAMd+kfodM=;
	b=HmT+bwEKr2J9SqLR+IivO8pa4zoE3gt8WNh6CuWNjREK/o8MrLgs8WJBbH+vxoDrDKxyLu
	FHzsK/27lkTMolEGgpk6hz/kM4MeFDl8kc94Yx+3Dm1A/BYpw8u3KfKzti/hjaDzWrwlMW
	xBRKkdEbP6OwC+cYry2YVyvb0OUTxgQd2B+mOdtTqbJfrB/DFtGCmaaRXeFcuHcY6O7EE9
	5jf/Nb61m7azidKCogheJCpL+jCWBugiYfexxadZOhkazulbMdyU+OCB0JQkLmCgFJMRck
	aoCfncvVOJPvRBuaizQbrgggSTzWJhN0BsucLFfEdWt0LHQbUgT4ZRgcTkhcxg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 16/17] tests: fail on compiler warnings and enable Wextra
Date: Mon, 18 Nov 2024 16:02:38 +0100
Message-ID: <20241118150256.135432-17-cgoettsche@seltendoof.de>
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

Warnings issued by -Wall and -Wextra most of the time point to actual
issues in the code.  Treat the as error, so the resulting test run
failure will be investigated and the issue handled.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index 35bb358..6af7651 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -6,7 +6,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 SELINUXFS ?= /sys/fs/selinux
 FILESYSTEMS ?= ext4 xfs jfs vfat
 
-export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
+export CFLAGS+=-g -O0 -Werror -Wall -Wextra -Wno-unused-parameter -D_GNU_SOURCE
 
 DISTRO=$(shell ./os_detect)
 SELINUXFS := $(shell cat /proc/mounts | grep selinuxfs | cut -f 2 -d ' ')
-- 
2.45.2

