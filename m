Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C119E7F9
	for <selinux@vger.kernel.org>; Fri, 26 Sep 2025 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758867791; cv=none; b=fwm7wyoxMdLTXGgewWQwhAYhGScheLj99q3LMj9ZyUVujxLsDRrhf8zcRHcPujp3P0AmZExflsctBcDoP51u3Tu1oLlZa3l/rwFe3peake1y0rIWMxJcStvsPKZrcOvWjaubyzKA3dbLBAzj7tozUOJaPK+JbLvJJep89RiYgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758867791; c=relaxed/simple;
	bh=hl06/GejOj67dpIRfbyeehkpT5QyoISw3+NnPMbBMTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3XQtzO3MpjQdTmkXSmVj/siSW4Bqq0fhgM+Be3UcT4k8ari52BRqptSCQ/wC9Wp8KcuM0/GC4gVK29PSO036fdZ5Bg85LiJiIPetTtSWNw9rsU7PjFgEUKcYPjcGKSTvnmnxgPORtOzOZvFTu6DvpW4fJJqPPSOcydEAEs3lys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH6p1cO1; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH6p1cO1"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-27eed7bdfeeso7444405ad.0
        for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 23:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758867789; x=1759472589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXqzzN/wLuzy9B0JFPQF3WHk7WqttvDi0Eb7LF+6B7c=;
        b=nH6p1cO11+T4NZydvKj8cwzfKxzT8e+wI7x89o2N2JrhValECNNvISJPyF10E7kO9P
         h9OONwj1ZlFH+C9blSJhZdgQKKLLq/RoyLeiGfNI3IhcHWrX/xbfFtCaBEa7ULo4MO9g
         V5oFq5HitnVmiIjX+YOZWvZ9slMnnZaII8JNktod+d6R4tV9+MUe75r46HeMq3bvw/SU
         vuup4o5C5yHutySQFFwcmzGuSuQcsPbwnULJZW58q8gih5PBBSkOBawg3tvUaDAGkNCy
         AGg9pOi1jnEUa/Cl9ob1pu9dO3TKMBsu4n/U64j5cbRic8ZLtC3qykISch1lfJxWfC4B
         hp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758867790; x=1759472590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXqzzN/wLuzy9B0JFPQF3WHk7WqttvDi0Eb7LF+6B7c=;
        b=lUvWWte3msU6nxPukPlMqaz7E1DHywK9R2hT8h61CFdAUUKE0Qth8wvphjm6g8pt5N
         Er46gXXdo0cujpogGGz6WMcUCJXbGK1cUCwvgQFXpj7gAI3BePYePruNswIxgTf5GVLo
         +xMT4Tci3WFgIxdvhE8UuFLJnG/PLP9vFqCWTptwATbxHRFN/kRzCrPamzap96nVD1L/
         ro8vYqjdgHhSpu4FNPGfWT22U71IOjhNwVfREWUlh1gOVm0J+pHqJxE6b0+wpfI+ZriZ
         +NED0BKG83taPRyhJOctvpmII+lqRt1MmO6w7ETr4n5hnxoNnBGx476cDncrAwCKhnHj
         EFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4UYJ73LBBq3BsPxIUdi4EvKW/qmdJzEhlUx156yFOKQt9u/49DfweSGwZOefnZeh0/npKrCzv@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkD5uKh3YfBmllRKMCyf5Is3MHt7rYhxcQzXktgVIH/v9jR0u
	fcnmXumLjd0G727c9su6IBmN8THVhGc/Dq8tjdzAVxI4MZ+b35i07z/T
X-Gm-Gg: ASbGncuC/J1M22DRM1svl7fHv/9+FzREhRLGkg8PVzzJifcSEN23u+T7al02hAY2Woq
	Gp3PduyX1kSdZS3WpzcA9cE4jbJf07iM34Somtn5/eJTtatt6qnkd0HbA3y0pzI4LXqGRP/jx9L
	gQhicsckywQIsGzuWyyZq90YlBzpoJlkjPNHxU7diRHCsluyplz8/qq/AKCbeujH43v39XLu5Fd
	kxWgUGlRiXrl4kXfBBdMGikpAMf5hEAhjsl398uo3HQFI2G+ddAMjq/eEPvFqRmiIORBpmvTXFv
	5XBJpQHFT3u5jJjcs7iNgQs+k2d0wQ9rdKQI0LU/WNriyr8NNLPQlVjLTQ7Kvn2BNLasrVnWvN5
	a0erTwI82Xe7XhX4kIu8XumMIei75HSKwIytpBKFBpCVY29nvMhfnUctequzeRQ==
X-Google-Smtp-Source: AGHT+IHqTuzXjAiBFyYqSkJdGGhp4EGsOELDx97gEtLNeZslxl71fQpI7u0DQXy0uKoMDX9VETSB4A==
X-Received: by 2002:a17:903:41ca:b0:265:e815:fcdf with SMTP id d9443c01a7336-27ed722bb4amr53324465ad.17.1758867789465;
        Thu, 25 Sep 2025 23:23:09 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac966fsm42356755ad.139.2025.09.25.23.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:23:09 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v3 0/2] selinux: speed up avc_search_node() with large number of avc nodes
Date: Fri, 26 Sep 2025 14:23:02 +0800
Message-ID: <cover.1758859391.git.zhanghongru@xiaomi.com>
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

This is v3 of the patch series.
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

Hongru Zhang (2):
  selinux: Make avc cache slot size configurable during boot
  selinux: improve bucket distribution uniformity of avc_hash()

 .../admin-guide/kernel-parameters.txt         |  4 +
 security/selinux/avc.c                        | 83 ++++++++++++++-----
 2 files changed, 65 insertions(+), 22 deletions(-)


base-commit: 68e1e908cb7682db9fb7f79907f9352435a81c0f
-- 
2.43.0

