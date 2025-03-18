Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968C1FF7DD;
	Tue, 18 Mar 2025 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286895; cv=none; b=VINUMPqnG02YICA60QLzlqenEA3WhC5u7zn1Z4iXbwsgZl39/cqJZY+723lEGbZ+bnIVXsJoTTIdROtQGwSHrWB4YlC9fHglJVNkWHZ5SyzbzL5FuYTCjexuaj0CW17pZAPT5AhSzP7D2KQYv028pe5epPN0WhSqUE53c1B5Syg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286895; c=relaxed/simple;
	bh=MFUs8+IYFyBcBjCYHLgZ+RXxXndtSbbFTM4vbc5mgd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yi74XlZRpZW9g3m+yzSwLHN3hB+0OmY5bqhs0tYSeDn6V+QQC9aK0RHbL3ZHODIIwh7f8MFu6Ee2a99x8uQj5Hj3lmuxZZzFnoei63QDBs/tbCYUwgNBzKbEVkohivDZqEhniEmacQKE8GlfzE8oN4+U8/hExU+VpOegM3wHBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=QvzLlDFv; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="QvzLlDFv"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1742286884;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=s93yBV3BSJn5LVCBfGTaijGihV02lgcOIXQOv8jiEm0=;
	b=QvzLlDFvjUNhOblVyNU2GNE6XTdgPxGtByz9JlLBT7ltEaVccGsVEViX4Yfr8VcRg1cCvN
	eUD7Ap0/SGqBAfnwnzaNxzDkeCHl+VZtcdHeww6lgF6+vDM1mPa9tYrRC3qKmIFOM/k7ta
	W2o3cu/GsKe8xWPSs/nhZaz2sB5yjDFzZ2ipdOy6oOsoxvjxyiZsThPq0WFybGRts2gJKY
	2g2LaNoZSHwHr6AmwcDzQVLml6G0bWX1CUh4KBqQmRi+KLPPjnfaW3PfqLHvdjTvv/QdCt
	bY+bxkRgt/kssI+zp2aUYCnGowKDZQhKJZhENI1JugD9VwKm698Cpba5EIxl2Q==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	GUO Zihua <guozihua@huawei.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/6] selinux: contify network namespace pointer
Date: Tue, 18 Mar 2025 09:33:29 +0100
Message-ID: <20250318083422.21489-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The network namespace is not modified.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/objsec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c88cae81ee4c..b11c97c9feed 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -82,7 +82,7 @@ struct ipc_security_struct {
 };
 
 struct netif_security_struct {
-	struct net *ns; /* network namespace */
+	const struct net *ns; /* network namespace */
 	int ifindex; /* device index */
 	u32 sid; /* SID for this interface */
 };
-- 
2.49.0

