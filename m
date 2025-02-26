Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42A1E1DF5
	for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563057; cv=none; b=oDk+vRg/V+7lwnlHZEu7CsLIDWlxz7Oh3qMIcM1OrTkbrU1tX9y3zq0mxX19285pXPTv1AJ2Rtbt/l2fCqCx6iZgNQMSrXMSrwaIkdVBRBCex5SDcU8LGp/maNfhXLyN656naRH5+4kGaRXOuAGpMU08lzX99vIPb0S8V10x9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563057; c=relaxed/simple;
	bh=PKnnMq/zIIGknHNZnOsaA5g/lrIgO7MEooED449Zxhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bPCV4pvzbB4PocGYdAlQRWoAEO1YE+ktrJprv60qnX+VXBw3UR2pjz35CGu2pu8moV1hlLSzOlYtNusleRn1weRl+QGTMXkYKDM9cCteaMfVDlIyLetC4lIAQNKPt4mAcl04zyrWlWpZ0oekDr4rieemMNJ681kz5xxqA3hysOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=eVDSmLve; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="eVDSmLve"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740563052;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mvNmypvaH9FP8+Okog+7cMK6Cj4GsGdK6pdo72dula0=;
	b=eVDSmLveT5SitInps4R8U/ROmtaG0GmjmB0iDiNuamZ+82+NiF0Zs6CMueFY4GeUBlzDdF
	QbdIP1aZbw01JUdUnTXFOj3+GnCAyMY3l8WhFjP0RYUDox1+uevAgElshXK5ngfqd0lPQ5
	v+RD/GfyHrDA1nv1JVC+LQxUpF3J5dsT9BLHqHY+BGmZE2CwYj8gDVCdXiAWnZ+rsYy2wI
	UlafcUIi4pS2Jbr7mP+/vVrhx4Lkj/CToThnee//ttSL/u5steAyPAKX/e54jTecssyfY0
	+kyZBdCgR7+Tf01LxiX8Koq3h8cefULNspiwn82ZDeoSwbQgvDXPLo4TC9lYqA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] mcstrans: make use of context_to_str(3)
Date: Wed, 26 Feb 2025 10:44:07 +0100
Message-ID: <20250226094409.41452-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Avoid unnecessary allocations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 mcstrans/src/mcscolor.c | 2 +-
 mcstrans/src/mcstrans.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index 9ff0ce2f..ef3752a0 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -101,7 +101,7 @@ static int check_dominance(const char *pattern, const char *raw) {
 	ctx = NULL;
 	if (context_range_set(my_tmp, pattern))
 		goto out;
-	ctx = strdup(context_str(my_tmp));
+	ctx = context_to_str(my_tmp);
 	if (!ctx)
 		goto out;
 
diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 7667e131..f18f9da9 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -925,7 +925,7 @@ new_context_str(const char *incon, const char *range) {
 		goto exit;
 	}
 	context_range_set(con, range);
-	rcon = strdup(context_str(con));
+	rcon = context_to_str(con);
 	context_free(con);
 	if (!rcon) {
 		goto exit;
-- 
2.47.2

