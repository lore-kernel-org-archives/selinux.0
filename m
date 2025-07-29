Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4888026A1B8;
	Tue, 29 Jul 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780252; cv=none; b=RAjXaavlA4JJle3sV71LNlwErYHtUMr19ehOb7bIgHYxOmNKYCOOS4JDzecPlmHMIv+rOiEBCuzvI1NtQQaVyj2/rAHCjm840X9MaT9kl68UJWVgL8itpXaioZAcTx6vPiqtVP1p33fKLLPC8RFnZ96jQnm5Xbn5SPGDpj33Nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780252; c=relaxed/simple;
	bh=gK4Yvwc3AeQ0XMOafjrcf+wxfetigDikGdk3gyvzbVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hgFdRaoKh3FpQ+gugBVBI8NiJvPuK5IO9PzYD1adb6HPc9xGFSpkbTkBiDun9H85JtQhJi0bLKGdeNK1/tL6b5B56eYZcJlYmLaB9FpDofB/2LGXS5J18Bl8QIO8eYOCqsjYxW9P0KPZrXwSicGvf9C9wCpWO9ON6EbLPOFp65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Nxn4WwVR; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Nxn4WwVR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753780247; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xLOn24MxdPURuEEkt2stIxBd6I+5GdQyNqZxLgQ8Evc=;
	b=Nxn4WwVRDKmz6D8i3jR6Gdbk0MloD7abNjRYOJCkOqtsBK93pT+T32pb8T8GdQ1lwktaPvt+WFKI8ZqYMckz/j2OJ18qvyZ4cOUobKJT/NmU/egtOpP4h/UYp+Yla3COEa7AnUiq0y65MjYGKqgea+4LuaC7ozEPIPyV3qMun9w=
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0WkPUOPq_1753780246 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Jul 2025 17:10:46 +0800
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] selinux: use a consistent method to get full socket from skb
Date: Tue, 29 Jul 2025 17:10:44 +0800
Message-Id: <20250729091044.95411-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to maintain code consistency and readability,
skb_to_full_sk() is used to get full socket from skb.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 595ceb314aeb..362f92b2fafb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5861,7 +5861,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 	/* we do this in the LOCAL_OUT path and not the POST_ROUTING path
 	 * because we want to make sure we apply the necessary labeling
 	 * before IPsec is applied so we can leverage AH protection */
-	sk = sk_to_full_sk(skb->sk);
+	sk = skb_to_full_sk(skb);
 	if (sk) {
 		struct sk_security_struct *sksec;
 
-- 
2.39.5 (Apple Git-154)

