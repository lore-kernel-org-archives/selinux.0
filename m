Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE61F8753;
	Tue, 18 Mar 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287818; cv=none; b=WXYNTb9g1XLnBMS0yYlcGT/7dF3+YoRGIBdgsLphNScqFWzN5aBckZj4j/6Z7FoiO2IEjBBtBkS4bMesv1xCMafYJfBSbVmkrsZHSw9yqptkFL6SwWIuKk9y7xjc5T9rZWXXHAN1qnqXqf+KpH5s8IubiIDeq4NuZuU4o2mU5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287818; c=relaxed/simple;
	bh=ZDC8GEiQ6rmdIGlvnIoFQNX9pEXFq2GhsMSmsZGomgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tQ6gsd7/ngAZ+9Ih1BnhBwRl9V8LlKfQ5+ftKP3pIL7LtBaCrldWnPGL7GbtIczoqnI+juytj1IXp0KoPDZd1AK24FdXnmCIJulzfpgdKPrvZYW2/re7HKGUevJV1CpnJa4a0M7HIlUWIuhUlDdLOzCn1NZ3WZP40J9ooUw0TSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=DUEnB2zL; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="DUEnB2zL"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1742287810;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sHPhayGKOKXkiuvLCTBF/hyQNwoYElajGndyiv3Mn24=;
	b=DUEnB2zLrjKim1TILca6oGnvOwkMpP0Vs60tuPHvYJY98czhZjHq51A26hyzTuXKPq1+KB
	CE6JTxtItJNQhcAQDU2u69Iq7WwmNgYDX4dpwMVgQ+gRbPfQX2PDzQ2BfFlFMa2XASU25h
	mQ85HwyhEeHc+b3wxeaeywcyCma/8hmHJ/YTX6A3i27XP+mX22IxnN5Y8/XfpLnEGog+Fq
	KasJIFlKy13nD61ju0Q0BVeiOngBzWFXkAh74yWRMfDK0kfiXD2wA8QuxnmWUTGUBi8k59
	YtfLoJfBRSnwPIHkmOFXPVjLhFpVa/cE+98uI9ehBW+ecHIDRqcQd2jYojEoYw==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/7] selinux: drop copy-paste comment
Date: Tue, 18 Mar 2025 09:50:05 +0100
Message-ID: <20250318085007.26887-1-cgoettsche@seltendoof.de>
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

Port labeling is based on port number and protocol (TCP/UDP/...) but not
based on network family (IPv4/IPv6).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/netport.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 2a315dcc4344..cfa55d703ce1 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -47,12 +47,6 @@ struct sel_netport {
 	struct rcu_head rcu;
 };
 
-/* NOTE: we are using a combined hash table for both IPv4 and IPv6, the reason
- * for this is that I suspect most users will not make heavy use of both
- * address families at the same time so one table will usually end up wasted,
- * if this becomes a problem we can always add a hash table for each address
- * family later */
-
 static DEFINE_SPINLOCK(sel_netport_lock);
 static struct sel_netport_bkt sel_netport_hash[SEL_NETPORT_HASH_SIZE];
 
-- 
2.49.0

