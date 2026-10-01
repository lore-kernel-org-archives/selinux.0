Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525652CCDD
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868911; cv=none; b=V41p8dhN4xrgm2FrbjGQ36O2wqOm02bqGiYVA3wECirAt+rYQutewGHNfhoBnkBf8ZX8ujciXi0wSR6eVfH4T1rhS509hEkiT4bfXMFjjqaZnRqU96GRDdQ93URB5SELMlQxORUoXil02/SUTLq3i/yr5hBhtjvGtRRXI8V/6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868911; c=relaxed/simple;
	bh=TwiNFzwMX+xgwOtqJlu/8FiKZaS6FbF8sH8GGBcTx3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjHpxdmBXT2DNMYnGrvDPeHOiA3FnkzBx2odmBlar/kTWlKHrL3dzHu5iB8WThsw4rJ50gNJllqusHG0oJAbAkmRMzSDXq7MVJPbNYI2cDvNDxWuILGiXvqfTHhmyVVfe2RDYUomZu4qWUnEqeY2jXbL2KSuqqPnBY3wFb+GAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E55adHE4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E55adHE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TvfGqc7F6+1YIrmCoDH01UvRA6TxuC9d2kDCoKlXIDw=;
	b=E55adHE4J8XUBDeX51RfMmOjDTfch8oR83Ph7F3EfAPIDF/sAFq6CzPnbMty9HrUahu50+
	y8fK54LYEN7zA7+w3UX7vjnSvMHRsBQPBMXhxDZwHDX9HIeYUPwQQTM02sKSVYaHs1EotX
	K8g7W+aJzMaezHBQBnNypN28yrBkz6I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-9MuW9vMeNWKBRzUh5oQ1Xw-1; Thu,
 01 Oct 2026 11:35:05 -0400
X-MC-Unique: 9MuW9vMeNWKBRzUh5oQ1Xw-1
X-Mimecast-MFC-AGG-ID: 9MuW9vMeNWKBRzUh5oQ1Xw_1790868905
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00CE21955EB6;
	Thu,  1 Oct 2026 15:35:05 +0000 (UTC)
Received: from bgrech-thinkpadp1gen3.rmtustx.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D21D30000E6;
	Thu,  1 Oct 2026 15:35:03 +0000 (UTC)
From: Brian Grech <bgrech@redhat.com>
To: selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com
Cc: jonderka@redhat.com,
	Brian Grech <bgrech@redhat.com>
Subject: [PATCH] skip inet_socket/mptcp when MPTCP is not supported
Date: Thu,  1 Oct 2026 10:34:56 -0500
Message-ID: <20261001153456.104370-1-bgrech@redhat.com>
In-Reply-To: <20260710081533.451115-1-jonderka@redhat.com>
References: <20260710081533.451115-1-jonderka@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

MPTCP is supported since kernel 5.6, but only works with SELinux
since 6.5. tests/Makefile currently adds inet_socket/mptcp whenever
the kernel version is >= 6.5. That is not sufficient: some kernels
meet the version requirement but are built without MPTCP.

Gate inclusion of inet_socket/mptcp on both:
  1. kernel version >= 6.5 (existing check)
  2. the net.mptcp.enabled sysctl existing under /proc/sys/net/mptcp

v2: use the net.mptcp.enabled sysctl instead of grepping
CONFIG_MPTCP out of /lib/modules/$(uname -r)/config.

Signed-off-by: Jan Onderka <jonderka@redhat.com>

Co-developed-by: Jan Onderka <jonderka@redhat.com>
Signed-off-by: Brian Grech <bgrech@redhat.com>
---
 tests/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index d53684a..ecfc569 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -157,10 +157,15 @@ endif
 endif
 
 # MPTCP is supported since kernel 5.6, but only works with SELinux
-# since 6.5
+# since 6.5. Skip when the running kernel was built without MPTCP: the
+# net.mptcp.enabled sysctl only exists when CONFIG_MPTCP is set, so this
+# works for hand-built/booted kernels too, unlike checking
+# /lib/modules/$(uname -r)/config directly.
 ifneq ($(shell ./kvercmp $$(uname -r) 6.5),-1)
+ifeq ($(shell test -e /proc/sys/net/mptcp/enabled && echo true),true)
 SUBDIRS += inet_socket/mptcp
 endif
+endif
 
 # nlmsg test dependencies: policy >= 30, nlmsg permission, netlink_xperm capability
 ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && [ -f /sys/fs/selinux/class/netlink_route_socket/perms/nlmsg ] && grep -q 1 $(SELINUXFS)/policy_capabilities/netlink_xperm && echo true),true)
-- 
2.55.0

