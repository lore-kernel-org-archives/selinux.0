Received: from smtpdh16-1.aruba.it (smtpdh16-1.aruba.it [62.149.155.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0D14D6ED
	for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668626; cv=none; b=rHgJ+vOKNMNAUPPtvEJAjpEy+GBeOVihTA7BKvqFnDhRUkQjHSiaKFN4p+rZEdJmytGVpYueWzcIprnKDxI8EU+xAvaO8het1Hml7MTPnn1nkLZjnU7W8qkIpZ5kNi3x7gzmquZ8Si2rLPiGOV/daq3ykl7Lxd+T5QsEdAycCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668626; c=relaxed/simple;
	bh=BODLZC1TZq7rGNbo9I6qMDt0bfmamzibH29muv2IlQQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:Mime-Version; b=FMu6kCQgAV0NyunIuMZ9xrAb9YNKXfbR+/0oJMc7ytCLfO5EILurkASiyha2Pw5EDpibD93uagacyuCQxRdPeMb9D97MsFsfeWbc2UOxCXeaokvpzjT5is/yaJ1RdP+zmmnUMfWKKmYWKzdMM3wxlc3KT0/Ycu7DJQ/vuujzTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=lquf4EU+; arc=none smtp.client-ip=62.149.155.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="lquf4EU+"
Received: from [192.168.43.2] ([109.54.128.216])
	by Aruba Outgoing Smtp  with ESMTPSA
	id iX2msosEGbsngiX2ms4Hi5; Mon, 26 Aug 2024 12:33:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1724668433; bh=BODLZC1TZq7rGNbo9I6qMDt0bfmamzibH29muv2IlQQ=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=lquf4EU+7mLq2zFc4nNuBkpl/k5ot13nsA+XwEdc00W0WiRptZUvMG0E6XOQxF+B2
	 X2Qz7748yOa/iR9MvEjvQ9aAKqga9YhVJEPBqlnV8HphBD4V01Ro2/BiqJJDSVJj1A
	 vYcIrICC6fXt40shb2ocaxPiiChvnIMrtvi1KMpaJlYYjpAUlxVQv3rU5Y319zQ+wP
	 XEu98W8GLwyxHvq+/xQiHJnXUSAZuAn6SaSmu3n6REvFkyI7KkNHL8WjYc9b3qsexa
	 +Hyw7MyslZDDqopM+fyPG5LymqWnNM+yDWZrayB3zaXGmAzZ7UnUxSSosu70mLosVU
	 og8wSdV9DUuNQ==
Message-ID: <1724668431.19755.1.camel@trentalancia.com>
Subject: [PATCH] selinux: mark all newly created Internet domain sockets as
 labeled sockets
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com
Date: Mon, 26 Aug 2024 12:33:51 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOX8mnwYYHV+ECm5OlP6cJjLt1XHE5Ir/DbLnPO/8OjCNKLR+yw655PSf2UzpzUOXyv/88uHhP68sT52QCjmBsJU475i6PJ67zJfOlbQBL/M3PSKlqCa
 gNLVfeyQVLKkzmluAyECAyokWXlqoQtFVXr0DGGxaMqjTE1chI/KWXsjVnGCPtyF0d9qy66vDebaNIUkIAmUkCWYfOda1OXGmyV+z8bsyU9gX0pNfrk8ZI3v

In function selinux_netlbl_inet_csk_clone() mark
as labeled not only IPv4, but also IPv6 sockets.

The current partial labeling was introduced in
commit 389fb800ac8be2832efedd19978a2b8ced37eb61
due to the fact that IPv6 labeling was not
supported yet at the time.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 security/selinux/netlabel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/selinux/netlabel.c	2024-08-25 22:19:37.556414928
+0200
+++ b/security/selinux/netlabel.c	2024-08-25 22:20:02.860415642
+0200
@@ -358,7 +358,7 @@ void selinux_netlbl_inet_csk_clone(struc
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	if (family == PF_INET)
+	if (family == PF_INET || family == PF_INET6)
 		sksec->nlbl_state = NLBL_LABELED;
 	else
 		sksec->nlbl_state = NLBL_UNSET;
