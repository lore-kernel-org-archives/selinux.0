Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6933F5AA
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680149; cv=none; b=VwSFcQxvEBs7Gli1UW7Wxo7RfK0/qbr1m5xyZCkpvo3yv5uiWOXxbmaC+ZSNp01A8NsFu6I1zp0Jii5aFP3Kqqz2l7SzllGN2+5JYTMxsbupMKGlTDsO32uphDKZ5mxaAwrBwuu/4CIsIqE73tFS1DZq9HxI5N3OgDkR/8Ic9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680149; c=relaxed/simple;
	bh=T5gY5HXrT9KM0fqxqmFfDNLIHFxckJuM7Ycv+eNJIxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y17IS3QjtcmDj+DdBAxx9En0iU3GHlHZTmLYTC0NatoUph7ZXsOnKwIqcsxyPHIcBZ4PTpHK6Jfgpvq27YvqwLrgIgqLEgwTCeFD6pNoao5PikR+j+u+w23RjlIMTnMudth7v+lGrctUB4Mp5rdXBxgO7mooa+wlUurHZ2kObBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=T/wP9xMq; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="T/wP9xMq"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780680144;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D88c3IVjQMCh9Ek3FZE0fDbfaN4WWljFKuSjTeMOOBQ=;
	b=T/wP9xMq3T3SI7GPb6GX7rRvSyyG+X7jREWBf0F1viZNxRzJhjnPdzNxaPiuAo1GwU0Ka3
	mqCPgvX5w0AUJqB0uiyfgyhuzDhgBSrK5MA2CCgRcou3MOPrMen7JNBpIyvF/w3TiI/H25
	Vx5/2AqflGFGi10rt7CmQ45qTNF9jKlhqVvBLuEDCxrmAjGmn1aT7CZQf/Kuo9M7VVExx7
	rO8JbZu67RBb5eYhuTA+grhjRK9dC1qWEygTKOA+7ThptvQLfH4axBK+Ew+6KVVnqgMYN3
	U+NEICX5ylx7eC5a3wd57gvm3tp8cbq2kh8qTit/gdASq9dijuWYOD57JTQDvg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 07/11] mcstrans: check context_range_set(3) for failure
Date: Fri,  5 Jun 2026 19:22:02 +0200
Message-ID: <20260605172207.222382-6-cgoettsche@seltendoof.de>
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

Bail in case context_range_set(3) fails.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 mcstrans/src/mcstrans.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index e0593c76..ee9392bc 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -981,7 +981,10 @@ static char *new_context_str(const char *incon, const char *range)
 	if (!con) {
 		goto exit;
 	}
-	context_range_set(con, range);
+	if (context_range_set(con, range) < 0) {
+		context_free(con);
+		goto exit;
+	}
 	rcon = context_to_str(con);
 	context_free(con);
 	if (!rcon) {
-- 
2.53.0

