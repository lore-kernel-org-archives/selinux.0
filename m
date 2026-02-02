Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0336A033
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042256; cv=none; b=jczuV39g6OfXmUF+dmiQ5/2Tlia1kJhXQ9sxo+zSz14SRUE1RPJ5ohKL1HQSZeBFWkA/k2oqZtJoXMBQ9mymXA8Ix54EVkP8dBlRk6xH0I8397X1Y4yjQCnSp0WPG3g6PKr2GKpfrgd5gUD8MHKnnWwyEKhR3XyxS3Sd3Ecpy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042256; c=relaxed/simple;
	bh=GxLERZz2gOiJSZxWoyPuQSE05IaQzxQrgYqXCJf/9eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewqVPqLExT+LI6zm43xyJXPdBP2nMg0+06bYgWZ0MvzNCRtM0INN5D54h31CF6UepvVDqBMejxzIfFFt7J4vxZXd05X1GqiO0+9dLT+RrsgC7GeMmYEGCCsB/UOY48GO7WxD2GaQLrj7aNxp463BAeRrMSY5vC0lQQXhYPZhuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=LT7HOse2; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="LT7HOse2"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042253;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KrQlxMfGBjXl3EyyNyMBy7uyjrh+mAZV1g1IGysuwVQ=;
	b=LT7HOse2JA6c5ZBdiJHoWZ2iROE2EZN9WXWAlFGPA+GRprKB/OsNyLAqM3YnAYfC2OkRlr
	exKuFCDBRQhbJiw5q/8SpWeCGRi7WdGi43kBOof02JRuOxtWD7nWj/liOgsJI5I9MxR0xk
	0xy0mobQiuHqjb7WpMFtxgXmfwQwM73SUKhe9Cn0NuZnukBXUUZNyJvVI2rGr48PjL7iD3
	0AKuZ7o9teCGxhhMkv5x6/4pVubtCbyGj1cBtzCj/V7fZ+qX33yP4OrSsUhRaCQVtAXxQU
	bkuQxsgtp5lHAOqQ0oNNYbS0a87NbxR0YB643bMxClEKX0Ko0kiWviqXqxEDSA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 6/8] libselinux: drop unreachable return
Date: Mon,  2 Feb 2026 15:24:01 +0100
Message-ID: <20260202142404.92347-5-cgoettsche@seltendoof.de>
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

The function end cannot be reached and compilers are good enough to
prove it at compile time.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc_internal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
index ffc663e5..f0eb5ece 100644
--- a/libselinux/src/avc_internal.c
+++ b/libselinux/src/avc_internal.c
@@ -264,7 +264,6 @@ int avc_netlink_check_nb(void)
 
 		(void)avc_netlink_process(buf);
 	}
-	return 0;
 }
 
 /* run routine for the netlink listening thread */
-- 
2.51.0

