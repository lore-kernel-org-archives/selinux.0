Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D134DB4B
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425800; cv=none; b=CLgqApy6R2rSPCf3N3cEA9m5sCtTNsYQvj+BAeUeOTzvCbu9IcKsSulZoAKM9y+EClyzqNKST52Sdt01Lg7RPLJ3pbFyKECGpmuyXoboR2APXk9hm0yIbJPjXvBUvvsEyO3UYnmjZEDPnk1/3Gxk7qgDAwCy2OGkeVXvz4FZOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425800; c=relaxed/simple;
	bh=duBx2NZVWh9sUQEGfb5Nx5/6gm4+jvLNkjVZbCfw9cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWDHg5tV8V0ET0GUR8QP1evuROSHZrm7hCIZry7P2HlBuu2eWNoLh4/EHSmC4f7XeWWIcu8TBYsYdJuySgFWAwu6TDctBZ8IsKz3hu2RjYZZziUD3OAROelnHT4J/AstNjk7MgwKF+hEDgh34Ph4oId3meUy4oM8g6/dLcIOLHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ShVbUhR1; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ShVbUhR1"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014b671367so2850621cf.3
        for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 13:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768425797; x=1769030597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVCy4V3r2esjNV9WokGzxmBAWCZzobtziEycva4YEOw=;
        b=ShVbUhR1Hi3tQMM1hyqtkWufAgwUZrNBm532Jkmjcm4UBXCygiJ0AM1M0mhfhAvHdM
         hRclhKBsVM325iGP98RnybL8rBY47QIu/n3WEEZbckmbwYDlNYaHXDj/xzg98Q7+4vwZ
         kSen3BpXzYCIyCBuHpl3IuKoMQJDrnpSnZz/fkbm9DJs8X2riwV/PrEDTHVPchL+OiMc
         A+YzxarEB6Blv07C8XjJmodXgA1iPlOPfoKJn6Q4JI4DYq+ZpMPEfFANne85VnRmHUaP
         NjZcLftqLZSAZLnYjK0zPvx12UjCSAi5oVpAg2hFajvVazAVqmFOT3Pzazx8hJcgwCAJ
         hlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768425797; x=1769030597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVCy4V3r2esjNV9WokGzxmBAWCZzobtziEycva4YEOw=;
        b=lWWeuOLmMlepmjL/W1DNiqtL2pJ6fmWKQSOo/hzFnqMCcmMjcktweklDxIjIcSF6q8
         4pY7+ov5CFYhIxB1FoD5xliLs1k+8Gux9EnJMcHA1VsncXBaIKeI18UzEp8LmnfyLQOv
         qUvTJBysc8q2f36LdZB3TgJveonApDyegZTArprndaLkGL0F4t2N0zA/IHXv7v6hzNqt
         uSQ/hBAyQZ9dXRnegNb/B0NZg6khMJmuJ3gl2Em9+HiwpfoKVm61J1r2sJ7Z3tCF+8Xq
         ZUWoR0INhsYXSwquZZ54fyApr513YF7jLoT0gyWoXV/rJY+9pb/i8BHFbdUk1MuimqlV
         v9/A==
X-Gm-Message-State: AOJu0YymvYA1P0upJlsSGLi5brlBMSJm1qiZbDJaqX0Wsjonb5ifIxJp
	icQuMo89urQnaoXTnyIMXrqsOF96BbQ+r6c0ZmcrXbZdcczUrzVUaoOMU+a7vvUr4NY4yvxRtkt
	PcxY=
X-Gm-Gg: AY/fxX62h5O6ogo6765YsxY1H6t9EJdn5qfYajT8iElXoWBwZN0Mz+GTqfJ6KcGvUKl
	FHsGK9fbqtpGQChaZ3OawsfNagmIu2QUsYhl3/RbOnU4pPzpRFFPQd/7ZBbKJ/+Xi5b8qc1dOf3
	GT8IlpOr3iuSCPTpW/5rCd1c27FtnIz6JgU3Mpa95H7O3XbwOd+B4tSVbHxV5c5Bm3AA4mfNswu
	ovSR3byOXesCRsyffqsAsyz7fgjNyshf4q4FUngwQHcb6IQf9ZC0la4rtpaTKTMs91RWXV0I3hP
	8NoARU/psfIJwXOEwfYV+Rf46C77Z2PpmX7Vv5NDPqwOfAXYuMYN6GcPnoZmMjI2Lc0yH43cf0I
	XzG9u/iWUAtmZb7twCVqhXGRQmnqN5l7TB7hrHbJvaF63cxbOx6xHhBYmZHemGYIv+YVLraCIys
	QBT7OxOVJ4RuWIi04/VuX131T+F68LlaYhPVn7HJ3dbEHZLftibztkgmfHIurIk8VAhaQ=
X-Received: by 2002:a05:622a:6a4b:b0:501:4446:2ce with SMTP id d75a77b69052e-5014827841bmr41992841cf.49.1768425797234;
        Wed, 14 Jan 2026 13:23:17 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm185296916d6.23.2026.01.14.13.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:23:16 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com
Subject: [PATCH] selinux: fix a capabilities parsing typo in selinux_bpf_token_capable()
Date: Wed, 14 Jan 2026 16:23:09 -0500
Message-ID: <20260114212308.291762-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=paul@paul-moore.com; h=from:subject; bh=duBx2NZVWh9sUQEGfb5Nx5/6gm4+jvLNkjVZbCfw9cE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpaAk81jIZqt9xBldeLagcSjPWpnxWmDj+QrYEt Gfi2l9mK86JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaWgJPAAKCRDqIPLalzeJ c+OgD/0ZCIMk66ewkrwXonjuElqvMvX8D1hEKLTA7n8jsnD82W8I0DN1K/yrLFr8sKEe6O2Fb2D +4/cT1T2wGm+qoxSp95pDSMTS/6BeHHdagh0QuyT/QS6QLT6A+zHa/gkeSn5nSppLs6FkikW48u 6n8Zsma8Wq9RmZJ7bBp+fDKKZ3H6+OE4Sh1mGs1D5Q1VV/N4EifYKLbBh9x1IjwoZLprPnlBK/9 1eC2i1u6vwFPUTs7a0LdCjogElOQ263qK5e0xmPv6deRGQGwsV4t2alklNAP1h2bCi5z0c0OgvH 7CK4j5bKHPMgjsb78OI098lSVpwe89c1IuSC0pWFRfx8NSU/YhuT9Me5ScHfX8zTa9RqGD6u8dM 5od7ZMyf9vyA0hKBiROTNS0Q6Uld3CW/eWA9G46AA0+7fXfRE3ekf/g++udcBrUdPh2WuP6HKwZ pbWJOM84ArvopXWAIOQVkkkO8Orx9k2X715x57XbzNFyUr1tsg6dLz1gU05dtvci3vw4X9XHge1 ofnsqqeTLah81qNAr7cYlmiQ84AWjs5uAxAX9WaIm7isAgWagWdA0b/d8aLirThLns3NwUjsugW +2ccWSoH1xXQ/P+gLTm09AxdQL3n3vn7rBfki+5yebfVoMQ2qASgo+uHYZaPUggzYyJgNA+SeNd rTcfS1VXysYpeYQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

There was a typo, likely a cut-n-paste bug, where we were checking for
SECCLASS_CAPABILITY instead of SECCLASS_CAPABILITY2.

Fixes: 5473a722f782 ("selinux: add support for BPF token access control")
Reported-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c7c19ceeeb2f..9289ed89a8ec 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7260,7 +7260,7 @@ static int selinux_bpf_token_capable(const struct bpf_token *token, int cap)
 		sclass = initns ? SECCLASS_CAPABILITY : SECCLASS_CAP_USERNS;
 		break;
 	case 1:
-		sclass = initns ? SECCLASS_CAPABILITY : SECCLASS_CAP2_USERNS;
+		sclass = initns ? SECCLASS_CAPABILITY2 : SECCLASS_CAP2_USERNS;
 		break;
 	default:
 		pr_err("SELinux:  out of range capability %d\n", cap);
-- 
2.52.0

