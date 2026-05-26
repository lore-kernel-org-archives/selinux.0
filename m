Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE13B2FCD
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803978; cv=none; b=VJDBV9lw1GJ/O7bDhiIljhmmD24bdn3P6lk7tnld0y2mr4KWov1kqtGvdBVfGOsIV5m5XOm5C3hChyRNFvg3CREmcuiUQ3k9wFkkaSILLRR/ihir+tJav9x1cVv0CjrczecSt5VACpE3CPJ+NjQtvnP+gGkbRz5iI9b6BOywkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803978; c=relaxed/simple;
	bh=oi8CEqX0uFevmntGh4NJtsQPvPMPp25lfU15JLRia6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JaWkErk01VSydTXt9Y8QXQluReNt/3nJ40xklCFc66sHgVrSmPGlrP6y8u1HJXF9NCD/qdOsYOz7BoZRn3F8Cm+dSvYQdInpg7XT/DfGrkXnrrtAreo1gyOvgpp1Wl33lh9Sr1tuNVzeNEB5iyOxukosbRdHYZX6xS9NBIc3j34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrMTZ3A8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrMTZ3A8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso7692054a91.1
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779803976; x=1780408776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBdZkb2RwHxx+FNg+ugjHpoi6ESbhLEgzYBxG/HNPgA=;
        b=qrMTZ3A8evZF+7BV4IPOIP59QEHmnbm0pAtdDJTCbf0LLp6PYMHq1epHgJyaf/Jcrc
         lm3V+doo+2JNISEwGF4ALhNXKoFzb2T7GOiBsXRoAJV8+s7Hk++zrjv2jw/iP21JvSGr
         Dy0SlgX7VC9oSgYrfObYpmJ1V4W3Poq6vfePE2L7WuBe+dV51YkXp4aJBL9lcwZ/LcXY
         LwC5R+S1wf9uneTBjK61FWiFMHyRWM2r1efOsG9RUlP9MidBc4AfDXLCEfRkOW58K/jz
         u4Jx5pr9iriVcFOBl5Emft9q03ehfsIXEbJP/ZD7TxFHq1ohoXk0/2NVlx4EvrIBiCRG
         xQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803976; x=1780408776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBdZkb2RwHxx+FNg+ugjHpoi6ESbhLEgzYBxG/HNPgA=;
        b=FTkhv2d2sSSpurjgpODU8nZjR/SGkthGMGDjbV+GHfnXrZDvvO0qCWwAw6LeIKwX9e
         2pQ7OZXk0NfAl7aj76ppj1Xpy4NM+1RKdudCmxgngOhBrtOGTdZRyy9g0HLMU0cQYCDm
         FAjl7mv6G2iHxVuXxKru3OwKkzKF7G1TEAHOvknRe9vLdMB0F4i2Ok6vM1spIBQX03Xe
         C8xgwgXZBSTcQ/2iabCgqvsH0VBCEb4j8mpdASENm/IfwleS9yIdJuKmY2Qe7FZzjmkX
         i1cSj0hG2MiabEF7JFt03zX4pqDBNBuoia5a3kItJbs6jyCDfPvKqCPCAt3fetKIX6b6
         sTnA==
X-Forwarded-Encrypted: i=1; AFNElJ95iLrUpKQ8cuQmlqjJiR+Y51RdT4s6I8pR1O2ZkfqRYxhmC8rTghAqMS2WoLSa41gDxt47udCe@vger.kernel.org
X-Gm-Message-State: AOJu0YyvitT4Djg2NLcZf3izw9m9hM0Qkv2qOs4gTygJW6UrVByrNmFw
	yN2bgfxdmC58C31U49++2+Y2zxFvFDR1QSTy46Uy3KTlH4ULbnB/EA93
X-Gm-Gg: Acq92OGpmzQ1LRCS8j+/nERWrM2NlurSNjXHM01knMnUXX56O7KdUZ7Z4tTIOa1hB2t
	OX/dzHc/hPkv0TRGeBxsU5C0apndVZDQBxNvkeLf/92RH5pE+Lu78sYEBaJA18meHaph42O1BmO
	UWTnxwEGbz9+Z/CTBWsrZM+/ytRzm8tNVMWk7SqcAqo+085/4ZQ+Qxi9HKgXn14pqukF0+R7Lfk
	+3FFf1FwAomBr6TUlRZlqFi5XW4aHVdehujV4XL+59lV6Zti/9pPkLBGsNl7r63jZJ4SnI2BU7t
	0Q/7bBA8N062jZDGPyTHpQTcMO27+6Gms8BKuhEU9r2wPrQzaAktzh0g6QcByeIzcVHJiTVhrO6
	fBVTzHvNeHFt3fUOS9W766J0mea9pV2S5gD34v2HLJ6gjB+8fX9gOLJkqZA7nPnexrYJDjinHxc
	9uoeIWpZITt1Bvqx7uzgcy1BQLAUIA+SF1pAk=
X-Received: by 2002:a17:90b:3eca:b0:368:864:62ad with SMTP id 98e67ed59e1d1-36a473cf321mr19356488a91.3.1779803976361;
        Tue, 26 May 2026 06:59:36 -0700 (PDT)
Received: from ubuntu2204.. ([171.213.255.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a723dfa2dsm12684682a91.16.2026.05.26.06.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:59:35 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: stable@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Liem <liem16213@gmail.com>
Subject: [PATCH 5.15.y] selinux: enable genfscon labeling for securityfs
Date: Tue, 26 May 2026 21:59:21 +0800
Message-Id: <20260526135921.17453-1-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

commit 8a764ef1bd43 ("selinux: enable genfscon labeling for securityfs")

Add support for genfscon per-file labeling of securityfs files.
This allows for separate labels and thereby access control for
different files. For example a genfscon statement

    genfscon securityfs /integrity/ima/policy \
	system_u:object_r:ima_policy_t:s0

will set a private label to the IMA policy file and thus allow to
control the ability to set the IMA policy. Setting labels directly
with setxattr(2), e.g. by chcon(1) or setfiles(8), is still not
supported.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
[PM: line width fixes in the commit description]
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit 8a764ef1bd43fb2bb4ff3290746e5c820a3a9716)
Signed-off-by: Liem <liem16213@gmail.com>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 69143a216a3c..1c0f8209f130 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -741,7 +741,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    !strcmp(sb->s_type->name, "tracefs") ||
 	    !strcmp(sb->s_type->name, "binder") ||
 	    !strcmp(sb->s_type->name, "bpf") ||
-	    !strcmp(sb->s_type->name, "pstore"))
+	    !strcmp(sb->s_type->name, "pstore") ||
+	    !strcmp(sb->s_type->name, "securityfs"))
 		sbsec->flags |= SE_SBGENFS;
 
 	if (!strcmp(sb->s_type->name, "sysfs") ||
-- 
2.34.1

