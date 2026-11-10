Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308364;
	b=P3BmiRTw90DLmO0/ZE1qwOKSrq3v/nuDrBKnj/wsVSOffIJbQidp+ynjjwiZ1Kmzy8KE
	 UBOWrE5l3TIm/FOiUrcaWEh3BalcqHZpq6UBldMkyc/0+te/u6bjwYGYTdiHqQA58+oXa
	 b8LgYCIMWCkYveMph95cwvYageOF/nmOws/e0YaiU7vGVORV4ZFXl3YwgY+MzXOHDu504
	 v+PhF66rNnGlDVMyQpgj3WSu++1+yssvdD7urRjte90PLaVsAWy8hnrAA8lBy3y1x360I
	 8Y/trtnzFgFnTBlU0k6+3dL5ysZrA/VZK8QojCSYDqh+njvExjegcwDcSZJpBykMTyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308364;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Lzemu2I6bjGYtRFaCM4FtWJmnGQoNzrqBL600HNGoHE=;
	b=yZ21L5U75qNGeVZOKKWJrlBA8eQ9WyxcpBXycKS0nZGX4Lh15UlZI/RyKCk221RIm7G/
	 xEdDNpK+rbqFPS+H8HSCadRjaUYg3p88+Of1MhZ6JXFPbQmqrmPDYctQqlAh+jC+9x16p
	 qo1ZLIRRXU+xMHlgFeAtiuGEx9zVAYCtWekpsvy/fEAFfyXfZMrLo+KW1OAJOJglg8l/j
	 ZAZjza4Ua/tvkyeJw7a5CfiYwBayAFMeF934f5XAcUZ1bGbLl2tPW2+MbAPXuRRILZbcd
	 7axKByGlLbuc2VFelz9w8pNC75n72HxzwzGxLx2nPeFeIUqHuVmOJ8hQYk57tHeh4Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=uaRidBhv;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E5E60A262B
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 10:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45E5E60A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=uaRidBhv
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308360;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lzemu2I6bjGYtRFaCM4FtWJmnGQoNzrqBL600HNGoHE=;
	b=uaRidBhvR05AcF0oS/xcMCZPnWNjSEvjMY9JD39HB4l69aBGS8tGLWplnVIX0mA4/tACIi
	8vZa7nIQfpxysN8ssWBkT4+iaWeND2VcwARSrwSIXeyVcFldgtJuN0kyyQ3PDVt7bBEeN3
	6DT0T4Y1rBq7WVl/wUbXKktLlEo29PpDb+XTb+d8zccYDgs3gFyv9GgZPjV6NXx2ZJfzMI
	PqSqL6EKW2COcZj1E620BBJYQhwpEWhlIpb6u7SHz8KVXvJJ4IxU4jA1ygANmzDbUpNsaa
	KzoFd6hPHjuJVAAjYkn01ZPgBEQGzzYX8RlGwm4d4VfWdCWnIE/fwkSD9/RSbg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/7] libselinux: set errno on getseuserbyname() failure
Date: Tue, 10 Nov 2026 11:59:00 +0100
Message-ID: <20261110105906.58509-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261110105906.58509-1-cgoettsche@seltendoof.de>
References: <20261110105906.58509-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The require_seusers no-match path returned -1 without touching errno,
contradicting the documented contract. Set ENOENT there while letting
the fopen() failure path keep its own errno.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/seusers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index ea542392..659626fe 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -269,6 +269,10 @@ int getseuserbyname(const char *name, char **r_seuser, char **r_level)
 		return 0;
 	}
 
+	/* No matching entry found; the fopen() failure path jumps past this
+	   to nomatch and keeps its own errno. */
+	errno = ENOENT;
+
 nomatch:
 	if (require_seusers)
 		return -1;
-- 
2.55.0

