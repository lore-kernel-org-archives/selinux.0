Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FF2D23B6;
	Mon,  2 Feb 2026 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770040145; cv=none; b=VjsHAkPCgkETzywz32pXad7HauFy+AnX5OmFCLw8W8ew809rX+HzojdqgIKkZ1klSc1VSkpThiY7PuSw6mes79nQIa28OoBfkC7dmTARQiIWZRMuC3CvYEePNCGF05V1GMFHLtI2cSGwX/7WTT4fZ/ieV3PyEQsGklXE1hw1rlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770040145; c=relaxed/simple;
	bh=jIIk/vxhdXzmLNXfyhVfHiCy4d1BBvjgpi736yaNyXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tYRIXc2c7chiaQcOYJkJa4wooUtFmpuUaZ5QQEzK72WuiO5Ae2V+xPunhFuu4MciyiK7/2GIAKN2IoRGHAzRc6FlKHa66YiJiCHmf7t7w6eZAxczu4Ilu8Pf1+DW0uZnqtAsYQQAsYLLkpIVduXY0u+reRPhsuky/LZ9z3Sg3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=VacFThdp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="VacFThdp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770040133;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jSXHlkzmvekyYR84Jod4cK11Fjm72jvZZByzumtzxzg=;
	b=VacFThdp/4PkAKqurvlAJVCI199KFB/M7CdI8xWwTlmXGPdgl8F6RPUo/2FHbv31oDB3RZ
	DKMguy9s++E8xwGlBo4VkUBOO7CUCPalt0eQXDNirV43A6QX+h53fUCb/GkmWVid+u5PFJ
	abgnrVLPi0X9KWlAgT9TWdE7PwKB+/0ayFMSfPSJ9dEwRR1Cp4Ej0zqVDyEOrF8sY1hoUs
	CMVvXRrgmdPppGJbJP6uGqglNX+Z2Qsf1vxeK9+EwRYLdhgKAz2JQwIAQZMJw6mKeeCrjm
	J6AsjsNoJHUhJivMtntnpN04tDnkTl2Oi3b3Ve5Ayzl7Komzn1/bVVegrrONvg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] selinux: fix data race on AVC latest_notif
Date: Mon,  2 Feb 2026 14:48:02 +0100
Message-ID: <20260202134822.67476-1-cgoettsche@seltendoof.de>
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

The latest revocation notification of the AVC cache can be bumped
concurrently. Ensure an atomic read using READ_ONCE() and please
KCSAN by using data_race().

Reported-by: syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a7f7cb0737bd91aa698c
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 8f77b9a732e1..fd1f9486fa98 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1204,5 +1204,5 @@ int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
 
 u32 avc_policy_seqno(void)
 {
-	return selinux_avc.avc_cache.latest_notif;
+	return data_race(READ_ONCE(selinux_avc.avc_cache.latest_notif));
 }
-- 
2.51.0

