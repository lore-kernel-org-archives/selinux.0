Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FADD37CD27
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222153; cv=none; b=pDV3RQ1RiEPHthtbgoXR6BAEctKTUAKjN+5/naYY+sH/LsALGDC0QTXPxkVChxPcvQ3o6mI7P1UQVCoL2IcJocitEEZYynJh6ImxAg4pa8jUBiV95rEM+2+nJEXoRRskck94Gno8nrk8OGN4hVGosV8VCzGbgvMR8dHVRv8nWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222153; c=relaxed/simple;
	bh=A/lnI+Q2uczCvjkhuE8ztEkEsQhEdR05rEqZz6xhfaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxFfXvZyIO+jAt2I7JgedkW4RZiDbM1q5REs2RUehqtZp8QvjS9M2K8AAJkByGGS4KyBwBAlDcn9Avs6Fs/2jISLQ5cIT5GPZSIBco9cpDBSi7+Q4LTg+4+KZH77vtvoVv7EmawCyPzxPXO+CakNeHloL+DlZFWyxyOI75vOxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=QNRSrfu/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="QNRSrfu/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222150;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COu8u2YB1DH9PzJ7bcE0SBAViKQFjKaDxnpilt8JX+A=;
	b=QNRSrfu/II2KYqNWhbOszQIen703dTsil1guQJ48vjWMHWK9JT0h+WBLXM68vwDAyGjstK
	+hRkXfEP2Ry/5KY7LOIXEEhH3GoQfIgOLUZPfssg+2f16ubtcwmzJEw+BhWX6irZcQ17vY
	+QELfKX/fr6ck7fwwWw+bF0MvWqJ/G2FPUNvlUZBVOiDDI9nWa3qyA1J7sKW8dLuB6Ymtv
	Hfm6mx6AumBkAuucQuyWMzj5jfNLuo1XNGb1dPnRxNgJF1OObtduvywNSkSLBVyUfNNbEQ
	5CQ/Ed9X/vvFMSMlTwzv4S3rW5RQWa3Poz706LYLJ1BfpKtIXxdcVxt1M2DJSg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 06/24] libselinux: check buffer before pointer arithmetic in regex_format_error
Date: Tue, 23 Jun 2026 15:41:55 +0200
Message-ID: <20260623134215.98273-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

The error pointer was computed as &buffer[buf_size - the_end_length]
before the !buffer/!buf_size guard, forming a pointer from a possibly
NULL base (undefined behavior). Move the guard ahead of the arithmetic.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/regex.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index bd7f2188..80b01692 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -560,12 +560,16 @@ static struct regex_data *regex_data_create(void)
 void regex_format_error(struct regex_error_data const *error_data, char *buffer,
 			size_t buf_size)
 {
-	unsigned the_end_length = buf_size > 4 ? 4 : buf_size;
-	char *ptr = &buffer[buf_size - the_end_length];
+	unsigned the_end_length;
+	char *ptr;
 	int rc = 0;
 	size_t pos = 0;
+
 	if (!buffer || !buf_size)
 		return;
+
+	the_end_length = buf_size > 4 ? 4 : buf_size;
+	ptr = &buffer[buf_size - the_end_length];
 	rc = snprintf(buffer, buf_size, "REGEX back-end error: ");
 	if (rc < 0)
 		/*
-- 
2.53.0

