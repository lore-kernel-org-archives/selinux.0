Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147C155321
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836368; cv=none; b=XGnzrsQBc/GUj3zGuJhcDt5J8JKx6zY9FTugmLr6wtKFj3ZEpN4i/PItg24tNc2V+lETPG/T1FF+1ZlM3kvs/+RkmjFOXF4uBea47ri6ETCy7+1aLAfYmvp/AZCoNS+/ZxogZYJ6BPaWQpkHqciXd2Rz4u8EzqXsior3jPaXI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836368; c=relaxed/simple;
	bh=3lstVvoIKDrbY/Kw/AyHr2jehr16SC+3tBnjjeuD+3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WE2shuiS6aWfwBwOHlmJX6qvZmMHgqiVbwZMyNp7kbXByelR+rZxakc9Ae6rPRDsQfNN+sZwhT3NKwS8USn05TaTGJroJu1otSiMBpSVy24h0lpLA8dtS/wmmr8QkHyTeY7CLDdt+++v077ekyMj3m5eYpljXdnl/Op+KZuSnus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffTFN/wJ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffTFN/wJ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b7041273ddso819124385a.3
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836363; x=1736441163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/kBecojtJbJEwGGJ7ydPliof2m9e4Ne+qfAhthVE5E=;
        b=ffTFN/wJe/4F5TJ+11eS1Gw0sGzx0b7aq/qYialwdWsBiECSYoIjfqmOm4gf1Y2zEn
         xFxKUNNRmERvjlF++tn60FyqM6O92SYTbhu4bTp0v6XL3QjbgMNLR7/X5YwYDr45Y75Y
         RRqtBir0mJ4mUS3nJ/FcwgNWtyrvvgXbRGQOteNuHPFSYBorv+vRCt+8vb1brpsYJVju
         7ItfsoqEJqMDuTPvEPuaAIPKAF+qaXbL3rkJw8XMUj33ol/ezQpUBoGjRE7ATskZxQ7L
         PAWX4yzaRcWgfxiqOZeo+UvDS3x8Y31p6k3/noBptbXRbqFwbQDQFOZuti6Uw6e8TVzO
         EZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836363; x=1736441163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/kBecojtJbJEwGGJ7ydPliof2m9e4Ne+qfAhthVE5E=;
        b=w/ftaAzhJWGLP2t7L4ueEXGZ8qeakPbCOmTg2y1/TvuheVeWPyeWMg1CfIQGUad8Wg
         KV7V/70jhfIP+1daCHHR6qpGKX3fhSrLpxjylpH+QlDv7P12S/G9kYHjfH5N1svn9tOx
         zfoEBGnP6SAYgn0rmPPd23yFzJrfWrfEBTiGCfUUEZuRwhavT+g36eZ8Hcf4QcRLRKQR
         +lHhkwoIAGT9jWlBPJy6r8EVHXONdnTpWM0DL5pZ6o8hUCmMct/+LOUPNWWa3yWoHrkq
         4QeznOcIYcVsXyzNww1fVmjZrTxy/2wtGfNgWsNQ4S9mPRB9RzsKEN2lFN22Br4jrFZF
         ub+g==
X-Gm-Message-State: AOJu0YwY5OFPa4vLEqu1S8LFZnRbLvP7I26Yx0uZPs2kJQ4PhuGFVIGK
	q33+4nBJVTugHc/gYK5FWlQtXfY3XgcB5RRjNIY5jJL5ukHbVh+qJpV/DQ==
X-Gm-Gg: ASbGnctMbOt+LS6CNVoKz8QkX8dhcT7887RjsCUP7ufNUbySIFDcp+gLOzyOibXTkl3
	mdgCS8IJSnSo6IlDdiesMWt79bnqKeahVfxHYAZ8ogxZVV+iM8v4NgaSEVCZM8SchfeQ83RP+zb
	czQOyThuRWiFs0K1a+eXV7LRWoSEYnanD6bX/+HvuVA55/C0+oEksidR6XEU5Eb3QndhsgM+6zH
	CrNjsQ01G/tuEF2QW6++/6NZIBJG7fCfVoczIQhKjBrbHqNP/vyiL3maKnUW3l9l8SPRy2upVeL
	kp4f799psdhw9t4WhfuQNdWJQMxbJuS9zt3FktXUxHPpBMfOWdFTooTIC/yTHaqCd8F6MA==
X-Google-Smtp-Source: AGHT+IEEQhXk+IRxWdEAO7MNHWAm1OVZkCKAjk8iWB8qLsU57IhEC2zwksDpscC+nFU3QTybCw8ORw==
X-Received: by 2002:a05:620a:45a1:b0:7b6:f15c:3b1d with SMTP id af79cd13be357-7b9ba7c1d81mr5993000985a.32.1735836363526;
        Thu, 02 Jan 2025 08:46:03 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.46.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:46:03 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 42/44] selinux: exempt creation of init SELinux namespace from limits
Date: Thu,  2 Jan 2025 11:45:07 -0500
Message-Id: <20250102164509.25606-43-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exempt the creation of the init SELinux namespace from the
maxns limit. It was already exempted from the maxnsdepth
limit by virtue of only applying that check when there
is a parent namespace. Otherwise, if one were to set
CONFIG_SECURITY_SELINUX_MAXNS to 0, the creation of the
init SELinux namespace would fail.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5ce0e2afd84f..8c0e44effdbc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7635,7 +7635,7 @@ int selinux_state_create(const struct cred *cred)
 	struct selinux_state *newstate;
 	int rc;
 
-	if (atomic_read(&selinux_nsnum) >= selinux_maxns)
+	if (parent && atomic_read(&selinux_nsnum) >= selinux_maxns)
 		return -ENOSPC;
 
 	if (parent && parent->depth >= selinux_maxnsdepth)
-- 
2.47.1

