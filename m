Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D63258EDA
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805357; cv=none; b=tEvzUg04CDys50ACOb3PdR2oHlvO26ziQyZv8NuVqGzzd1oYb3LJLRyX1e3tce1pI4mQdzKCrKhkp7+/eg4AMu/94teVk6v47PlfSUzfFbwOnFxvbhoNmrF0omuIuxjrv26hJwk/Rq5xj9bd+xZL/2IpkgHRps5xQnw9yFhEriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805357; c=relaxed/simple;
	bh=8HSD1MWMNu4pgvMU4a7xsP5FxkUbBCrJvtbInsfgXc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+FWnFsM8LHBzB/Yp9cdOPStlintr5aMUu2Xqew6oW+YlXnUrSGHkYdQnj/PtqvpoEXDr2dGMWNIMGfT20a23jLr5vuPv9Yn+RszGpnohZJ/qzzG3Dsb/UdjtOL6lHxQbxdfjgEudjOsfMcAmMcDSVJ2AjoL0fgUrd8u0evvFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ogb+9kDK; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogb+9kDK"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9157f7c1c0eso122408085a.1
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781805354; x=1782410154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l62z+qEX+pg3FxTT6Z4UUbs3k6pl93cKtz8oCBZiyKI=;
        b=Ogb+9kDKGxduJ4cf/qBRlqrT/yhSeAgFyBG1/dx3/Ch3su398nEsoYBqJTzu/612HW
         +pERmODMorA0WjOJLAUW+RYpoHrqn9fo2TSK2MxrOmtzfnyETmcIVY14RCIoL2nonXhl
         WJzHXZMq++H6I8KIeHONDPmjphdaoTUcixe3EqTxFnp7CQZlrKQ2IIAJ9PAeGdjkSNKY
         +Fe6vEYLWZSfRqHHZXaZGUW3V7lTnEYpnVuwTDJHsX1qP2hAi7SQyqzD/vzogyIUgIjd
         SH9vliXVHh5Zgk/TLwnhXsvntgRooVN3I0z592uqGtX7W2U2cDyx5Y5pVNeLpvoqBEpX
         kqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781805354; x=1782410154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l62z+qEX+pg3FxTT6Z4UUbs3k6pl93cKtz8oCBZiyKI=;
        b=pNl74xl190XJCnOp3Lt22dS8/rQidMtp0L2D9Q3KBdW3e96yi9HffDIeat0oYLWdmj
         14t6WPoXOyoKS/TpV6vgNAvnI+zQhNnlVOjDF3/OJfGUsVfgX7DhRAj+jnxJ4/YmGC3T
         YYmi8LbrAF+JQOXMhuHFj9SkqvcF29ZVtix8USjyeVfOzF3NvnPYhF6CeRYK3a3Rn+1+
         88fGs/jqyzg2dEypTPRwAkVqGfbnsy1MGRzPDTM39zoNnqi+ad3NkGcjRVjSaX264Phd
         RufjZ+ZMzTl8G6Z/fRxFkl4ALOIRmMHOkBF+9HwP0gvhkVJ8Sw3cXoRQ0tyI6RZ2PNqJ
         QhEw==
X-Gm-Message-State: AOJu0YzR9dLvjw4MI9fQjsAktH947GFhLsX3HKmZv/G/miOV6LH/N2b0
	3JXDWUDASuFf11WTCzkeFINnfETFEXKCRPAgbdprtjzh8jZ5SYOGs9IB8XdGZw==
X-Gm-Gg: AfdE7cnc/pLVczIRsOv8k8qTMRWF4X35CkSLt+phr8+8BydJk5R+zKeuEg6EKCIcjBK
	J4Sl/wq3lCqfKO0XOwwjQI8EhIbV228Cb3AMB2Z5djvao7NZcvIyS2huIWaneluP1irE/0PTl/9
	a4aid+sXs1FfFwEqBTpKiK5RAaS1BY9vwBl195nNcLyfT9njhbjtPYrGBLgjTIBL0UdtTFkTp4X
	nJQpKluDRPJphwDmjmocQDdOz29oDuFMzKK94ftsxPcMmgdkHyqkrQlxqdeDOV2VOgytlk8KZyC
	PGZ8iD9ISX8dc3tY01ixwiqxyyceQzMEzKfbpwsWToZGfA9uG97uHPGCA+010beF3FiVlksAF8u
	2nzDzVQjK8SGanSf8IF5+/rLTxRSD4IZ6sYm2rpppIC3Br/pMaXbGp9FLe7u2UDjuum+LZAvnJS
	0LY3j8qAZnkoVFGgBe9ucRb0MolXXiaL77/XLCqUtnB3EFcRA7IHJBgqRqigWmrkLldXG0RcVjT
	A6h8pBwzVUdf4Oe
X-Received: by 2002:a05:620a:4046:b0:915:9d98:bd6 with SMTP id af79cd13be357-91d8d7aad1bmr1568672685a.38.1781805354352;
        Thu, 18 Jun 2026 10:55:54 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm2137514285a.21.2026.06.18.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 10:55:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Subject: [PATCH] selinux: check connect-related permissions on TCP Fast Open
Date: Thu, 18 Jun 2026 13:55:14 -0400
Message-ID: <20260618175513.112443-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to Landlock, SELinux was not updated when TCP Fast Open
support was introduced to ensure connect-related permissions are
checked when using TCP Fast Open. Update its socket_sendmsg() hook to
call selinux_socket_connect() when MSG_FASTOPEN is passed.

Link: https://lore.kernel.org/linux-security-module/20260616201615.275032-1-hexlabsecurity@proton.me/
Link: https://lore.kernel.org/linux-security-module/20260617180526.15627-2-matthieu@buffet.re/
Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Reported-by: Matthieu Buffet <matthieu@buffet.re>
Reported-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
NB Build-tested only so far.

 security/selinux/hooks.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 97801966bf32..855cc32a7653 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5270,7 +5270,23 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 				  int size)
 {
-	return sock_has_perm(sock->sk, SOCKET__WRITE);
+	int rc;
+	struct sockaddr *const addr = msg->msg_name;
+	const int addrlen = msg->msg_namelen;
+
+	rc = sock_has_perm(sock->sk, SOCKET__WRITE);
+	if (rc)
+		return rc;
+
+	if (addr && (msg->msg_flags & MSG_FASTOPEN) && (sk_is_tcp(sock->sk) ||
+		(sk_is_inet(sock->sk) && sock->sk->sk_type == SOCK_STREAM &&
+		sock->sk->sk_protocol == IPPROTO_MPTCP))) {
+		rc = selinux_socket_connect(sock, addr, addrlen);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
 }
 
 static int selinux_socket_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.54.0

