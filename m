Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2417727A906
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063356; cv=none; b=csYv5R05MoJcuYz2ekoiaFTYHkTpHLl03CoXWwvkcJIgkO9SSQU+HSzDW0186sorSbUP5VyfT5Om6vv5p4oSOc4eR2PGJwNKxSO6k5lzffZYhVbZj4s2an0y1/H5z4ZFrqJfmbm8VQcTmVJGFlJY1P/I4gm0eUpNUHBrBGNgGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063356; c=relaxed/simple;
	bh=rAujF+bIjGCTRHwe82Ukg/EqZl6PN2eBR7iMnhM+dX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yy78XC6avAOQ7B8EQkiKIe9OGc4WAmX9HVO0ep5wTx03UewOhpBfKTHk4m9Q5sGXdi3tB04XOBdLh9Fr9stecOJ/nIqaJyx7NXt+/sSb3RYNpnFhfMoiAXSbQ9FNYnClBw5f5pAyKN/kE8nJStuKEVEKypbumLiOYb5OkIeDhP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMxZAS9h; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMxZAS9h"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-7e346ab52e9so200502985a.2
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 08:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754063353; x=1754668153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=weN5SFTWDPM64McQAyP7ppntKaoXE0YyY35jMaMmSb4=;
        b=VMxZAS9h7hQfiG3JhLkmc/nGqKYQxgBjaCAHmXpbqYSvzmlba+IC6ui5nGsSTWOI7R
         8IzxrmZA9/4PJAHOrXeCUKUu+xMVc01eBrES9eXm6WaOLzdP6jLvXy7EfzNqk5oLrC12
         fHBPg45WhLYtGNT2ERSvHUMLdgSkfhbhthnHvAKza0W0LVSUM/7q4vBirjpGzYNSx4//
         wpkuZsbP6z25Z0jTOszw4pGYdounHKEAFULVTwLQH/Mu8eFxfDA1FrbErFknfxZdOB3m
         Uv3QEnNOVZbCZBF1iN2sPXp/JOEbW3gxiboCwMYopcawZyUsPsfhAQgWA+vCXJ1dGYNq
         aLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754063353; x=1754668153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weN5SFTWDPM64McQAyP7ppntKaoXE0YyY35jMaMmSb4=;
        b=AG29WLWu2RWaXw/O4coUJrsC0uicPwHRuQdDh+8YCQAKiiQejDgWy2O8e6hHBeM/pI
         yNGW+7VqpkDse3EBrOEP5O30amPVnyWbiW7N0zvjA0SmegDUYKEp1LvpVtoJQCnLKKVT
         sAobX3SgZ0x4U92tx04Y3v/gO8Td5u0KApVxUQioSbW8yXsV9Vr6vFB2kvFH3scyAgpL
         eT3j1dw3M1RuYdc/gqAsh9cI0SDyRVkbgkGGP+yH3Z8bn/vKhkPUk7KM5IzqnqHe3Rtt
         /fPX2G1u34EPDBYXzSSPohT1QVRHe4iQQOm5rTPnzZx0zyt+tIk9MbZneT2e5XJrcbXJ
         E58g==
X-Gm-Message-State: AOJu0Yyl7kP/N/RN6bz3LMQXT7Um4LrO70rmBU6t4ScdqmvMU/9qwyxW
	QTxTVAUtW/LhlPSr+KVvvQ0FrCbQjq5aj5UM/Vdw8oGSodiyD4XSh6EUEfRQYsGq
X-Gm-Gg: ASbGncvdCT7AyE8b1EvxqTpF6I+Sph51o8cZth5y+U8yfwXz3psVqvbWGzJqVcpK2mq
	8qC1cEVGwQlfKDfXL+5vC2Gug9kq5Mj6/ZNVB1LhuRdZPziMsYbW9RyvHrE03/qCb/fZ4dww6qt
	baDRlfBWHWCrWoBGOkF+kxIASPsNqNwsPOfVQuLQVmujemIoWPXxejatLHGFpJz+9fhZZFbPmfb
	5gzYbBloHTXPw4IjcmwXn+yYFcr6UCSoBzz38XDLWxZoqhra6g3lCv5h7GLATEgDGVyZ5mppEAE
	rfj1fNrAerjn00qhzOxF3qKd4j+eIznPRFtXAoelpswVrPSeBneH9mrlMF4wqfB85O+fA1Xw9IE
	02dk+P+fAtiyUFYBXYAhV8P3HOKjxDvm12FuGzUCz4MzwU0gdHGxizPeyn5LnQFY7K92Sv8K9N3
	uuPhLTg76mYccvL0WH7GVNtmLSYgcvr/O6jA==
X-Google-Smtp-Source: AGHT+IEjOF9eE9zgtGgnwOZaoDBHWKAYwDRqQdeP6E59+Nsj+sfVc8yXLmK949IzpACvR/orRqHEGg==
X-Received: by 2002:a05:620a:5613:b0:7e3:4ef1:f583 with SMTP id af79cd13be357-7e69636b9a7mr37983185a.42.1754063353297;
        Fri, 01 Aug 2025 08:49:13 -0700 (PDT)
Received: from localhost (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f593eedsm230124985a.7.2025.08.01.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:49:12 -0700 (PDT)
From: danieldurning.work@gmail.com
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Subject: [PATCH] selinux: implement bpf_token_cmd and bpf_token_capable hooks
Date: Fri,  1 Aug 2025 15:46:37 +0000
Message-ID: <20250801154637.143931-1-danieldurning.work@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Durning <danieldurning.work@gmail.com>

Implement bpf_token_cmd and bpf_token_capable hooks for SELinux.
For both hooks we check against the token SID, to support
delegation. We could add a further check based on process SID
when the token is first created.

Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
---
 security/selinux/hooks.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 335fbf76cdd2..bffddffe0b25 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7154,6 +7154,52 @@ static void selinux_bpf_token_free(struct bpf_token *token)
 	token->security = NULL;
 	kfree(bpfsec);
 }
+
+static int selinux_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
+{
+	struct bpf_security_struct *bpfsec = token->security;
+	u32 sid = bpfsec->sid;
+	int ret;
+
+	switch (cmd) {
+	case BPF_MAP_CREATE:
+		ret = avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,
+				   NULL);
+		break;
+	case BPF_PROG_LOAD:
+		ret = avc_has_perm(sid, sid, SECCLASS_BPF, BPF__PROG_LOAD,
+				   NULL);
+		break;
+	default:
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int selinux_bpf_token_capable(const struct bpf_token *token, int cap)
+{
+	u16 sclass;
+	struct bpf_security_struct *bpfsec = token->security;
+	u32 sid = bpfsec->sid;
+	u32 av = CAP_TO_MASK(cap);
+
+	switch (CAP_TO_INDEX(cap)) {
+	case 0:
+		sclass = SECCLASS_CAP_USERNS;
+		break;
+	case 1:
+		sclass = SECCLASS_CAP2_USERNS;
+		break;
+	default:
+		pr_err("SELinux:  out of range capability %d\n", cap);
+		return -EINVAL;
+	}
+
+	return avc_has_perm(sid, sid, sclass, av, NULL);
+}
+
 #endif
 
 struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
@@ -7525,6 +7571,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
 	LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
+	LSM_HOOK_INIT(bpf_token_cmd, selinux_bpf_token_cmd),
+	LSM_HOOK_INIT(bpf_token_capable, selinux_bpf_token_capable),
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
-- 
2.50.1

