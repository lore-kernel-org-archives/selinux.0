Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1B3002A0
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787852; cv=none; b=UbpKX9wn3/uyRn1ucEBznlahBOAvcuhaQ72wIKsznzH1Z8afQ5q0gfkJmmo16JcHPpQahxCpVJudvS7nDl7l/tXPNe9iXhKE7TA9deetvHMjY9W9XZiSkxX+hRNaE89o5P3dP1Hf/Y24HuwGi1Z8OUicqpVBVr0lqGePy2jgQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787852; c=relaxed/simple;
	bh=OJIdvfmtWWhanCvarrwqhoEFmG//+TcJBhg7coKRQIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/cwyJMZJc40KtmXGt6XTSp981Nkf46eQnyzr5hNe2op4ke7EYxsRuNFdUovA3wuGTR43lhLOg5LYwVR/rnJrHgFPE5v6S2WvH5ofFsUOHhK6a6cnooNh2BxqPjQqjmkj9XeTGGj/OVrgthZEW+JXFRbKBk5yI2k37OG/DzDu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20251104.gappssmtp.com header.i=@perfinion-com.20251104.gappssmtp.com header.b=MMwqnkIr; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20251104.gappssmtp.com header.i=@perfinion-com.20251104.gappssmtp.com header.b="MMwqnkIr"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so211980a12.3
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20251104.gappssmtp.com; s=20251104; t=1784787849; x=1785392649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0dhe2TF1VZT1n4RkwDevSNz8VhgF3Lp6jID3ipbk0Cg=;
        b=MMwqnkIrcpqGNOLg1ii1umoFtEQF5e3/3ZhNUPV+2XvM3fu4YgcVhkiNbfhDuE4j6l
         E0thsPx6qAstdm6csb8kfwp89D2l12wLoS492dLcvZyvGiyd/dWZ3oPllTzs/7rRXobJ
         WU0L+U25bgqa0GLmq3mS7FHA/Rlvr7o+WQvtClOSqeDKLKo/8aT9UXnDcZsoW9W71JPm
         SK6VdZtUqIqV9F4ZDmR/z8Zzw5cXvwxkHJWXflrw5e29kfnKt7SJOnk0rTjXwZmDxw0B
         TXsXiJbvHegs/KbfuWFxt5++wH/pZSDSWh5TVvfa2wQbMT+XNlrvn1nrwzzZtb9lPqtH
         ME/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784787849; x=1785392649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0dhe2TF1VZT1n4RkwDevSNz8VhgF3Lp6jID3ipbk0Cg=;
        b=enc7LkIZSzJyddX6OimOLhQBPH+cwGRRtygfzRKl99DRwlq4BVNM7wDdY2uWu/1+qp
         JkV76iWILEJ4NlVWAHUVTSHZ0KA6hD/rszhlhd3BPkYPAmT8npDwAYu1w1gEomxx+n5q
         m2Iyb/QeQT/69O76HKak2vABUobHG9119Oe6qxvfhO81g3YW+s9Br9NPrFkpa4xoS8fI
         zSEgD+TEVqitVRWHzWjfR5oxmCgMFvoC8b/crYv/tJzMASS7rcYdsnbPJ8xriONk1ZYs
         jIRgQnxV0uSOcX1HcRhzxYa4xYbFGe4/aCoiVO0iqQML/WuIUeSwL5M4ERryXXhBPVKh
         15Rw==
X-Gm-Message-State: AOJu0YyS735DWFjdxgUKz3aztXYRTtJIvzIBf6dQdMNqCuisjUXV733U
	ANQQgE8yITixHmdhm/8Za66aSPLPXxm7reuwUoGmqy75Vz4Ah7yPMsfV/WBJhNoNX04MW2AHfwe
	SdvNz
X-Gm-Gg: AR+sD138EPg/Fm9IolYnPve73icR32ht7xYda31K+r0PWXDYQ4mAFfbYMFoBXtpW+hz
	ZqZ0rMlFWYyz6qtgUjhWOi3u89tiEu2Gx8anlL9jWyx9v/fdtYDqfYb9mTJ2HYN0J8/5rKtD2dy
	tjajSiq6ioDEz5HtK1CeN0hDf1GVf2OM1zEIKY136GvKWQexWOnJPwhtCqTYj4bDyqvnackadaB
	v/apYz7Bf/o7nb5ksORdxCOkfyNpi7kRIi+a7/utSyxM+kXPsHWwxXeChmqzlMv5qoYOCNSiZ78
	n0xbWAaHIydeVz4okJwARIp1rhXCteNRPXdCWVddqI+PfwD+jkdo6vp3bUIoM15M7lveolNFRgK
	LSAgLGeE71skcmyEkfPGBIc5694QbTK2auvwQ3idjqudz+X9wLRxwmuO43iyN1YAN4p+hq3FTxJ
	vOsWBUfXjETz37qtXI4KMw3Qfg1QZf/K6kaDsvSKM=
X-Received: by 2002:a05:6a21:4cc1:b0:3c3:8255:8c4a with SMTP id adf61e73a8af0-3c44aff5387mr1990078637.17.1784787849307;
        Wed, 22 Jul 2026 23:24:09 -0700 (PDT)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130cc5ebsm16128862c88.12.2026.07.22.23.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:24:08 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@vger.kernel.org
Cc: Jason Zaman <jason@perfinion.com>
Subject: [PATCH 3/3] RFC: SECURITY.md: Rough draft of codifying the maintainer process
Date: Wed, 22 Jul 2026 23:23:55 -0700
Message-ID: <20260723062355.3096648-3-jason@perfinion.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723062355.3096648-1-jason@perfinion.com>
References: <20260723062355.3096648-1-jason@perfinion.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since security issues are quite rare, best to codify the processes so
when they come along we can fall back to this and dont forget any steps.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 SECURITY.md | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/SECURITY.md b/SECURITY.md
index 49c40e97..145a2714 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -35,6 +35,9 @@ the issue as quickly as possible and shorten the disclosure window.
   *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
 * Ondrej Mosnacek, omosnace@redhat.com
 
+If unsure about whether an issue is in kernel or userspace, feel free to send
+to any and the maintainers will handle it internally.
+
 ### Resolving Sensitive Security Issues
 
 Upon disclosure of a bug, the maintainers should work together to investigate
@@ -57,3 +60,26 @@ lists.
 
 * https://oss-security.openwall.org/wiki/mailing-lists/distros
 * https://oss-security.openwall.org/wiki/mailing-lists/oss-security
+
+### Maintainer Process
+
+This is the process maintainers will follow upon receiving a security notification.
+
+1. Make sure all appropriate SELinux maintainers are notified. Regardless of
+   which maintainer was initially contacted, others should be looped in. This
+   may also include the kernel maintainers if relevant to the issue.
+2. After an initial review of the issue, maintainers will agree on one person
+   to be main point of contact. The response to the initial mail may come from a
+   different maintainer. If the initial mail was PGP signed/encrypted, the
+   replies will also be PGP signed/encrypted with one of the above keys.
+3. Maintainers will work together in private to verify and fix the issue. For
+   larger fixes, this might involve a github private fork within a draft github
+   security advisory.
+4. Maintainers will prepare the fix as soon as reasonable. Maintainers may
+   invite the reporter to the draft security advisory or private fork to help
+   verifying the fix.
+5. We will aim to release the fix publicly quickly, but may request an embargo
+   period up to 90 days if the complexity of the issue requires it or if
+   severity of the issue requires coordinated rollout amongst distros.
+6. Public disclosure will involve pushing the fix to the public repo and
+   publishing the security advisory on Github and to the mailing list.
-- 
2.54.0

