Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB62ECD3F
	for <selinux@vger.kernel.org>; Thu, 23 Oct 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218906; cv=none; b=m8za29cDL7Uwm+6B7JpNSbrBB9JQjdEaPID+5nIiQdTi2W5vWaLgB73oQZ02Cp6kfQBU7RbJ9utWcx+ZRv+3IEGE6+/mHZP+xs7auWapKOM7e58HK/7GI6+pG81pciLjF57Cyw/Nw4LgBKay+3EDWgWSMVbFxLO6Ic4lP0ltrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218906; c=relaxed/simple;
	bh=xEJ8xmksDCO68QlgMu6kHN6e2tdE6aDoB8ZnbtugNB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hXfW2fTHFalAl5i3mEVD/3g2QssgaP8Hb3oBi6pt5wqF7FmpTKdkn1LuLm2ZdkAmKALjFJljx3D7wbkUgVA8EXBuUIccVC8BiqpcMN0EnxGGoktx+MOQvx0YVc6NZIAeCt2YJWdDQc2uueLDzQfVWwdak3AZq9VLlgpB/1NKPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FARgDpV5; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FARgDpV5"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so523581b3a.2
        for <selinux@vger.kernel.org>; Thu, 23 Oct 2025 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218904; x=1761823704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WeGo6oTt2UUEu258vfpQl+lWEvdRCYo6wBNdmy2kx8g=;
        b=FARgDpV5b1s+Kd0nx/yYs7isR6LtCB8v91o2RZRZa12Pwf7n+F1EkFN3yCK04inEsB
         cHWJrf5tb4YhdrbzSfUsnY9DczkhAa9F+vJtV72OIO2IGROs8AxC0yE+Dr+BWAGXt5qZ
         BJ4+7LuSZQaOOr0dRWs1eTZXLRD63aWCXtjHVofiPD8JVDnUWeKcyDOdIXm1A8YKSmUp
         LgMFTreGg/E4k3TbSIQgmeYcMGy9Bz9occyrUJbryewOBpyaMDFokNuWODN02m0kVMcZ
         Z7Skfi9bKYqcZYFafGZckr+o+Zwo4nWBsrGTvdc71VsTQ5WrqFTHIxMgxll1DwRISJu7
         RLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218904; x=1761823704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeGo6oTt2UUEu258vfpQl+lWEvdRCYo6wBNdmy2kx8g=;
        b=nngl2FC7p9cqsV8MMTAwH9qHSOBP0rzB6NsOuGtN70G3JXW6ZIHU6WpxF3FtIMKnjy
         oxHyPzAEBX/biRd3aCI6lflSDJnampeVIWOUGodgm6lIVnDUCa7bPKGY6UE7sjm5nRvy
         t8uEGqvDFK1N1RefIBo4202Ofs3I7kv5YDLuYDPQzMPjXZUjUorVj6VlET/tY73JeBQg
         nZVwMCRNyWNgbrRXS2wd3isioLIm2+SvVN2siJboZP+nRm1EVUya7+Kxj0znYDoEH1K4
         ZSDUgthO9OeU+v12gk3esCGwS5GPdnXABpmrRKMTr8MgvmWestHb6qHEByfznl6T7Gnl
         /Azg==
X-Forwarded-Encrypted: i=1; AJvYcCXIWGsxbiB2gzrT5LdSb8J1sRqxe4LPI+gynKxJaWNB1aD17PlBC0u+Yuw8jyDpQ6vd5ehndL9b@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8xD3/7KGZQDZAp6BrTkuITAbhXadLHXG0oDqvKga15UrdW2Y
	W+4Y7T9PIgmZkZl56ynzdwCAFvjvdJ8JxPjB4583DtGK7S9pnoyEg1D9
X-Gm-Gg: ASbGnct2nmIVh+rEcPzuL1zaqib3HN58nbXFsborotNkHG5xbaW3D7k+8kgkvzKlJRE
	VK3e2fNv7OgDnWxarrT5Ji6S48EWrQRbqGPvm3voaMsYAFn4m+9CAyBxVmHXBHfoNr937rKOtKd
	vrkRBttO0mzPShoWEif82HHQdWSJU1jLivwx1BxS/d5VYdSZd6l04rvQ6Xd/yZyPrGlG1ujUrzi
	0yhflxKXGj1yq1GQAPkKV4WWQQiqugSKEvBXuAsV9pQsL2fHkeWlVH201YjkpYoJzlMOytvxywp
	dQPKNGSnCkErP5vs8sSPWkMRTIiGIJowx8BEcej1p5Fh8HCJFJeeXcgca0zNgjC72GPWgQWUGbw
	8AQ0xnMozWMKg3ddnU2fp1u1XuPiTz/nVv6SHKq8oBEwFQg8yhyJEURWJluxr9eWSzY5C/bKpi6
	pVlh/Dd3rk+ocBWJS48Q3A3K3el4BX
X-Google-Smtp-Source: AGHT+IG2udP4swV7OHHKDSmKceMu90JbozzjLhfR7TxBH0NX/JY86b2HJ1oNZwcz6KZq92xtEb1wSA==
X-Received: by 2002:a05:6a20:e212:b0:334:a681:38a3 with SMTP id adf61e73a8af0-334a8542a1dmr29714656637.13.1761218904027;
        Thu, 23 Oct 2025 04:28:24 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb86cbsm1826524a12.7.2025.10.23.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:28:23 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v4 0/3] selinux: speed up avc_search_node() with large number of avc nodes
Date: Thu, 23 Oct 2025 19:27:55 +0800
Message-ID: <cover.1761217900.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On mobile device high-load situations, permission check can happen
more than 90,000/s (8 core system). With default 512 cache nodes
configuration, avc cache miss happens more often and occasionally
leads to long time (>2ms) irqs off on both big and little cores,
which decreases system real-time capability.

Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
to mitigate long time irqs off, hash conflicts make the bucket average
length longer because of the fixed size of cache slots, leading to
avc_search_node() latency increase.

This patch series aims to expand AVC nodes without significantly increasing
avc_search_node() latency.

This is v4 of the patch series.
Changes since v3:
- use MurmurHash3 to improve avc_hash()
- add a config to adjust avc cache slot size instead of kernel parameter
Changes since v2:
- update changelog and fix warnings for commit ("000bce8f11d0
  selinux: improve bucket distribution uniformity of avc_hash()")
Changes since v1:
- improve hash algorithm in avc_hash()
- define avc_cache_slots as a static variable

v1 discussion:
https://lore.kernel.org/selinux/20250905100454.685866-1-zhanghongru@xiaomi.com/
v2 discussion:
https://lore.kernel.org/selinux/cover.1758633723.git.zhanghongru@xiaomi.com/
v3 discussion:
https://lore.kernel.org/selinux/cover.1758859391.git.zhanghongru@xiaomi.com/

Hongru Zhang (3):
  selinux: Introduce a new config to make avc cache slot size adjustable
  selinux: Move avtab_hash() to a shared location for future reuse
  selinux: improve bucket distribution uniformity of avc_hash()

 security/selinux/Kconfig        | 11 ++++++++
 security/selinux/avc.c          |  9 ++++---
 security/selinux/include/hash.h | 47 +++++++++++++++++++++++++++++++++
 security/selinux/ss/avtab.c     | 39 +++------------------------
 4 files changed, 66 insertions(+), 40 deletions(-)
 create mode 100644 security/selinux/include/hash.h


base-commit: c6f0a830ef4bffc8eedd7ddb307bfba4929cd3e1
-- 
2.43.0

