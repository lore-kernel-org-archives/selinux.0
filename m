Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1303264C5;
	Fri, 24 Apr 2026 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016311; cv=none; b=qEuVoON/CvYEGvFqcKMLkMFFLI7PUrWBzryvZagX0kWxpOSg39aKHdAXlQUC5jCY41mYln1QJ7MYWUTFlnsNRzR9dIwZvOI5yjb341E9m8Z0s2Do3iiZHwdqgwdm63ZuzLowYFVIPEAjMUpkRUkSKVCWENrlbF0UXif6voVmJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016311; c=relaxed/simple;
	bh=kpheDQP8j0+L92LTgG/TFg1U/SMl/wGQyeeOI0pBshU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUdOrwBnx+m1d4hqTcLhulvXEzXyrT20u3e4xnvKPrU5S9O3JngwuY4Ew5W2BEpieWgcekKVgDT/4pbe8LAgSWlgAE9uBmD5FkZoN+38sX4l26Cs/l+bujEUDoF5+BLpeIGT7Tw9r8Lsh0qNfJTIhhi8kV/9ggoXf3XhuIb68j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fCSuEX+2; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fCSuEX+2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777016276; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=chS97eG9qD4KjwmxMXTIlDIT2HuaCpLsMGBmc51zXAw=;
	b=fCSuEX+2Xs10BZ6VkOjLU6r7YUJyIm1rHhHkBi3BOQihMyeYDTR/BnUmmZsedwrSpU55czaer+uML/D9ruHUsRJGbD67EUBBaGQDbP1xlNk9pcUfBcjJ5AG/odseohncCcD1CryNRkE4hX1MhVHQaXXU961msRfdw4RloYMy8NM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=zongyao.chen@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X1bzLTi_1777016274;
Received: from localhost(mailfrom:ZongYao.Chen@linux.alibaba.com fp:SMTPD_---0X1bzLTi_1777016274 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Apr 2026 15:37:55 +0800
From: ZongYao.Chen@linux.alibaba.com
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	ZongYao Chen <ZongYao.Chen@linux.alibaba.com>
Subject: [PATCH] selinux: use sk blob accessor in socket permission helpers
Date: Fri, 24 Apr 2026 15:37:53 +0800
Message-ID: <20260424073753.2012574-1-ZongYao.Chen@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>

SELinux socket state lives in the composite LSM socket blob.

sock_has_perm() and nlmsg_sock_has_extended_perms() currently
dereference sk->sk_security directly, which assumes the SELinux socket
blob is at offset zero.

In stacked configurations that assumption does not hold. If another LSM
allocates socket blob storage before SELinux, these helpers may read the
wrong blob and feed invalid SID and class values into AVC checks.

Use selinux_sock() instead of accessing sk->sk_security directly.

Fixes: d1d991efaf34 ("selinux: Add netlink xperm support")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
---
 security/selinux/hooks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 97801966bf32..49c482e3fa3f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4920,7 +4920,7 @@ static bool sock_skip_has_perm(u32 sid)
 
 static int sock_has_perm(struct sock *sk, u32 perms)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net;
 
@@ -6227,7 +6227,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 
 static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_type)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	u8 driver;
 	u8 xperm;

base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
-- 
2.47.3

