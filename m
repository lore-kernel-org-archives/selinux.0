Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1707482C6
	for <selinux@vger.kernel.org>; Fri, 15 Mar 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523490; cv=none; b=VT3jypyy6TesfKPeMQeDwQTsme0i2wY05WSll4VteatrfM0rGFArL2JcZ4DVvN5bJN8kokMbSpFKWFMYqZ7B2pTXZANMzBOsMP4Rp5gKhQUhdMZuDsMoPulewH6/iPFuOg96BRQJ/GlZ9loS4ZaaWI97OI2iV2VxUIgnFJeqqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523490; c=relaxed/simple;
	bh=iQPLrDeCqtraib+pJCWHwK8EjIvEnWptjOv3Fvb4/r0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VpgiSPJ2SjoNJa+kRVbfdLs9Ov/4BaKLpuwMIEKBD1XC1JjiTKa+pDo9B0/3fk5wFB7fC92kBfwRcWTPT1CgI2bVp/d5yH+l1KLqsbWoQMQxgoBCxd4w6x1Wt1R6DCy92Itv/V9AXp3nwRF2TkdTGYeE/xYE9f3/CiR48/BmNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=k+yzhq9V; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k+yzhq9V"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a468616ed70so129888866b.3
        for <selinux@vger.kernel.org>; Fri, 15 Mar 2024 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710523487; x=1711128287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=52MKcYBY1cHuI+6lyRnfngYZT9OHXkaScG2zXVCNtR0=;
        b=k+yzhq9VOJiAEBgClJkP631j6fTfkuzztHWVGAlX/NQqLT6ZXR8V3vOiedluvqXPMe
         /us1eYVz+PPgYDeCR07LD4UUhybqjiGaCQq7c9tPP7Ylw68Eke9e/7PZUqGZlPzL9Z7+
         Gs82qw3W6d7Pm96J3hfgB5gj/BOnFPFIIuObCu0Jw3oaOlJyx4rRtaHZIkI/nK71mtJm
         X+KhzNs3/la9oHvwNrklveQXr8TjCMchAHfGpEZjNV+KIyscWO3he9oQijHrBmqMtxPY
         elHQL71w4t1wc8kVuDnBDIuqYLoFu1kOGgrqXWObiQt5Db7W85QNDuaiE9NGQxhGJ/fz
         3Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523487; x=1711128287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52MKcYBY1cHuI+6lyRnfngYZT9OHXkaScG2zXVCNtR0=;
        b=iM6Y+ES4pMNZe08iEv8rNS/Ij2FkUETbt5SjYLXPF+C/bhXiGZ8923WufROJz7wptA
         A3WYxh+9HIwr2tZxs/aQnwWy6XnoRCLqInFbV3q/lDeGo/mSc03gqC+LJSvv+KJrEB2P
         CBusodfiHwXurTR8y4ucIvxd7k7i0EULbbW5LqV1y6DBtC+498cy2yhjlrDXmhxD36n8
         gXzIcNlm0VEPOFyq8rs1pm4gUiCbyxhiS2ONPxj/MrLUcS90kd0nVOu625MG8MquwYnA
         scYTi9odePBnWvG+1xmB0qsYYGTL9UvpOvsBFhoOut5bNw7Uu8RtQIg22XbDu5aVM1rm
         kBIA==
X-Gm-Message-State: AOJu0Yw38bGleYqcb5W1cbA1r5fKEB/HnbsL8DErVuBPzcKhyneqQzEU
	Q47cAhrVggisI0ls+IPdED9uJv7f8w4tgzypGbJIKrpBDnzE/A0/9esvEfn85PeRCw==
X-Google-Smtp-Source: AGHT+IGYIU7ncEkg1GajUx91eeX/hZmSKTx0fS+sdQAxTsfHWN+hDkA1/XgnY4wTCfjTTIfv7PYdSA==
X-Received: by 2002:a17:907:9709:b0:a46:7bd3:c7b2 with SMTP id jg9-20020a170907970900b00a467bd3c7b2mr3286364ejc.5.1710523487014;
        Fri, 15 Mar 2024 10:24:47 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id l23-20020a1709065a9700b00a460040a102sm1854943ejq.124.2024.03.15.10.24.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:24:46 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libselinux: avoid logs in get_ordered_context_list() without policy
Date: Fri, 15 Mar 2024 18:24:22 +0100
Message-ID: <20240315172436.631262-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If no policy has been loaded yet and thus the current context is still
"kernel" avoid logging failures in get_ordered_context_list(), like:

    get_ordered_context_list:  error in processing configuration file /etc/selinux/debian/contexts/users/root
    get_ordered_context_list:  error in processing configuration file /etc/selinux/debian/contexts/default_contexts

Since get_context_user() needs a valid context, because it tries to split
it into its parts, jump right to the failsafe.
---
 libselinux/src/get_context_list.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 7e23be05..ec3775a8 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -427,6 +427,12 @@ int get_ordered_context_list(const char *user,
 		fromcon = backup_fromcon;
 	}
 
+	if (strcmp(fromcon, "kernel") == 0)
+		/* get_context_user() needs a valid context, avoid
+		 * unnecessary log messages if no policy has been loaded
+		 * yet. */
+		goto failsafe;
+
 	/* Determine the ordering to apply from the optional per-user config
 	   and from the global config. */
 	fname_len = strlen(user_contexts_path) + strlen(user) + 2;
-- 
2.43.0

