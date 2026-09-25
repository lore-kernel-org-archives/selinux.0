Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518653E4504
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356745; cv=none; b=rdqVqrpLWKDkZPOWxERbWuIZ7+Fa3Z2Hr1F53jZBLT3lXvzX07KR+9zTOD8g3+A5jA3OHmgO+F349zvIaOKpcIkR/TEJmw+tPPCs3pxKdKRm6XdxYpvMkFEaQncJxTryCanUFWX2XpwD7rJz8mN964h2YZYWxK5LIIx7eR6jBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356745; c=relaxed/simple;
	bh=X4ldjyyTeGewfCjypawXHSRaReaKDnPkWmBIVwVKkCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nt6d0uTeu6oDMcH9Y9umFhX7ToSPIzB2Q7MZNavxNlpfIJm3zF9CdBOZZh8zLgtVg9ACPy6UTzj/SNj6p9fxbH58TEHiUXMuyH9xsOcA4Ge+RfRS1zmuZQF2tNnw4Yw21WXs2CfjlhENA1bUbhi0h6ftBE9f1yys36OZ3XpDyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=avPwNo13; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="avPwNo13"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356715;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ8iAZo+YSw3ZBJ5qQov7GfCK6gljmusZJveGMY8lxY=;
	b=avPwNo13sVGkzgBlx7xzMjfsz3bejpO3kaUQIwCCIiaR2vqkjJIFaJ5Ffv3XRkbn/un8Ba
	QxQwOp2W3WV1w44WHMV6vdD5i9mEBsBC/GCskk55doj59Q4tuMHKZdJ6+O2/nloxZ2eho9
	lDA5tk56LO2YITgpg2YqD3zZlu3sqeWlJqT9sbpwCzNynQSXAIcM9sb1tyUN5h2YilnJyB
	Czc2tUm8ZKGG/hWp1P7kh2a6o3rV9akNb36d9Z7nFsVwoqPgFenpP53J/YThrk3L56kb6B
	I3PIn52vAdOJf1YSNDT/VRZOe+AP2eiNFxYjvQZuTW3uo6Hj8umyzt9DQ/InAQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 20/21] tests: fail on compiler warnings and enable Wextra
Date: Fri, 25 Sep 2026 19:17:52 +0200
Message-ID: <20260925171755.2029271-19-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
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

Warnings issued by -Wall and -Wextra most of the time point to actual
issues in the code.  Treat the as error, so the resulting test run
failure will be investigated and the issue handled.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index d1edd4d..1118089 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -6,7 +6,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 SELINUXFS ?= /sys/fs/selinux
 FILESYSTEMS ?= ext4 xfs jfs vfat btrfs f2fs
 
-export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
+export CFLAGS+=-g -O0 -Werror -Wall -Wextra -Wno-unused-parameter -D_GNU_SOURCE
 
 DISTRO=$(shell ./os_detect)
 SELINUXFS := $(shell cat /proc/mounts | grep selinuxfs | cut -f 2 -d ' ')
-- 
2.55.0

