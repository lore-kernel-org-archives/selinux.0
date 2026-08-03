Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEE91F1537
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765623; cv=none; b=I5PL243IJzXw3C8ZR05lSZGyZ9JX0E2aFZupQF9l5TTK8NX2noltjg5iKAAmlnY2FuSHziUoPfr22pSwnS59I/JE3purz+IDTljVTHmS/lII1Bh3rDFwhSZicSGaQ9cb6byyTtTI46DO7o5sVhhAhcUny+cDY9NWYnldIWaJW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765623; c=relaxed/simple;
	bh=6/bjWQQ/RcIspxV1E8OXcoTNGdHOTtEtfwW2kGCNRqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3t7RrBiA5aeDV7DSWCqup5D/xjV5mAYkWsnSxvKYYuSdPjrV/uaTFKhaG8AYgnXfx4sSvxnWbGAsQcUr4D52Jml0XT7qqljohjAh3y3CRf/HAMKuBMRutphTKKDtRBuFFRkXNzRoTUg63I1xtLWcb2oni9mEMkwxgntFhUEv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haqmwxrh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haqmwxrh"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c04bf4711so29665211cf.2
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785765621; x=1786370421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ssYbuUIwNhPMKp9ZVTpg8heoAIQSBJudC/ri2JWrNgA=;
        b=haqmwxrh+KpQ9uvdbHLHwgxpoeAdJ1TAsG8LeRiEjb9EXxK75YSktugeOVvQszfs3E
         yJcu9XV8sk9Q3Swv0FyGQX5onUmIlR9DFnkcQnMD7QqMN48VPSY8fr/lIT6WZ9Efj2dB
         5siBhcEiFGCv/oXy2tDJeJQR/AQyLQgGkJDQLBLA5ZtNo6SuFwFcVi+9Xh97y99YHCxM
         DZXq/T6VvKyIiWyqp+uaaXFkUA+YWAsPx+S907PPGZptlEk3yo8wPNfJG01UUD3KZzdM
         8H8F3ISLprgI7MBYBI4nrOjfjRHb39RG8F7Tm8vgAOiXEfNf1lZVNVODWtBYABnWaSaM
         ILzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785765621; x=1786370421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssYbuUIwNhPMKp9ZVTpg8heoAIQSBJudC/ri2JWrNgA=;
        b=MWPDMu2jNvRN6dRTQ3lVVoG1zxXigYV/7bnzLCbQhEvDy/17T4Bs+8yL/3SZswbapR
         FdoS7vhHpe7S2nrX3kzahZUhVV/5pG8QYoskqc54IKyjjyFR4UDof35K61v37ciKeOTe
         LU3qUaU+/l6z25ci+K7LjRlayZDLRQnQPBRESOuZhVTbqRl22ECd+fNf8wScMQOHFMUe
         s5cVaxhcVWfUN58xDK05mwbcUPti+XYcGGuZC2ckezZbhacvM8XuVBaqxWpIdt6rTTX7
         LVThaihADaHldsVgqm160saT9tPlxRK9ddT14zsW4vcHLPtyIeHB5oz48j9RA7HI/KdB
         of9Q==
X-Gm-Message-State: AOJu0YxYsv4Y7QXkJ+omPcmKQQOqoieLcAFNWBb3MVja95Finj5YWmNG
	39cbIP2WQmUJPwyn3J3cjtyqrWpeLbw2Dm4bcCnESAeCGu8xTmLkOwY5V6dZPQ==
X-Gm-Gg: AR+sD13eM+LpeP+enusuelwxfZqcHvQIdTMM7sZ45YP+Wa6X72jiOAb7JOnY6WLR84U
	eQM0R43P80dThib2XiXrqyysT6u9OKcu9Oj+11drJgIBJbUoawjTsh61Lf8WePNhptNRJ+yI3H0
	Vce1VjgV4CaRiifhZIuu0EdW56pQh3h9XJpEKcSje7q8wULo1EQ3RsHw6YSRkPzyVThgXyp8ozU
	WNGa99tTRPLdGLtA7H4OvVgAXpP0TFobd/AbRoISK0y04Xvbg1F6so/00WXZn4V7PdDIKpacc/q
	JYz9dsQPN6JUoKDMllcM5oA0RF9A0qBkxRmzurXI7PBQ5iHEJoLlsHsFS4VNXiNh/YZrZ7l4D0x
	K6XbUtadPbo8LIDYKKfdt1cAwXp6WwB77KjiiICaEs/waCvRkSS9x0w909pO4vZNCkc1L0Yc49Z
	9AzmDz3axjT+/rBhA0IQRV2qwjxNXwE/vqoML2EZlW7RzIPxEXxr/WCMu8a4tRL0Ny5WMvEdXdM
	SQ/ts+tTnn17nxqWxCOmHR/Uo5f1OSKF5PIH/yzDwd82pEBxkXzQXc51z5bJ/asMvep6cuMSy8=
X-Received: by 2002:a05:622a:40ce:b0:51c:1a46:9148 with SMTP id d75a77b69052e-52b5678f975mr201629661cf.34.1785765618934;
        Mon, 03 Aug 2026 07:00:18 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4ec01d54sm63178741cf.31.2026.08.03.07.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:00:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] README.md: fix CIFuzz badge link to refer to a specific workflow
Date: Mon,  3 Aug 2026 10:00:07 -0400
Message-ID: <20260803140007.41237-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already had separate links for the other CIFuzz actions, so
just make this one reference the check format workflow.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 08e82d0c..6f1bfcc8 100644
--- a/README.md
+++ b/README.md
@@ -5,7 +5,7 @@ SELinux Userspace
 [![Run Tests](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml)
 [![Run SELinux testsuite in Testing Farm](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/tf_testsuite.yml)
 [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
-[![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
+[![Check Format](https://github.com/SELinuxProject/selinux/actions/workflows/check_format.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/check_format.yml)
 
 SELinux is a flexible Mandatory Access Control (MAC) system built into the
 Linux Kernel. SELinux provides administrators with a comprehensive access
-- 
2.55.0

