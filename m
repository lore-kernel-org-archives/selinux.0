Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184042BEFE1
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080964; cv=none; b=BqBgRiUY6l5Qzwpxveuj/llZqMqD+EaUsPwaw3HZZdHDxE2vqOpM+8eOzdLkb3g0BwjrR6bPOG8JzovK4pCYBOzJ5v0KaTqsFrxTW2sb8SswUkzR7bSIPh2J49Tj6dsEBni1uhUvEMOSV8OGX/JW1R1bjwg53Q7jFnr18x4qaHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080964; c=relaxed/simple;
	bh=0eybk6nZpFHa2slxnlNcQpEg36rPhKddQwXkvGtf9qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3KipY8WZXY46SxZwy2OvuJvAHIuQbQAx1WTDtsi6kTX3mRKbiWFBI+RkNm/dd6lD5dJca96+VU+TbUW4+esiLHzx096w2sRJV7V7u1cgfRfbvM26HyFC/5QQz/6Ue3upKtKoHOf8NYprQiiwjF4S1HRfWq98gzcBv7YxHhYL0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/+mghkH; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/+mghkH"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so46954796d6.1
        for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750080962; x=1750685762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLgT8/NTFfwUXus3UL1eYOxM2CnTbDhxToVAfAvv/wc=;
        b=A/+mghkHGsoC0N8EbZ0mgbiOxzOUboYhv63kGm5clt7CWT1RD7bw8v7OBypZLuCehH
         adiDVC+O8fyW5oLb4keX3eu4RN77Qp7Xdu+0RHLIf2Y1ClSiNwCyMS5hwJmzofWQ/1kK
         T+aePhj4mIXLIFhWdaWU2n3IlWoxA9EbhZ2MF/2vp0260si+le1XzK9WpUy+/pAIYxK/
         HvU/SW/FZ5e+/26lt1qfQzvynXkrlCvRIxYVp16A0OwI64MU1qSZSsYgsb72fZsQysKo
         2Bvq3veWQa8mKBMQXve2Kxo67wkZMuCYuA4z5sUbMqQSvGCayKsixhiY/AGWKiDkViS/
         lzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080962; x=1750685762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLgT8/NTFfwUXus3UL1eYOxM2CnTbDhxToVAfAvv/wc=;
        b=u3vcNn2S/ecYrmZeSvcsheItOXkjfeMdkpJqAxxOK3SmmRvfHTx4uTT/CnceQj+SpX
         N4pkxwQ2TQv4PPAOkaL0uzczmNMvcbfkrHwqC6nR0PantqBOjX2Cd0sgCrtQNdPfzgxC
         rmmQtcBZokMcZlhku2oFw+JRVqb2Fub7+cwy+4aHalUfebhsRopvL5lUKdy0MkEdvzRV
         sir7t0ryVfXGJZ87+TV5zpbBYn9r0TDenNGO7Skl6ql1kb2OY97g1Rmp0S6sZ3QBzl5w
         DQuE1aRStun8HHIKYgY1EV7qd8/ulWaXuNfqgt0hRjzcSR08HEsddL97pSEOM3Q32HkH
         DgYw==
X-Gm-Message-State: AOJu0YyTBTIhcksga9q9A59wLHNw5RTcaP5mdxqZ3uTXI+uluTnejPl6
	fnJWLyc2k6TZW9ppqR/ihz6CuJEtBD/veHKMJ05uhNReGiKJux/7sitcQEZNfA==
X-Gm-Gg: ASbGnct/wEo1GsVdghf3ii2IXfUFGqgx5OEGD7dr9d3x74KrN3S80ehpm8LHed/mVsw
	mn07zi0YZVZdNwPo+hdpsa1N9O9WZrmBzD5mHUyJ+CZPTByVX2/xdYoQ0qNWpATzth3xnQ6rVaJ
	WSRPpIX5biydTMB9REXfFTIsC2Rg0Uc3sIowL5hnhBXWVpKTmFPMtD97CGNb8Vk/2wwAKyuThW8
	fg3rI629pWnwVxk1NHD9cgHLw6y3kZG3n+gaGHXfTUo9dXKf4Yor3LiqVTA2e+mWcRIxTQo9fuu
	FxVOZBmo/x4Nb1UErAfPFAjENBf6w6knh/4TAmfbk+TxjE1eIjA2GyRrXmPQ0HGq3ACzkVgTbup
	f2evhRxkOCvWOB4xMrniwU6rliK9s+hsVGtXRPeebwizZDnDXfZ33pHDgaDlnRCFr/GDWqpts0R
	zOOuOAgw3BT8l84n5y2kWt8wDTbQ==
X-Google-Smtp-Source: AGHT+IGHUeKmTTK7fkf4n9/6NJeAzBzroazkPU3Pz1rpTjQe9njjESheHFD/q7P0+VpHzj3YjscQ2Q==
X-Received: by 2002:a05:6214:cab:b0:6fb:1db:e9e7 with SMTP id 6a1803df08f44-6fb477383e3mr142337116d6.10.1750080961468;
        Mon, 16 Jun 2025 06:36:01 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c31a1esm51082356d6.74.2025.06.16.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:36:01 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] Documentation/admin-guide/LSM/SELinux.rst: add links to resources
Date: Mon, 16 Jun 2025 09:35:49 -0400
Message-ID: <20250616133549.23192-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add links to the SELinux kernel subsystem README.md file and to the
SELinux kernel wiki to the SELinux guide.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 Documentation/admin-guide/LSM/SELinux.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/LSM/SELinux.rst b/Documentation/admin-guide/LSM/SELinux.rst
index 520a1c2c6fd2..e8efa0499293 100644
--- a/Documentation/admin-guide/LSM/SELinux.rst
+++ b/Documentation/admin-guide/LSM/SELinux.rst
@@ -2,6 +2,12 @@
 SELinux
 =======
 
+Information about the SELinux kernel subsystem can be found at the
+following links:
+
+	  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/tree/README.md
+	  https://github.com/selinuxproject/selinux-kernel/wiki
+
 If you want to use SELinux, chances are you will want
 to use the distro-provided policies, or install the
 latest reference policy release from
-- 
2.49.0

