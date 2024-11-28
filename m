Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE06F06A
	for <selinux@vger.kernel.org>; Thu, 28 Nov 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807969; cv=none; b=IpeS5u+xbQFCTU32sczc3HQd/1uj56KB/Tv0PkD1/c0nuFMwxEZs3/KZAWs1oCAiKENqWIeQAGiGx7iNUQG2gJZLqgtErQK8Wv0dOpFc2hu+sM/6dQH34QPj9FAXsLlWVRvmiWS7+Og9ulDa/L/3keNV8J/h5zlv/k+EyRaomF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807969; c=relaxed/simple;
	bh=eVBiL5rNgy2Rv9052/s2YCjt5EpMyfBjchNk/GhvdJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y4oTnvFg7s4tx6bY20R4OUwQO2osLBODtLrIFtQLKRkjKDWpdabn60hOh8XGiqDwJptWAD0RMfk3EvLemIN5k31aKFywE7BtflhjMrMZ2IZ3+yJ0vVjlZI0CZpd7jbZE3YJO+Qn+fVlW1+xJR/uNKxnmtZPlEhQSppWH/apw2Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=cR7d5dnC; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="cR7d5dnC"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732807962;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Cp1bxvpWCg8BBrReY/U1h+N8cQZq/V92LWIJnEWwVIE=;
	b=cR7d5dnCMLBA2v1xFv0z4vDx1mJRdIL88EmoZczYijIk+mx5C5Ub0tXn6eE+9vd8Vsz6Ro
	Rij5x44snaVkAnGcGoh9xgP1PkG3A/7LMbAM1S0trcRo1KNmUxBRqs14+90dJX+HvAs2Fm
	AEUtwnDbR8Sw/0ua+tYlLRBhiVG050zUzb0qFdZOQqYuCpoi+apaJFaz9dvnN37hI9S2I8
	JSL2AZ7CLaBREz1RF0VGiy68XRgZIAzOKbuNsbjkO29STKIk55RgUh3XlDjRhrhovE9R79
	haDPguwmiqQ3dwQfKAOZUtKto79pG7AAGeXIbxt2N4d+ZoiXv/4j3Ktyh9IxUQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux/utils: use correct error handling
Date: Thu, 28 Nov 2024 16:32:39 +0100
Message-ID: <20241128153239.16472-1-cgoettsche@seltendoof.de>
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

Instead of returning directly goto the err label, which prints a message
and closes the opened file stream.

Found by clang-analyzer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/sefcontext_compile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 23d31274..5d7ab301 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -471,7 +471,7 @@ static int write_binary_file(const struct saved_data *data, const struct sidtab
 	/* write context table */
 	rc = write_sidtab(bin_file, stab);
 	if (rc)
-		return rc;
+		goto err;
 
 	rc = write_spec_node(bin_file, do_write_precompregex, data->root, stab);
 	if (rc)
-- 
2.45.2

