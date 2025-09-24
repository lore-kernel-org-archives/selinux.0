Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE894317D
	for <selinux@vger.kernel.org>; Wed, 24 Sep 2025 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758682533; cv=none; b=QhTh3p3ysteTtZvgYqKKPh18U/4n+Zu2rllLUQGDHshn4tgw0dvFkljMarmhNn7EITmbS+E9Z1TO8UtFJKsxRil7SRQhH3CN9o+mu86uwkO4r4t122YAP0x6g5wHUv8XA/FSL9KJLsHgHVFSJrPgSa6F0Qo34gje6W3msi2ABuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758682533; c=relaxed/simple;
	bh=bm2epe93zLMC1CmNPO/0bKANSpaCEfsZMpV2wIYXwD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHVbnMaxOvFxjgrHea5ABPdE+zMSavHXFwhoXNKh3U73hD4MqQsumpwSMz8F9T1W/fNs2JqPMIW2lOjBgWAeyhBNQXrFToNDe9F+cUEn3/cwbomFX83/AqnTokDBgGhE1dWDsycXaALeVzJnTPaxx2FcZqUC4wcyB2rYK9INb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIzNF5+1; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIzNF5+1"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-27a6c3f482dso21443285ad.1
        for <selinux@vger.kernel.org>; Tue, 23 Sep 2025 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758682531; x=1759287331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=il0Rh6jjeeiAS7jzN7tDtV9HZWk/D2ddD41PvShuPbk=;
        b=OIzNF5+11nzpevbwtGGWzjGrA/UvUoWjcW0X8sMeAg1H+U4HRm5O3yjcIx7o0AN2/b
         XstyXFFIhSUvtlWFr3JWudVDsHNP/slQR/zA5BEMHWXgSULrW7H91KUpdMMMVRq1V03U
         q0k39WdBLreoGTophyYhpTXSnUWvFBB120TU09W8iimXmt4QMVcC7Azz1k9RQBzPZ/a/
         EaW31ecGubL+BarPSIaFtYKGiS4hS3zwPr+layZg7YAf/DT5yHFq6+Q8R45J34FtXefK
         IfnY7RBFcpBdYFgeWuQBhYa5jzpHPPkmGirIMOg76G7TLCztJYTgBcEUA+1Wwg5AtrN3
         UMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758682531; x=1759287331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=il0Rh6jjeeiAS7jzN7tDtV9HZWk/D2ddD41PvShuPbk=;
        b=MoRuk4ouC6RwPksjhnD9YUcE0dAUEZgq+cBfEf1WJUhtg6DTY04j0wEpPxu+9jD6m9
         zU5fjqEIwOdzImHLgPr+g3k69mQMLdAPzr2F2HacKz/hQwdUlYb9DoLqTNiMhQ4pL1Le
         S5cnNT6Fyb6LMzT9Mcd85pVmRfzIf8vds7YKQNAOcu0xfYpaRGTqwTizqfp2x4rlH0Wf
         79RwpDZKvZw92BsjTyqwt35tKo+0gXQvLlRLQvcSlCF3hTxSMM2RRWUhi9zrrysx2JBS
         HMwo+sfCCcm7f5PqtzmED27b/F5RixHlDOaSwyqm84RqmEBmVnkq08eMsNbFBAw220cL
         VTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyzR+qfdJfCBemLKjykSOR+uFgFuzgKTQmOI+RcubRUv6dVamsNWrh+Duc+zjanI22D9tP8fCh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/jT4kvKwRZbbJL+BqTK35zGk99wlG5Fnn26mUIXtBmZdsKGVj
	1oR78pn53r7M3tuA2Aesl/gBGoHW0CzCagFRieRgpyHCN1vi7dVU97PE
X-Gm-Gg: ASbGnctYlZF0KS13WrbKvXGy6dl8RUoC/bN33wzsueHZx3mPI0x3yawETpFTGb6o+qw
	nnyEa9YWw8RZllpHRCfKvhk9ClcFN1cz3l9y4FyI8H+8sPxokzSr9VG7Ed5z/dFXVS8Lh/aSvVq
	PH0wUDLS3aoC5ZK6bmh1dukpoPfRN06o9mcZaRYOnwgQ+adUOWyXX9NLIi7EeqEdudvQ+B0TUja
	L6FutfBvuHorc5BknmaPdMeuHn7fOOsFJ7aYBgf6yPyibVHkhhSKnpSkpM7DXSClGRECRHMaLRX
	kxoG/uACWfFrPZfM+oSUxsdb9oUKgCs1F9tNU1hf7Miwi/4X2fmKYHqdo6nn3tTd/A87G7QIoLU
	YDT0JZHDos1Qz5cAb5nCZ8C7x5zBMo6g7ijx/MDf/5lqHEMhC944=
X-Google-Smtp-Source: AGHT+IF1meMrMvZtj8Zhw9AeG+j9x3fUMEf06X9X2JaKe3j4NHlXZzTdJGu3JBvEXaE9LIEr1DLkMQ==
X-Received: by 2002:a17:902:e790:b0:26e:146e:769c with SMTP id d9443c01a7336-27cc79c8873mr60981165ad.52.1758682531425;
        Tue, 23 Sep 2025 19:55:31 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980319870sm175895955ad.120.2025.09.23.19.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:55:31 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v2 0/2] selinux: speed up avc_search_node() with large number of avc nodes
Date: Wed, 24 Sep 2025 10:55:19 +0800
Message-ID: <cover.1758633723.git.zhanghongru@xiaomi.com>
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

This is v2 of the patch series, addressing feedback from v1.
Changes since v1:
- improve hash algorithm in avc_hash()
- define avc_cache_slots as a static variable

v1 discussion:
https://lore.kernel.org/selinux/20250905100454.685866-1-zhanghongru@xiaomi.com/

--
Hongru Zhang (2):
  selinux: Make avc cache slot size configurable during boot
  selinux: improve bucket distribution uniformity of avc_hash()

 .../admin-guide/kernel-parameters.txt         |  4 +
 security/selinux/avc.c                        | 82 ++++++++++++++-----
 2 files changed, 64 insertions(+), 22 deletions(-)


base-commit: 68e1e908cb7682db9fb7f79907f9352435a81c0f
-- 
2.43.0

