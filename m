Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCAB2253A1
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087643; cv=none; b=EaPlNUI/KRCpXqKFoISf9CFhmON3lfjh09th8D0Ji3maSk5FqlkloRoECI0VJuSJiQMjX8tAZ/QuE/H0gr+WzerxOUoEJZuJu7amNvstKqR296vofTrMJ/LnjWv2iDhs6wJJUfxbZX7TH3iIyOTaN0N+3Re7qtOXk3NfkWwMMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087643; c=relaxed/simple;
	bh=5Thrqr3d7LyhH5/DrRiIRUkCwHcWmCy//ZbE+TaZK9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A80yvPaW4/1wCcy+rHRnmZrB4kJm4ktuPLLbSFLPxZ83IIv58pVlYJ4UY5DyNB7hm6FkDWxy6ckVn5s6QoXwdxunyI1J1fR8Hkke9AKVJuZBV8bWsVE2RcgUyK4z/j/Rh22HZ+MbbjIxW0S58NuZodFED+Grub5HDxLsp4hc1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhC3/p8M; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhC3/p8M"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb769ca17so34052991cf.2
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087641; x=1790692441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmNUERpsJt6op1fpVDk0HWbR1IQoc2JnA50D1aIQtwY=;
        b=QhC3/p8MSj8E84YOQgdHJR62r4ZXsnL24MurLkdgTflQF+BEkP9Rg7Zic50s2gfP8+
         oxVf9MgDpzOWX5K3eN0Pi92GJLN4Zv/XY9EdSRAH6EIr2XMztDnmXL8wMpxpcwDbafn6
         sTFYWM4zJzhc+fkTN/KVmHb+8gJ024NDT4/aKk6l3pGXr+BtDwzYCRq+WZUTxa908Pdb
         7mRoryzlLpjqKVcH4yEsnS4+cZEbc6QTrCAx5aaX4hzZawUKewQUdXdCRWp2K2HwXkaS
         JT0UDWJ/BXHTUXujgOxE988DQn4cl8b7oh7GRKVwIAvbrWyZcsKRN7I4d2DFO+dosEf8
         4DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087641; x=1790692441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmNUERpsJt6op1fpVDk0HWbR1IQoc2JnA50D1aIQtwY=;
        b=MWv45he31GbI+L9cLJP0+7yNhgHW4oDiu5BVGPj/hncczRqO8GjMZIp49Mk0BgLa25
         GDGPXla2Vw2IryT493L+xAKWBzmkbuFe4C/BR7D2Z52Dp3VTspRfckn+w+vWV6yGli6h
         d7WtywSxvVOZM5PcV9BFmOxjEBLN4n3B/Wrotu6LgvzUGLSgQG1gXCXfoyWpTjWouqcp
         CotDPN+ovqdYv5G1h26pHGO+S6SAnM4jCByoWctDqP7VJk/jMmVubjXrD5D0PpkosVHK
         GH4CpnCiFqhujze+xXOLXNFtpgXYpH6Pt+Uxc0LfMpvSkt1CKq6iVwKsdG2oAmrA2lND
         BXNQ==
X-Gm-Message-State: AFuF++lPmWBnGCjqOOHytzTP+b1TyHSFTAq8afD4Z3cPeMo8D6WCMDbi
	EpbPnkVftm9LyTG44XCQAU4zn6zOL9pjTACYb0Gf0HgkFYAy5kgY0KRj7YaVVQ==
X-Gm-Gg: AYBFou1Grdk0UrNRuQGteLciqSZyZngujIIHbOc+pXAJZufBrRoV+88kp1T4G8RUJwc
	HK+ylhxwC40UEBSEUw827qSoBCcjdMdmerE2J1k8M/evG7CO3+QCsWgauURfrgohke/Qk0kDOUf
	35pVPiA+qtpDf3jRJYAgyMuwun3Y6G5fj+jOEIY3Dy42GSZfxQmY0Dlv/JP/zdFCkDyPB52UFfs
	fdHi5kKYDCSJtyXjg1SsxP46b2o0iUQ2DKZykB8RXCdcEsCqBWwP3z5NAofeWuxXpZ/NDAMl8b6
	ceR2FawOsHq8UMPoXKBEIbbjOBGrO1sCU+uPgrKhrb8ssDYVN7Nfg1wMCleco5zOshZyXwTCrFh
	a0Bgtd2qxW+YTn4z/d6iaFcrrKB+S3I1OthytAX/8C4AWy+3CPzV3/8heii7nkYIczTdYeAij1T
	bbMDQiLLp3omgbSC7Qgb5ZwsySgfQYhbdwqrPV5++8ic4ACAXnSJl0Q07GZYxJo3EkxRz+fswIg
	WoUnjHZALAMtAh61aX9VecS3bnFqL8DJ65sjSYmxqNyFFmuqPdpQhzkj4fsKyAFKCNYrDKqIu0=
X-Received: by 2002:ac8:5d15:0:b0:532:d5c5:8eae with SMTP id d75a77b69052e-532d8d47ff4mr61129641cf.27.1790087641114;
        Tue, 22 Sep 2026 07:34:01 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e1716786sm14227871cf.4.2026.09.22.07.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:34:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/3] mcstrans: search fallback configuration roots for setrans.conf and secolor.conf
Date: Tue, 22 Sep 2026 10:33:44 -0400
Message-ID: <20260922143345.46093-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922143345.46093-1-stephen.smalley.work@gmail.com>
References: <20260922143345.46093-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open setrans.conf and secolor.conf using the newly exported
selinux_policy_open() so the same fallback search that libselinux
internally uses applies here.

Include= targets in setrans.conf are user-supplied absolute paths and
are opened as written after glob() expansion; a vendor setrans.conf
that ships under /usr/lib/selinux should therefore reference its own
Include= fragments by their vendor-root path rather than /etc, since
the search is not applied to Include= arguments.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcscolor.c | 9 +++++++--
 mcstrans/src/mcstrans.c | 9 ++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
index e4a0db74..0b2dfef1 100644
--- a/mcstrans/src/mcscolor.c
+++ b/mcstrans/src/mcscolor.c
@@ -263,9 +263,14 @@ int init_colors(void)
 	if (getcon(&my_context) < 0)
 		return 1;
 
-	cfg = fopen(selinux_colors_path(), "r");
-	if (!cfg)
+	int fd = selinux_policy_open(selinux_colors_path(), O_RDONLY);
+	if (fd < 0)
 		return 1;
+	cfg = fdopen(fd, "r");
+	if (!cfg) {
+		close(fd);
+		return 1;
+	}
 
 	__fsetlocking(cfg, FSETLOCKING_BYCALLER);
 	while (getline(&buffer, &size, cfg) > 0) {
diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 9704f5dc..20b074cd 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -921,9 +921,16 @@ int read_translations(const char *filename)
 		return -1;
 	}
 
-	FILE *cfg = fopen(filename, "r");
+	int fd = selinux_policy_open(filename, O_RDONLY);
+	if (fd < 0) {
+		syslog(LOG_ERR, "%s file open failed", filename);
+		return -1;
+	}
+
+	FILE *cfg = fdopen(fd, "r");
 	if (!cfg) {
 		syslog(LOG_ERR, "%s file open failed", filename);
+		close(fd);
 		return -1;
 	}
 
-- 
2.55.0

