Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0AFFBEE
	for <selinux@vger.kernel.org>; Wed,  8 May 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187880; cv=none; b=DdsQfrfO+7cfPrRWpmNjjIyuCoFo+eHNwyY5p4M9CqxnThXhA/DBR7B9zEm8mBGZvzAR9hu5JX8Ux3O9tz9P+qbDEDlXNZd3hythI21McbeDWx4Xow1NHaN1hZ/zJW087nxzCirJa6aa2YwSLbM+WDVk2Bcv2sAYiZZtW0g/M6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187880; c=relaxed/simple;
	bh=qnSn1M1TUkOSBKTNTTmsScCxfFGJqVmpGMSjlSKmIH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hyjgovf3/i/3J3m3LSLt4iOjuxk2b/dVBaLYb1wcHVGX8NVh4S9uxm3ypgryqyuaEDXNvtiuVhdp3RJwN2ATkkDs5P6crf869bBnvdPZWT5t3CkzxQ83XuwQD5uI0v3HqfHN9wHIoPuaxuY7qKwUrtmH/UXSDBKG2CSfoqzYXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WjxjNTH1; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WjxjNTH1"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1715187868;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+wlgnxdSYwM4NYjm1yL32sUGtF5MNt1L1xVLluaojZ0=;
	b=WjxjNTH1lUltalzJLTKXlWLHOXjA652Y80vSWxkzwyxnAHOD45V9DAEAYfCOevk6I+seuz
	ZrbVMjQigD6wLDKkDwakRWjLYPihwNj01k/ghCwUVI/mBUEY11abBt/SMOzGi+/vLcuH0N
	Ate08WYA00yt9nh6HE1U8GJ/w1DOsciml7hO1zEQOuIaxvpTmFx6AhhV1N6/cf0+pYRJi8
	JRreE4XPJykjVUMlWTI2SDJHsTlDhR92gdPhPJ7XCWapu3It0HWEmiIi7sK9srJkG+31Mh
	WSA1HzOOnU4tQYLxiXsplolFuwf6C6+SH4i+gRXTrEcULiRyqvxAPm89id1a+w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] checkpolicy: perform contiguous check in host byte order
Date: Wed,  8 May 2024 19:04:21 +0200
Message-ID: <20240508170422.1396740-1-cgoettsche@seltendoof.de>
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

The contiguous check for network masks requires host byte order on the
underlying integers.
Convert from network byte order to avoid wrong warnings.

Fixes: 01b88ac3 ("checkpolicy: warn on bogus IP address or netmask in nodecon statement")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index aa2ac2e6..9671906f 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5292,7 +5292,7 @@ int define_ipv4_node_context(void)
 
 	free(id);
 
-	if (mask.s_addr != 0 && ((~mask.s_addr + 1) & ~mask.s_addr) != 0) {
+	if (mask.s_addr != 0 && ((~be32toh(mask.s_addr) + 1) & ~be32toh(mask.s_addr)) != 0) {
 		yywarn("ipv4 mask is not contiguous");
 	}
 
-- 
2.43.0

