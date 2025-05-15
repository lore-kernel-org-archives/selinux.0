Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6429A30C
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314648; cv=none; b=DMphIrJEMS3DYaCNC9MmSgOHCdJMZ+geaB3LgmqD6cHBFBfSjMyEZTnY0PbgsB0kVbAkpDH+kPBMGg00xotFHC2ToxyEwWn1YzwNo82LRhFLgXp2dujKledBu93ZvkrVjK3VctY+KesuK6XRROHuoKC8tY8BsSmOOla5D2q2lc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314648; c=relaxed/simple;
	bh=O3+Jzae/2TCAt5lwRSiJvsRgHZ/TOadlUSeph4b3/CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQMbP5EoP3MGZ+jS52PcwyRfupARokwQeHyeSedmajczwm+fr/eQm0b9LM4+1p4PKAyTF34sMGCn7QuYopSGYmtJXZu8kONmhIULSW7xazu0MUF4LXBh+NE2gjxkvGbvFOFDS0kjCUEGWlxtJDEqvZdisEuUZ701RlQTEPlKtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOk3SaOi; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOk3SaOi"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4775ccf3e56so23398001cf.0
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314646; x=1747919446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4BndgNs7MRsmPhIcKc2TrIK+0rWHQ2J3Nhd3013ack=;
        b=nOk3SaOi9vq65yqD3UDhVKVecLws01SJ0Ui4I+sdHgUEKKDba1qtl26IdclxCeyFva
         HW7zqXilgEW4mV7KG1id2of4h7cS7XTlzzsYHUwu6R331y1cxw89D0fyIgZeE7ZqW4LS
         buWhZ4qzfoIcHqrgJEau1ScOW9PxC5rx/AgHUd0I7ct7a986j/sZiHcd5fvGMEOneQe/
         UaL0LK+3/JCaj1f/S9Gfx8YYcAo4W+r8622vtSEU5OcDg1sF3Acx/aaCCrQD8FfGlpwn
         YAiFgj4A1u0flTTeYisNO4bil8Y56tRveYnf4BCEE/fMk6YRiSuJ0foxIAtAIWAS/vHz
         N0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314646; x=1747919446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4BndgNs7MRsmPhIcKc2TrIK+0rWHQ2J3Nhd3013ack=;
        b=GyMPgYYcztNQ80jsU5RF0uCWeEXvpOpfCbU5CsaO8MB5Wa/o/1i5RcfoaooqvxkKOQ
         lRQZM+6sK/CZxrCq3NRhhWQKKu86owDifd/bBVgLCWHenrMwFv2BeBCHVyEyqKK6opf8
         vGLoOnNr73SlVklUDT5ww4g/RxstUO1dLQOg8X/uT9+pTvD1DAQn2p2+g/h5VeIHCzGO
         CTlaPIwzHKtygkpNUuNPoyJSle1gPLp3okTV4bg/x0M6L/hly64LRX0gUn7Vl+soXgPy
         C2VHpv3/frtAGr7LxLeMdEBJxyIJdERv205IcAWtcsZ6n7Ns1DOhQqNgWmzWSGnTQtEH
         aHVQ==
X-Gm-Message-State: AOJu0YzsetAevKfPUV/be1ervIK2DNC2H9yhq17KeEQlnwvG7iEvOIb8
	2YeTI/VZp7Uzd33Ldxlt9og72E57UNndQrUeK1wKh4BLC8PMmWpoHZrN2g==
X-Gm-Gg: ASbGncv/XARdBysTEE7ryma02QIksLkzUNfe8prhHmjnTW7v2Dr/Spz20HXMCwifaE8
	NfnVhjf1KXT3rx57mj+vJPq76/uTe7vML/YnSCuR86kPOn5OOywvfR0fSSy+a+FNOxdAf2AsYne
	2Tc4M7zGt4rdkV7OJ3W2bv1FOydTNHrhX7hmtVy6XYP3MBWy3ZA3mcIqYT3brV4Xe4PRCXZ3C/I
	6+ya0mfe3Fw1xnWzUNXza5kJ1Zbp4oJ5NWai4VW0Fg8vFrGmQt3KBHXy46RyxbS3C7mCxbhITmF
	1MZ/JM06lhsbheaR6vkRCeDUcCyFG9Uwhtb1kTHEnbz52eKqsuXPZjnaazqEPr4D+3l7pgiyvxU
	jUK6LiEgVFBRMruP0qaVQ2kWA1yG6m7OY3leu/5NUqyfXlvjwCF514Q==
X-Google-Smtp-Source: AGHT+IEvzYSmzn048+ba6enMxc5j1j4RXdsZ5t/5B08lt/iOrJv4DzjgAeZoSM8YFIBXb80PXRo5ag==
X-Received: by 2002:a05:622a:1f0a:b0:494:9e33:6fa with SMTP id d75a77b69052e-494a0e5d5f2mr67009301cf.23.1747314645793;
        Thu, 15 May 2025 06:10:45 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 36/49] selinux: set initial SID context for init to "kernel" in global SID table
Date: Thu, 15 May 2025 09:09:34 -0400
Message-ID: <20250515130947.52806-37-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace treats any non-null value other than "kernel" as an
indicator that SELinux policy has already been loaded, so
the global SID table needs to transparently remap the init
initial SID to "kernel" just like the security server does.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/global_sidtab.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/selinux/global_sidtab.c b/security/selinux/global_sidtab.c
index 516a4ab49be8..423e902e3b88 100644
--- a/security/selinux/global_sidtab.c
+++ b/security/selinux/global_sidtab.c
@@ -21,6 +21,15 @@ int global_sidtab_init(void)
 
 		if (!str)
 			continue;
+		/*
+		 * Before the policy is loaded, translate
+		 * SECINITSID_INIT to "kernel", because systemd and
+		 * libselinux < 2.6 take a getcon_raw() result that is
+		 * both non-null and not "kernel" to mean that a policy
+		 * is already loaded.
+		 */
+		if (sid == SECINITSID_INIT)
+			str = "kernel";
 		ctx.str = (char *)str;
 		ctx.len = strlen(str)+1;
 		rc = sidtab_set_initial(&global_sidtab, sid, &ctx);
-- 
2.49.0

