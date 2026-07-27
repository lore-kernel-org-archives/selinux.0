Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61941F5F9
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173947; cv=none; b=DjRAesUhCqDq97qSNf5kXqAqe4cG6BiSbbBqz+F+uYsjzzO9tX7/kck5WFpIpvO1sZly4E/uIpiXFNj9h8ZCRv5TXu6mXfQfE5u9U7QsXyUGOEP5FdyaBgqm5gDdYiYQ1IFTD3mXRDOaOj0ijuZOJqcXINN4yMJGYt9Wp8GlKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173947; c=relaxed/simple;
	bh=i3sBZfRSsQVUMuxMCz71OJ9v1wXO7r5shBesr1zbaO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dS+3mplwEchaOsHzD41SNJN4O/0/UzfYog05a7NpVi2ERg3tXw7kZA1VYTW4YJfSewy9HWi8GC9wLUW8opylXP2Bj6qeoMg2Eaaq8aVnyU4ct9Hp9ix3EbnAXZuA3EGGF+XJEbzDMcJSVmwF29Mbv/2BvHkZCGbv/OQABUKUfQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXHnM26y; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXHnM26y"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c2cce930cso28941461cf.0
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785173945; x=1785778745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qw7rUif3A3TBu1Se+oZ+N2Ec39nvuKsjfTuQHQTjQyQ=;
        b=pXHnM26yiKmPdK4VgBEiQeZUYV++xanBzO/X5DcrDqFEwSZzzDk6xNC8+FI7vFAGEw
         BA7JJSnuuS6IzL+MWEY3gmibRbnyXD1Z2YgG1a2jPnLNl2Sk18HA2N6WQ02spz1ggEBy
         jL2X+ntNuuioOQDvI9mfTg/Nw2YPEtHfiBsvepRBWTbupHWyjmKd5//Bh4SgUmurDBfE
         8SDid53ZQ2HYXcKQkN/uUJPpPfuLWOZpd0gUjp5vQjvCTjHOHQ27wJgvTYuiMuv2PnBy
         gfckj0qEL+Zyf/1C+5WiOtpgVoO7/cjC72CtAPsT4dB4I8hKXP94eNJrd4enzVgjV8VA
         NTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173945; x=1785778745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qw7rUif3A3TBu1Se+oZ+N2Ec39nvuKsjfTuQHQTjQyQ=;
        b=VkQgJAGIDj5X3Mz+r7uxDNTBKaDxWksby4iEfyS2x5rh3l/kxIescPsuQ8qN6bNEct
         3L3XREJu9YzEvWIUHtyPIV0eGhIFhHEzRpLiwsqdrO8MJGN8RW1eWM3v6E5HACgS97xT
         3o8AuVKrFCclIHZ1sWeCLShfgvmhmc3SrTwGgKurl8+IMXWtMdxWJKYhNDL7GvEXlob3
         PNfVM2fif93K6y4jISFjt3S+2Zp1wpw3Goo3xBkmqWnpwAL5/GyQT0Fxs0n//X5tlDVT
         HdX1O+6Ec6+b0WuTAcCjcfo+UHOwNdh8qADHCU5TqGAcUKp2eVsfLe3q3/v65dL5/3Pb
         vEOw==
X-Gm-Message-State: AOJu0YzAkUeBijUKxWu9mi+7MfxhHlhHPDVG+nn3BRSiSDymjz8ddqga
	PiNpn3yf59OQai1s95zs3iYetghMLjugkrSfBcqxBP08re7k0urJRj1CAxeijA==
X-Gm-Gg: AR+sD12jP5hqBPMepaod6fnt8w4m3OTt7ZtcPEhw8Q+B1aIljSKGH0V+1zIbaIgLHbk
	WZ1Vy0roqlRjNfdpFa0mcER3QR580YeGtZZPLKIVDkhBiZA9GV1QoJjvt8uN4x9IVeD+Md54STM
	0XrL28D3qFnKES6nhIgBsCu0EyBb/6gBJKZeny1LpjHD2/x/JHwvhMW/3iW5g2YijkSI1caVThn
	QRYUFboCkqTUZTMhQLlRObAPVkvfz5mtSyix8yxfBrhz0XKnR+0c17VHFDUfnaP5zv7OhXbYUIn
	r9ZDqYQH5LifAMIVpwaodOANUNO1GGVpTHiHv84iwSLnSyNpOuuQIff42Ivxj4Di8bw5AsRPtIP
	b9nFlVSn7WGBoc6/2cLzh7/GpIKeU03+Dqc3JZW5Lp81okQsrXhxMd3d+9Jtvr6Wdn0xLkODRnO
	llTtKrwfWdrJOJ184Ri0H8UdAyhED9YFlJb/NXg7NrlTZNcXOVq82BE6sx/iWn7o4LQ28CWA1kx
	6mFYH9dsC0=
X-Received: by 2002:a05:622a:4b08:b0:51c:2149:52db with SMTP id d75a77b69052e-529a86d7b1fmr90341111cf.59.1785173944820;
        Mon, 27 Jul 2026 10:39:04 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a2a0a7ffsm58203981cf.26.2026.07.27.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:39:04 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Return SEPOL_ERR on failure to set bit
Date: Mon, 27 Jul 2026 13:38:54 -0400
Message-ID: <20260727173854.10810-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions cil_typepermissive_to_policydb() and
cil_typeneveraudit_to_policydb() return rc when ebitmap_set_bit()
fails, but the rc value at the point is SEPOL_OK.

Return SEPOL_ERR instead of rc when ebitmap_set_bit() fails.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index caf2d987..7ec3e781 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -614,7 +614,7 @@ int cil_typepermissive_to_policydb(policydb_t *pdb,
 		return rc;
 
 	if (ebitmap_set_bit(&pdb->permissive_map, sepol_type->s.value, 1)) {
-		return rc;
+		return SEPOL_ERR;
 	}
 
 	return SEPOL_OK;
@@ -632,7 +632,7 @@ int cil_typeneveraudit_to_policydb(policydb_t *pdb,
 		return rc;
 
 	if (ebitmap_set_bit(&pdb->neveraudit_map, sepol_type->s.value, 1)) {
-		return rc;
+		return SEPOL_ERR;
 	}
 
 	return SEPOL_OK;
-- 
2.55.0

