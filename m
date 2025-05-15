Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BD29A310
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314659; cv=none; b=H6UBC7ixhg9PwZ1Txowdfyd+GY4AaRXmMH/WE7yL/sHyGeffpFtmLzgzNPcEhpjfuHgfjf+WhrgOM5ou6p+/dxWnOJx2GzYkaxale5E3VtzcvAqKr4BjGtugzRjhPRwF31+VvLvgtBWIFfqY3CoWLQbdAtF7xheC61peo68Pbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314659; c=relaxed/simple;
	bh=RpMua+HLwt+MHGpELXZF1msSBn6vtDU/mOYxhqljUcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WP+DSdmC2442+RHqiQRZVYjjoSDNNA6krWNkTJYCty4cZAQBN8uvDzsCmUrmxZ3s2ftnlJCVdtXjao3hy6QC4/VJzq+3ALfio4M8CeYT1HIy93Y2wZXVamX2VDnDBpqQ9KmOEqKKXZV0qEk6vBlr6e0uCHz/tawBh31DOO3yKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7RI+aNY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7RI+aNY"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7424c24f88bso1208525b3a.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314657; x=1747919457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1UHAL2dK7QDdMHKpips53kmiglfcYGkQfuMEuBbJUM=;
        b=i7RI+aNYKp3dv6PdioxbyS9v99c8mPYvM5rjk9WCUrNiJ9LlrC1T101tupxFjKAGCy
         sQyrVlkZAEB/dR4+s2cfXq0LAF2SVPWzmzL8PlmjPWfO4TQ43GNd9T3Mm/k9fwMs7zoh
         Q4lr6JpBc2m92CNsAGRDfMPGp4MnA63AcpOln1sEyqvu6D1JHaC2/h0eLAiAnk5/TPGo
         wVyFsavVAaG3TYVsuIHTDBt74uhTZbpJtI4yTY8K5WTCX7Q+fNr1SVKJQj6TFdUAOeh7
         no7wVa2mVDPZ0WmZ+IXp2j3XtiXwvoO9RadK6+TtNpaFFhHzmVISQ3x9RfpZS8xBjpCt
         dJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314657; x=1747919457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1UHAL2dK7QDdMHKpips53kmiglfcYGkQfuMEuBbJUM=;
        b=aFYx8XYuA0yZIWCSWUUMgj/fZBpeEoJj0Cz/NBY8zhdHq0Wr7uktrqH+2neWTrEngM
         BxzGf0UKgG9plDeRxeEtCr3WHrM45DdFnbvVAKv76d8WiU3xcshYukfQs/w5bvUuqsw2
         Z0IU1pfub4ZXNkuBnH6/Uewi8yBELFo2Cgyyp+PGaYCfEvuVzV7wLaz61kgPHUBicJp2
         spd0K0cVW9FVDWwXQHQj/A3JWsJLDBvkO/6RTBI18ib6rGtfMP9Rzp8rg9VFq9p6CwtA
         XoZ2qJbA/loY5lhVVcJAFSLeAlCUtPmIuoq6IASbIWle3ckX8qiJq0Lxy6aO02GQXX46
         yVLg==
X-Gm-Message-State: AOJu0Yw4EhX+ybsflPGSlAyi9bN3nA71Nh6TsYDUjKPSGXyOYACc5duH
	erTyEFTqE2z0k7fdiPMZfmPyp7ut4cJ/pUQp7/AYOY+uXO6pPcC7ljiRWg==
X-Gm-Gg: ASbGncu4LZPkMPVd0ZQGmdHb5YUq0M5GeKjUVfJ9sNPz4qZsJQsWr5cKK9snhqOEv3i
	eEE5tK6dC01i82cPlj+WLd+EUYwCi7m38YceJv1ZeU2l07XIIfGLCgEedN0yTLTy5qWe5zuNESH
	G6WkzUT0iG4ua90sQeONNdMkWER0+gQ9LBb39hRWrcIprr1VqiNWuAPdxp09itnaYvRJPjZnWV5
	NpyS1FDDBUcWimc29ftz/eSizaaVgZx4r8RKJ3aLsBUKfUcUFLAocfnAl5/qK1lYRyRpGe4rUuA
	8d3abfbKUA1zDkl1PEgPA1mcs7ZWttCwpb+f8mbQcQjrpZ5qkb28+LjIA99ikwA5NeUJoewWBiX
	CAz9ZGgSeewOkINnpB1UZfWrwRRTyMS+7YLO5SW3UdQX/XpqHDQbvcbNl8I2EKcxi
X-Google-Smtp-Source: AGHT+IGxZ/2PBKk1eK81xnPyzetuHiHAr4zhe/8y5Nb1bDWxlLPvpFQZMW6+qEFqMvTH3zqTv4gGgA==
X-Received: by 2002:a05:622a:4a0b:b0:476:91f1:9e5 with SMTP id d75a77b69052e-494a3674080mr50607811cf.50.1747314647176;
        Thu, 15 May 2025 06:10:47 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 38/49] selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
Date: Thu, 15 May 2025 09:09:36 -0400
Message-ID: <20250515130947.52806-39-stephen.smalley.work@gmail.com>
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

Convert nlmsg_sock_has_extended_perms() to use the
cred_has_extended_perms() helper for namespace-aware checking.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b9d1600b6340..a0e0d86e2992 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6291,9 +6291,9 @@ static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_t
 	driver = nlmsg_type >> 8;
 	xperm = nlmsg_type & 0xff;
 
-	return avc_has_extended_perms(current_selinux_state, current_sid(),
-				      sksec->sid, sksec->sclass, perms,
-				      driver, AVC_EXT_NLMSG, xperm, &ad);
+	return cred_has_extended_perms(current_cred(), sksec->sid,
+				       sksec->sclass, perms, driver,
+				       AVC_EXT_NLMSG, xperm, &ad);
 }
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
-- 
2.49.0

