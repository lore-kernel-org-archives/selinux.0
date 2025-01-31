Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF61DFF0
	for <selinux@vger.kernel.org>; Fri, 31 Jan 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738346588; cv=none; b=HYMRYmxRnzvpu2XsHlrztN3xM7YLYooadD+tZtlvIdVLR70d8Oa294oTmZ6u+b//O6F3FYAxeShMu110NWqtXTivo8QqsuicTBrRT4ZI1pafIP3bvmqxFif8XKb44sd4v3PnmdpRGyVb6SAlYt00oWhs3OTch22wO6stPt8Iwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738346588; c=relaxed/simple;
	bh=h8+R/JHHlNjjCxsdntDlVlA5pjrZn6NU51OJMxSsewk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f25y1ilJ4RrlVicrbQ2GtZU1oARGlWttLCHEHxwjKltnEquSWDBxm61bHcashMEmzdqjhwGGyz1VB3mvctk+FcFBLAPG7eewzEJQKkiW/DhPFANekUm1eRLwfSTO0rHl2a/ZEJYrKRV3XjNjGj1NjhjScUgqqIUjJ5W0RJEE98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=hB/k/xq/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="hB/k/xq/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1738346160;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6XBeX7pPKKCqqC36QZCOplstPy3/W6QHvjEbjcLL0C8=;
	b=hB/k/xq/89Zmo0q5A2Yev0V57SsgOOGHF+CONOrQ9vNT2IRAoipn3voHLMAaM8rFMZ4Iyf
	Y4IaGtF4OA7LBIRVECNKBn/GgANlpQ2fSEv+QRZjOGsYvt6Hsnvpm3UPURLZp8yeHq5N6v
	FV5U0Y1ilWaCCvmNU7Odh4mD5kg02CV5rvvzsoJTBKONdtnGzfZTiDIkvL9L2SPisf7LG9
	d9vqfXvcAliohyxGLKv54p7fHevCl7UAoONHnEjqOSa6+OP2Tf9F9gBv4+oY+VHzEsDHCY
	AFafXzgJQShdrrPheAjETTHG0hzgmXeM1TEgwovPSgx5PA64T4fvdpCi/hn4yQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/4] libselinux: constify global strings
Date: Fri, 31 Jan 2025 18:55:53 +0100
Message-ID: <20250131175556.21836-1-cgoettsche@seltendoof.de>
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

Declare the read-only encode table const.
Drop the only once used global variable selinux_rootpath.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/compute_create.c | 2 +-
 libselinux/src/selinux_config.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index d19baa0b..ff8553bc 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -33,7 +33,7 @@ static int object_name_encode(const char *objname, char *buffer, size_t buflen)
 				return -1;
 			buffer[offset++] = '+';
 		} else {
-			static const char *table = "0123456789ABCDEF";
+			static const char *const table = "0123456789ABCDEF";
 			int	l = (code & 0x0f);
 			int	h = (code & 0xf0) >> 4;
 
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 1d8cfb71..75db14ba 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -153,7 +153,6 @@ static int setpolicytype(const char *type)
 }
 
 static char *selinux_policyroot = NULL;
-static const char *selinux_rootpath = SELINUXDIR;
 
 static void init_selinux_config(void)
 {
@@ -312,7 +311,7 @@ int selinux_set_policy_root(const char *path)
 
 const char *selinux_path(void)
 {
-	return selinux_rootpath;
+	return SELINUXDIR;
 }
 
 
-- 
2.45.2

