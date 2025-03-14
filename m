Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD91FE470
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958279; cv=none; b=GYb4ngkqhOYagss0zA7ujMSzbOHu/+SsMWR38JlFl/hjhS/PBmIKhmR41iqN2048BRaVbaaiBi3rCPigHD5oNxRJ9kGhCDEB4ReF9yD5KRgB8FjXziTDEt3MNzVLFnOYOllkcQZKfTphcoW+oxlPJfjJ/hQGtITrcpH11gwHpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958279; c=relaxed/simple;
	bh=8Hfhx2JUKrPhHF9vHW43Vvc57gwq/r7NMIp3YKIgezk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROtomGOOTotk4q5eTZn8NwvlkGAgtOv6z68PE441dbHKLSgiXvGTI8OGnz1k+6Yl9ZD8dlbeAOmKjWgvWM9LORi6B7/xZD7X407IEt/dCLoz54GqDJyh7teHOp2khSEKvLrmR41f4BOeMbyT0W6jYfVlh2M7TwvCC9+jLyncMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=XIP+QdRI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="XIP+QdRI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1741958276;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szv4YABbw/t+AMOe0EiF0RtQgjdHHBMeww+FDjrFywY=;
	b=XIP+QdRIVf0C6CKzMmsUuFJqjoqAldERViDkCG7+oZT+joV4eiUA7sLPAzzSjii8Ja2jDl
	y8qWj5Rn2gEUEq9wj9bUZYbRSuyskojje3MFY//wr2Npbc9jfwjo1tOm45/Apuv9vd+WuN
	hUhoi3dIgAmP84lKIUyV3OT+aY80EbvOpA6AtInoA5+KfQFrQFgotBgeeGTmrunROiUsn+
	/83mTEAzVNOGZm/3xp9d5e2ILHkS5ZDRRYYKAGDlYPvG/t7aSKU6/cfNJoKIUanYHtsBO9
	c5TJeTzihTU0C6i3m2N0II+qPwCqiRTAW40J5vg7zl1BH4uchry4W2ucAWeNOg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 1/4] libselinux: constify global strings
Date: Fri, 14 Mar 2025 14:17:51 +0100
Message-ID: <20250314131751.28289-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250314131751.28289-1-cgoettsche@seltendoof.de>
References: <20250314131751.28289-1-cgoettsche@seltendoof.de>
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
2.47.2

