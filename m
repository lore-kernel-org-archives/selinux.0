Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60436167E
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042255; cv=none; b=aUChth9V3ZaeDOpQt3jQ+QuaeMH6s+FbYkA1Xx3XHbYaWKLCQuJS4EE4iCHBhrocwSCL0ZIZ6AAlSXRO9o4jH+nLRxxdARIJ4LUVkFk7OV5ODO/YpPc2wVS6j1767htV6SRcRlR/VWqKI6VoPCCsEYiWmVbsp4VJx386eRq0zwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042255; c=relaxed/simple;
	bh=A+W1zoBGA2zHMRth+NKV4kFRh9zCMhapbXAWaXxGm00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nc1g8bvVMFiJMPRA238LhrKu9n9xla72L1PhvVh8/9Kzs7xHYyg+TiGBIb0CjdZ9g56TNYGX0AwmmRouwBNCWnwvgE1Mu79zwAbVvUwDLxpqEvRoYEIk9J2BLBQJmJGfTu/p0ic0B+ZuXGW0fh1M8FSyiM+yq5yVi04eRlE84LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=DfeMPm0F; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="DfeMPm0F"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042252;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ldov57ViTkysTwLnX4uqIvr+In26BRsyhgXT0sO+xmc=;
	b=DfeMPm0FDjeqrTf/XBTIQiG1D2MAyPSQoslNx3qRxwlrM+MIhKFzyU5sNGV7HfhC8XROhi
	WoDW6T31V+UllCn3qQbutPRlzX53bLgg/RhANUfOsZJiSeOk8UW2NcbynIx8WuHws2fhY+
	iYK3cNIfmOSN3heecrKg/ns4h1yAAjYJsAo9RYWlLUs6TgYDZlKRKb3q6eWp9tXU8cAcOD
	fJidgz1fGR8hveFjwb3CeVnnuNwQpxv0iALmdVbrY+jfj4aexNdFo+hik95rmpNamohlZZ
	5HiSkbhpK6SYYtXMShGNULtzPBiRHhcKTFboLdEPlUAdZb/BXFtW6/KFQBLlWg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/8] libselinux: drop void cast on function returning void
Date: Mon,  2 Feb 2026 15:23:57 +0100
Message-ID: <20260202142404.92347-1-cgoettsche@seltendoof.de>
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
 libselinux/utils/selabel_get_digests_all_partial_matches.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c b/libselinux/utils/selabel_get_digests_all_partial_matches.c
index e2733b41..1ee7afd8 100644
--- a/libselinux/utils/selabel_get_digests_all_partial_matches.c
+++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
@@ -164,6 +164,6 @@ int main(int argc, char **argv)
 	}
 
 	(void) fts_close(fts);
-	(void) selabel_close(hnd);
+	selabel_close(hnd);
 	return 0;
 }
-- 
2.51.0

