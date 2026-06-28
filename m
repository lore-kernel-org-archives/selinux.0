Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C074638D
	for <selinux@vger.kernel.org>; Sun, 28 Jun 2026 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782607301; cv=none; b=GdvIwpKMTJBs8pbxEgCeyD7Ezv7Xr0zb83rkjPlQNGcX+SuA6Lx9RV7EzNlzQrE0z52eO0TbXAls85fcfCBFvyR/Y/Dh7VOB1UhLVmc755xqJN3ejIQpsmoDnOFZRfho5UIob8rKH1qh8qeWKc/QCmnDEEY57W7laSLgvBqnHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782607301; c=relaxed/simple;
	bh=EuvogT+4tgFRQaRabsEihvQQCBjMwLZD2chPhkrgIgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfhcl6f2nX7uCg+v6fXAiCaHdi6I++WvBR9u8qwUswxyAhciWQM7xG0dCYwcfeod0uKti8w6yyebq1TM5Hl4sUeWPiYxXqBie+2VCmiWXWEZL3dAdU/TZ63ydP8Z4T9948hoci1j3I7DzDpMaQZC7AINEsv2BEXNf/QwxsBeYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LydU0yBH; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LydU0yBH"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8dedb44ed1fso22218196d6.1
        for <selinux@vger.kernel.org>; Sat, 27 Jun 2026 17:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782607300; x=1783212100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpQ9uX/9jCVkGsWOYgnxOv+cbv6fHXnpZeERaYN1V/c=;
        b=LydU0yBHRsHfMCCTSaGH0SdlyaUmXGTNUHSvM+v2BPVdjAo8HVm7oJKB3fij9qnxp1
         07ecmEX0HYh20rA9jjlmHmDVNF1TpRFlIx/kRwCq+yhdb69pl5LxRiX0fVmYx4x8vb3z
         sP/tN5mRip9iAomDGrAWpoxkmvBplXK9z2EJgxKlO3WnkRDTxFlp8RJKjHZPpFkLFqKs
         cKELc+yKV1zsMappTKbVGTvuqukufct8j1fHRfyvGAbiP6vVaSQ3KlQiqJ5mAsufKL0t
         +ZwQ7hLAQSXcNupoYhRJREoi8LZh2qNsRaPjvHImzmFzsf2HXqPMUjirfw8yaS+jeYtF
         9rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782607300; x=1783212100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpQ9uX/9jCVkGsWOYgnxOv+cbv6fHXnpZeERaYN1V/c=;
        b=RJH0Jy5jMtsr4PfvsS6UEb6+QYOp5iJyTZrxNYImImkTOMZdbQyBLiiKXir42CRnCM
         VPpcAebS6/0mc2myH1fI4kwoLmBmI0hBc0S+9eDEil2wGJldC6wZ2g5KSMfSx51rFCsc
         TKtOT96FIDBz9CT7NRsTQJylG0YI74RZ9ANyiKs4DpqP1gIj+AFqpN3jdcv558f5iKNK
         iM5fhQgLLcJPBe9mhS56tRnS16wL1/e/haf6MYMCyNLR3poygq034vpgoLNWUdpVC1bb
         lBLDjASyoC7cfuc6DgbbeWBulFhA+KMp+cbrpOBOnKThaVeD1OaIld56pQBRFmVrSCLu
         43LQ==
X-Gm-Message-State: AOJu0YxOYRGh345fePdQNIy73I4m9Ix/u77xFYH+ewrYSn6F+NAKSvW8
	HFO+glA7eAOfd4MI1TvmnUPV8MCg0ZmIOCC8P9CFA+VD8O35AEgk8JbuD67+AA==
X-Gm-Gg: AfdE7ckI16UXJtis/GWr67gonkk55Bg2FD7GYXiiySbXz7imqU9hBBqV0k2tFw8Jju4
	JafvTeF4c23Anhrb/y7GyhW9BVpqpcGLti1iFv78iidiayVzVizO9PW3cnz6U/SA7KUXaurd0GO
	rM9kuEOL8e45NzseMgCeDXD/aBPhwE43JgspS3+xq8atmFoVp+xZSQh/KQB9JnWugn9O1QvxF8S
	XCLgoDcK313Xpf7xCFmNtkjWnEUlCEV1JRPumliC/O/xfEwPm0JUw0KaB3uoDsBuf0poDNSHGHF
	ArY4PEjT2ZUgysWnNmRuMKmMX0nOAMNt54ZtWjmZFEIpEWe/1F6j0kNvhik5oBPOzKbyJbcj4sG
	hnMdOE+9SXyWdooQ0OBKr21cSLU9u5GnqqEXIT5Lr157p+nSwdtsB/E1RQnXvBHMWGG6IRUQR5k
	zouWyu/x6AjEgfUNHrZrbOXzwI1ODiZnmWbcyOoihsvKFO4jiIFtWk+T1xRL5c+b0vTweIkN/89
	gC65iexeZTM7EbRO3lHMVd4qfY=
X-Received: by 2002:ad4:5965:0:b0:8e9:f5de:d5b7 with SMTP id 6a1803df08f44-8e9f5deda40mr95603706d6.46.1782607299659;
        Sat, 27 Jun 2026 17:41:39 -0700 (PDT)
Received: from fedora.mynetworksettings.com (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7ef1fe40sm259090576d6.4.2026.06.27.17.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:41:39 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: selinux_restorecon(): fstat() if skip_multilink set
Date: Sat, 27 Jun 2026 20:41:30 -0400
Message-ID: <20260628004130.28649-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selinux_restorecon() must call fstat() on every entry if skip_multilink
is set to fetch the st_nlink value.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 0159fb7f..b34d8e60 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1271,13 +1271,15 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 
 		/*
 		 * Skip fstat() when d_type already gives the file type and
-		 * neither xdev (st_dev) nor add_assoc (st_ino) is needed.
+		 * none of xdev (st_dev), add_assoc (st_ino), or
+		 * skip_multilink (st_nlink) are needed.
 		 * Directories always fstat for cycle detection and walk_push().
 		 */
 		mode_t mode_from_dtype = d_type_to_mode(de->d_type);
 		bool need_fstat =
 			mode_from_dtype == 0 || S_ISDIR(mode_from_dtype) ||
-			state->flags.set_xdev || state->flags.add_assoc;
+			state->flags.set_xdev || state->flags.add_assoc ||
+			state->flags.skip_multilink;
 
 		if (need_fstat) {
 			if (fstat(fd, ent_sb) < 0) {
-- 
2.54.0

