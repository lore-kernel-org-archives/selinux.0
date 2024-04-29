Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FA8624A
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408749; cv=none; b=KW4GQg1jPgyEgWLBoDQJE6iq/2CCCF+CF8SkD9QNDRP9q+/QzQVEfGvAGBWu8e460ngQs3CK3h6c4/+dTHUyzHV9iZ0Fj7jznF1n3G3UVmnjBpydNkFo9z7FtJ2m+q4qtePbH7xofZkL2OYJhONxyoGtQ9INoek7tXToseTrttE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408749; c=relaxed/simple;
	bh=sH7c4Agew8m8raT0/bfIQm7I0qJqGiLPzOig+KhMUBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U6UGgk2uwJoRrZAd2TsK5Vymrjb2yfUL4lHToM/pqsqK8/6ODO+AqrqqnUK3iSFNxd6/h2iLAKtbzRvt40bQt/QBzafs4lZ7lxa71iAo4UrwGsYskpL09/2nVxO7mcJpdWNeBoKwCgyUrSxIgwXWd+1LgeNFFv5ZP5270ThYtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=iHCZe6US; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="iHCZe6US"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1714408745;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bo0+gobzquwxjmjN7pi76NBU4VKrJI5A0KEUz0qROlg=;
	b=iHCZe6USDCFfjzQ5C7HqJ4TsGSvrnooQF+eeoeYtfho5+KeQi5jLXITrxxIQ2MZL+2Zu6+
	uMEXLjpJ/HCT9qrv3kE6FvSTN02TtlU7hLm6OttTJrWT0TIFC2Nqo1Mv93mWWjzX9zwDKZ
	k1I5UGLpl3NZOF4SFwG07y+IcGJaNDg8gHBS9ohmjniM2DhDcGNdnBtIrdzMZrDZcAZViJ
	CeBMVXl2ZXeP3UI+Ogo9Yw7eeaFEfgV3fjjySWu6jifDqhqmjQc9K7UXtFS91MGTHZjOjc
	FKQjvhqSJkZXHmxhcyWNShmFHMDO6i5R3xUGb2VhkyveLo3Syi6w5jUzBDXSOg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/3] libselinux: free empty scandir(3) result
Date: Mon, 29 Apr 2024 18:38:59 +0200
Message-ID: <20240429163901.65239-1-cgoettsche@seltendoof.de>
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

In case scandir(3) finds no entries still free the returned result to
avoid leaking it.

Also do not override errno in case of a failure.

Reported.by: Cppcheck

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/booleans.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index c557df65..1ede8e2d 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -53,7 +53,11 @@ int security_get_boolean_names(char ***names, int *len)
 
 	snprintf(path, sizeof path, "%s%s", selinux_mnt, SELINUX_BOOL_DIR);
 	*len = scandir(path, &namelist, &filename_select, alphasort);
-	if (*len <= 0) {
+	if (*len < 0) {
+		return -1;
+	}
+	if (*len == 0) {
+		free(namelist);
 		errno = ENOENT;
 		return -1;
 	}
-- 
2.43.0

