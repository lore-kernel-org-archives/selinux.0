Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760D3ACA46
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497186; cv=none; b=POFOg43Qfgdi8LY7MsywQw05Zf/QaOHMOUCTfiOFTV5ecSPoWDgQc80nBVwCCfZHi7mIJT3yHN8odPS5lV08xUM4d6+v/Xd7l11ac/bN3nHmrRW30MDjhAZ/YOxcAih3LmaYzo67JhJyHUNurt7Kp2ZRWYIhbnldGm9ZGJqeoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497186; c=relaxed/simple;
	bh=UiGSmUYxOMO4uMdqETkPqLmv/Nnqe4LJn6Gn9ttHw0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtStUKbY4cfAy8+YHLkzNd7Wc7ClV1YMj1CVZvWQUBGs6O4A1640zPRwORZi79KgRpW3IdDIjCLCnuickf1c9AAvAp83Cg1qPMN/O7sre8QsiBShQ8p7dHKaMaBs6ZziL1kEebVPmEqOIB8naILa2DheWkLohx7/Ngfp0xPcqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6OA3n60; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6OA3n60"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8f0579401c4so20217085a.3
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497184; x=1778101984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/d6zkx7NKPUXdGKIfW/EZhJzXWtCzUMx94HJuI6ADg=;
        b=i6OA3n60GCFxwuRsHIygvSceCNGiFLMw5mHj0eOb3c7Y4NaS3L9lm1l4BZqLqPuedE
         SwOLieXtjOZx2s0W+JXytmBJKFMuBSbMEoGvL84lzQGXdfMX4E6AC7xxABeFVZec21OH
         t1AuJcGbjga0vnLcBp+HsEWYsIModf4xnDhRVhj1Nt358oX/Q7hfxaiHFuochHuUzgWP
         LUT2U8GA76eYYmrru1t5LMhT42g4z+WwTHRzd2piVn1HyjHSchUz4Hv4+tMFe4Mzal+U
         RHgHntwwNIspWf3/JgHYTDoym9OQVefq06vIf7WHdoMVuT2B7Vlshhknw3tvVbraakkj
         N+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497184; x=1778101984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/d6zkx7NKPUXdGKIfW/EZhJzXWtCzUMx94HJuI6ADg=;
        b=nSlZ1YIxg1zcEkXPs5w8xSDjC2riD1sVg6jjAsB2KQ3xi2R/HDwxo15SS6fFcliV2n
         qBCoXK6qrcfBb9rQO7gqUKCjXwtfDPCZdOD9YeqWQXILS6iRkyZnGQo82+SKMWRbuN9j
         lUlxdgMNa8Cnw4RKU3WrpBbbTf+KGpD/oIoAUZJJmv1yx/PSZmhmoaT+e8lEpM3HiJzC
         y2LU/jfTMbX3BvvwxmPZWMb0PTS+Aya9YYnazeOKmKn5GSk19u5PF+iSNFQ804jZxJ9s
         A2Zfg5Ug+rLJPzHX5frythTFxaNjV8W/D0oEBgCq9rc8TIkB6svFaBFjKRhe+qm+A42s
         2YFg==
X-Gm-Message-State: AOJu0YwD0TM5xmwj/XfmvyGW+BGHRUSkUklOPzffbmdVZPhJyG1fo9l/
	WWobsN6znqw+5pvku43VvFIRLRdWZo9vz6xE7WJKGcp5sK08iKjwSFnVTr+KFQ==
X-Gm-Gg: AeBDievK9VDv2UI4RctkLrd1EaPaqLQhLYa6NtvkrRhg16tOi+TvRg0ZBgCQWxPe6By
	r11JScNqETEpCEDwOeOQxNsyYjkQoTHXenO7wlKQKgq0H1r15Ga92Rm32CYGnJWPpTwFDrdFNOF
	kPh8RdbWIH4Dh2I6n1Bn6WuQmt8q5zlY4yQ07A84IJ56D0zeiD83U21rksKo629RG+KBmz9BWl0
	7XJi+yvLDxXnY8OMoiDGhuTgftzEK9Rrft3dmGaadxmoO3GlpC+N0nkkPFWWBPLS3SQ6RjYL1F5
	ThDxYzY6PXicdp6Ef082TlMPIDDPbRGvVgD3uWufjdvs63S8/qbx45RXm3bzsnoMeV2OO/Xh+rk
	wpj7+RVp12CL/3E4WxoniRX2OVqXhvgZvrYxboytqYkO8T2xER2UNaa1NsPfnZmOF3uLMhTtBbB
	6SkWC2l6fUgD8j3SNQKyIzO2I53HaygZhfWqJFqiQRtSZ+6LwV2dGeZ08haFBkno92sqQJ9IkDX
	6AoGQ3U3V7SdsXQ0Y2klG7zmIygcnNENhiTnJBpqi+26i/YsMzgGidFI5otQhFexg==
X-Received: by 2002:a05:620a:1788:b0:8c9:fb69:e708 with SMTP id af79cd13be357-8fa86fa814cmr78830085a.25.1777497183939;
        Wed, 29 Apr 2026 14:13:03 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93cff8e85sm280355885a.17.2026.04.29.14.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:13:03 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/3] selinux: prune /sys/fs/selinux/disable
Date: Wed, 29 Apr 2026 17:12:28 -0400
Message-ID: <20260429211229.3750-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429211229.3750-1-stephen.smalley.work@gmail.com>
References: <20260429211229.3750-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f22f9aaf6c3d ("selinux: remove the runtime disable
functionality") removed the SELinux runtime disable functionality but
left everything except the actual runtime disable functionality intact
and started logging an error message to warn any residual users.

Prune it to just return count (i.e. all bytes written successfully) to
avoid breaking userspace. This also fixes a local DoS from logspam.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 71ffa64b15a6..2181c82b5159 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -272,35 +272,11 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
-	char *page;
-	ssize_t length;
-	int new_value;
-
-	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-
-	/* No partial writes. */
-	if (*ppos != 0)
-		return -EINVAL;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
-
-	if (sscanf(page, "%d", &new_value) != 1) {
-		length = -EINVAL;
-		goto out;
-	}
-	length = count;
-
-	if (new_value) {
-		pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
-		pr_err("SELinux: Runtime disable is not supported, use selinux=0 on the kernel cmdline.\n");
-	}
-
-out:
-	kfree(page);
-	return length;
+	/*
+	 * Setting disable is no longer supported, see
+	 * https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable
+	 */
+	return count;
 }
 
 static const struct file_operations sel_disable_ops = {
-- 
2.54.0

