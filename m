Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E732E757
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680146; cv=none; b=amM6i66GZkdaNY/o/CM7R1Fi7zqbNL7gq1rpBzAmtMBQLVVcYWz1ApsdJdTXY1u1SHIkSh9ZyJ8ytVVLla9m/snSAC2tnogY40z8BE0AfcYT4sWjGU/OswazBcotQf4eTlo0uFxrqALzDsFmtzpYvOdanP5ACmL3nohkVqWPeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680146; c=relaxed/simple;
	bh=nI9UWIlO9a6BDFWcRqWYZnKI4tJs7pqAOqiHzKAPGrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIcPxRKbQQCyw5GqSC/hE/v9arGLkxzZVFbgFuZ54ZMs4X9A+Awl2IZ6UIzrT6T/TuEgTJ21Se3ZR1E4607TBGBu2cCGcNkodILF/1htFiF3mar1qQUKXP4raYyoYV6A150F+rnBKOqe+O9fb9U5t5bLQRTvsEWPaeof8fTIiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=XAu3Y/Xn; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="XAu3Y/Xn"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780680143;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2w9M6WPdXNas4KOjuLNCk6hknsTjXPzm3oGx0kA71w=;
	b=XAu3Y/XnTe0KDZ2r+JiipQYn6UZ1GusVppXFU13kIVjXnol/CPma6uxmZJh/PHa+q3tpsm
	jbnqON4bTtSflAkMyp81G7kefzUN6+CZtNQhGU0p5dlTKNN/RiDfe0legDWmnVrZXWIElo
	+A5I491zk97Dpn9cALlRsMl/H9qEyD0qxPQVQ82/BzVGRPBlGOmcoOWMtis01KpJLpPrWM
	SVpfEqgnQbGvf3yfLDzlpYwK565jcJdAdWGaxEPWSYG7ozqkr2WGsyYB7KIFyg9NFe5JYg
	BxSZOMX+hQsqA82roo85RRpvz4mpPPpE2RkQbmMmJE0jC9aDKEmHLrTyL40s/g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 03/11] sandbox: drop unused macro
Date: Fri,  5 Jun 2026 19:21:58 +0200
Message-ID: <20260605172207.222382-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-1-cgoettsche@seltendoof.de>
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
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

    seunshare.c:55:9: error: macro is not used [-Werror,-Wunused-macros]
    #define BUF_SIZE 1024
            ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 sandbox/seunshare.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index f9da3644..0e046398 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -52,7 +52,6 @@
 	"policycoreutils" /* the name of this package lang translation */
 #endif
 
-#define BUF_SIZE 1024
 #define DEFAULT_PATH "/usr/bin:/bin"
 #define USAGE_STRING \
 	_("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] \
-- 
2.53.0

