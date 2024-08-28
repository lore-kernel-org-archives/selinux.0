Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98D166F1D
	for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837967; cv=none; b=AO+RbMWYaOiAscBtB3OlkNE3RUSLuVoCvHeBw+hxYBbLJalFQsjbQa3sdDu0xqAoD0vK8l/CeD9K+NnH+S/iJUzlfn+xP/bvkg//6sWFnjcVfbR9O4ya1AkgtTh+TIj8kDDvTCXjr5iwEdeYqAe/+Gt+cYjodpnFeiy6uq/eEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837967; c=relaxed/simple;
	bh=5soydvIrTgzldrWaL9Bmcpn2vRGwRfx2FEPtbem5gUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utHFTviG03KjT8XruE/bT/U+ZdZfwnhKY1XnEVCtKCQRz3ntLZYFbofhkOsl8UkqXIiQrrfLRe+2+IJqCkDmvPn3Mq6e6PVSLBZ3bJvKVnjM2uRTLpVp3AadNgFfKyJQxP2+Pbf7o6S49UWcj06h5ieT1OT3HHboacnYI5ONmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Q8NmjJF+; arc=none smtp.client-ip=62.149.156.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Q8NmjJF+"
Received: from vortex.com ([109.54.133.229])
	by Aruba Outgoing Smtp  with ESMTPSA
	id jF65sD3UiTSwmjF65sp0ac; Wed, 28 Aug 2024 11:36:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1724837774; bh=5soydvIrTgzldrWaL9Bmcpn2vRGwRfx2FEPtbem5gUc=;
	h=From:To:Subject:Date:MIME-Version;
	b=Q8NmjJF+FfFh1LtZbvtc4iFpfv+C8G0LA72JKsCAmlKHlHE9XERnI7h/9Xc14aAVb
	 8OflfBjnaJ9EUMTDSrffyLbTuRCbeYJWQd4ZFudodyYnV3t7WRRQWzoDCyLlTYy0+H
	 j1NAnRDiP6GtcMkwjaD3z9yPaXMLEA8YownxFfjmBeYK8JBdP1IFhEmt2qfDwIkUmB
	 +GlAixC6SAbbA8Uh8wZncIMrbRbUxmO006avXAs8xnvafkBL9UTPphYZBI8I8muPlx
	 qCHlExYJBvXLWytzVNZmUljXl6NoYcrp1+iPRbhD0CVrNBcpxG+PTeQVCV/UxaEKd4
	 BlYtD5yL33bzw==
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	Guido Trentalancia <guido@trentalancia.com>
Subject: [PATCH RESEND] selinux: mark all newly created Internet domain sockets as labeled sockets
Date: Wed, 28 Aug 2024 11:35:19 +0200
Message-Id: <20240828093518.27340-1-guido@trentalancia.com>
X-Mailer: git-send-email 2.19.5
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPT3aqOjyok0dM5nKZsJ06h0rR4ZwJS1r4e3OX2aS4IuCAg41u3cIgS2V5OZkKd+HQzHkEVwgbXYt7c8tscgfRkTJHMyJN63PXA/Te84Tiy6RCL732Cz
 maAlHO38zj/7OWBjcjOTRY4AAc+zzmH6lnyDoiqR33EkGrRdpJwkI7W6zpRfd6D/UDlbNe6eyZUhpapKgKFePQ1aVHNOJp01OoSn4Xx114MNTVp08L543UWz
 pCPwo+pIeJQUVFI403oPvRmjmb0/K7q5KpOSn0gEZug=

The current partial labeling was introduced in
commit 389fb800ac8be2832efedd19978a2b8ced37eb61
due to the fact that IPv6 labeling was not
supported yet at the time.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 security/selinux/netlabel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 55885634e880..f6846cbdd977 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -358,7 +358,7 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	if (family == PF_INET)
+	if (family == PF_INET || family == PF_INET6)
 		sksec->nlbl_state = NLBL_LABELED;
 	else
 		sksec->nlbl_state = NLBL_UNSET;
-- 
2.19.5

