Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71036C5A1
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042258; cv=none; b=cOXNRocnWfbn9gqzSUR+9ke0wQW3I3w4VrdIkBhKmfpO3G9P07khlFyf6PutC3nyOZRnsa88hJ0SiDOBFH4UhQ6+7wBeLG0Vmydtz+MMW4hUYzMVzayR4iWvhFANHNyRy/Pt1+zpNxAHlKYdieKRrouzND2dTweEym3scjYnO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042258; c=relaxed/simple;
	bh=WmbEGLfvcHViiOiOFms+ycIvtLLQSR3fa4ZxtUJynoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miYBaHHj9Pc7ZUphGs52Ihi/M0Rv1b/fBEqeZWOdQVBZYTfRneFLmSoZOZRCdYI8CYiwBfAlYUxGKhE5ZcyyuQqfhPe0xfiIiIyaPOqD4wjUSdmWGF0gdsyiCgYFOm+Rd4QTW8yjjkDR8fY8NqdoyCXVFVMzJLvPXMT/7QcC/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=gzNlz+Sz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="gzNlz+Sz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042254;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnMJoV5yR2judvF4D80JLC1hKYbdH4T/Et/mX0ANCsE=;
	b=gzNlz+SzAHvDI7TlmVTXdhJiiURIwkkXNxEmFoVLZroLHTM5WsjunBOxKqbWheR2RXLDzl
	avMCtAAv4QExHr0A7gI2nrtxSxSdO92KQI7XaX2Bcg+eM0G/wP4zPghTBM1JqVJugKUiBQ
	UHrOUVPrz11ey+F0bxHGHD11aep0EB7QrmL8E+nVBtJVtH8m/MZef+BywxlyADqrIyUzLE
	ST+mwj+p4AxJghcpD41olF8zM7E3hStOP0Y28eSGtXbec+iTHv0yzJ8+CEE5wxSQFw55Fn
	wIU11JoVz6BqPEn2ZNBQMvGUreRQUqUTI66kSxnROafJXjzoZKuBqnImxNbQDA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/8] libselinux: drop duplicate include header
Date: Mon,  2 Feb 2026 15:24:04 +0100
Message-ID: <20260202142404.92347-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260202142404.92347-1-cgoettsche@seltendoof.de>
References: <20260202142404.92347-1-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selinux_check_securetty_context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libselinux/utils/selinux_check_securetty_context.c b/libselinux/utils/selinux_check_securetty_context.c
index 5581dde1..0abbdfb9 100644
--- a/libselinux/utils/selinux_check_securetty_context.c
+++ b/libselinux/utils/selinux_check_securetty_context.c
@@ -3,7 +3,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <getopt.h>
-#include <errno.h>
 #include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-- 
2.51.0

