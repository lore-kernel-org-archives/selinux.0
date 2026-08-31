Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C464AA022
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189176; cv=none; b=VHRsB9Cg/pIGayfLIqqLUWnPyrpYiz1Kt3SejxUfxbK4B2TLNktX4t0dgpTuMSilpqBnFCRqiuCrFvBXHslx3qzLx1TJmTXPSpNni5ztWPPnrU9UawAnyZTWCy17++4dsHeuTWqZ15Fqj8qh5yjDAkRuzAq9cGhKoxwD7l5Sn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189176; c=relaxed/simple;
	bh=KCvDPeuERYpCYJC5h4z2isrXIuiyyTxtUQQUo26LqVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXw8oqPv81TrU7jekIOL81QBXBS9X22rgl5bCEMhxuPCcBQ8DpqdMXAuHuZOD5UwfpgOzNASjwvHJgBtSVR8oHibIFI0KlAood17FhkJMhjWD+CCm3DVO4Wn7bVY7bZVPNGgno1gS3SeQ+ICoyA9saecdZzjc7oiDWMs14KOEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqeoNUrt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqeoNUrt"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9390a2c8909so247181085a.0
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189174; x=1788793974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7J/YVajnvzWLpuNBmiP9Gzzh3WbP2dLJE/GtVcP7aLI=;
        b=NqeoNUrtKDZfBNN4PWo03lAp0tByamjRgeZ69QW1J+q6I1uqIecKaO+yTQQ2VTEHPu
         gb6VtPjestqOkhLcjEFC8aVCkr1ipZUhJMHNXIdcQnQ0lN7e1sRILUmh8gRmWMOWHfgA
         3PcKG9bMlGmlckxd7cRrsC96pLewXCurhgdypeOHXV4pxow7fgFs7S6zmuPfn+nlqJD/
         /dgN5bk043VAKExwzqAbDB7/RHv5BzhBjpiIkwfpaXhexT2S3LUcAfPA5227vQVM7uo4
         2cFrqIxtikDSIxwZYNipL5GnPPoubhg4qfFDMqkgZHyuIkVn7rv0lN2mwD/zZWM0Xx40
         dirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189174; x=1788793974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7J/YVajnvzWLpuNBmiP9Gzzh3WbP2dLJE/GtVcP7aLI=;
        b=Nxpewt1I3gtfAuSTJCOGUfrL7Gms/4Tr7AWkObk4Ad4OjPe561RqEZKjBYjC6FAE0V
         Y6+Wgkti6WcAaf9ADSdZnpycKNeXwk8Q0+D6hl9twE/yECZ9nK1B4eOgCKfNvP5uLG3C
         031pLpHWrQrHjARrtwlKDDxtYbXVcQKwo7zFe76QU921OCLHJWJOMI3Kybo8xqOOsbqE
         9HhAGzAvuj1kT0C8BkvtEovtc7G7g6fHyfGeQsTwAla8VDQK3OqsWYNBujm+D9E5qjit
         K4l5iise+9Z6AY/xvqiaTrLJYZFe5iamzjFbqpPDrtaF4d7kVCDU7IL8F4+66HECluUA
         LUAA==
X-Gm-Message-State: AFuF++kNVAXYfv7wEOOzWLhYmGBy2pxeK9+bcpb93m2TQGkEtOnj+rJH
	wWm+qkZMn0VGGURQuXNaVQMYaZvUnsXOADXOOaklMu2MCgfQShJETGADm6BwTw==
X-Gm-Gg: AR+sD12KeP+3rvAkts/7yMmgNZJSJK8pjiIMboieyRg6L8c4vM1hvzAjLfOcU51wbkL
	cgJj4ExtquXakSDn1eRiyitjCm1HfvukafyYpTD9hbp04prE9W9U624XOVXLWcyvuYG/Cw/6dSh
	WWERW11+HNRNuIV93ky4M9s9smdxAvW0BBgrMNmADwVm+MoPrEbegMtLktYJjdCAYyhNm6Z0KAI
	s6Ltyn/h7o5ozZer+FqSQ0ZcQjeFSBIBXkKoJmbxsZW8HcyepHkjcPdBCbPfYLvaiUazxQkzpx/
	ASzqgtu91uRMqwXSJhXOTL/mqkrFvgsoBpwsi8RhOg0oLUMU00k5hwuoVvyYw/ERhE54eED/aEu
	2Y4cdBKWetjzUjPcN2NpCuNT7NPHrM6QkTnnyq+IpOtOTkIgrWZPM44UXKm2Z52lloZPla0al1E
	BGGWfVnt/6kF4H/ZncYn4G6L3JR+tc5vOHX7LKRRY8CWyHbxZ41WhU36jOlDQFi5ihYRAqyDYnX
	O0GtYqjjLn+vNwYR+cx1w==
X-Received: by 2002:a05:620a:29c1:b0:92e:520a:ffab with SMTP id af79cd13be357-9394819e6f6mr242591585a.38.1788189173979;
        Mon, 31 Aug 2026 08:12:53 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939172604f3sm812443685a.21.2026.08.31.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:12:53 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] checkpolicy: Check for mls constraint expression in non-mls policy
Date: Mon, 31 Aug 2026 11:12:38 -0400
Message-ID: <20260831151238.44845-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a constraint expresison l1, l2, h1, and h2 all refer to levels
and should only appear in mls policies.

Return an error if a mls constraint expression is found in a non-
mls policy.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/policy_define.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 30157826..1984c52f 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4055,6 +4055,12 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2)
 		e1->next = expr;
 		return arg1;
 	case CEXPR_ATTR:
+		if (!mlspol && (arg1 >= CEXPR_L1L2)) {
+			yyerror("MLS constraint expression "
+				"in non-MLS configuration");
+			constraint_expr_destroy(expr);
+			return 0;
+		}
 		expr->attr = arg1;
 		expr->op = arg2;
 		return (uintptr_t)expr;
-- 
2.55.0

